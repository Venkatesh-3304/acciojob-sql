\connect retailmart;
CREATE SCHEMA IF NOT EXISTS hr;

CREATE TABLE IF NOT EXISTS hr.attendance (
  attendance_id int PRIMARY KEY,
  employee_id int REFERENCES stores.employees(employee_id),
  check_in timestamp,
  check_out timestamp
);

CREATE TABLE IF NOT EXISTS hr.salary_history (
  payment_id int PRIMARY KEY,
  employee_id int REFERENCES stores.employees(employee_id),
  amount numeric(12,2),
  payment_date date,
  status varchar(20)
);
