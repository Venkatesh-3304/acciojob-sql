Example 1 (Easy): Find All Unique Cities
Scenario:
Management wants to know in how many unique cities RetailMart has customers.
Task:
List all unique cities from the customers table.

select distinct city
from customers.customers;

Example 2 (Medium): Find Unique City-State Combinations
Scenario:
For geographical analysis, we need unique combinations of city and state (some city names appear in multiple states, 
like "Hyderabad" in Telangana and Sindh historically).
Task:
Find all unique city-state combinations.

Select
	distinct state,city
from
	customers.customers


select
'NULL'='NULL'

NULL = NULL  → UNKNOWN
NULL <> NULL → UNKNOWN


create table demo(
	id int unique
)




Example 4 (Crazy Hard): DISTINCT ON for First Customer per City
Scenario:
For a "Pioneer Customer" appreciation campaign, marketing wants to identify the FIRST customer who joined from each city (based on join_date). 
These early adopters deserve special recognition!
Task:
Find the first customer from each city using DISTINCT ON.

select distinct on (city)
	*
from
	customers.customers
order by city,join_date



select distinct city,join_date
from
	customers.customers
order by join_date,city


First 10 customers on the basis of join date

select 
	*
from
	customers.customers
order by join_date
limit 10


Distinct	=> Unique values (single Column, Multiple Columns)

select 
	distinct city
from
	customers.customers

select 
	distinct city,state,join_date
from
	customers.customers

Unique combination if city and state along with join date

select 
	distinct on (city,state)
	city,state,join_date
from
	customers.customers
order by city,state,join_date





