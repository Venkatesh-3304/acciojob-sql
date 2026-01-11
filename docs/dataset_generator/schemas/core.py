import pandas as pd
import numpy as np
from datetime import datetime, timedelta
from faker import Faker
import random
from ..config import REGIONS, DEPARTMENTS
from ..utils import write_csv

fake = Faker('en_IN')

from ..config import REGIONS, DEPARTMENTS
from ..utils import write_csv
from ..taxonomy import TAXONOMY as CATEGORIES

fake = Faker('en_IN')

# Internal banks now moved to taxonomy.py for better management


def generate_core(config, output_dir):
    print("🌍 Building Core Dimensions...")
    
    # 1. Dim Date
    years = config["core"]["dim_date_years"]
    end_date = datetime.now()
    start_date = datetime(end_date.year - years + 1, 1, 1)
    
    date_range = pd.date_range(start=start_date, end=end_date)
    dim_date = pd.DataFrame({
        "date_key": date_range,
        "day": date_range.day,
        "month": date_range.month,
        "year": date_range.year,
        "quarter": date_range.quarter,
        "day_name": date_range.strftime("%a"),
        "month_name": date_range.strftime("%b")
    })
    write_csv(dim_date, output_dir / "core" / "dim_date.csv")

    # 2. Dim Region
    # Generate realistic Indian cities/states via Faker
    regions_data = []
    seen_states = set()
    
    # We want a good spread of states
    while len(seen_states) < 20: 
        state = fake.state()
        if state not in seen_states:
            seen_states.add(state)
            regions_data.append({
                "region_id": len(regions_data) + 1,
                "region_name": random.choice(REGIONS),
                "country": "India",
                "state": state
            })
    
    dim_region = pd.DataFrame(regions_data)
    write_csv(dim_region, output_dir / "core" / "dim_region.csv")
    
    # 3. Dim Category
    cats_data = [{"category_id": i+1, "category_name": c} for i, c in enumerate(CATEGORIES.keys())]
    dim_category = pd.DataFrame(cats_data)
    write_csv(dim_category, output_dir / "core" / "dim_category.csv")
    
    # Map name -> id for FK
    cat_map = {row['category_name']: row['category_id'] for row in cats_data}

    # 4. Dim Brand
    brands_data = []
    bid = 1
    for cat, brands in CATEGORIES.items():
        for brand in brands:
            brands_data.append({
                "brand_id": bid,
                "brand_id": bid,
                "brand_name": brand,
                "category_id": cat_map[cat]
            })
            bid += 1
    dim_brand = pd.DataFrame(brands_data)
    write_csv(dim_brand, output_dir / "core" / "dim_brand.csv")
    
    write_csv(dim_brand, output_dir / "core" / "dim_brand.csv")
    
    # 5. Dim Department
    print("  ... dim_department")
    dim_dept = pd.DataFrame([
        {"dept_id": i+1, "dept_name": d} 
        for i, d in enumerate(DEPARTMENTS)
    ])
    write_csv(dim_dept, output_dir / "core" / "dim_department.csv")

    # 6. Dim Expense Category (Finance)
    print("  ... dim_expense_category")
    EXPENSE_CATS = ['Rent', 'Utilities', 'Maintenance', 'Marketing', 'Software', 'Travel', 'Office Supplies']
    dim_exp_cat = pd.DataFrame([
        {"exp_cat_id": i+1, "category_name": c}
        for i, c in enumerate(EXPENSE_CATS)
    ])
    write_csv(dim_exp_cat, output_dir / "core" / "dim_expense_category.csv")
    
    return dim_date, dim_region, dim_category, dim_brand, dim_dept, dim_exp_cat
