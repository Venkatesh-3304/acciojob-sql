Handling NULLs in JOINs

Technical Definition:

NULL handling in JOINs refers to the strategies and techniques used to manage NULL values that appear in JOIN results - either from unmatched rows in OUTER JOINs or from NULL values in the source data. Key techniques include using COALESCE(), IS NULL/IS NOT NULL filters, and understanding how NULLs propagate through JOIN operations.

Layman''s Terms:

Think of NULL as an empty seat at a wedding. When you do a LEFT JOIN of the guest list with the seating chart, guests without assigned seats show up with NULL for their table number. Handling NULLs means deciding what to do with these empty seats - do you assign them a default table? Flag them for attention? Or use them to find who still needs seating?

5.2 Story: The IRCTC Customer Service Mystery
🚂 THE STORY:

You just joined IRCTC as a Data Analyst. On your first day, the Customer Service Head storms in: "We're getting complaints that some passengers can't see their PNR status, and some bookings are showing wrong passenger names!"
You investigate and find:
•	bookings table: Has booking_id, pnr_number, user_id
•	passengers table: Has passenger_id, booking_id, name
•	Some bookings have NULL user_id (guest bookings)
•	Some passengers have NULL booking_id (cancelled bookings with orphaned records)
The NULLs are the clues! 🔍
•	LEFT JOIN + WHERE right.id IS NULL = Find bookings without passengers
•	RIGHT JOIN + WHERE left.id IS NULL = Find orphaned passenger records
•	COALESCE = Show 'Guest User' instead of NULL for guest bookings

💼 Real Job Connection: At OYO Rooms, data analysts use NULL detection in JOINs to find booking-payment mismatches, helping recover lakhs in revenue from failed transactions that weren't properly recorded!

5.3 Syntax Patterns

-- Pattern 1: Find unmatched records from LEFT table
SELECT a.*
FROM table_a a
LEFT JOIN table_b b ON a.id = b.a_id
WHERE b.id IS NULL;  -- Only rows with NO match

-- Pattern 2: Replace NULLs with default values
SELECT 
    a.name,
    COALESCE(b.value, 0) AS value,  -- Replace NULL with 0
    COALESCE(b.status, 'Not Found') AS status
FROM table_a a
LEFT JOIN table_b b ON a.id = b.a_id;

-- Pattern 3: Categorize based on NULL presence
SELECT 
    a.name,
    CASE 
        WHEN b.id IS NULL THEN 'No Match'
        ELSE 'Has Match'
    END AS match_status
FROM table_a a
LEFT JOIN table_b b ON a.id = b.a_id;

you have used the inner join and you are getting null
Left , Right , Full Outer  these joins can produce null records

RetailMart's Marketing team wants to run a 'We Miss You' campaign targeting customers who registered but never made a purchase. 
These are potential customers who need a nudge!
Task:
Find all customers who have never placed an order.
Concepts Used:

All Customers - Customers who placed the order

'
Pattern 1 	=> we filtered and showed only null vlaues
select 
	*
from
	sales.orders o
right join customers.customers c
	on c.cust_id = o.cust_id
where o.order_id is null

Pattern 2 	=>	We have replaced the null Values with some value
select 
	coalesce(order_id, -1)
from
	sales.orders o
right join customers.customers c
	on c.cust_id = o.cust_id

Pattern 3 	=>	checked and then categorised the in new column
select 
	case 
		when o.order_id is null then 'Inactive Customer'
		else 'Active Customer'
	end as is_active
from
	sales.orders o
right join customers.customers c
	on c.cust_id = o.cust_id
where o.order_id is null









