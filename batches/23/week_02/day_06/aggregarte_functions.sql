RETAILMART WANTS TO KNOW HOW MANY ORDERS ARE IN THEIR SYSTEM
AND HOW MANY HAVE BEEN DELIVERED.;

SELECT COUNT(*) AS TOTAL_ORDERS
FROM
	SALES.ORDERS;

Select
	count(*) 
from
	sales.orders
where 
	order_status = 'Delivered';

RetailMart's marketing team needs to understand customer reach - 
	how many unique cities do they serve, 
	and Compare total CUstomer ,Customers covered in state'

select
	distinct city
from
	customers.customers


select
	count(distinct city)
from
	customers.customers;

select
	count(*),
	count(distinct state),
	count(distinct city)
from
	customers.customers;


📋 Scenario: RetailMart's finance team needs to calculate total sales revenue and understand the value of pending shipments.
🎯 Task: Calculate total order amounts and sum of orders that are still pending delivery.

'
select
	sum(total_amount) as total_revenue
from
	sales.orders

select
	sum(total_amount) as total_revenue
from
	sales.orders
where 
	order_status in ('Pending','Processing','Shipped')


📋 Scenario: RetailMart wants to analyze their payment collection and identify potential revenue from high-value orders.
🎯 Task: Calculate total payments received, total refunds processed, and sum of high-value orders (above ₹5000).

select 
	sum(amount) as total_collected
from
	sales.payments

select
	sum(refund_amount)
from
	sales.returns

select
	sum(total_amount) as premium_order_value,
	count(*) as premium_order_count
from
	sales.orders
where
	total_amount > 5000;

📋 Scenario: RetailMart''s HR team needs to analyze employee salaries and customer review ratings.
🎯 Task: Find average salary of employees and average product ratings from customer reviews.

select
	round(avg(salary),2)
from
	stores.employees

select
	round(avg(rating),2)
from
	customers.reviews
where
	rating between 4 and 5


📋 Scenario: RetailMart needs comprehensive analysis of their inventory, ratings, and delivery performance.
🎯 Task: Find stock extremes, rating ranges, and delivery time bounds.

Select
	min(stock_qty) as lowest_stock,
	max(stock_qty) as highest_stock
from
	products.inventory



Select
	*
from
	products.inventory
where 
	stock_qty in (0,500)
order by stock_qty


Select
	min(rating) as lowest_rating,
	max(rating) as highest_rating
from
	customers.reviews


Select
	*
from
	sales.shipments

Select
	min(delivered_date - shipped_date) as fastest_delivery,
	max(delivered_date - shipped_date) as slowest_delivery
from
	sales.shipments
where
	status = 'Delivered' 


📋 Scenario: RetailMart''s CEO wants a quick snapshot: all payment modes accepted, all courier partners, and all employee roles in the company.
🎯 Task: Aggregate distinct values from multiple tables into readable strings.

select
	string_agg(distinct payment_mode, ' , ' order by payment_mode desc)
from
	sales.payments

SELECT STRING_AGG(DISTINCT courier_name, ' | ' ORDER BY courier_name) 
    AS delivery_partners  
FROM sales.shipments


📋 Scenario: RetailMart''s tech team needs arrays of data for their mobile app - product categories and store IDs.
🎯 Task: Create arrays of distinct categories and store IDs for API responses.


Select
	array_to_string(array_agg(distinct category), ' , ')
from
	products.products


Select
	array_length(array_agg(distinct category),1)
from
	products.products



Select
	unnest(array_agg(distinct category))
from
	products.products


{
	1,
	2,
	3,
	4
}


{
	{},
	{},
	{},
}

{
	{
		{},
		{}
	},
	{
		{},
		{}
	},
	{
		{},
		{}
	},
}

select 
	distinct col_1 
from (
	select unnest(array['1','2','2','3','3','4','5','6','1',null,null,' ',' ']) as col_1
)

select 
	col_1
from (
	select unnest(array['1','2','2','3','3','4','5','6','1',null,null,' ',' ']) as col_1
)
group by 
	col_1

Select
	distinct state,city
from
	customers.customers
order by state,city


select 
	distinct order_status
from 
	sales.orders



select 
	cust_id,			--	non - aggregate col
	order_status,		--	non - aggregate col
	sum(total_amount),	--	aggregate col
	count(order_id)		--	aggregate col
from 
	sales.orders
group by
	order_status,cust_id
order by
	cust_id
    
select 
	cust_id,			--	non - aggregate col
	order_status,		--	non - aggregate col
	sum(total_amount) as total_revenue,	--	aggregate col
	count(order_id)	as total_orders	--	aggregate col
from 
	sales.orders
group by
	order_status,cust_id
having count(order_id) > 1
order by
	cust_id