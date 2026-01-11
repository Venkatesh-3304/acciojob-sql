import pandas as pd
import numpy as np
from datetime import datetime, timedelta
import random
from ..utils import write_csv

def generate_finance(config, output_dir, dim_date, dim_exp_cat):
    print("💰 Building Finance...")
    n_exp = config["finance"]["n_expenses"]
    
    # Generate random expenses
    dates = np.random.choice(dim_date['date_key'], size=n_exp)
    amounts = np.round(np.random.uniform(100, 50000, size=n_exp), 2)
    
    # Use IDs
    exp_cat_ids = dim_exp_cat['exp_cat_id'].values
    cat_ids = np.random.choice(exp_cat_ids, size=n_exp)
    
    # Ideally link description to category name, but simple description is fine
    desc = [f"Expense transaction {i}" for i in range(n_exp)] 
    
    df_finance = pd.DataFrame({
        "expense_id": np.arange(1, n_exp + 1),
        "expense_date": dates,
        "exp_cat_id": cat_ids, # Normalized
        "amount": amounts,
        "description": desc
    })
    write_csv(df_finance, output_dir / "finance" / "expenses.csv")
    
    # 2. Revenue Summary (Aggregates)
    print("  ... Revenue Summary")
    # This is normally a view or calculated table. We'll generate a summary table 
    # that roughly tracks the sales volume (we won't query sales directly to keep modules decoupled in generation 
    # unless we pass df_orders, but here we can just simulate matching trends).
    # Ideally: It should match sales. But config["sales"] helps us estimate.
    
    # Let's generate daily revenue for the last 3 years
    rev_dates = dim_date['date_key'].values
    n_days = len(rev_dates)
    
    # Random fluctuation base
    rev_amounts = np.random.uniform(50000, 500000, size=n_days)
    
    df_rev = pd.DataFrame({
        "summary_id": np.arange(1, n_days + 1),
        "summary_date": rev_dates,
        "total_revenue": np.round(rev_amounts, 2),
        "total_orders": np.random.randint(50, 500, size=n_days),
        "avg_order_value": np.round(rev_amounts / np.random.randint(50, 500, size=n_days), 2)
    })
    write_csv(df_rev, output_dir / "finance" / "revenue_summary.csv")
