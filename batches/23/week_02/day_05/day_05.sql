-- Extract all the columns from the customer table Ctrl  /
SELECT
	*
FROM
	CUSTOMERS.CUSTOMERS;

SELECT
	JOIN_DATE,
	FULL_NAME,
	CITY,
	STATE
FROM
	CUSTOMERS.CUSTOMERS;

-- Scenario: 
-- 	RetailMart wants to identify all customers from Delhi who joined in 2024. 
-- 	The marketing team needs this for a regional campaign targeting new Delhi customers.
-- Task: 
-- 	Find all customers from Delhi who joined on or after January 1, 2024.
-- All Customers	=>	customers
-- 						Delhi
-- 						joined in 2024 or after that
SELECT
	*
FROM
	CUSTOMERS.CUSTOMERS
WHERE
	STATE = 'Delhi'
	AND JOIN_DATE >= '2024-01-01';


-- Scenario: 
-- The operations team at RetailMart noticed delivery delays in certain regions. 
-- They need to find all orders that are either 'Pending' or 'Processing' AND were placed more than 3 days ago (before January 7, 2025) to escalate them.
-- Table 	=>		sales.orders
SELECT
	*
FROM
	SALES.ORDERS
WHERE
	ORDER_STATUS = 'Shipped'
	AND ORDER_DATE < '2025-01-07';

SELECT DISTINCT
	ORDER_STATUS
FROM
	SALES.ORDERS;


-- The HR department needs to analyze employee compensation. 
-- They want to find employees whose salary is NOT in the standard range (between ₹30,000 and ₹80,000) for audit purposes - either too low or too high.
-- Table 	=>		stores.employees
SELECT
	*
FROM
	STORES.EMPLOYEES
WHERE
	SALARY < 30000
	OR SALARY > 80000;

The CEO wants a report on orders that need attention: 
high-value orders (>₹10,000) that are either 'Pending' or 'Processing' or 'Shipped' AND are 
NOT from the Electronics category stores. (Electronic is in Store no 58 only)

These might be stuck orders in other departments.

Select
	*
from
	sales.orders
where
	total_amount >10000
	and (order_status = 'Pending' or order_status = 'Shipped' or order_status = 'Processing')
	and (not store_id = 58)
		
Select * from products.products
where category = 'Electronics'

Electronics
	101 -220

select distinct store_id from products.inventory
where
	prod_id >100 or prod_id <221

RetailMart's marketing team wants to find all products containing 
'Phone' in their name (iPhone, Smartphone, Phone Case, etc.) for a mobile accessories campaign.'

Select
	*
from
	products.products
where
	prod_name ilike '%phone%';

Select
	*
from
	products.products
where
	prod_name like '%Phone%';

Customer support needs to find customers whose names start with 'S' and have exactly 5-letter first names (to match against a partial ID document). 
Also find customers whose email domain is Gmail.

Select 
	*
from
	customers.customers
where
	full_name like 'S____ %'
	-- or email ilike '%@gmail.com'

The finance team needs all orders placed during the festive season (October to December 2024) for revenue analysis.

select
	*
from
	sales.orders
where
	order_date >= '2024-10-01' and order_date <= '2024-12-31'


select
	*
from
	sales.orders
where
	order_date between '2024-10-01' and '2024-12-31'

RetailMart wants to analyze orders from specific high-performing stores (stores 1, 3, 5, 7) 
with order values in the premium range (₹5,000 to ₹50,000) but excluding cancelled and returned orders.

select
	*
from
	sales.orders
where
	(store_id= 1 or store_id= 3 or store_id= 5 or store_id= 7)
	and (total_amount >= 5000 and total_amount <=50000)
	and (not order_status = 'Cancelled')
	and (not order_status = 'Returned')

select
	*
from
	sales.orders
where
	store_id in (1,3,5,7)
	and total_amount between 5000 and 50000
	and order_status not in ('Cancelled','Returned')

select * from day_04.demo_departments

insert into day_04.demo_departments
values(5,'Finance',NULL,238784.3434)


select * from day_04.demo_departments
where dept_head is not null


The expansion team wants to know all unique cities where RetailMart has customers, along with their states - to identify new markets.

select 
	distinct city,state,gender
from
	customers.customers

select 
	distinct city,state
from
	customers.customers

select 
	*
from
	customers.customers

First value for each combination of city and state

select 
	distinct on(city,state)
	full_name,city,state
from
	customers.customers

select 
	distinct state,city
from
	customers.customers
where state = 'Uttar Pradesh'
order by
	state,city desc
limit
	1
offset 5