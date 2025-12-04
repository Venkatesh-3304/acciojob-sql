select
	<list of columns>
		All	=>	*
		col1,col2,col3
from
	<table_name>

The SELECT statement retrieves data from one or more tables. 
The WHERE clause filters records by specifying conditions that must be met. 
Only rows where the condition evaluates to TRUE are included in the result set.

1	=>	TRUE
2	=>	FALSE
3	=>	TRUE
4	=>	TRUE
5	=>	FALSE



Customers	=>	50 Lakh
Manager		=>	Priya
Customer	=>	Rahul Sharma
				Banglore

Select * from customer;

Select
	*
from
	customers
where
	cust_name = 'Rahul Sharma'
	and city = 'Bangalore'

Retailmart
	8 Schemas
		core
			dim_brand
			dim_category
			dim_date
			dim_region
		customers
			
		sales
		stores
		hr
		finance
		marketing
		product

Find All Customers from Mumbai

Identify schema
Identify table
Identify columns
Identify filter

Select
	*
from
	customers.customers
where city='Mumbai';

-- Find High-Value Products in Electronics Category

-- Scenario:
-- RetailMart's procurement team needs to review all electronics products priced above ₹10,000 to negotiate bulk discounts with suppliers.
-- Task:
-- Find all products in the 'Electronics' category with price greater than ₹10,000.


Select
	*
from
	products.products
where category = 'Electronics'
	and price > 10000;
	
-- Find Active Employees Earning Above Average in Non-Metro Stores
-- Scenario:
-- HR wants to identify high-performing employees in Tier-2/Tier-3 cities who earn above ₹40,000. 
-- These employees might be candidates for transfer to metro stores.
-- Task:
-- Find employees NOT in Mumbai, Delhi, Bangalore, or Chennai, with salary above ₹40,000, sorted by salary.


-- Complex Customer Segmentation Query
-- Scenario:
-- Marketing wants to identify "Young Female Customers" and "Senior Male Customers" for a targeted campaign. 
-- Young females (18-30) might prefer trendy fashion, while senior males (50+) might prefer electronics and appliances.
-- Task:
-- Find customers who are either (Female AND age between 18-30) OR (Male AND age 50 or above).

Find young females Customers and senior male Customers
	<30
	>50

Select 
	* 
from
	customers.customers
where
	(gender='F' and age >= 18 and age <=30)
	or
	(gender = 'M' and age >= 50);
	

Comparison Operators
	=
	!=
	>
	<
	>=
	<=

Logical
	not
	or
	and
	


-- Find Orders That Need Attention
-- Scenario:
-- The operations team needs to find all orders where the total amount is greater than ₹10,000 but the status is NOT 'Delivered'. 
-- These high-value pending orders need priority attention.
-- Task:
-- Find orders with total_amount > ₹10,000 and status not equal to 'Delivered'.

select
	*
from
	sales.orders
where
	total_amount > 10000
	and order_status != 'Delivered';


-- Multi-Condition Employee Analysis

-- Scenario:
-- HR is conducting a compensation review. 
-- They need to find employees who might be underpaid (salary < ₹35,000) or overpaid (salary > ₹80,000) compared to the company average of ₹45,000. 
-- Additionally, they want to see employees whose salary is NOT exactly at standard pay grades (₹30,000, ₹45,000, ₹60,000, ₹75,000).

-- Task:
-- Find employees with salary < ₹35,000 OR salary > ₹80,000, and whose salary is not equal to any standard pay grade.


Select 
	*
from	
	hr.salary_history
order by 
	emp_id

Select 
	*
from	
	stores.employees
where
	(salary < 35000 or salary > 80000)
	and salary != 30000
	and salary != 45000
	and salary != 60000
	and salary != 75000;

Find Customers from Metro Cities
Scenario:
For a premium product launch, marketing wants to target customers from any of the four metro cities: Mumbai, Delhi, Bangalore, or Chennai.
Task:
Find customers from Mumbai OR Delhi OR Bangalore OR Chennai.



Multi-Layered Business Logic
Scenario:
The CEO wants a report on "High-Risk, High-Value" orders for the board meeting:

Orders above ₹20,000 (high value) that are NOT delivered yet
OR orders of any amount that are in 'Cancelled' or 'Returned' status
But exclude orders from January 2024 (already reviewed)

Task:
Build a complex query with nested AND/OR/NOT logic.

select 
	*
from
	sales.orders
where
	(
		-- High-value pending orders
		(total_amount > 20000 and order_status != 'Delivered')
		OR
		-- Any Cancelled/returned orders
		(order_status = 'Cancelled' or order_status = 'Returned')
		AND NOT
		--Exclude January 2024 orders(already reviewed)
		(order_date >= '2024-01-01' and order_date <'2024-02-01')
	);









