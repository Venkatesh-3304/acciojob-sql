\connect retailmart;
CREATE SCHEMA IF NOT EXISTS customers;

CREATE TABLE IF NOT EXISTS customers.customers (
  customer_id int PRIMARY KEY,
  first_name varchar(50),
  last_name varchar(50),
  email varchar(100),
  phone varchar(20),
  registration_date date
);

CREATE TABLE IF NOT EXISTS customers.addresses (
  address_id int PRIMARY KEY,
  customer_id int REFERENCES customers.customers(customer_id),
  address_line text,
  city varchar(50),
  state varchar(50),
  pincode varchar(10),
  is_default boolean
);

CREATE TABLE IF NOT EXISTS customers.reviews (
  review_id int PRIMARY KEY,
  customer_id int REFERENCES customers.customers(customer_id),
  product_id int,
  rating int,
  review_text text,
  review_date date
);

CREATE TABLE IF NOT EXISTS customers.loyalty_points (
  loyalty_id int PRIMARY KEY,
  customer_id int REFERENCES customers.customers(customer_id),
  points_earned int,
  source varchar(50),
  date_earned date
);
