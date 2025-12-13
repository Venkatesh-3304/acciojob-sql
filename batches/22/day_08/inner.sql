🎯 TOPIC 2: INNER JOIN

📖 Definition

Technical Definition:

An INNER JOIN returns only the rows where there is a match in BOTH tables based on the specified join condition. If a row in either table doesn't have a corresponding match in the other table, it is excluded from the result set.

Layman's Terms:

Think of INNER JOIN like a school reunion where only students who are in BOTH:

The "Paid Fees" list AND
The "RSVP Confirmed" list

...can enter the venue! If you're only in one list, sorry - no entry! 🚫

Indian Analogy - The Wedding Guest List! 💒

Imagine you're organizing a wedding reception. You have:

List A: People invited by the bride's family
List B: People invited by the groom's family

An INNER JOIN finds guests who are on BOTH lists (common relatives/friends). Only THEY get the special "VIP" wristband!



📖 Story: The Zomato Restaurant Match 🍕🍔
🎬 THE STORY:
You're a Data Analyst at Zomato, and the Marketing team wants to run a special "Top Rated Restaurant" campaign in Mumbai.
They ask: "Give us a list of restaurants that have BOTH high ratings AND at least 100 orders this month!"
You have two reports:

Report A (ratings_data): All restaurants with their average ratings
Report B (orders_data): All restaurants with their order counts

The Challenge:

Some restaurants have ratings but zero orders (new restaurants)
Some restaurants have orders but no ratings yet (rating data delayed)

You only want restaurants that appear in BOTH reports!
sql-- This is EXACTLY what INNER JOIN does!
SELECT 
    r.restaurant_name,
    r.average_rating,
    o.order_count
FROM ratings_data r
INNER JOIN orders_data o ON r.restaurant_id = o.restaurant_id
WHERE r.average_rating >= 4.5 
  AND o.order_count >= 100;
Result: Only restaurants with BOTH ratings AND orders appear!
Why This Matters:

New restaurants with no orders? Excluded (can't measure popularity)
Popular restaurants with no ratings? Excluded (can't guarantee quality)
You get the PERFECT list for your campaign!

Real Job Connection:
At Zomato, Swiggy, and food delivery apps, analysts constantly use INNER JOINs to find restaurants that meet MULTIPLE criteria. This ensures campaigns target only qualified businesses!

📖 Syntax
sql-- Basic INNER JOIN Syntax
SELECT columns
FROM table1
INNER JOIN table2 ON table1.column = table2.column;

-- Using table aliases (recommended!)
SELECT 
    t1.column1,
    t1.column2,
    t2.column3,
    t2.column4
FROM table1 t1
INNER JOIN table2 t2 ON t1.common_column = t2.common_column;

-- Multiple conditions in JOIN
SELECT columns
FROM table1 t1
INNER JOIN table2 t2 
    ON t1.column1 = t2.column1 
    AND t1.column2 = t2.column2;

-- Note: "INNER" is optional - JOIN alone means INNER JOIN
SELECT columns
FROM table1
JOIN table2 ON table1.column = table2.column;


-- Basic INNER JOIN Syntax
SELECT columns
FROM table1
INNER JOIN table2 ON table1.column = table2.column;

-- Using table aliases (recommended!)
SELECT 
    t1.column1,
    t1.column2,
    t2.column3,
    t2.column4
FROM table1 t1
INNER JOIN table2 t2 ON t1.common_column = t2.common_column;

-- Multiple conditions in JOIN
SELECT columns
FROM table1 t1
INNER JOIN table2 t2 
    ON t1.column1 = t2.column1 
    AND t1.column2 = t2.column2;

-- Note: "INNER" is optional - JOIN alone means INNER JOIN
SELECT columns
FROM table1
JOIN table2 ON table1.column = table2.column;


RetailMarts manager wants to see order details along with customer names. 

Currently, the orders table only has cust_id, not the actual names.

Task:
Show order ID, customer name, and order amount for all orders.


select
	o.order_id,
	c.full_name customer_name,
	o.total_amount
from
	customers.customers c
inner join
	sales.orders o
on
	o.cust_id=c.cust_id

The inventory team needs to analyze which products are selling well. 
They want to see each order item with its product name, category, and brand - not just product IDs.
Task:
Show order items with product names, categories, and calculate line totals.

All the product id of order_item table will be present in products
But all the product_id of products table may not be present in order_items

If all the listed product is order atleast once we can use right join also

Select
	oi.order_item_id,
	oi.order_id,
	p.prod_name,
	p.category,
	p.brand,
	oi.quantity,
	oi.unit_price,
	(oi.quantity* oi.unit_price) as line_total
from
	sales.order_items oi
join
	products.products p
on
	oi.prod_id=p.prod_id
limit 15;
