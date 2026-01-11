import pandas as pd
import numpy as np
from faker import Faker
import random
from datetime import timedelta
from ..utils import write_csv

fake = Faker('en_IN')
Faker.seed(42)

def generate_products(config, output_dir, dim_category, dim_brand, df_stores):
    print("📦 Building Products...")
    
    # 1. Suppliers
    n_suppliers = 100 # Default or config?
    suppliers_data = []
    for i in range(n_suppliers):
        suppliers_data.append({
            "supplier_id": i + 1,
            "supplier_name": fake.company(),
            "contact_name": fake.name(),
            "city": fake.city(),
            "email": fake.company_email()
        })
    df_suppliers = pd.DataFrame(suppliers_data)
    write_csv(df_suppliers, output_dir / "products" / "suppliers.csv")
    
    # 2. Products
    # We will generate products based on brands
    products_data = []
    brands_list = dim_brand.to_dict('records') # list of dicts: brand_id, brand_name, category_name
    
    pid = 1
    # Generate approx 50 products per brand
    for b in brands_list:
        for _ in range(random.randint(20, 80)):
            # Generate a realistic product name
            # "Samsung Galaxy S21" or "Nike Air Max"
            # Faker doesn't have good models for this, so we combine Brand + Adjective/Noun
            p_name = f"{b['brand_name']} {fake.word().capitalize()} {random.choice(['Pro', 'Max', 'Lite', 'X', 'Plus', ''])}".strip()
            
            # Find category_id (Not needed in products table for Snowflake, but needed for logic if we wanted it)
            # Snowflake: Product -> Brand -> Category. So we only need brand_id.
            
            # Supplier: 5% chance of being NULL (internal brand or data error)
            sid = random.randint(1, n_suppliers)
            if random.random() < 0.05:
                sid = "" # Empty string for CSV or None
            
            products_data.append({
                "product_id": pid,
                "product_name": p_name,
                "brand_id": b['brand_id'],
                # "category_id": cid,  <-- REMOVED for Snowflake Normalization
                "supplier_id": sid,
                "price": round(random.uniform(500, 50000), 2),
                "cost_price": 0 # to be calculated as pct of price
            })
            pid += 1
            
    df_products = pd.DataFrame(products_data)
    df_products['cost_price'] = round(df_products['price'] * 0.7, 2)
    write_csv(df_products, output_dir / "products" / "products.csv")
    
    # 3. Inventory
    print("  Stocking Inventory...")
    # Link products to stores
    # Not every store has every product. Sparsity matters.
    # Pandas Cross Join is memory heavy if N_stores * N_products is growing.
    # N_inv = config["products"]["n_inventory_pairs"]
    
    # We'll pick random pairs.
    n_inv = config["products"]["n_inventory_pairs"]
    
    # Generate random arrays
    s_ids = np.random.randint(1, len(df_stores)+1, size=n_inv)
    p_ids = np.random.randint(1, len(df_products)+1, size=n_inv)
    
    # Deduplicate pairs
    pairs = pd.DataFrame({'store_id': s_ids, 'product_id': p_ids}).drop_duplicates()
    
    # Add quantity
    pairs['quantity_on_hand'] = np.random.randint(0, 200, size=len(pairs))
    pairs['reorder_level'] = np.random.randint(10, 50, size=len(pairs))
    
    write_csv(pairs, output_dir / "products" / "inventory.csv")
    

    
    # 4. Promotions
    print("  ... Promotions")
    n_promo = config["products"]["n_promotions"]
    promos = []
    for i in range(n_promo):
        sd = fake.date_between(start_date='-2y', end_date='today')
        promos.append({
            "promo_id": i + 1,
            "promo_name": fake.catch_phrase().split()[0] + " Sale",
            "discount_percent": random.choice([5, 10, 15, 20, 25, 50]),
            "start_date": sd,
            "end_date": sd + timedelta(days=random.randint(3, 15)),
            "active": random.choice([True, False])
        })
    df_promos = pd.DataFrame(promos)
    write_csv(df_promos, output_dir / "products" / "promotions.csv")
    
    return df_products, pairs
