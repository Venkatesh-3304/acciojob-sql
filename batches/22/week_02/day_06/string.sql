String_agg	=>	Concatenation,txt_join

Department | Employee
-----------+---------
Sales      | Rahul
Sales      | Priya
Sales      | Amit
IT         | Sneha
IT         | Vikram


Department | Employees
-----------+---------------------------------
Sales      | Rahul, Priya, Amit
IT         | Sneha, Vikram


List All Cities
📋 Scenario:
Marketing needs a comma-separated list of all unique cities where RetailMart has customers.
📝 Task:
Create a single string with all city names.

Select
	string_agg(distinct city, ' , '  )
from 
	customers.customers;


Select
	unnest(array_agg(distinct city))
from 
	customers.customers;













	