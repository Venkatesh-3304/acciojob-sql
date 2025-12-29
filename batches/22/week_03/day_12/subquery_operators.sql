Select *
from customers.customers
WHERE
    city = 'Lucknow' or city = 'Bihar' or city ='Delhi'

Select *
from customers.customers
WHERE
    city IN  ('Lucknow','Bihar','Delhi')
IN and NOT IN Operators

8.1 Definition

Technical Definition:
IN operator checks if a value matches ANY value in a list or subquery result set. Returns TRUE if match found. NOT IN operator returns TRUE only if the value does NOT match ANY value in the list. CAUTION: NOT IN with NULL values in the subquery will return no rows because NULL comparisons are UNKNOWN, not FALSE.

Laymans Terms:
IN is like asking 'Is your name on this guest list?' - if your name matches ANY name on the list, you get in! NOT IN is the opposite - 'Is your name NOT on the banned list?' But here's the tricky part: if someone wrote 'Unknown' on the banned list, the bouncer gets confused and blocks EVERYONE! That's the NULL problem with NOT IN.

8.2 The Story - The College Admission Drama!

🎓 IIT-JEE RESULTS DAY!
Results are out! Coaching center owner asks:

"Which students qualified for IIT?" → Use IN (check if in qualified list)
"Which students did NOT qualify?" → Use NOT IN (check if not in qualified list)

-- Students who qualified (IN)
SELECT student_name FROM coaching_students
WHERE roll_number IN (SELECT roll_number FROM iit_qualified);

-- Students who did NOT qualify (NOT IN with NULL safety)
SELECT student_name FROM coaching_students
WHERE roll_number NOT IN (
    SELECT roll_number FROM iit_qualified
    WHERE roll_number IS NOT NULL  -- CRITICAL: Filter out NULLs!
);
8.3 Syntax

-- IN with subquery
SELECT columns FROM table
WHERE column IN (SELECT column FROM other_table);

-- NOT IN with subquery (with NULL safety)
SELECT columns FROM table
WHERE column NOT IN (
    SELECT column FROM other_table
    WHERE column IS NOT NULL  -- Always add this!
);

-- IN with literal list (also valid)
WHERE city IN ('Mumbai', 'Delhi', 'Bangalore');


Find Products Never Ordered

where we have identified which products we have ordered atleast once

select
	distinct prod_id
from
	sales.order_items

all available products

select 
	*
from
	products.products
where 
	prod_id not in (
		select
			distinct prod_id
		from
			sales.order_items
		)

Find Customers With No Orders This Year

Select
	distinct cust_id
from
	sales.orders
where
	extract(year from order_date)=2025

Select
	*
from
	customers.customers
where cust_id not in (
	Select
		distinct cust_id
	from
		sales.orders
	where
		extract(year from order_date)=2025
)

EXISTS and NOT EXISTS Operators

9.1 Definition

Technical Definition:
EXISTS operator returns TRUE if the subquery returns at least one row, FALSE otherwise. It doesn't care about the actual values returned - only whether rows exist. NOT EXISTS returns TRUE if the subquery returns NO rows. EXISTS is often more efficient than IN for large datasets and handles NULLs safely without special treatment.

Layman s Terms:
EXISTS is like asking 'Does this thing exist? Yes or No?' - you don't care about details, just existence. Imagine checking if your favorite restaurant is open: 'Is there at least ONE waiter inside?' - you don't need their names, just whether someone's there! NOT EXISTS is asking 'Is this place completely empty?' - true only if absolutely no one is there.

9.2 The Story - The E-Commerce Return Policy!

📦 FLIPKART CUSTOMER ANALYSIS
The VP of Customer Success asks the data team:

"Find customers who have placed at least ONE order" → EXISTS
"Find customers who have NEVER returned anything" → NOT EXISTS

The key insight: EXISTS doesn't need to fetch all matching orders - it stops as soon as it finds ONE! This makes it faster for 'Does it exist?' questions.
'
-- Customers who have placed orders (EXISTS)
SELECT c.cust_id, c.full_name
FROM customers.customers c
WHERE EXISTS (
    SELECT 1 FROM sales.orders o  -- SELECT 1 is efficient
    WHERE o.cust_id = c.cust_id   -- Correlation with outer query
);

-- Customers who NEVER returned anything (NOT EXISTS)
SELECT c.cust_id, c.full_name
FROM customers.customers c
WHERE NOT EXISTS (
    SELECT 1 FROM sales.returns r
    INNER JOIN sales.orders o ON r.order_id = o.order_id
    WHERE o.cust_id = c.cust_id
);
9.3 Syntax

-- EXISTS syntax
SELECT columns FROM outer_table o
WHERE EXISTS (
    SELECT 1 FROM inner_table i
    WHERE i.key = o.key  -- Correlation is common
);

-- NOT EXISTS syntax
SELECT columns FROM outer_table o
WHERE NOT EXISTS (
    SELECT 1 FROM inner_table i
    WHERE i.key = o.key
);

-- Pro tip: SELECT 1 is preferred over SELECT *
-- because we only care about existence, not data




















