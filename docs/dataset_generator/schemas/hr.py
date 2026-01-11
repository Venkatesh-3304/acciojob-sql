import pandas as pd
import numpy as np
import random
from faker import Faker
from ..utils import write_csv

fake = Faker('en_IN')

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
    
    # 2. Salary Payments
    print("  ... Salary Payments")
    # Generate last 6 months salaries for all employees
    sal_data = []
    # Assume monthly pay on 1st or 28th
    # For simplicity, 3 payouts per employee
    emp_list = df_employees.to_dict('records')
    payout_dates = [fake.date_between(start_date='-3m', end_date='today') for _ in range(3)] 
    
    pay_id = 1
    for emp in emp_list:
        base = emp['salary']
        for d in payout_dates:
            sal_data.append({
                "payment_id": pay_id,
                "employee_id": emp['employee_id'],
                "amount": round(base/12, 2), # Monthly portion
                "payment_date": d,
                "status": "Processed"
            })
            pay_id += 1
            
    df_sal = pd.DataFrame(sal_data)
    write_csv(df_sal, output_dir / "hr" / "salary_history.csv")

