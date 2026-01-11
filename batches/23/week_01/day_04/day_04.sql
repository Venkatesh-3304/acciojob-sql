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


SHOW SEARCH_PATH;

SET
	SEARCH_PATH TO DAY_04;

CREATE TABLE DEMO_REVIEWS (
	REVIEW_ID SERIAL,
	PRODUCT_ID INT NOT NULL,
	CUSTOMER_ID INT NOT NULL,
	RATING SMALLINT NOT NULL CHECK (RATING BETWEEN 1 AND 5),
	REVIEW_TEXT TEXT CHECK (LENGTH(REVIEW_TEXT) >= 10),
	REVIEW_DATE DATE NOT NULL,
	HELPFUL_VOTES INT CHECK (HELPFUL_VOTES >= 0)
);

INSERT INTO
	DEMO_REVIEWS (
		PRODUCT_ID,
		CUSTOMER_ID,
		RATING,
		REVIEW_TEXT,
		REVIEW_DATE
	)
VALUES
	(
		101,
		5002,
		5,
		'Good product overall',
		'2024-01-16'
	);

INSERT INTO
	DEMO_REVIEWS (
		PRODUCT_ID,
		CUSTOMER_ID,
		RATING,
		REVIEW_TEXT,
		REVIEW_DATE
	)
VALUES
	(101, 5003, 4, 'Nice!', '2024-01-17');

SELECT
	*
FROM
	DEMO_REVIEWS;


CREATE TABLE USERS (
	USER_ID SERIAL,
	USERNAME VARCHAR(50) NOT NULL UNIQUE,
	EMAIL VARCHAR(100) NOT NULL UNIQUE,
	PASSWORD_HASH VARCHAR(255) NOT NULL,
	ACCOUNT_STATUS VARCHAR(20) DEFAULT 'Active',
	ACCOUNT_TYPE VARCHAR(20) DEFAULT 'Free',
	IS_PROFILE_COMPLETE BOOLEAN DEFAULT FALSE,
	LOGIN_COUNT INT DEFAULT 0,
	CREATED_AT TIMESTAMP DEFAULT NOW()
);

INSERT INTO users (username, email, password_hash,account_type)
VALUES ('tech_rahul', 'rahul@gmail.com', 'hashed_password_123',NULL);

select * from users;


CREATE TABLE DEMO_STORES (
	STORE_ID SERIAL PRIMARY KEY,
	STORE_NAME VARCHAR(120) NOT NULL,
	STORE_CODE VARCHAR(10) UNIQUE NOT NULL,
	CITY VARCHAR(50) NOT NULL,
	STATE VARCHAR(50) NOT NULL,
	OPENING_DATE DATE,
	MONTHLY_RENT NUMERIC(12, 2)
);

INSERT INTO
	DEMO_STORES (
		STORE_NAME,
		STORE_CODE,
		CITY,
		STATE,
		OPENING_DATE,
		MONTHLY_RENT
	)
VALUES
	(
		'D-Mart Andheri',
		'DM-MUM-001',
		'Mumbai',
		'Maharashtra',
		'2020-03-15',
		250000.00
	),
	(
		'D-Mart Whitefield',
		'DM-BLR-001',
		'Bangalore',
		'Karnataka',
		'2019-08-20',
		180000.00
	);


INSERT INTO demo_stores (store_id, store_name, store_code, city, state)
VALUES (1, 'D-Mart Pune', 'DM-PUN-001', 'Pune', 'Maharashtra');


CREATE TABLE DEMO_INVENTORY (
	STORE_ID INT,
	PROD_ID INT,
	STOCK_QUANTITY INT NOT NULL DEFAULT 0 CHECK (STOCK_QUANTITY >= 0),
	REORDER_LEVEL INT DEFAULT 10,
	MAX_STOCK INT DEFAULT 100,
	LAST_UPDATED_AT TIMESTAMP DEFAULT NOW(),
	PRIMARY KEY (STORE_ID, PROD_ID)
);

INSERT INTO demo_inventory (store_id, prod_id, stock_quantity, reorder_level, max_stock) VALUES
(1, 101, 45, 10, 100),   
(1, 102, 120, 20, 200),  
(2, 101, 30, 10, 80),    
(1, 101, 150,30,null)


-- Step 1: Create PARENT table first (departments)
CREATE TABLE DEMO_DEPARTMENTS (
	DEPT_ID SERIAL PRIMARY KEY,
	DEPT_NAME VARCHAR(50) NOT NULL UNIQUE,
	DEPT_HEAD VARCHAR(100),
	BUDGET NUMERIC(14, 2)
);

-- Step 2: Create CHILD table with foreign key (employees)
CREATE TABLE DEMO_EMP (
	EMP_ID SERIAL PRIMARY KEY,
	EMP_NAME VARCHAR(100) NOT NULL,
	EMAIL VARCHAR(100) UNIQUE NOT NULL,
	SALARY NUMERIC(12, 2),
	DEPT_ID INT REFERENCES DEMO_DEPARTMENTS (DEPT_ID)
);

-- Step 3: Insert departments FIRST
INSERT INTO
	DEMO_DEPARTMENTS (DEPT_NAME, DEPT_HEAD, BUDGET)
VALUES
	('Engineering', 'Rajesh Kumar', 5000000.00),
	('Marketing', 'Priya Sharma', 2000000.00);

INSERT INTO
	DEMO_EMP (EMP_NAME, EMAIL, SALARY, DEPT_ID)
VALUES
	('Amit Singh', 'amit@wipro.com', 800000, 1), -- Engineering
	('Sneha Gupta', 'sneha@wipro.com', 700000, 2);

-- Marketing
INSERT INTO
	DEMO_EMP (EMP_NAME, EMAIL, SALARY, DEPT_ID)
VALUES
	('Mohan Singh', 'mohan@wipro.com', 800000, 3);

DELETE FROM DEMO_DEPARTMENTS
WHERE
	DEPT_ID = 1;


CREATE TABLE demo_posts_ (
    post_id SERIAL PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    content TEXT,
    author_name VARCHAR(100) NOT NULL
);

CREATE TABLE demo_comments_ (
    comment_id SERIAL PRIMARY KEY,
    post_id INT NOT NULL,
    commenter_name VARCHAR(100) NOT NULL,
    comment_text TEXT NOT NULL,
    FOREIGN KEY (post_id) REFERENCES demo_posts_(post_id) ON DELETE restrict
);


-- Insert post and comments
INSERT INTO demo_posts_ (title, content, author_name)
VALUES ('SQL Tips', 'Here are some tips...', 'Siraj Sir');

INSERT INTO demo_comments_ (post_id, commenter_name, comment_text) VALUES
(1, 'Rahul', 'Great article!'),
(1, 'Priya', 'Very helpful!');


select * from demo_posts_;
select * from demo_comments_;

DELETE FROM demo_posts;
	























