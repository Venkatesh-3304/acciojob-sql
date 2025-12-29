select 
	count(*)
from
	customers.customers
where
	state='Bihar'

GROUP BY - Single & Multiple Columns

Total Count => 	50
Gender
	Male 	=> 25
	Female	=> 25
	
`GROUP BY` is a clause that groups rows sharing the same values in specified columns into summary rows. 
It's used with aggregate functions (COUNT, SUM, AVG, etc.) to perform calculations on each group. 
Every column in SELECT that isn't an aggregate must appear in GROUP BY.

-- Basic GROUP BY (single column)
SELECT 
    column_to_group,
    COUNT(*) AS count
FROM table_name
GROUP BY column_to_group;

-- GROUP BY with multiple aggregates
SELECT 
    column_to_group,
    COUNT(*) AS row_count,
    SUM(numeric_column) AS total,
    AVG(numeric_column) AS average
FROM table_name
GROUP BY column_to_group;

-- GROUP BY multiple columns
SELECT 
    column1,
    column2,
    COUNT(*) AS count
FROM table_name
GROUP BY column1, column2;

-- GROUP BY with ORDER BY
SELECT 
    column_to_group,
    SUM(amount) AS total
FROM table_name
GROUP BY column_to_group
ORDER BY total DESC;

-- IMPORTANT RULE: Every non-aggregate column in SELECT 
-- must appear in GROUP BY!

-- WRONG:
SELECT city, state, COUNT(*) FROM customers;  -- Error!

-- RIGHT:
SELECT city, state, COUNT(*) 
FROM customers 
GROUP BY city, state;


-- Customer gender distribution

select 
	*
from
	customers.customers;

Aggregate Column			=>		Count , Sum , Min, Max etc
Non Aggreagate Column		=>		no aggregate function used

select 
	gender,count(cust_id) as customer_count
from
	customers.customers
group by gender
order by customer_count desc
;

Sales by Store with Totals
📋 Scenario:
Finance needs store-wise sales performance with multiple metrics.
📝 Task:
Group orders by store and calculate sum, count, and average.

select
	store_id,
	count(*) as total_orders,
	sum(total_amount) as total_revenue,
	round(avg(total_amount),2) as avg_order_value
from
	sales.orders
group by store_id
;

📋 Scenario:
The expansion team needs customer distribution by state AND city to identify growth opportunities.
📝 Task:
Use GROUP BY with multiple columns for granular analysis.


select
	state,city,
	count(*) as customer_count,
	count(distinct region_name) as regions_covered
from
	customers.customers
group by city,state
order by customer_count desc

HAVING Clause

`HAVING` is a clause used to filter groups after GROUP BY aggregation, based on aggregate function results. 
While WHERE filters individual rows before grouping, HAVING filters groups after aggregation. 
HAVING can only reference columns in GROUP BY or aggregate functions.


select
	state,city,
	count(*) as customer_count,
	count(distinct region_name) as regions_covered
from
	customers.customers
group by city,state
having count(*) > 750 and city in ('Noida','Nashik')
order by customer_count desc

| You Write | SQL Executes |
| --------- | ------------ |
| SELECT    | ✅ 5          |
| FROM      | ✅ 1          |
| WHERE     | ✅ 2          |
| GROUP BY  | ✅ 3          |
| HAVING    | ✅ 4          |
| ORDER BY  | ✅ 7          |
| LIMIT     | ✅ 8          |

1️⃣ FROM
– Tables are identified
– JOINS happen here
– ON conditions are applied

2️⃣ WHERE
– Row-level filtering
– Happens before grouping
– You cannot use aggregate functions here

3️⃣ GROUP BY
– Rows are grouped into buckets
– One row per group is formed

4️⃣ HAVING
– Group-level filtering
– Used after aggregation

5️⃣ SELECT
– Columns are picked
– Expressions are calculated
– Aliases are created here

6️⃣ DISTINCT
– Duplicate rows are removed

7️⃣ ORDER BY
– Final sorting
– Aliases can be used here

8️⃣ LIMIT / OFFSET
– Final row restriction


select
	state,city,
	count(*) as customer_count,
	count(distinct region_name) as regions_covered
from
	customers.customers
group by city,state
order by state asc,city,customer_count desc


| Aspect 					| WHERE 						| HAVING |
|--------					|-------						|--------|
| When it filters 			| Before GROUP BY 				| After GROUP BY |
| What it filters 			| Individual rows 				| Groups (aggregated results) |
| Can use aggregates 		| No 							| Yes |
| Can use non-aggregates 	| Yes 							| Only if in GROUP BY |
| Requires GROUP BY 		| No 							| Yes (practically) |

If any non aggregate column is in select it should be present in group by
if we have combination of non aggregate and aggregate column in select we have to use group by



-- Marketing needs cities where:

-- Customers are adults (age >= 25) 
-- City has at least 750 customers 
-- City's average customer age is between 25-40  (target demographic)

select 
	city,
	count(*) as no_of_customers
from
	customers.customers
where
	age>=25
group by 
	city
having
	count(*)>500
	and
		avg(age) between 40 and 50



Scenario: Build a comprehensive "Store Health Report" that:

Only considers orders from Q1 2024 
Only includes delivered orders 
Groups by store 
Only shows stores with 30+ orders 
Only shows stores where revenue > ₹90 Lakhs 
Only shows stores with AOV > ₹4 Lakh
Sort by revenue 


select
	store_id,
	count(order_id) as q1_orders,
	sum(total_amount) as q1_revenue,
	avg(total_amount) as q1_aov
from
	sales.orders
where 
	order_date between '2024-01-01' and '2024-03-31'
	and order_status='Delivered'
group by
	store_id
having
	count(order_id) >= 30
	and sum(total_amount) > 9000000
	and avg(total_amount) > 400000





select
	store_id,
	count(order_id) as q1_orders,
	sum(total_amount) as q1_revenue,
	avg(total_amount) as q1_aov
from
	sales.orders													150000
where 
	order_date between '2024-01-01' and '2024-03-31'				10000
	
group by
	store_id,order_status
having
	count(order_id) >= 30											500
	and sum(total_amount) > 9000000									100
	and avg(total_amount) > 400000									50
	and order_status='Delivered'									4


select
	store_id,
	count(order_id) as q1_orders,
	sum(total_amount) as q1_revenue,
	avg(total_amount) as q1_aov
from
	sales.orders													150000
where 
	order_date between '2024-01-01' and '2024-03-31'				10000
	and order_status='Delivered'									2000
group by
	store_id,order_status
having
	count(order_id) >= 30											50
	and sum(total_amount) > 9000000									10
	and avg(total_amount) > 400000									4
























