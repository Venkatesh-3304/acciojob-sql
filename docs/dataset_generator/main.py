import click
import pandas as pd
import numpy as np
from pathlib import Path
from tqdm import tqdm
from .config import DEFAULT_CONFIG, CSV_ROOT_RAW
from .schemas.core import generate_core
from .schemas.customers import generate_customers
from .schemas.stores import generate_stores
from .schemas.products import generate_products
from .schemas.sales import generate_sales
from .schemas.finance import generate_finance
from .schemas.hr import generate_hr
from .schemas.marketing import generate_marketing
from .schemas.support import generate_support
from .utils import ensure_dirs

@click.command()
@click.option('--output-dir', default=str(CSV_ROOT_RAW), help='Directory to save CSV files')
@click.option('--scale', default=1.0, help='Scaling factor for dataset size (e.g. 0.1 for small, 10 for huge)')
@click.option('--seed', default=42, help='Random seed')
def main(output_dir, scale, seed):
    """
    RetailMart Dataset Generator (CLI)
    Generates realistic, normalized, enterprise-grade synthetic data.
    """
    print(f"🚀 Starting RetailMart Data Generator")
    print(f"   Output: {output_dir}")
    print(f"   Scale:  {scale}x")
    print(f"   Seed:   {seed}")
    
    # Setup
    np.random.seed(seed)
    out_path = Path(output_dir)
    ensure_dirs([out_path])
    
    # Adjust config based on scale
    # We only scale "counts", not "rates" or small integers like items_per_order
    KEYS_TO_SCALE = ["n_customers", "n_reviews", "n_inventory_pairs", "n_promotions", 
                     "n_stores", "n_employees", "n_expenses", "n_orders", 
                     "n_campaigns", "n_ads_spend", "n_email_clicks"]
                     
    config = DEFAULT_CONFIG.copy()
    for category in config:
        if isinstance(config[category], dict):
            for key in config[category]:
                if key in KEYS_TO_SCALE:
                    config[category][key] = int(config[category][key] * scale)
    
    # 1. Core
    dim_date, dim_region, dim_category, dim_brand, dim_dept, dim_exp_cat = generate_core(config, out_path)
    
    # 2. Customers
    df_customers, _ = generate_customers(config, out_path)
    
    # 3. Stores
    df_stores, df_employees = generate_stores(config, out_path, dim_region, dim_dept)
    
    # 4. Products
    df_products, _ = generate_products(config, out_path, dim_category, dim_brand, df_stores)
    
    # 5. Sales
    generate_sales(config, out_path, df_customers, df_stores, df_products, dim_date)
    
    # 6. Aux
    generate_finance(config, out_path, dim_date, dim_exp_cat)
    generate_hr(config, out_path, df_employees, dim_date) 
    generate_marketing(config, out_path, dim_date, df_products)
    generate_support(config, out_path, df_customers, df_employees, dim_date)
    
    # 7. SQL Scripts
    from .sql_generator import generate_sql_scripts
    generate_sql_scripts(out_path)
    
    print(f"\n✨ Generation Complete! Data saved to {out_path}")

if __name__ == '__main__':
    main()
