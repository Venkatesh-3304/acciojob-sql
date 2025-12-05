	BETWEEN
	IN
	NOT IN

Example 1 (Easy): Find Products in Price Range
Scenario:
A customer has a budget of ₹5,000 to ₹15,000 for electronics. Help them find suitable products.
Task:
Find all products with price between ₹5,000 and ₹15,000.

select
	*
from
	products.products
where
	price between 5000 and 15000;


select
	*
from
	products.products
where
	price >=5000 and price <=15000;


Example 2 (Medium): Find Orders from Multiple Cities
Scenario:
Regional manager for South India needs to see orders from all major South Indian cities for quarterly review.
Task:
Find orders from Chennai, Bangalore, Hyderabad, or Kochi.

Select 
	*
from
	stores.stores
where city = 'Chennai' OR city = 'Banglore' or city = 'Hyderabad' or city = 'Kochi'

Select 
	*
from
	sales.orders
where store_id in (5,33,43,64,103,146,156,160,166,186)


Example 3 (Hard): Complex Filtering with BETWEEN and NOT IN
Scenario:
Finance team needs to analyze "medium-sized" transactions that might need auditing:

Order amounts between ₹5,000 and ₹50,000
Exclude 'Cash' and 'UPI' payments (auto-verified)
Only from Q4 2024 (October-December)

Task:
Find payments matching the complex audit criteria.


select 
	*
from
	sales.payments
where
	amount between 5000 and 50000
	and payment_mode not in ('Cash','UPI')
	and payment_date between '2024-10-01' and '2024-12-31';

Example 4 (Crazy Hard): Multi-Table Filtering Logic
Scenario:
Annual review requires finding "Active High-Potential Customers":

Age between 25 and 45 (peak earning years)
From Tier-1 cities (Mumbai, Delhi, Bangalore, Chennai, Hyderabad, Kolkata)
NOT from states with existing loyalty programs (Maharashtra, Karnataka)
Joined in the last 2 years (2023-2024)

select
	*
from
	customers.customers
where
	age between 25 and 45
	and city in ('Mumbai', 'Delhi', 'Bangalore', 'Chennai', 'Hyderabad', 'Kolkata')
	and state not in ('Maharashtra', 'Karnataka')
	and join_date between '2023-01-01' and '2024-12-31';




select * from daily.employee_records

insert into daily.employee_records (emp_id,emp_name,age) values (2,'Rahul','23'),(3,'Sohan','34')

Find employess where salary is not available;

select * from daily.employee_records
where salary is null

Find employess where salary is  available;



select * from daily.employee_records
where salary is not null








