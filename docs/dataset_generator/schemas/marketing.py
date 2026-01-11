import pandas as pd
import numpy as np
from ..utils import write_csv
from faker import Faker
import random

fake = Faker('en_IN')

def generate_marketing(config, output_dir, dim_date, df_products):
    print("📢 Building Marketing...")
    n_camp = config["marketing"]["n_campaigns"]
    
    # Campaigns
    c_names = [fake.catch_phrase() for _ in range(n_camp)]
    dates = np.random.choice(dim_date['date_key'], size=n_camp)
    
    df_camp = pd.DataFrame({
        "campaign_id": np.arange(1, n_camp + 1),
        "campaign_name": c_names,
        "start_date": dates,
        "end_date": [pd.Timestamp(d) + pd.Timedelta(days=random.randint(5, 30)) for d in dates],
        "budget": np.round(np.random.uniform(10000, 1000000, size=n_camp), 2)
    })
    write_csv(df_camp, output_dir / "marketing" / "campaigns.csv")
