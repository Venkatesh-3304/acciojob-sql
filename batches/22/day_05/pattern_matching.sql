LIKE
	%

🎬 THE STORY: The Zomato Search Disaster! 🍕

You're a Data Analyst at Zomato. It's lunch time, and 10 lakh people 
are searching for "Biryani" right now! 🍚

Problem: Your search is EXACT MATCH only!

User types: "biryani"
Query: WHERE dish_name = 'biryani'
Results: 0 dishes found! 😱

Why? Because database has:
- "Hyderabadi Biryani"
- "Chicken Biryani Special"
- "Veg Biryani Family Pack"

Select * from dishes
where dish_name LIKE '%biryani%'

Results: 500 dishes found! 🎉
- Hyderabadi Biryani ✓
- Chicken Biryani Special ✓
- Veg Biryani Family Pack ✓

But wait! Some users type "BIRYANI" (caps lock on 😅)

Query: WHERE dish_name LIKE '%BIRYANI%'
Results: 0 found! (LIKE is case-sensitive!)

Final fix with ILIKE:

SELECT * FROM dishes 
WHERE dish_name ILIKE '%biryani%';

Now "biryani", "BIRYANI", "Biryani" ALL work! 🎊

Users are happy. Orders are flowing. Zomato makes crores! 💰




-- Example 1 (Easy): Find Products by Brand Prefix
-- Scenario:
-- A customer calls support asking about "all Samsung products" but doesn't remember exact names.
-- Task:
-- Find all products whose name starts with 'Samsung'.


select 
	*
from
	products.products
where
	prod_name like 'Samsung%'

-- Example 2 (Medium): Case-Insensitive Customer Search
-- Scenario:
-- Customer support receives a call: "I'm looking for a customer named sharma... or was it SHARMA? Maybe Sharma?" 
-- The support agent needs to find all Sharmas regardless of how the name was typed.
-- Task:
-- Find all customers whose name contains 'sharma' in any case.

select
	*
from
	customers.customers
where
	full_name ilike '%sharma%';



Example 3 (Hard): Finding Products with Specific Patterns
Scenario:
Inventory wants to find all products with model numbers following a specific pattern: starting with "PRD" followed by exactly 4 digits. 
Examples: PRD1234, PRD5678.
Task:
Find products where prod_name matches pattern 'PRD' + exactly 4 characters.
	TATA______


select
	*
from
	products.products
where 
	prod_name like 'Tata___________';


Example 4 (Crazy Hard): Complex Multi-Pattern Search
Scenario:
The marketing team needs to find all customers for a campaign targeting people with specific name patterns:

First name starts with 'A' or 'S' (traditional Indian names)
Name contains 'kumar' or 'devi' anywhere (common Indian name patterns)
Located in states ending with 'Pradesh'

Task:
Build a complex pattern matching query combining multiple LIKE/ILIKE conditions.


select
	*
from
	customers.customers
where
	-- First name starts with A or S
	(full_name like 'A%' OR full_name like 'S%')
	AND
	--Name contains kumar or devi (case-insensitive)
	(full_name ilike '%kumar%' OR full_name ilike '%devi%')
	AND
	-- State ends with Pradesh
	state like '%Pradesh';
	












	









