4. Topic 1: LAG() & LEAD() - Time Travel in Data
4.1 Definition
Technical Definition: LAG() and LEAD() are window functions that allow you to access data from a previous row (LAG) or a subsequent row (LEAD) within the same result set, without using a self-join. They operate on a specified column and can look back or forward by a specified number of rows.
Layman's Terms: Imagine you're standing in a line at a chai stall. LAG() lets you peek at the person BEHIND you (previous row), while LEAD() lets you see who's AHEAD of you (next row). You stay in your position but can see what happened before or what's coming next!
4.2 The Story - Flipkart's Sales Growth Calculator
🛒 THE STORY: Flipkart's Big Billion Day Analysis
Imagine you're a data analyst at Flipkart during the Big Billion Days sale. Your manager, Priya, rushes to your desk with a cup of cutting chai and an urgent request:
"We need to know how each day's sales compared to the previous day! The leadership wants to see day-over-day growth percentage for every single day of the sale!"
You think about it... You have daily sales data. To compare today with yesterday, you'd normally need to:
•	Join the table with itself (messy! 😫)
•	Write complex subqueries (slow! 🐌)
•	Pull data into Excel and calculate manually (tedious! 😴)
But wait! You remember LAG() from your SQL training! 💡
With ONE simple function, you can peek at yesterday's sales while looking at today's row. No self-joins, no subqueries, just pure elegance!
In 5 minutes, you deliver the report. Priya is amazed. You get promoted! 🚀
💼 Real-World Connection: This is EXACTLY what analysts do at Amazon (Week-over-Week comparisons), Zomato (order growth trends), and every major company. Month-over-Month and Year-over-Year comparisons are interview favorites!

4.3 Syntax
-- LAG(): Access previous row value
LAG(column_name, offset, default_value) OVER (
    [PARTITION BY partition_column]
    ORDER BY order_column
)
 
-- LEAD(): Access next row value  
LEAD(column_name, offset, default_value) OVER (
    [PARTITION BY partition_column]
    ORDER BY order_column
)
 
-- Parameters:
-- column_name: The column value you want to retrieve
-- offset: How many rows back (LAG) or forward (LEAD). Default is 1
-- default_value: Value to return if no row exists. Default is NULL


Calculate Previous Day's Order Total for Each Customer
Scenario: RetailMart wants to see each customer's current order alongside their previous order amount to identify spending pattern changes.
'
Select
	o.cust_id,
	o.order_date,
	o.total_amount as current_order,
	lag(o.total_amount,1,-1) over(partition by o.cust_id order by o.order_date) as previous_order,
	o.total_amount - lag(o.total_amount,1) over(partition by o.cust_id order by o.order_date) as change_in_spending
from sales.orders o
join customers.customers c
	on o.cust_id=c.cust_id
where 
	o.order_status = 'Delivered' and 
	o.cust_id in (
		select cust_id
		from sales.orders
		where order_status = 'Delivered'
		group by cust_id 
		having count(*)>5
	)
order by
	c.cust_id,o.order_date

Month-over-Month Sales Growth with Percentage Change
Scenario: Calculate monthly sales totals with Month-over-Month absolute change and percentage growth - a classic interview question asked at Amazon, Flipkart, and Swiggy!



Calculate Previous Day's Order Total for Each Customer
Scenario: RetailMart wants to see each customer's current order alongside their previous order amount to identify spending pattern changes.

Select
	o.cust_id,
	o.order_date,
	o.total_amount as current_order,
	lag(o.total_amount,1,-1) over(partition by o.cust_id order by o.order_date) as previous_order,
	o.total_amount - lag(o.total_amount,1) over(partition by o.cust_id order by o.order_date) as change_in_spending
from sales.orders o
join customers.customers c
	on o.cust_id=c.cust_id
where 
	o.order_status = 'Delivered' and 
	o.cust_id in (
		select cust_id
		from sales.orders
		where order_status = 'Delivered'
		group by cust_id 
		having count(*)>5
	)
order by
	c.cust_id,o.order_date





Select
	o.cust_id,
	o.order_date,
	o.total_amount as current_order,
	lag(o.total_amount,1,-1) over(partition by o.cust_id order by o.order_date) as previous_order,
	o.total_amount - lag(o.total_amount,1) over(partition by o.cust_id order by o.order_date) as change_in_spending
from sales.orders o
join customers.customers c
	on o.cust_id=c.cust_id
where 
	o.order_status = 'Delivered' and 
	o.cust_id in (
		select cust_id
		from sales.orders
		where order_status = 'Delivered'
		group by cust_id 
		having count(*)>5
	)
order by
	c.cust_id,o.order_date

select
	o.cust_id,
	o.order_status,
	lag(order_status) over(partition by o.cust_id),
	lead(order_status) over(partition by o.cust_id)
from
	sales.orders o



Percentile
    1000
    10000
    100000
    Min =>  0th 
    Max =>  100th

    Dataset 
        divide that in 100 positions / parts

5. Topic 2: FIRST_VALUE(), LAST_VALUE(), NTH_VALUE()
5.1 Definition

Technical Definition: FIRST_VALUE() returns the first value in an ordered partition, LAST_VALUE() returns the last value, and NTH_VALUE() returns the value at a specific position (nth row). These functions are evaluated over the window frame defined by ROWS BETWEEN or RANGE BETWEEN.
Layman's Terms: Think of a cricket match scorecard showing all batsmen's scores. FIRST_VALUE() tells you what the opening batsman scored, LAST_VALUE() tells you the last batsman's score, and NTH_VALUE(3) tells you what the 3rd batsman scored - all while you're looking at any batsman's row!
5.2 The Story - Zomato's Restaurant Comparison Engine
🍕 THE STORY: Zomato's 'Compare with Best' Feature
You're a data analyst at Zomato, and the product team wants to build a new feature: When users view a restaurant, they should see how it compares to the BEST restaurant in that cuisine category.
The feature should show:
•	'Best in category' - The highest-rated restaurant (FIRST_VALUE)
•	'Most recent addition' - The newest restaurant in category (LAST_VALUE)
•	'Silver medalist' - The 2nd best restaurant (NTH_VALUE)
Instead of running 3 separate queries and joining them (slow and complex), you use these window functions to get ALL comparisons in a single elegant query!
💼 Real-World Connection: E-commerce sites like Amazon use these functions to show 'Best Seller in Category' alongside each product. It's how they build comparison features efficiently!
5.3 Syntax
-- FIRST_VALUE(): Get the first value in the window
FIRST_VALUE(column_name) OVER (
    [PARTITION BY partition_column]
    ORDER BY order_column
    [ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING]
)
 
-- LAST_VALUE(): Get the last value in the window
-- IMPORTANT: Requires explicit frame for correct results!
LAST_VALUE(column_name) OVER (
    [PARTITION BY partition_column]
    ORDER BY order_column
    ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
)
 
-- NTH_VALUE(): Get value at specific position
NTH_VALUE(column_name, n) OVER (
    [PARTITION BY partition_column]
    ORDER BY order_column
    ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
)

ROWS | RANGE | GROUPS
BETWEEN 
    <start> and 
    <end>

ROWS 
BETWEEN 
    UNBOUNDED PRECEDING AND 
    UNBOUNDED FOLLOWING

🔸 UNBOUNDED PRECEDING

Start from first row of partition

🔸 UNBOUNDED FOLLOWING

Go till last row of partition

🔸 CURRENT ROW

The row being evaluated

🔸 n PRECEDING

n rows before current row

🔸 n FOLLOWING

n rows after current row

Compare Each Product's Price with Category's Cheapest & Most Expensive
Scenario: For each product, show how its price compares to the cheapest and most expensive product in its category.



Select
	prod_name,
	category,
	price,
	dense_rank() over(partition by category order by price),
	first_value(price) over(partition by category order by price) as cheapest_in_category,
	last_value(price) over(partition by category order by price rows between unbounded preceding and unbounded following) as most_expensive_in_category,
	last_value(price) over(partition by category order by price rows between unbounded preceding and 2 following) as most_expensive_in_category,
	nth_value(price,3) over(partition by category order by price desc ) as most_expensive_in_category
from
	products.products


select
	*
from
	products.products

offset
	1
limit 10


from /join
where
group by
having
select
distinct
order by
limit / offset


Window Frames (ROWS BETWEEN, RANGE BETWEEN)
7.1 Definition
Technical Definition: Window frames define which rows are included in the window function calculation relative to the current row. ROWS BETWEEN specifies an exact number of rows, while RANGE BETWEEN specifies a range based on values. Frame boundaries can be UNBOUNDED PRECEDING, N PRECEDING, CURRENT ROW, N FOLLOWING, or UNBOUNDED FOLLOWING.
Layman's Terms: Imagine you're on a train looking out the window. The frame is what you can see at any moment. ROWS BETWEEN is like saying 'I can see 3 seats behind me and 2 seats ahead' (exact count). RANGE BETWEEN is like saying 'I can see all passengers within 5 meters' (value-based). You control exactly what's in your view!
7.2 The Story - CRED's Transaction Monitoring
💳 THE STORY: CRED's Fraud Detection Window
You're working on CRED's fraud detection system. The security team needs to monitor transactions with different 'viewing windows':
•	Last 5 transactions: To detect rapid small transactions (common fraud pattern)
•	Transactions in last 24 hours: To detect unusual daily spending
•	All transactions since account opened: To track lifetime spending patterns
Each scenario needs a different 'frame' - and SQL window frames give you precise control over exactly which rows to include in each calculation!
💼 Real-World Connection: Banks use window frames for rolling credit scores, Netflix uses them for 'watch history in last 7 days' recommendations, and stock apps use them for various technical indicators!
7.3 Syntax
-- Window Frame Syntax
function() OVER (
    [PARTITION BY column]
    ORDER BY column
    {ROWS | RANGE} BETWEEN frame_start AND frame_end
)
 
-- Frame Boundaries:
-- UNBOUNDED PRECEDING  = First row of partition (the very beginning)
-- n PRECEDING          = n rows/values before current row
-- CURRENT ROW          = Current row being processed
-- n FOLLOWING          = n rows/values after current row
-- UNBOUNDED FOLLOWING  = Last row of partition (the very end)
 
-- Common Frame Patterns:
-- Default frame (if ORDER BY present):
ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
 
-- All rows in partition:
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
 
-- Last 7 rows including current:
ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
 
-- Centered 5-row window:
ROWS BETWEEN 2 PRECEDING AND 2 FOLLOWING
⚠️ ROWS vs RANGE: ROWS counts physical rows (exact count). RANGE considers value ranges (can include multiple rows with same value). For most cases, use ROWS - it's more predictable!
7.4 Examples
📝 Example 1 (Medium): Last 3 Orders Average per Customer
Scenario: For each order, show the customer's average spending over their last 3 orders (including current one) to detect spending trend changes.
Concepts Used: AVG() OVER(), ROWS BETWEEN, PARTITION BY, ORDER BY, JOIN (Day 8)
-- Average of last 3 orders per customer
SELECT 
    c.full_name,
    o.order_date,
    o.total_amount AS current_order,
    ROUND(AVG(o.total_amount) OVER (
        PARTITION BY o.cust_id
        ORDER BY o.order_date
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ), 2) AS avg_last_3_orders,
    COUNT(*) OVER (
        PARTITION BY o.cust_id
        ORDER BY o.order_date
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS orders_in_window
FROM sales.orders o
JOIN customers.customers c ON o.cust_id = c.cust_id
WHERE o.order_status = 'Delivered'
ORDER BY c.full_name, o.order_date;
Result Explanation: Each order shows the average of the last 3 orders. The orders_in_window column shows how many orders are actually in the window (important for first few orders where we don't have 3 yet). Great for detecting sudden spending spikes!
📝 Example 2 (Hard): Multi-Frame Analysis - Running, Rolling, and Total
Scenario: Create a comprehensive sales analysis showing daily sales, cumulative YTD sales, 7-day rolling sum, and total annual sales for percentage calculation.
Concepts Used: Multiple Window Frames, SUM() OVER(), PARTITION BY, Various frame specifications, CTE (Day 12), ROUND
-- Multi-frame sales analysis
WITH daily_sales AS (
    SELECT 
        order_date,
        EXTRACT(YEAR FROM order_date) AS year,
        SUM(total_amount) AS daily_total
    FROM sales.orders
    WHERE order_status = 'Delivered'
    GROUP BY order_date
)
SELECT 
    order_date,
    daily_total,
    -- Running total from start of year (cumulative)
    SUM(daily_total) OVER (
        PARTITION BY year
        ORDER BY order_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS ytd_cumulative,
    -- Rolling 7-day sum
    SUM(daily_total) OVER (
        ORDER BY order_date
        ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
    ) AS rolling_7day_sum,
    -- Total for entire year (for percentage calc)
    SUM(daily_total) OVER (
        PARTITION BY year
    ) AS year_total,
    -- Percentage of annual total achieved so far
    ROUND(
        SUM(daily_total) OVER (
            PARTITION BY year
            ORDER BY order_date
        ) * 100.0 / 
        SUM(daily_total) OVER (PARTITION BY year)
    , 2) AS pct_of_annual
FROM daily_sales
ORDER BY order_date;
Result Explanation: This powerful query shows: daily sales, Year-To-Date cumulative (resets each year), 7-day rolling sum, total annual sales, and what percentage of annual sales has been achieved. Notice how different frames serve different analytical purposes!
















	