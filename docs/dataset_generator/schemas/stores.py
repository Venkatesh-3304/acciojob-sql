import pandas as pd
import numpy as np
from faker import Faker
import random
from ..utils import write_csv
from ..config import EMP_ROLES, DEPARTMENTS

fake = Faker('en_IN')
Faker.seed(42)

def generate_stores(config, output_dir, dim_region, dim_dept):
    print("🏪 Building Stores...")
    n_stores = config["stores"]["n_stores"]
    
    # ... (code truncated logic) ...
    # Re-impl city logic to be safe or just focus on employee part? 
    # Let's assume user accepts partial replace if I specifically target function signature and employee loop.
    
    cities_db = [fake.city() for _ in range(n_stores)] 
    
    stores_data = []
    for i in range(n_stores):
        rid = random.choice(dim_region['region_id'].tolist())
        stores_data.append({
            "store_id": i + 1,
            "store_name": f"RetailMart {cities_db[i]}",
            "region_id": rid,
            "city": cities_db[i],
            "square_ft": random.randint(1000, 5000),
            "opening_date": fake.date_between(start_date='-5y', end_date='-1y')
        })
    df_stores = pd.DataFrame(stores_data)
    write_csv(df_stores, output_dir / "stores" / "stores.csv")
    
    # Employees
    print("  Construction Employees...")
    n_emp = config["stores"]["n_employees"]
    emp_data = []
    
    # Create valid dept_ids list
    dept_ids = dim_dept['dept_id'].tolist()
    
    for i in range(n_emp):
        sid = random.randint(1, n_stores)
        role = random.choice(EMP_ROLES)
        dept_id = random.choice(dept_ids) # Normalized
        fn = fake.first_name()
        ln = fake.last_name()
        
        emp_data.append({
            "employee_id": i + 1,
            "store_id": sid,
            "first_name": fn,
            "last_name": ln,
            "email": f"{fn}.{ln}@retailmart.com".lower(),
            "role": role,
            "dept_id": dept_id, # Replaces department string
            "joining_date": fake.date_between(start_date='-4y', end_date='today'),
            "salary": random.randint(20000, 150000)
        })
        
    df_employees = pd.DataFrame(emp_data)
    write_csv(df_employees, output_dir / "stores" / "employees.csv")
    
    return df_stores, df_employees
