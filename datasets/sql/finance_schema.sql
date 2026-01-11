\connect retailmart;
CREATE SCHEMA IF NOT EXISTS finance;

CREATE TABLE IF NOT EXISTS finance.expenses (
  expense_id int PRIMARY KEY,
  expense_date date,
  exp_cat_id int REFERENCES core.dim_expense_category(exp_cat_id),
  amount numeric(12,2),
  description text
);
