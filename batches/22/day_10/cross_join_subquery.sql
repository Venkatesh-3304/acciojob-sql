📖 TOPIC 2: Cross Join (Cartesian Product)

2.1 Definition

Technical Definition

A Cross Join produces a Cartesian Product of two tables, combining every row from the first table with every row from the second table. If table A has m rows and table B has n rows, the result will have m × n rows. No join condition is required.

Layman's Terms

Imagine you're at a South Indian restaurant with 4 types of dosas (Plain, Masala, Rava, Onion) and 3 types of chutneys (Coconut, Tomato, Mint). If you want to try EVERY possible combination, that's 4 × 3 = 12 combinations! Cross Join does exactly this - it pairs EVERYTHING with EVERYTHING. It's like saying 'Give me ALL possible pairings!'
2.2 The Story: The Startup's Pricing Matrix 💰

Meet Vikram, founder of a SaaS startup in Bangalore. He's launching a subscription service with:
• 3 Plans: Basic (₹499), Pro (₹999), Enterprise (₹2999)
• 4 Billing Cycles: Monthly, Quarterly, Half-Yearly, Yearly
His investors want to see ALL 12 possible pricing combinations (3 × 4 = 12) on one page!

💡 Cross Join is perfect for this! Swiggy uses it to pair restaurants with delivery zones, Myntra pairs products with sizes/colors, and IRCTC pairs trains with stations!

2.3 Syntax
-- Cross Join Syntax (Explicit)
SELECT *
FROM table_a
CROSS JOIN table_b;
 
-- Cross Join Syntax (Implicit - Old Style)
SELECT *
FROM table_a, table_b;
 
-- ⚠️ WARNING: Cross Join can produce HUGE results!
-- 1000 rows × 1000 rows = 1,000,000 rows!
-- Always use with small tables or LIMIT clause

⚠️ CAUTION: Cross Join without WHERE clause is dangerous! A 10,000 row table crossed with itself = 100 MILLION rows! Always use wisely!


Generate All Store-Department Combinations

Scenario: RetailMart management wants to see which departments could potentially be added to each store. Generate all possible store-department pairings.

select
	s.store_name,
	s.city,
	d.dept_name
from
	stores.stores s
	cross join stores.departments d

Select *
from
	stores.departments d

Create a Calendar Matrix for Sales Analysis
Scenario: The analytics team wants a complete matrix of all stores × all months, even for months where a store had zero sales (for gap analysis).


Select 
	distinct month,year
from
	core.dim_date
order by 
	year,month

Select
	*
from
	stores.stores
where region ='Central'
Select 
	o.store_id,
	extract(year from order_date) as order_year,
	extract(month from order_date) as order_month,
	count(o.order_id)
from
	sales.orders o
group by 
	o.store_id,
	extract(year from order_date),
	extract(month from order_date)

Select
	distinct
	date_trunc('month',order_date) as month
from
	sales.orders

timestamp
	yyyy-mm-dd hh:mm:ss.ms zone



select
	s.store_name,
	m.month,
	coalesce(oc.no_of_orders,0)
from
	stores.stores s
	-- Sub Query to get date combination
	cross join (
		Select
			distinct
			date_trunc('month',order_date) as month
		from
			sales.orders) m
	-- Sub query to get no of orders for each store and month combination
	left join (
			Select 
				o.store_id,
				date_trunc('month',order_date) as month,
				count(o.order_id) no_of_orders
			from
				sales.orders o
			group by 
				o.store_id,
				date_trunc('month',order_date)
		) oc
		on s.store_id = oc.store_id
			and m.month=oc.month
order by
	s.store_id,m.month
			
		


select
	s.store_name,
	m.month,
	coalesce(oc.no_of_orders,0)
from
	(
		Select
			*
		from
			stores.stores
		where region ='Central'
	) s
	-- Sub Query to get date combination
	cross join (
		Select
			distinct
			date_trunc('month',order_date) as month
		from
			sales.orders) m
	-- Sub query to get no of orders for each store and month combination
	left join (
			Select 
				o.store_id,
				date_trunc('month',order_date) as month,
				count(o.order_id) no_of_orders
			from
				sales.orders o
			group by 
				o.store_id,
				date_trunc('month',order_date)
		) oc
		on s.store_id = oc.store_id
			and m.month=oc.month
order by
	s.store_id,m.month
