🎯 TOPIC 4: RIGHT JOIN (RIGHT OUTER JOIN)

📖 Definition

Technical Definition:

A RIGHT JOIN (or RIGHT OUTER JOIN) returns ALL rows from the right table and the matching rows from the left table. If there's no match in the left table, NULL values are returned for the left table's columns. It's the mirror image of LEFT JOIN.

Layman's Terms:
Think of RIGHT JOIN like a class assignment submission portal:

Left Table: Students who submitted assignments
Right Table: ALL assignments that were due

RIGHT JOIN shows all assignments, marking which students submitted and showing NULL for those who didn't!

Indian Analogy - The Restaurant Menu Check! 🍽️

Imagine a restaurant audit:

List A (Left): Dishes actually ordered today
List B (Right): Complete menu (all available dishes)

RIGHT JOIN shows:

Butter Chicken - Ordered 50 times
Paneer Tikka - Ordered 30 times
Fish Curry - Ordered 5 times
Exotic Mushroom Risotto - NULL (nobody ordered!)

The complete menu appears, highlighting dishes nobody wants!

List the customers and their order count
    if there is any customer who never order from the retailmart

Left Join
    Left    =>  Cusotmer
    Right   =>  Orders

Right Join
    Left    =>  Orders
    Right   =>  Customers

List the products which were present in the order_items
    If there is any product which was never ordered


Table1
Table2
Table3
Table4

All The data from table1 and Table2 =>  Left    =>  result1

Result1 Table3  => all the values from table3 and matching value from result1 


-- Basic RIGHT JOIN Syntax
SELECT columns
FROM left_table
RIGHT JOIN right_table ON left_table.column = right_table.column;

-- With table aliases
SELECT 
    l.column1,
    r.column2,
    r.column3
FROM left_table l
RIGHT JOIN right_table r ON l.id = r.id;

-- RIGHT OUTER JOIN (same as RIGHT JOIN)
SELECT columns
FROM left_table
RIGHT OUTER JOIN right_table ON left_table.column = right_table.column;

-- Finding unmatched records from right table
SELECT r.*
FROM left_table l
RIGHT JOIN right_table r ON l.id = r.id
WHERE l.id IS NULL;  -- Only rows with NO match in left table


-- RIGHT JOIN
SELECT * FROM A RIGHT JOIN B ON A.id = B.id;

-- Same result with LEFT JOIN (swap tables!)
SELECT * FROM B LEFT JOIN A ON B.id = A.id;


Management wants a complete store performance report showing every store, even those with no orders yet (newly opened stores).
Task:
List all stores with their order count, including stores with zero orders.

Right Join

Stores	=>	Right	
Orders	=>	Left

Select
	*
from
	sales.orders o
right join
	stores.stores s
	on
		o.store_id=s.store_id


select distinct store_id from stores.stores
select distinct store_id from sales.orders


The merchandising team wants to know which product categories have strong sales and which are underperforming or have no sales 
at all across all stores.

Task:
Create a comprehensive category performance report showing all categories with their sales metrics.

Label each category on the basis of below condition
	if no of times order is less then 10000 low performer
	<20000 Moderate 
	>20000 Star Category
	No Sales at all

Products	=>	Right
Order_Items	=>	Left

Select
	p.category,
	count( distinct p.prod_id) as products_in_category,
	count(oi.order_item_id) as times_sold,
	sum(oi.quantity * oi.unit_price) as total_revenue,
	case
		when count(oi.order_item_id)=0 then 'No Sales at all'
		when count(oi.order_item_id)<10000 then 'Low Performer'
		when count(oi.order_item_id) < 20000 then 'Moderate'
		else 'Star Category'
	end as performance_tier
from
	sales.order_items oi
right join
	products.products p
on
	oi.prod_id=p.prod_id
group by 
	p.category



Select
	*
from
	sales.order_items oi
right join
	products.products p
on
	oi.prod_id=p.prod_id
order by
	p.prod_id




















