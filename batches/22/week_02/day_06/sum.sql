Calculate Total Sales Revenue

📋 Scenario:
The Finance team needs the total revenue from all orders for the annual report.
📝 Task:
Calculate the sum of all order amounts.

select
	sum(total_amount) as total_revenue
from
	sales.orders;

-- Calculate Revenue with Conditions
-- 📋 Scenario:
-- RetailMart's North Region Manager wants to know total sales from North region stores where orders are completed (Delivered status).
-- 📝 Task:
-- Calculate sum with multiple WHERE conditions.

select
	store_id
from
	stores.stores
where
	region='North'

select
	sum(total_amount) as north_region_revenue
from
	sales.orders
where 
	order_status = 'Delivered'
	and
	store_id in (3,17,34,53,54,57,64,69,70,74,80,83,88,93,96,98,99,101,104,106,109,110,114,123,127,133,146,148,149,156,158,160,165,166,167,180,181,189)

Scenario:
The CFO needs a revenue breakdown from order_items:

Gross revenue (before discounts)
Total discounts given
Net revenue (after discounts)
Average discount per item

Select
	sum(quantity) as total_items_sold,
	sum(unit_price* quantity) as gross_revenue,
	sum((unit_price*quantity)*((discount/100))) as total_discount,
	sum((unit_price*quantity)*(1-(discount/100))) as net_revenue,
	sum((unit_price*quantity)*((discount/100)))/count(*) as total_discount,
	avg((unit_price*quantity)*((discount/100)))
from
	sales.order_items
limit 10;


Select
	unit_price,quantity,round((unit_price*quantity)*(1-(discount/100)),2) ,discount
from
	sales.order_items
limit 10;
























