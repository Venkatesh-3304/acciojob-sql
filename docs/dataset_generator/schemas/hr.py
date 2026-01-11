import pandas as pd
import numpy as np
import random
from ..utils import write_csv

def generate_hr(config, output_dir, df_employees, dim_date):
    print("👥 Building HR...")
    
    # Needs employees to exist
    att_days = config["hr"]["attendance_days"]
    
    # Generate attendance for last N days for all active employees
    # Simplified: Random check-ins
    print("  Generating Attendance...")
    
    # Just generating random attendance logs
    # N rows = Employees * 30 days roughly
    n_recs = len(df_employees) * 30
    e_ids = np.random.choice(df_employees['employee_id'], size=n_recs)
    dates = np.random.choice(dim_date['date_key'], size=n_recs)
    
    df_att = pd.DataFrame({
        "attendance_id": np.arange(1, n_recs + 1),
        "employee_id": e_ids,
        "check_in": [pd.Timestamp(d) + pd.Timedelta(hours=random.randint(8, 11)) for d in dates],
        "check_out": [pd.Timestamp(d) + pd.Timedelta(hours=random.randint(17, 20)) for d in dates]
    })
    write_csv(df_att, output_dir / "hr" / "attendance.csv")
