import pandas as pd
import numpy as np
from faker import Faker
from ..utils import write_csv
import random

fake = Faker('en_IN')
Faker.seed(42)

def generate_customers(config, output_dir):
    print("👥 Building Customers...")
    n_cust = config["customers"]["n_customers"]
    
    # Bulk generate profiles
    # Using list comprehension for Faker is cleaner than numpy vectorize for complex objects
    data = []
    for i in range(n_cust):
        fn = fake.first_name()
        ln = fake.last_name()
        data.append({
            "customer_id": i + 1,
            "first_name": fn,
            "last_name": ln,
            "email": f"{fn.lower()}.{ln.lower()}{i}@example.com",
            "phone": fake.phone_number(),
            "registration_date": fake.date_between(start_date='-3y', end_date='today')
        })
    
    df_customers = pd.DataFrame(data)
    write_csv(df_customers, output_dir / "customers" / "customers.csv")
    
    # Addresses (1-2 per customer)
    # We'll just generate one main address per customer for simplicity/speed in this version
    # unless scale dictates otherwise.
    addr_data = []
    for i in range(n_cust):
        min_addr = 1 if random.random() > 0.1 else 0 # 10% customers might not have address yet? No, usually 1 required.
        # Let's say all have 1 address for now
        addr_data.append({
            "address_id": i + 1,
            "customer_id": i + 1,
            "address_line": fake.street_address(),
            "city": fake.city(),
            "state": fake.state(),
            "pincode": fake.postcode(),
            "is_default": True
        })
        
    df_addr = pd.DataFrame(addr_data)
    write_csv(df_addr, output_dir / "customers" / "addresses.csv")
    
    # 3. Reviews
    print("  ... Reviews")
    # Generating reviews for "generic" products to avoid circular dependency loop with Products schema
    # (Customers generator runs before Products).
    # In a perfect world we pass product IDs, but here we'll just simulate product IDs 1..5000
    # or we can move this to after products generation?
    # Better: Update main.py to pass df_products to customers? No, circular.
    # We will generate reviews in a separate call or just random IDs.
    
    n_reviews = config["customers"]["n_reviews"]
    
    reviews_data = []
    for i in range(n_reviews):
        # We assume ~6000 products exist based on smoke test
        pid = random.randint(1, 6000) 
        rating = random.choices([5, 4, 3, 2, 1], weights=[50, 30, 10, 5, 5])[0]
        
        reviews_data.append({
            "review_id": i + 1,
            "customer_id": random.randint(1, n_cust),
            "product_id": pid,
            "rating": rating,
            "review_text": fake.sentence(),
            "review_date": fake.date_between(start_date='-2y', end_date='today')
        })
    df_reviews = pd.DataFrame(reviews_data)
    write_csv(df_reviews, output_dir / "customers" / "reviews.csv")
    
    # 4. Loyalty Points
    print("  ... Loyalty Points")
    # One active point balance per customer? Or transaction log? 
    # Usually a ledger. Let's do a ledger for last month.
    loyalty_data = []
    for _ in range(int(n_cust * 0.5)): # 50% customers active
        cid = random.randint(1, n_cust)
        points = random.randint(10, 500)
        loyalty_data.append({
            "loyalty_id": len(loyalty_data) + 1,
            "customer_id": cid,
            "points_earned": points,
            "source": random.choice(["Purchase", "Referral", "Bonus"]),
            "date_earned": fake.date_between(start_date='-1y', end_date='today')
        })
    df_loyalty = pd.DataFrame(loyalty_data)
    write_csv(df_loyalty, output_dir / "customers" / "loyalty_points.csv")
    
    return df_customers, df_addr
