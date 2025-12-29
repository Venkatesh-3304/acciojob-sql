Introduction to Subqueries

4.1 Definition

Technical Definition:
A SUBQUERY (also called an inner query or nested query) is a SQL query embedded within another SQL query. The subquery executes first, and its result is used by the outer query (also called the main query or parent query). Subqueries can return single values (scalar), single columns, single rows, or complete tables.

Layman's Terms:
Think of a subquery like asking a helper question to answer a bigger question. Imagine you're at a Diwali party and someone asks 'Who earns more than Sharma ji's son?' First, you need to find out HOW MUCH Sharma ji's son earns (the inner question), and THEN you can answer who earns more (the outer question). That's exactly what a subquery does - it answers a small question first, then uses that answer to solve the bigger problem!

4.2 The Story - Sharma Ji Ka Beta Problem!

🎭 THE DIWALI PARTY DRAMA
It's Diwali time at the Gupta family reunion in Lucknow. 50 relatives gathered, and you know what that means - the annual 'Who is doing better in life?' competition! 😄

Your curious Bua Ji walks up to you with THE question:

"Beta, tell me - who in our family earns MORE than Sharma ji's son Rahul?"

Now, here's the problem. You don't know Rahul's exact salary! You need to:
•	FIRST: Find out Rahul's salary (this is the INNER query)
•	THEN: Compare everyone else's salary with Rahul's (this is the OUTER query)

In SQL terms, Bua Ji's question becomes:

-- The OUTER query asks: Who earns more than...
SELECT relative_name, salary
FROM family_members
WHERE salary > (
    -- The INNER query finds Rahul's salary first!
    SELECT salary FROM family_members
    WHERE relative_name = 'Rahul Sharma'
);

The magic? SQL runs the INNER query first, gets Rahul's salary (let's say ₹12 LPA), then replaces the entire subquery with that value:

-- After inner query runs, it becomes:
SELECT relative_name, salary
FROM family_members
WHERE salary > 1200000;  -- Rahul's actual salary

💼 Real Job Connection: At companies like Flipkart, this exact pattern is used daily! 'Show me products priced higher than the average in Electronics category' or 'Find employees earning more than their department average' - these are subquery patterns you'll write in real jobs!
4.3 Basic Syntax

-- Basic Subquery Structure
SELECT column1, column2
FROM table_name
WHERE column_name operator (
    SELECT column_name
    FROM another_table
    WHERE condition
);

-- Key Points:
-- 1. Subquery is ALWAYS enclosed in parentheses ()
-- 2. Subquery executes FIRST, outer query uses its result
-- 3. Subquery can be placed in WHERE, SELECT, or FROM clause


Find Products Priced Above Average

Scenario: RetailMart's category manager wants to see all products that cost more than the average product price. This helps identify premium products in the catalog.'


select
	*
from
	products.products
where
	price > (
		Select 
			avg(price)
		from
			products.products
	)

Find Customers Who Spent More Than Store Average

Scenario: The marketing team at RetailMart wants to identify high-value customers - those who have spent more than the average customer spending. 
These customers will receive exclusive Diwali discount coupons!

--Total Spending customer wise
Select
	sum(total_amount)
from
	sales.orders
group by 
	cust_id

--Average Customer Spending

Select
	avg(customer_total)
from
	(
	Select
		sum(total_amount) as customer_total
	from
		sales.orders
	group by 
		cust_id
	) as customer_spending


--Find the High Value customer who spent above average
1063174.429726629909

'
Select
	c.cust_id,
	c.full_name,
	c.city,
	sum(o.total_amount) as total_spent
from
	customers.customers c
join sales.orders o
	on o.cust_id = c.cust_id
group by
	c.cust_id,
	c.full_name,
	c.city
having
	sum(o.total_amount)>(
							Select
								avg(customer_total)
							from
								(
								Select
									sum(total_amount) as customer_total
								from
									sales.orders
								group by 
									cust_id
								) as customer_spending
							)
		
-- Breaking it down:
-- 1. Innermost query: Calculate total spent per customer
-- 2. Middle query: Calculate average of those totals
-- 3. Outer query: Find customers above that average
-- This is a NESTED subquery - subquery inside a subquery!

Subquery Placements

7.1 Definition

Technical Definition:
Subqueries can be placed in three main locations within a SQL statement: 

(1) WHERE / Having clause - to filter rows based on computed values; 

(2) SELECT clause - to add computed columns to each row; 

(3) FROM / Join clause - to create derived tables (temporary result sets) that act as virtual tables. Each placement serves different purposes and has different requirements for what the subquery must return.

7.2 Subqueries in WHERE Clause

The most common placement. Used to filter rows based on values calculated dynamically. The subquery result is compared against column values to determine which rows to include.

-- Filter orders above average amount
SELECT order_id, cust_id, total_amount
FROM sales.orders
WHERE total_amount > (SELECT AVG(total_amount) FROM sales.orders);

-- Filter employees in departments with more than 5 staff
SELECT emp_id, emp_name, dept_id
FROM stores.employees
WHERE dept_id IN (
    SELECT dept_id FROM stores.employees
    GROUP BY dept_id HAVING COUNT(*) > 5
);

7.3 Subqueries in SELECT Clause

Used to add computed columns to each row. The subquery runs ONCE per row of the outer query (unless it's a simple aggregate). Must return a SCALAR value (single value) for each row.

-- Add total product count to each category
SELECT 
    prod_id,
    prod_name,
    category,
    price,
    (SELECT COUNT(*) FROM products.products) AS total_products,
    (SELECT AVG(price) FROM products.products) AS avg_catalog_price
FROM products.products
ORDER BY category;

7.4 Subqueries in FROM Clause (Derived Tables)

Creates a temporary result set that acts like a virtual table. Also called 'derived tables' or 'inline views'. MUST have an alias! This is powerful for breaking complex queries into manageable steps.

-- Use derived table to find customers above average spending
SELECT 
    customer_spending.cust_id,
    customer_spending.total_spent,
    customer_spending.order_count
FROM (
    -- This subquery creates a derived table
    SELECT 
        cust_id,
        SUM(total_amount) AS total_spent,
        COUNT(*) AS order_count
    FROM sales.orders
    GROUP BY cust_id
) AS customer_spending  -- ALIAS IS REQUIRED!
WHERE customer_spending.total_spent > 50000
ORDER BY total_spent DESC;


-- Add total product count to each category

SELECT 
    prod_id,
    prod_name,
    category,
    price,
    (SELECT COUNT(*) FROM products.products) AS total_products,
    (SELECT AVG(price) FROM products.products) AS avg_catalog_price
FROM products.products
ORDER BY category;

-- Comprehensive customer analysis using all subquery placements
	-- Customer's Order Count
	-- Average
	-- Spending Totals
	-- High Value spender

Select
	count(*)
from
	sales.orders o

Select
	c.cust_id,
	c.full_name,
	c.city,
	(Select count(*) from sales.orders o) as order_count
from
	customers.customers c
limit 10





explain
Select
	c.cust_id,
	c.full_name,
	c.city,
	-- Subquery in Select : get customer's Order count
	(Select count(*) from sales.orders o where o.cust_id=c.cust_id) as order_count,
	customer_totals.total_spent,
	-- Subquery in Select : Compare to average
	(select avg(total_amount) from sales.orders) as company_avg_order
from
	customers.customers c
-- Subquery in FROM : Derived table with spending totals
left join 
	(
		select 
			cust_id,sum(total_amount) as total_spent
		from 
			sales.orders
		group by
			cust_id
	) as customer_totals
	on customer_totals.cust_id=c.cust_id
-- Subquery in Where : Filter High Spenders
where customer_totals.total_spent > (
	Select 
		avg(cust_total)
	from
		(
			select 
				cust_id,sum(total_amount) as cust_total
			from 
				sales.orders
			group by
				cust_id
		) as avg_calc
)
order by 
	customer_totals.total_spent desc


explain
with customer_spending as (
	select cust_id,sum(total_amount) as cust_total
	from sales.orders
	group by cust_id
),
customer_orders as (
	select cust_id,count(*) as order_count
	from sales.orders
	group by cust_id
),
avg_customer_spending as(
	Select avg(cust_total)
	from customer_spending
)
Select
	c.cust_id,c.full_name,c.city,co.order_count,cs.cust_total,
	-- Subquery in Select : Compare to average
	(select avg(total_amount) from sales.orders) as company_avg_order
from
	customers.customers c
left join customer_spending cs
	on cs.cust_id=c.cust_id
left join customer_orders co
	on co.cust_id=c.cust_id
where cs.cust_total > (select * from avg_customer_spending)
order by 
	cs.cust_total desc







