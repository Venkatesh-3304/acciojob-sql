\connect retailmart;
CREATE SCHEMA IF NOT EXISTS support;

CREATE TABLE IF NOT EXISTS support.tickets (
  ticket_id int PRIMARY KEY,
  customer_id int REFERENCES customers.customers(customer_id),
  agent_id int REFERENCES stores.employees(employee_id),
  category varchar(50),
  priority varchar(20),
  status varchar(20),
  created_date date,
  resolved_date date,
  subject text
);
