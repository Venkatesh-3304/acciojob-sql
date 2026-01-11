\connect retailmart;
CREATE SCHEMA IF NOT EXISTS products;

CREATE TABLE IF NOT EXISTS products.suppliers (
  supplier_id int PRIMARY KEY,
  supplier_name varchar(100),
  contact_name varchar(100),
  city varchar(50),
  email varchar(100)
);

CREATE TABLE IF NOT EXISTS products.products (
  product_id int PRIMARY KEY,
  product_name varchar(150),
  brand_id int REFERENCES core.dim_brand(brand_id),
  supplier_id int REFERENCES products.suppliers(supplier_id),
  price numeric(12,2),
  cost_price numeric(12,2)
);

CREATE TABLE IF NOT EXISTS products.inventory (
  store_id int REFERENCES stores.stores(store_id),
  product_id int REFERENCES products.products(product_id),
  quantity_on_hand int,
  reorder_level int,
  PRIMARY KEY (store_id, product_id)
);

CREATE TABLE IF NOT EXISTS products.promotions (
  promo_id int PRIMARY KEY,
  promo_name varchar(100),
  discount_percent int,
  start_date date,
  end_date date,
  active boolean
);
