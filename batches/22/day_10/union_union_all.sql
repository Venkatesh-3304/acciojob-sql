📖 TOPIC 3: UNION & UNION ALL

3.1 Definition
Technical Definition

UNION is a set operation that combines the result sets of two or more SELECT statements into a single result set, automatically removing duplicate rows. UNION ALL performs the same combination but keeps ALL rows including duplicates. Both require that all SELECT statements have the same number of columns with compatible data types.

Layman's Terms
Imagine you have two WhatsApp groups - 'College Friends' (50 members) and 'Office Friends' (30 members). Some people are in BOTH groups! UNION is like creating a new group with members from BOTH, but adding each person only ONCE (even if they're in both). UNION ALL would add everyone from both lists - so if Rahul is in both groups, he appears TWICE!
3.2 The Story: The Mega Sale Customer List 🛍️
It's Big Billion Day at Flipkart! The marketing team needs to send SMS notifications to:
• List 1: All customers who ordered Electronics last month
• List 2: All customers who ordered Fashion items last month
Problem: Priya bought both a laptop AND a dress! If they use UNION ALL, she gets 2 SMSes (annoying!). With UNION, she gets just 1 SMS (perfect!).
💡 UNION = Unique contacts only (no spam!). UNION ALL = All records including repeats (useful for counting total transactions across categories!)

3.3 Syntax
-- UNION (removes duplicates)
SELECT column1, column2 FROM table_a
UNION
SELECT column1, column2 FROM table_b;
 
-- UNION ALL (keeps duplicates - faster!)
SELECT column1, column2 FROM table_a
UNION ALL
SELECT column1, column2 FROM table_b;
 
-- Rules:
-- 1. Same number of columns in each SELECT
-- 2. Compatible data types in corresponding columns
-- 3. Column names from FIRST SELECT are used in result
-- 4. ORDER BY goes at the END (after all UNIONs)

🔑 Performance Tip: UNION ALL is faster than UNION because it doesn't need to check for duplicates. Use UNION ALL when you KNOW there are no duplicates or when duplicates are acceptable!


RetailMart wants to find all unique cities where they have either customers OR stores for planning new warehouse locations.


Select 
	city
from
	customers.customers
union
Select
	city 
from
	stores.stores

Finance team needs a combined report of ALL money movements: orders received and returns processed, with proper labeling.


Select
	'Order' as transaction_type,
	order_id as transaction_id,
	order_date as transaction_date,
	total_amount as amount,
	'Credit' as direction
from
	sales.orders
Union All
Select
	'Return' as transaction_type,
	return_id as transaction_id,
	return_date as transaction_date,
	refund_amount as amount,
	'Debit' as direction
from
	sales.returns


RetailMart wants to identify cities where they already have BOTH physical stores AND an existing customer base - prime locations for expansion!

Select 
	city
from
	customers.customers
intersect
Select
	city 
from
	stores.stores


📖 TOPIC 5: EXCEPT

5.1 Definition
Technical Definition

EXCEPT is a set operation that returns rows from the first SELECT statement that are NOT present in the second SELECT statement. It finds the difference between two result sets, showing what's unique to the first query.

Layman's Terms
Imagine you have a list of 'All registered students' and a list of 'Students who paid fees'. EXCEPT gives you students from the first list who are NOT in the second list - i.e., students who haven't paid! It's like subtraction: First List MINUS Common Elements = What's Left. Perfect for finding customers who browsed but didn't buy!
5.2 The Story: The Re-engagement Campaign 📧
Nykaa's retention team is worried. They notice many customers from 2023 haven't ordered in 2024!
"We need to find customers who ordered LAST YEAR but have NOT ordered THIS YEAR. Let's send them a 'We Miss You' email with 15% off!"
💡 EXCEPT is the hero! (2023 Customers) EXCEPT (2024 Customers) = Churned Customers to win back!

5.3 Syntax
-- EXCEPT Syntax
SELECT column1, column2 FROM table_a
EXCEPT
SELECT column1, column2 FROM table_b;
 
-- Returns: Rows in first query but NOT in second query
-- Order matters! (A EXCEPT B) ≠ (B EXCEPT A)
-- Automatically removes duplicates
 
-- Note: Some databases use MINUS instead of EXCEPT
-- PostgreSQL and SQL Server use EXCEPT
-- Oracle uses MINUS

🔑 Remember: EXCEPT order matters! 'Customers EXCEPT Orders' gives registered-but-never-ordered. 'Orders EXCEPT Customers' would give... an error (orders always have customers)!


RetailMart wants to identify cities where they have customers but NO physical store yet - potential locations for new store openings!


Select 
	city
from
	customers.customers
except
Select
	city 
from
	stores.stores
except

Select 
	city
from
	customers.customers