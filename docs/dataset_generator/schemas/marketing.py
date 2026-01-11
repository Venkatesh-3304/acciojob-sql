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
    
    # 2. Ad Spends (Daily spend per campaign)
    print("  ... Ad Spends")
    n_ads = config["marketing"]["n_ads_spend"]
    
    # Random daily spends linked to campaigns
    camp_ids = df_camp['campaign_id'].values
    
    df_ads = pd.DataFrame({
        "spend_id": np.arange(1, n_ads + 1),
        "campaign_id": np.random.choice(camp_ids, size=n_ads),
        "spend_date": np.random.choice(dim_date['date_key'], size=n_ads),
        "amount": np.round(np.random.uniform(100, 5000, size=n_ads), 2),
        "platform": np.random.choice(['Google', 'Facebook', 'Instagram', 'LinkedIn', 'Twitter'], size=n_ads)
    })
    write_csv(df_ads, output_dir / "marketing" / "ads_spend.csv")
    
    # 3. Email Metrics (Blast performance)
    print("  ... Email Clicks")
    # Often aggregated by campaign or individual blasts. 
    # Let's say one record per email blast event
    n_emails = 500 # Number of blasts
    
    df_email = pd.DataFrame({
        "email_id": np.arange(1, n_emails + 1),
        "campaign_id": np.random.choice(camp_ids, size=n_emails),
        "sent_date": np.random.choice(dim_date['date_key'], size=n_emails),
        "emails_sent": np.random.randint(1000, 50000, size=n_emails),
        "emails_opened": np.random.randint(100, 20000, size=n_emails),
        "emails_clicked": np.random.randint(10, 5000, size=n_emails) 
    })
    write_csv(df_email, output_dir / "marketing" / "email_clicks.csv")
