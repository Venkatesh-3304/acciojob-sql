\connect retailmart;
CREATE SCHEMA IF NOT EXISTS stores;

CREATE TABLE IF NOT EXISTS stores.stores (
  store_id int PRIMARY KEY,
  store_name varchar(100),
  region_id int REFERENCES core.dim_region(region_id),
  city varchar(50),
  square_ft int,
  opening_date date
);

CREATE TABLE IF NOT EXISTS stores.employees (
  employee_id int PRIMARY KEY,
  store_id int REFERENCES stores.stores(store_id),
  first_name varchar(50),
  last_name varchar(50),
  email varchar(100),
  role varchar(50),
  dept_id int REFERENCES core.dim_department(dept_id),
  joining_date date,
  salary int
);
