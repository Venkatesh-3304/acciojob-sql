import pandas as pd
from pathlib import Path
import os

def ensure_dirs(paths):
    for p in paths:
        os.makedirs(p, exist_ok=True)

def write_csv(df: pd.DataFrame, path: Path):
    path.parent.mkdir(parents=True, exist_ok=True)
    df.to_csv(path, index=False, encoding='utf-8')
    print(f"✅ {path.name} ({len(df)} rows)")
