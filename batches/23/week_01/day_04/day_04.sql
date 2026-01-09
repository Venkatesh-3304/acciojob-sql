-- RetailMart needs delivery tracking with dates, slots, and durations.
SHOW SEARCH_PATH;

CREATE SCHEMA DAY_04;

SET
	SEARCH_PATH TO DAY_04;

CREATE TABLE DELIVERY_TRACKING (
	TRACKING_ID SERIAL,
	ORDER_ID INT,
	EXPECTED_DATE DATE,
	TIME_SLOT_START TIME,
	DISPATCHED_AT TIMESTAMP,
	DELIVERY_DURATION INTERVAL
);

INSERT INTO
	DELIVERY_TRACKING
VALUES
	(
		1,
		1,
		'2026-01-09',
		'21:24:45.2345',
		NOW(),
		'3 days 2 hours 4 minutes'
	);

SELECT
	*
FROM
	DELIVERY_TRACKING;


CREATE TABLE CUSTOMERS (CUST_ID VARCHAR(2))

ALTER TABLE CUSTOMERS
ADD COLUMN CUST_NAME VARCHAR(200);


ALTER TABLE CUSTOMERS
ADD COLUMN RANDOM VARCHAR(200);

SELECT
	*
FROM
	CUSTOMERS;

ALTER TABLE CUSTOMERS
DROP COLUMN RANDOM;

ALTER TABLE CUSTOMERS
ALTER COLUMN CUST_ID TYPE INT USING CUST_ID::INT;

ALTER TABLE CUSTOMERS
ADD COLUMN AGE int;

ALTER TABLE CUSTOMERS
ALTER COLUMN AGE TYPE SMALLINT;

ALTER TABLE CUSTOMERS
RENAME COLUMN CUST_NAME TO FULL_NAME;


NOT NULL

Build a customer registration system where name and phone are mandatory.

CREATE TABLE DEMO_CUSTOMERS (
	CUSTOMER_ID SERIAL,
	FIRST_NAME VARCHAR(50) NOT NULL,
	MIDDLE_NAME VARCHAR(50),
	LAST_NAME VARCHAR(50) NOT NULL,
	PHONE VARCHAR(15) NOT NULL,
	EMAIL VARCHAR(100),
	REGISTRATION_DATE DATE NOT NULL
);

INSERT INTO demo_customers (first_name, last_name, phone, registration_date)
VALUES ('Rahul', 'Kumar', '9876543210', '2024-01-15');

INSERT INTO demo_customers (first_name, last_name, registration_date)
VALUES ('Priya', 'Sharma', '2024-01-15');

UNIQUE CONSTRAINT

CREATE TABLE demo_employees (
    emp_id SERIAL,
    emp_code VARCHAR(10) UNIQUE,           -- Each employee gets unique code
    emp_name VARCHAR(100) NOT NULL,        -- Names can repeat
    email VARCHAR(100) UNIQUE not null,    -- Email must be unique
    department VARCHAR(50),
    salary NUMERIC(12,2),
    join_date DATE NOT NULL
);

INSERT INTO demo_employees (emp_code, emp_name, email, department, salary, join_date)
VALUES ('EMP001', 'Rahul Sharma', 'rahul.sharma@company.com', 'IT', 850000, '2024-01-10'),
       ('EMP002', 'Rahul Verma', 'rahul.verma@company.com', 'HR', 720000, '2024-01-15');

INSERT INTO demo_employees (emp_code, emp_name, email, department, salary, join_date)
VALUES (NULL, 'Priya Singh', 'priya5@company.com', 'Finance', 800000, '2024-01-20');


select * from demo_employees;
