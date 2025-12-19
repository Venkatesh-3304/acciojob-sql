CROSS JOIN
IMPLICIT JOIN

Select
    *
from
    orders,customers
where orders.cust_id=customers.cust_id

Select
    *
from
    sales.orders o 
    inner join customers.customers c
        o.cust_id=c.cust_id



        explain analyse
Select
    *
from
    sales.orders ,customers.customers
-- where orders.cust_id=customers.cust_id

explain analyse
Select
    o.cust_id
from
    sales.orders o 
    inner join customers.customers c
        on o.cust_id=c.cust_id

SELECT *																			-- Select *
FROM customers.customers, sales.orders, sales.order_items,products.products 		-- Implicit Join
WHERE customers.customers.cust_id = sales.orders.cust_id							-- No Aliases
AND sales.orders.order_id = sales.order_items.order_id
AND sales.order_items.prod_id = products.products.prod_id
AND UPPER(customers.customers.city) = 'MUMBAI';  									--Function on Column

SELECT 
    c.cust_id,
    c.full_name,
    o.order_id,
    o.order_date,
    p.prod_name,
    oi.quantity,
    oi.unit_price,
    (oi.quantity * oi.unit_price) AS line_total
FROM customers.customers c
INNER JOIN sales.orders o ON c.cust_id = o.cust_id
INNER JOIN sales.order_items oi ON o.order_id = oi.order_id
INNER JOIN products.products p ON oi.prod_id = p.prod_id
WHERE c.city ILIKE 'Mumbai';  -- Case-insensitive without function






