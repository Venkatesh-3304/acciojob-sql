from pathlib import Path

# Base Paths
BASE_DIR = Path(__file__).parent.parent.parent.resolve()
DATASETS_DIR = BASE_DIR / "datasets"
CSV_ROOT_RAW = DATASETS_DIR / "csv_raw"
CSV_ROOT_CLEANED = DATASETS_DIR / "csv_cleaned"
SQL_ROOT = DATASETS_DIR / "sql"

# Default Configuration
DEFAULT_CONFIG = {
    "seed": 42,
    "core": { "dim_date_years": 3 },
    "customers": { "n_customers": 50000, "n_reviews": 30000 },
    "products":  { "n_inventory_pairs": 120000, "n_promotions": 800 },
    "stores":    { "n_stores": 200, "n_employees": 3000, "n_expenses": 20000 },
    "sales":     { "n_orders": 150000, "items_per_order_min": 1, "items_per_order_max": 4, "return_rate": 0.08 },
    "finance":   { "n_expenses": 40000 },
    "hr":        { "attendance_days": 90, "salary_events": 8000 },
    "marketing": { "n_campaigns": 250, "n_ads_spend": 4000, "n_email_clicks": 30000 },
}

# Constants
REGIONS = ["North", "South", "East", "West", "Central"]
PAY_MODES = ["UPI", "Credit Card", "Debit Card", "Cash", "Net Banking"]
ORDER_STATUS = ["Delivered", "Shipped", "Cancelled", "Returned"]
EMP_ROLES = ["Store Manager", "Assistant Manager", "Cashier", "Inventory Clerk",
             "Sales Executive", "Customer Service Rep", "Marketing Associate",
             "Finance Executive", "HR Executive", "Data Analyst"]
DEPARTMENTS = ["Sales", "Operations", "Marketing", "Finance", "HR", "IT"]
