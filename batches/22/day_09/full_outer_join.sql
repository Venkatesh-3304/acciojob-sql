Story: The Great Zomato-Swiggy Merger Analysis

🍔 THE STORY:

Imagine you're a Data Analyst at a consulting firm in Bangalore. Your biggest client just called - Zomato and Swiggy are exploring a hypothetical merger, and they need YOUR analysis!

The CEO asks: "We have 50,000 restaurants on Zomato and 45,000 on Swiggy. How many UNIQUE restaurants would we have after the merger? How many are on BOTH platforms? How many are EXCLUSIVE to each?"

You have two tables:
•	zomato_restaurants (restaurant_id, name, city)
•	swiggy_restaurants (restaurant_id, name, city)

Here's where FULL OUTER JOIN saves the day! 🦸

•	INNER JOIN would show only restaurants on BOTH platforms
•	LEFT JOIN would show all Zomato + matching Swiggy
•	RIGHT JOIN would show all Swiggy + matching Zomato
•	FULL OUTER JOIN shows EVERYTHING - the complete picture!

💼 Real Job Connection: At Flipkart, when they acquired Myntra, data analysts used FULL OUTER JOIN to merge product catalogs, identify overlapping inventory, and find unique products from each platform. This skill directly impacts business decisions worth crores!

4.3 Syntax

-- Basic FULL OUTER JOIN syntax
SELECT columns
FROM table1
FULL OUTER JOIN table2
ON table1.column = table2.column;
-- Alternative syntax (FULL JOIN = FULL OUTER JOIN)

SELECT columns
FROM table1
FULL JOIN table2
ON table1.column = table2.column;


Scenario:

RetailMart wants to see a complete list showing all customers (including those who never ordered) and all orders (including any orphaned orders). 
This helps identify both inactive customers and data integrity issues.

Task:
Use FULL OUTER JOIN to display all customers and their orders, showing NULL where there's no match.

Every order placed will have cust_id.
Its possible to have customer who never placed any order.'

Select
	*
from
	customers.customers c
full outer join sales.orders o
	on c.cust_id=o.cust_id
where 
	-- o.order_id is null								-- Identify the Inactive Customers
	-- o.cust_id is null and o.order_id is not null		-- We have placed the order 
order by
	c.cust_id;

Scenario:
RetailMart's Operations Head needs a comprehensive view showing all products and their inventory status across all stores. 
Some products might not be stocked in any store yet, and some stores might have items not in the main product catalog (promotional items).
Task:
Create a report showing all products with their inventory levels, categorizing items as 'Not Stocked', 'Low Stock', 'Adequate', or 'Overstocked'.