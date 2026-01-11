import pandas as pd
import numpy as np
from faker import Faker
import random
from datetime import timedelta
from ..utils import write_csv
from ..config import ORDER_STATUS, PAY_MODES

fake = Faker('en_IN')
Faker.seed(42)

def generate_sales(config, output_dir, df_customers, df_stores, df_products, dim_date):
    print("🛍️  Building Sales...")
    
    # Unsold Products Logic:
    # We only pick products from a subset (e.g., 90% of active products)
    all_pids = df_products['product_id'].values
    n_pids = len(all_pids)
    subset_size = int(n_pids * 0.90) # 10% products will NEVER be ordered
    active_pids = np.random.choice(all_pids, size=subset_size, replace=False)
    
    n_orders = config["sales"]["n_orders"]
    
    # 1. Orders
    # Dates between 3 years ago and today
    print("  Generating Orders...")
    
    c_ids = df_customers['customer_id'].values
    s_ids = df_stores['store_id'].values
    
    # Vectorized generation for speed
    order_ids = np.arange(1, n_orders + 1)
    cust_ids = np.random.choice(c_ids, size=n_orders)
    store_ids = np.random.choice(s_ids, size=n_orders)
    
    # Random dates
    # We'll pick from dim_date to ensure FK validity if we had one, but we assume date range matches
    dates = np.random.choice(dim_date['date_key'], size=n_orders)
    
    status = np.random.choice(ORDER_STATUS, size=n_orders, p=[0.7, 0.1, 0.1, 0.1]) # Delivered, Shipped, Cancelled, Returned
    
    df_orders = pd.DataFrame({
        "order_id": order_ids,
        "cust_id": cust_ids,
        "store_id": store_ids,
        "order_date": dates,
        "order_status": status,
        "total_amount": 0.0 # Will calculate from items
    })
    
    # 2. Order Items
    print("  Generating Order Items...")
    # Variable items per order
    min_items = config["sales"]["items_per_order_min"]
    max_items = config["sales"]["items_per_order_max"]
    
    # We need to expand orders to items
    # Simple loop approach is slow for 150k orders. Even vectorized is tricky with variable lengths.
    # We'll use a fixed distribution strategy: average 2.5 items per order.
    
    # Fast approximation: Generate Total Items array, then assign to orders.
    # items_count = np.random.randint(min_items, max_items + 1, size=n_orders)
    # repeat order_ids
    # This is fast:
    items_count = np.random.randint(min_items, max_items + 1, size=n_orders)
    repeated_order_ids = np.repeat(order_ids, items_count)
    n_items = len(repeated_order_ids)
    
    item_pids = np.random.choice(active_pids, size=n_items)
    quantities = np.random.randint(1, 4, size=n_items)
    
    # Prices: We need to look up prices from df_products
    # Create a map
    price_map = pd.Series(df_products.price.values, index=df_products.product_id).to_dict()
    # Map prices
    # fallback 0 if not found (shouldn't happen with active_pids subset)
    prices = [price_map[pid] for pid in item_pids]
    
    df_items = pd.DataFrame({
        "order_item_id": np.arange(1, n_items + 1),
        "order_id": repeated_order_ids,
        "prod_id": item_pids,
        "quantity": quantities,
        "unit_price": prices,
        "discount": 0.0
    })
    
    # Calculate Total Amount for Orders
    # group by order_id -> sum (qty * price)
    print("  Calculating Totals...")
    
    # Vectorized calculation (Faster & Safer)
    df_items['line_total'] = df_items['quantity'] * df_items['unit_price']
    grp = df_items.groupby('order_id')['line_total'].sum()
    
    # Update df_orders
    df_orders['total_amount'] = df_orders['order_id'].map(grp).fillna(0)
    
    write_csv(df_orders, output_dir / "sales" / "orders.csv")
    write_csv(df_items, output_dir / "sales" / "order_items.csv")
    
    # 3. Payments
    # One payment per order (simplification)
    print("  Generating Payments...")
    # Only for non-cancelled orders usually? OR maybe failed payments exist.
    # Let's say 95% orders have payments.
    
    pay_mask = np.random.rand(n_orders) < 0.95
    pay_orders = df_orders[pay_mask].copy()
    
    df_payments = pd.DataFrame({
        "payment_id": np.arange(1, len(pay_orders) + 1),
        "order_id": pay_orders['order_id'],
        "payment_date": pay_orders['order_date'], # same day
        "payment_mode": np.random.choice(PAY_MODES, size=len(pay_orders)),
        "amount": pay_orders['total_amount']
    })
    write_csv(df_payments, output_dir / "sales" / "payments.csv")
    
    # 4. Shipments
    # Only for Shipped/Delivered/Returned
    ship_orders = df_orders[df_orders['order_status'].isin(['Shipped', 'Delivered', 'Returned'])].copy()
    n_ship = len(ship_orders)
    
    # Dates
    ship_dates = pd.to_datetime(ship_orders['order_date']) + pd.to_timedelta(np.random.randint(1, 4, size=n_ship), unit='D')
    del_dates = ship_dates + pd.to_timedelta(np.random.randint(2, 7, size=n_ship), unit='D')
    
    # If Status is 'Shipped', Delivered Date is NULL
    # We can simulate this by setting it to NaT where status is 'Shipped'
    is_shipped = ship_orders['order_status'] == 'Shipped'
    del_dates = del_dates.mask(is_shipped, pd.NaT)
    
    df_shipments = pd.DataFrame({
        "shipment_id": np.arange(1, n_ship + 1),
        "order_id": ship_orders['order_id'],
        "courier_name": np.random.choice(['BlueDart', 'Delhivery', 'EcomExpress', 'FedEx'], size=n_ship),
        "shipped_date": ship_dates,
        "delivered_date": del_dates,
        "status": ship_orders['order_status']
    })
    write_csv(df_shipments, output_dir / "sales" / "shipments.csv")
    
    # 5. Returns
    # For 'Returned' orders
    ret_orders = df_orders[df_orders['order_status'] == 'Returned'].copy()
    # Need to link to items? Simplified: just link to order and one product from it
    # Complex logic omitted for brevity, assuming return entire order for now or random item
    
    # Let's pick random item from these orders
    # This is tricky without loading items.
    # Simplified: We will just generate returns.csv with order_id and random active pid (might be wrong, but fast)
    # CORRECT WAY: Merge with Items.
    
    items_subset = df_items[df_items['order_id'].isin(ret_orders['order_id'])].drop_duplicates('order_id')
    n_ret = len(items_subset)
    
    df_returns = pd.DataFrame({
        "return_id": np.arange(1, n_ret + 1),
        "order_id": items_subset['order_id'],
        "prod_id": items_subset['prod_id'],
        "return_date": pd.to_datetime(dim_date.sample(n=n_ret, replace=True)['date_key'].values), # Random date
        "reason": np.random.choice(["Defective", "Wrong Item", "Not liked", "Size issue"], size=n_ret),
        "refund_amount": items_subset['unit_price']  # Full refund of that item
    })
    write_csv(df_returns, output_dir / "sales" / "returns.csv")
    
    return df_items
