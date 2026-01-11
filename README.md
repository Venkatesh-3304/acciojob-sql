# 🎓 SQL Curriculum (PostgreSQL Edition)

**Instructor:** Sayyed Shiraj Ahmad (Ali)  
**Platform:** PostgreSQL 16 · pgAdmin 4 · Azure Data Studio  
**Duration:** 6 Weeks | 18 Sessions  
**Database:** RetailMart (10 + Schemas · 100 + Tables · 1 M + Rows)

---

## 📘 Overview

This repository contains the complete SQL curriculum designed for **Data Analytics** learners.  
It focuses on mastering **PostgreSQL** through practical exercises, relational modeling, and analytical problem-solving.

Each batch has its own customized folder under `batches/`, while the **curriculum templates** are maintained under `docs/templates/curriculum/`.  
Instructor-only setup and automation scripts remain hidden from GitHub (`docs/templates/sh/`, `docs/setup/`, and `docs/scripts/`).

All datasets and templates are standardized for **reusability** and **automation**.

---

## 🗂️ Folder Structure

| Folder                          | Description                                                 |
| ------------------------------- | ----------------------------------------------------------- |
| `batches/`                      | Student-facing batch folders with Excel notes & assignments |
| `datasets/`                     | RetailMart dataset (multi-schema CSV + SQL files)           |
| `docs/templates/curriculum/`    | Visible curriculum templates shared with students           |
| _(hidden)_ `docs/scripts/`      | Instructor notebooks and automation code                    |
| _(hidden)_ `docs/templates/sh/` | Instructor shell scripts                                    |
| _(hidden)_ `docs/setup/`        | Local setup guides copied automatically into batches        |
| `.gitignore`                    | Ensures all private/instructor files remain hidden          |

---

## 🧠 Topics Covered

### 1️⃣ PostgreSQL Installation & Setup

- DBMS vs RDBMS concepts
- Database creation, pgAdmin setup, psql basics
- Connecting via Azure Data Studio

### 2️⃣ SQL Basics & Data Types

- DDL, DML, DQL commands
- Constraints, normalization, data integrity

### 3️⃣ Data Filtering & Aggregation

- `WHERE`, `LIKE`, `GROUP BY`, `HAVING`, `CASE WHEN`

### 4️⃣ Joins & Relationships

- `INNER`, `LEFT`, `RIGHT`, `FULL`, `SELF`, `CROSS` joins

### 5️⃣ Subqueries & CTEs

- Scalar and correlated subqueries
- Recursive CTEs and analytical queries

### 6️⃣ Views, Indexing & Transactions

- `CREATE VIEW`, `MATERIALIZED VIEW`, indexing strategies
- `BEGIN`, `COMMIT`, `ROLLBACK`

### 7️⃣ Functions & Window Functions

- `RANK()`, `DENSE_RANK()`, `LAG()`, `LEAD()`

### 8️⃣ Final Project — RetailMart Analytics

- End-to-end SQL analysis on the RetailMart dataset

---

## 🧩 RetailMart Database (Enterprise Dataset v4)

A realistic **multi-schema PostgreSQL database** simulating a large retail ecosystem with customers, products, stores, sales, HR, finance, and marketing data.

| Schema      | Key Tables                                                  | Learning Focus           |
| ----------- | ----------------------------------------------------------- | ------------------------ |
| `core`      | `dim_date`, `dim_region`, `dim_category`, `dim_brand`       | Shared dimensions        |
| `customers` | `customers`, `addresses`, `reviews`, `loyalty_points`       | Subqueries & joins       |
| `products`  | `products`, `suppliers`, `inventory`, `promotions`          | PK/FK & normalization    |
| `stores`    | `stores`, `employees`, `departments`, `expenses`            | Aggregations & group BY  |
| `sales`     | `orders`, `order_items`, `payments`, `shipments`, `returns` | Window functions         |
| `finance`   | `expenses`, `revenue_summary`                               | CASE WHEN & calculations |
| `hr`        | `attendance`, `salary_history`                              | Date/time analytics      |
| `marketing` | `campaigns`, `ads_spend`, `email_clicks`                    | Joins + CTEs             |

---

## 📁 Dataset Files (in `/datasets`)

| File                                                | Description                                       |
| --------------------------------------------------- | ------------------------------------------------- |
| `/datasets/sql/retailmart_create_database.sql`      | Creates the database                              |
| `/datasets/sql/retailmart_all_schemas_create.sql`   | Creates all schemas (auto-switch to `retailmart`) |
| `/datasets/sql/retailmart_all_schemas_load_csv.sql` | Loads all CSV data                                |
| `/datasets/csv/<schema>/*.csv`                      | Data files per schema                             |

---

## 🚀 Getting Started (Students)

### Step 1 — Clone the Repository

```bash
git clone https://github.com/starlordali4444/sql-curriculum.git
cd sql-curriculum
```

### Step 2 — Create Database & Schemas

```bash
psql -U postgres -d postgres -f datasets/sql/retailmart_all_schemas_create.sql
```

### Step 3 — Load All CSV Data

```bash
psql -U postgres -d retailmart -f datasets/sql/retailmart_all_schemas_load_csv.sql
```

### Step 4 — Verify

```sql
\c retailmart
\dn
SELECT COUNT(*) FROM sales.orders;
```

---

## 🧹 Instructor One-Time Maintenance

If schemas were accidentally created in the default `postgres` DB:

```sql
\c postgres
DROP SCHEMA IF EXISTS core, customers, products, stores, sales, finance, hr, marketing CASCADE;
REVOKE CREATE ON DATABASE postgres FROM PUBLIC;
```

---

## 📚 Documentation Index

| Section                     | Location                                                                             | Description                                                 |
| --------------------------- | ------------------------------------------------------------------------------------ | ----------------------------------------------------------- |
| 🧱 **SQL Scripts**          | [`datasets/sql/00_README.md`](./datasets/sql/00_README.md)                           | Schema creation, loaders, and dependency order              |
| 📊 **CSV Datasets**         | [`datasets/csv/00_README.md`](./datasets/csv/00_README.md)                           | Data structure, schema-wise details, and validation queries |
| 📚 **Curriculum Templates** | [`docs/templates/curriculum/00_README.md`](./docs/templates/curriculum/00_README.md) | Student-facing week/day folder templates for each batch     |

---

# ⚙️ Instructor Automation Scripts

## 📘 Overview

This section explains all **instructor-facing automation tools** used to manage curriculum batches, generate datasets, and handle PostgreSQL setup tasks.  
These tools are **not visible to students** — they are used locally to automate repetitive setup and content-generation workflows.

---

## 🗂️ Tools Overview

| File                                | Type    | Description                                                               |
| ----------------------------------- | ------- | ------------------------------------------------------------------------- |
| `build_retailmart_dataset_v4.ipynb` | Jupyter | Generates the RetailMart dataset (CSV + SQL) using JSON data banks        |
| `create_batch.sh`                   | Shell   | Copies instructor curriculum and setup templates into a new batch folder  |
| `create_curriculum_template.sh`     | Shell   | Builds the reusable week/day folder structure for instructors             |
| `install_postgresql_mac.sh`         | Shell   | One-click PostgreSQL installation for macOS users                         |
| _(future)_ `validate_dataset.sh`    | Shell   | Script to quickly check dataset integrity (row counts, schema validation) |

---

## 🧩 Workflow Summary

### 🧱 Dataset Generation

Use the Jupyter notebook **`build_retailmart_dataset_v4.ipynb`** to create the RetailMart dataset.  
It automatically generates:

- `/datasets/sql/*.sql` (schema + loaders)
- `/datasets/csv/<schema>/*.csv` (data files)
- Cleans duplicates and ensures referential integrity.

#### Run Command:

```bash
jupyter notebook docs/scripts/build_retailmart_dataset_v4.ipynb
```

---

### 🏗️ Batch Creation

Use **`create_batch.sh`** to generate new batch folders from instructor templates.

#### Example:

```bash
bash docs/scripts/create_batch.sh 21
```

✅ Creates `/batches/21/` with:

- All day/week folders
- Setup markdown files
- Installer script for Day 1 (`install_postgresql_mac.sh`)

---

### 🧰 Curriculum Template Builder

Use **`create_curriculum_template.sh`** to generate the weekly skeleton structure inside `docs/templates/curriculum/`.

#### Example:

```bash
bash docs/scripts/create_curriculum_template.sh week_05
```

This script builds a week/day layout with placeholders for notes, exercises, and queries.

---

### 💻 PostgreSQL Installation Script

**`install_postgresql_mac.sh`** provides a guided installation on macOS, including:

- Homebrew install for PostgreSQL 16
- Service start validation
- pgAdmin & ADS installation notes

It is automatically copied into each batch’s `day_01` folder for student use.

---

## 🧠 Automation Highlights

- Clean file path logic for instructor-only content
- Safety checks to avoid missing template folders
- Supports future integration for validation or CI/CD steps

---

## ⚠️ Note

These scripts are intended for **instructor environments only**.  
They are **ignored in `.gitignore`** and never synced to GitHub public view.

---

## 🧾 Credits

Developed and maintained by **Sayyed Shiraj Ahmad (Ali)**  
for the **SQL Curriculum (PostgreSQL Edition)**

> _“Learn by doing, automate by design.”_
