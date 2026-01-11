-- RetailMart parameterized loader
-- Usage: psql -v data_path='datasets/csv_raw' -f datasets/sql/retailmart_all_schemas_load_csv.sql
\echo 'Loading data from :'data_path

\copy core.dim_date FROM :'data_path'/core/dim_date.csv WITH (FORMAT csv, HEADER true, DELIMITER ',', QUOTE '"', NULL '');
\copy core.dim_region FROM :'data_path'/core/dim_region.csv WITH (FORMAT csv, HEADER true, DELIMITER ',', QUOTE '"', NULL '');
\copy core.dim_category FROM :'data_path'/core/dim_category.csv WITH (FORMAT csv, HEADER true, DELIMITER ',', QUOTE '"', NULL '');
\copy core.dim_brand FROM :'data_path'/core/dim_brand.csv WITH (FORMAT csv, HEADER true, DELIMITER ',', QUOTE '"', NULL '');
\copy core.dim_department FROM :'data_path'/core/dim_department.csv WITH (FORMAT csv, HEADER true, DELIMITER ',', QUOTE '"', NULL '');
\copy core.dim_expense_category FROM :'data_path'/core/dim_expense_category.csv WITH (FORMAT csv, HEADER true, DELIMITER ',', QUOTE '"', NULL '');
\copy customers.customers FROM :'data_path'/customers/customers.csv WITH (FORMAT csv, HEADER true, DELIMITER ',', QUOTE '"', NULL '');
\copy customers.addresses FROM :'data_path'/customers/addresses.csv WITH (FORMAT csv, HEADER true, DELIMITER ',', QUOTE '"', NULL '');
\copy customers.reviews FROM :'data_path'/customers/reviews.csv WITH (FORMAT csv, HEADER true, DELIMITER ',', QUOTE '"', NULL '');
\copy customers.loyalty_points FROM :'data_path'/customers/loyalty_points.csv WITH (FORMAT csv, HEADER true, DELIMITER ',', QUOTE '"', NULL '');
\copy stores.stores FROM :'data_path'/stores/stores.csv WITH (FORMAT csv, HEADER true, DELIMITER ',', QUOTE '"', NULL '');
\copy stores.employees FROM :'data_path'/stores/employees.csv WITH (FORMAT csv, HEADER true, DELIMITER ',', QUOTE '"', NULL '');
\copy stores.expenses FROM :'data_path'/stores/expenses.csv WITH (FORMAT csv, HEADER true, DELIMITER ',', QUOTE '"', NULL '');
\copy products.suppliers FROM :'data_path'/products/suppliers.csv WITH (FORMAT csv, HEADER true, DELIMITER ',', QUOTE '"', NULL '');
\copy products.products FROM :'data_path'/products/products.csv WITH (FORMAT csv, HEADER true, DELIMITER ',', QUOTE '"', NULL '');
\copy products.inventory FROM :'data_path'/products/inventory.csv WITH (FORMAT csv, HEADER true, DELIMITER ',', QUOTE '"', NULL '');
\copy products.promotions FROM :'data_path'/products/promotions.csv WITH (FORMAT csv, HEADER true, DELIMITER ',', QUOTE '"', NULL '');
\copy sales.orders FROM :'data_path'/sales/orders.csv WITH (FORMAT csv, HEADER true, DELIMITER ',', QUOTE '"', NULL '');
\copy sales.order_items FROM :'data_path'/sales/order_items.csv WITH (FORMAT csv, HEADER true, DELIMITER ',', QUOTE '"', NULL '');
\copy sales.payments FROM :'data_path'/sales/payments.csv WITH (FORMAT csv, HEADER true, DELIMITER ',', QUOTE '"', NULL '');
\copy sales.shipments FROM :'data_path'/sales/shipments.csv WITH (FORMAT csv, HEADER true, DELIMITER ',', QUOTE '"', NULL '');
\copy sales.returns FROM :'data_path'/sales/returns.csv WITH (FORMAT csv, HEADER true, DELIMITER ',', QUOTE '"', NULL '');
\copy finance.expenses FROM :'data_path'/finance/expenses.csv WITH (FORMAT csv, HEADER true, DELIMITER ',', QUOTE '"', NULL '');
\copy finance.revenue_summary FROM :'data_path'/finance/revenue_summary.csv WITH (FORMAT csv, HEADER true, DELIMITER ',', QUOTE '"', NULL '');
\copy hr.attendance FROM :'data_path'/hr/attendance.csv WITH (FORMAT csv, HEADER true, DELIMITER ',', QUOTE '"', NULL '');
\copy hr.salary_history FROM :'data_path'/hr/salary_history.csv WITH (FORMAT csv, HEADER true, DELIMITER ',', QUOTE '"', NULL '');
\copy marketing.campaigns FROM :'data_path'/marketing/campaigns.csv WITH (FORMAT csv, HEADER true, DELIMITER ',', QUOTE '"', NULL '');
\copy marketing.ads_spend FROM :'data_path'/marketing/ads_spend.csv WITH (FORMAT csv, HEADER true, DELIMITER ',', QUOTE '"', NULL '');
\copy marketing.email_clicks FROM :'data_path'/marketing/email_clicks.csv WITH (FORMAT csv, HEADER true, DELIMITER ',', QUOTE '"', NULL '');
\copy support.tickets FROM :'data_path'/support/tickets.csv WITH (FORMAT csv, HEADER true, DELIMITER ',', QUOTE '"', NULL '');