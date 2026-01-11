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
    
    return df_customers, df_addr
