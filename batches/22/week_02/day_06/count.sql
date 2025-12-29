📊 TOPIC 1: COUNT() Function

4.1.1 Definition

Technical Definition:
COUNT() is an aggregate function that returns the number of rows that match a specified condition. 

It can 
	count all rows (COUNT(*)), 
	count non-NULL values in a specific column (COUNT(column_name)), 
	or count distinct values (COUNT(DISTINCT column_name)).
	
Layman's Terms:
Imagine you're a teacher taking attendance in a classroom. 🏫

COUNT(*) = "How many seats are filled?" (counts everyone, including those sleeping!)
COUNT(name) = "How many students have their name on the register?" (skips empty entries)
COUNT(DISTINCT city) = "How many different cities do my students come from?" (Mumbai, Delhi, Mumbai = 2 cities, not 3!)

It's like counting heads at a family gathering - you can count everyone, count only those who brought gifts, or count how many different families are represented!

Count All Customers

📋 Scenario:

RetailMart's CEO wants to know the total number of customers in the database for the annual report.

📝 Task:

Count all customers in the customers table.


select
	count(*)
from
	customers.customers;


The marketing team at RetailMart wants to understand customer distribution. They need:

Total customers from Maharashtra
How many unique cities in Maharashtra have customers

📝 Task:
Use COUNT with WHERE and DISTINCT to get both numbers.

Select
	count(*) as maharastra_customers,
	count(distinct city) as unique_cities
from
	customers.customers
where 
	state='Maharashtra'



-- Business Intelligence - Customer Acquisition Analysis
-- 📋 Scenario:
-- RetailMart's Growth Team wants to analyze customer acquisition over time. They need a comprehensive report showing:

-- Total customers acquired
-- Customers from different regions
-- Gender distribution (for inclusive marketing)

-- 📝 Task:
-- Build a comprehensive acquisition dashboard query.

Select
	count(*) as total_customers,
	count(distinct region_name) as regions_covered,
	count(distinct state) as state_covered,
	count(distinct city) as cities_covered,
	count(distinct gender) as gender_categories
from
	customers.customers
















