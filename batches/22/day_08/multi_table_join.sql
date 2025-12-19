🎯 TOPIC 5: MULTI-TABLE JOINS

📖 Definition

Technical Definition:

Multi-table joins involve combining three or more tables in a single query by chaining multiple JOIN operations. Each JOIN connects two tables, and the result becomes the "left" table for the next JOIN operation.

Layman's Terms:
Think of multi-table JOINs like connecting train bogies 🚂:

First, Engine connects to Bogie 1
Then, Bogie 1 connects to Bogie 2
Then, Bogie 2 connects to Bogie 3

Result: A complete train!

Each connection uses the right "coupler" (join key) to link properly!
Indian Analogy - The Wedding Reception Chain! 💒🎉
At an Indian wedding, you need multiple lists:

Guest List: Who's invited
Seating Chart: Which table they sit at
Menu Preference: Veg or Non-veg
Gift Registry: What gift they brought
RSVP Status: Did they confirm?

Multi-table JOIN connects ALL these to give:
"Sharma Uncle sits at Table 5, prefers Veg, brought a mixer-grinder, and confirmed attendance!"

table1
table2
table3
table4
table5

table1 join table2  =>  result1

result1 join table3 =>  result2

result2 join table5 =>  result3

result3 join table4 =>  result4





Amazon.com
    Sign Up
        Insert new entry for the customer
    Purchased
        Orders
            new entry 
        Order_items
            new entry
        Inventory
            reduce the stock


-- Basic Multi-Table JOIN Structure
SELECT columns
FROM table1 t1
JOIN table2 t2 ON t1.key = t2.key
JOIN table3 t3 ON t2.key = t3.key
JOIN table4 t4 ON t3.key = t4.key;

-- Mixing JOIN types
SELECT columns
FROM main_table m
INNER JOIN related_table1 r1 ON m.id = r1.main_id    -- Must match
LEFT JOIN optional_table1 o1 ON m.id = o1.main_id    -- Optional
LEFT JOIN optional_table2 o2 ON m.id = o2.main_id;   -- Optional

-- Multiple conditions in JOINs
SELECT columns
FROM table1 t1
JOIN table2 t2 ON t1.key1 = t2.key1 AND t1.key2 = t2.key2
JOIN table3 t3 ON t2.key = t3.key;

-- Best practice: Indent for readability
SELECT 
    t1.column1,
    t2.column2,
    t3.column3,
    t4.column4
FROM table1 t1
    INNER JOIN table2 t2 
        ON t1.id = t2.t1_id
    LEFT JOIN table3 t3 
        ON t2.id = t3.t2_id
    LEFT JOIN table4 t4 
        ON t3.id = t4.t3_id
WHERE t1.active = true
ORDER BY t1.column1;


Complete Order Details with Products
Scenario:
The finance team needs a detailed invoice report showing each order with customer info, all products purchased, and payment method. 
This requires joining 5 tables.
Task:
Create an invoice-style report with customer, products, quantities, and payment details.


Select
	o.order_id,
	o.order_date,
	c.full_name,
	c.city,
	p.prod_name,
	p.category,
	oi.quantity,
	oi.unit_price,
	(oi.quantity * oi.unit_price) as line_total,
	pay.payment_mode,
	pay.payment_date
from
	sales.orders o							--=>	Table1
	join customers.customers c				--=>	Table2
		on o.cust_id=c.cust_id				--=>	Result1	=>	Table1+Table2
	join sales.order_items oi				--=>	Table3
		on o.order_id=oi.order_id			--=>	Result2	=>	Result1+Table3	
	join products.products p
		on oi.prod_id=p.prod_id
	join sales.payments pay
		on pay.order_id=o.order_id


Select
	*
from
	customers.customers c, sales.payments
limit 100

table
	id unique

	Null
	NULL
	NULL
	NULL

	NULL = NULL 	=> 	False

table 
	id primary key
		Unique + Not NUll



The operations team needs a complete "Order Journey" report for customer service. When a customer calls, agents need to see: 
customer info, products ordered, store that fulfilled it, payment status, shipment tracking, and any returns. 
This requires joining 7 tables with mixed join types!
Task:
Create the ultimate order tracking report combining all relevant information.



Select
	o.order_id,
	o.order_date,

	--Customer Information
	c.full_name as customer_name,
	c.city as customer_city,
	c.state as customer_state,

	--Product Information
	p.prod_name as product,
	p.category,
	p.brand,
	oi.quantity,
	oi.unit_price,
	(oi.quantity * oi.unit_price) as line_total,

	--Store Information
	st.store_name,
	st.city as store_city,

	--Order Status
	o.order_status,

	--Payment Information
	pay.payment_mode,
	pay.amount as payment_amount,
	pay.payment_date,

	--Shipment Information 
	coalesce(ship.courier_name , 'Not Shipped') as courier,
	coalesce(ship.status, 'Pending') as shipment_status,
	ship.shipped_date,
	ship.delivered_date,

	--Return Information (If Any)

	case 
		when ret.return_id is not null then 'Yes'
		else 'No'
	end as has_return,
	ret.reason as return_reason,
	ret.refund_amount,

	--Overall Status
	Case
		when ret.return_id is not null then 'Returned'
		when ship.status = 'Delivered' then 'Completed'
		when ship.status = 'Shipped' then 'On the Way'
		when pay.payment_id is not null then 'Paid - Awaiting Shipment'
		else ' Processing'
	end as journey_status
from
	sales.orders o
	--Always have customer(INNER)
	join customers.customers c
		on o.cust_id = c.cust_id
	--Always have store (INNER)
	join stores.stores st
		on o.store_id=st.store_id
	--Always have items(INNER)
	join sales.order_items oi
		on oi.order_id=o.order_id
	--Always have products (INNER)
	join products.products p
		on p.prod_id=oi.prod_id
	--Payment might be opending (Left)
	left join sales.payments pay
		on pay.order_id =o.order_id
	-- Shipment might not exist yet(Left)		
	left join sales.shipments ship
		on ship.order_id = o.order_id
	-- Return is optional(Left)	
	left join sales.returns ret
		on o.order_id=ret.order_id
			and oi.prod_id=ret.prod_id
limit 25;

select distinct status from sales.shipments ship


