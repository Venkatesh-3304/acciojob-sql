🎯 TOPIC 3: LEFT JOIN (LEFT OUTER JOIN)

📖 Definition

Technical Definition:

A LEFT JOIN (or LEFT OUTER JOIN) returns ALL rows from the left table and the matching rows from the right table. If there's no match in the right table, NULL values are returned for the right table's columns.

Layman's Terms:
Think of LEFT JOIN like a school attendance register:

Left Table: All students enrolled in the class (EVERYONE appears)
Right Table: Students who submitted homework

Result: All students listed, with homework status (submitted or NULL if not submitted)

Every enrolled student appears in the result, even if they didn't submit homework! 📚
Indian Analogy - The Train Reservation List! 🚂
Imagine Indian Railways reservation chart:

List A (Left): All passengers who booked tickets
List B (Right): Passengers who checked in at the station

LEFT JOIN shows:

Rahul - Checked In ✅
Priya - Checked In ✅
Amit - NULL (booked but didn't show up!)
Sneha - NULL (booked but didn't show up!)

Everyone who booked appears, but only those who showed up have check-in details!


-- Basic LEFT JOIN Syntax
SELECT columns
FROM left_table
LEFT JOIN right_table ON left_table.column = right_table.column;

-- With table aliases
SELECT 
    l.column1,
    l.column2,
    r.column3
FROM left_table l
LEFT JOIN right_table r ON l.id = r.id;

-- LEFT OUTER JOIN (same as LEFT JOIN)
SELECT columns
FROM left_table
LEFT OUTER JOIN right_table ON left_table.column = right_table.column;

-- Finding unmatched records (very common pattern!)
SELECT l.*
FROM left_table l
LEFT JOIN right_table r ON l.id = r.id
WHERE r.id IS NULL;  -- Only rows with NO match in right table


All Customers with Their Orders (Including Non-Buyers)

Scenario:

RetailMart s marketing team wants to identify customers who registered but never placed an order. 
They plan to send them a "First Purchase Discount" email.

Task:
List all customers with their order count, including those with zero orders.

select
	c.full_name,
	coalesce(o.order_id:: Text ,'No Orders') as order_status
from
	customers.customers c
left join
	sales.orders o
on
	o.cust_id=c.cust_id
order by o.order_id nulls first
	
Customer Engagement Analysis
Scenario:
RetailMart wants to understand customer engagement patterns. Specifically, they want to see all customers with their order summary, review activity, and loyalty points - even if some customers have never ordered, reviewed, or earned points.
Task:
Create a comprehensive customer engagement report using multiple LEFT JOINs.