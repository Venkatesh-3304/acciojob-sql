\connect retailmart;
\echo 'Creating all schemas under retailmart...'
\i core_schema.sql
\i customers_schema.sql
\i stores_schema.sql
\i products_schema.sql
\i sales_schema.sql
\i finance_schema.sql
\i hr_schema.sql
\i marketing_schema.sql
\i support_schema.sql