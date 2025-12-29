CORRELATED SUBQUERIES

📖 Definition
Technical Definition:
A Correlated Subquery is a subquery that references columns from the outer query. Unlike regular subqueries that execute once, correlated subqueries execute once for EACH ROW of the outer query, using values from the current row to filter or compute results.
Layman's Terms (Simple Explanation):
Imagine you're a teacher checking if each student scored above their CLASS average (not the school average). For EACH student, you need to first calculate THEIR class's average, then compare. That's a correlated subquery - it's like a personalized check for every row!
📚 The Story: The Personalized Performance Checker
🏪 THE FLIPKART SELLER RATING SYSTEM
Imagine you're the Data Analyst at Flipkart. Your manager asks:
"Find all products that are priced ABOVE the average price in THEIR OWN category!"
🤔 The Challenge:
A ₹5,000 phone might be expensive for 'Budget Phones' category but cheap for 'Premium Phones' category. You can't use ONE average - you need CATEGORY-SPECIFIC averages!
💡 The Solution: Correlated Subquery!
For EACH product, the inner query calculates the average of THAT product's category, then compares. It's like having a smart assistant who customizes the comparison for each item!
🎯 Career Connection: At Amazon, analysts use correlated subqueries daily to find products performing above/below their category benchmarks!
⌨️ Syntax
SELECT column1, column2
FROM table1 AS outer_table
WHERE column1 > (
    SELECT AGG_FUNCTION(column)
    FROM table2 AS inner_table
    WHERE inner_table.key = outer_table.key  -- The CORRELATION!
);

⚠️ Key Point: The inner query references outer_table.key - this is what makes it CORRELATED!
💻 Examples
Example 1 (Medium): Products Priced Above Their Category Average
Scenario: RetailMart wants to identify premium-priced products - those priced above the average in their own category. This helps identify products that might need price adjustments or marketing as 'premium' items.
Concepts Used: Correlated subquery, AVG(), comparison operators

-- Find products priced above their category's average price
SELECT
    p.prod_id,
    p.prod_name,
    p.category,
    p.price,
    (SELECT ROUND(AVG(p2.price), 2)
     FROM products.products p2
     WHERE p2.category = p.category) AS category_avg
FROM products.products p
WHERE p.price > (
    SELECT AVG(p2.price)
    FROM products.products p2
    WHERE p2.category = p.category
)
ORDER BY p.category, p.price DESC;

Real-World Application: E-commerce companies like Myntra use this to flag 'premium' items within each category for special marketing campaigns and to identify potential price optimization opportunities.
Example 2 (Hard): Customers Who Spent More Than Their City's Average
Scenario: RetailMart's marketing team wants to identify high-value customers - those who spent more than the average customer in their city. This helps create city-specific VIP programs.
Concepts Used: Correlated subquery with JOIN, SUM(), GROUP BY in subquery, multiple table references

-- Find customers who spent more than their city's average
SELECT
    c.cust_id,
    c.full_name,
    c.city,
    SUM(o.total_amount) AS customer_total,
    (SELECT ROUND(AVG(city_totals.total_spent), 2)
     FROM (
         SELECT c2.cust_id, SUM(o2.total_amount) AS total_spent
         FROM customers.customers c2
         INNER JOIN sales.orders o2 ON c2.cust_id = o2.cust_id
         WHERE c2.city = c.city
         GROUP BY c2.cust_id
     ) AS city_totals) AS city_avg_spend
FROM customers.customers c
INNER JOIN sales.orders o ON c.cust_id = o.cust_id
GROUP BY c.cust_id, c.full_name, c.city
HAVING SUM(o.total_amount) > (
    SELECT AVG(city_totals.total_spent)
    FROM (
        SELECT c2.cust_id, SUM(o2.total_amount) AS total_spent
        FROM customers.customers c2
        INNER JOIN sales.orders o2 ON c2.cust_id = o2.cust_id
        WHERE c2.city = c.city
        GROUP BY c2.cust_id
    ) AS city_totals
)
ORDER BY c.city, customer_total DESC;

Real-World Application: Swiggy and Zomato use similar logic to identify 'super users' in each city for exclusive offers and early access to new features.

ANY, SOME, ALL OPERATORS

📖 Definition
Technical Definition:
ANY (or SOME - they're identical) returns TRUE if the comparison is true for AT LEAST ONE value returned by the subquery. ALL returns TRUE only if the comparison is true for EVERY value returned by the subquery. These operators work with comparison operators (=, >, <, >=, <=, <>) and subqueries returning multiple values.
Layman's Terms (Simple Explanation):
Think of a cricket team selection: ANY means 'Pick players who scored more than ANY batsman from yesterday's match' (just beat at least one score). ALL means 'Pick players who scored more than ALL batsmen from yesterday's match' (must beat everyone's score!). ANY is easier to satisfy, ALL is stricter!
📚 The Story: The IPL Auction Room
🏏 THE IPL AUCTION COMPARISON DRAMA!
Imagine you're a data analyst for Mumbai Indians during IPL auction...
🎯 Scenario 1 - Using ANY:
Coach says: 'Find bowlers who took more wickets than ANY Chennai bowler last season.'
Chennai bowlers took: 15, 20, 25, 30 wickets. A bowler with 16 wickets qualifies (beats 15)!
🎯 Scenario 2 - Using ALL:
Coach says: 'Find bowlers who took more wickets than ALL Chennai bowlers!'
Now you need 31+ wickets to qualify (must beat everyone including the 30-wicket champion)!
💡 That's the power difference! ANY = beat at least one, ALL = beat everyone!
⌨️ Syntax
-- ANY / SOME Syntax (they're identical)
SELECT columns FROM table1
WHERE column > ANY (SELECT column FROM table2 WHERE condition);

-- ALL Syntax
SELECT columns FROM table1
WHERE column > ALL (SELECT column FROM table2 WHERE condition);

💡 Quick Reference:
• > ANY = Greater than the MINIMUM value in the list
• < ANY = Less than the MAXIMUM value in the list
• > ALL = Greater than the MAXIMUM value in the list
• < ALL = Less than the MINIMUM value in the list
💻 Examples
Example 1 (Medium): Products More Expensive Than ANY Product in a Category
Scenario: Find all Electronics products that cost more than ANY product in the Groceries category. This helps identify cross-category pricing opportunities.
Concepts Used: > ANY operator, subquery returning multiple values

-- Find Electronics priced higher than ANY Grocery item
SELECT
    prod_id,
    prod_name,
    category,
    price
FROM products.products
WHERE category = 'Electronics'
AND price > ANY (
    SELECT price
    FROM products.products
    WHERE category = 'Groceries'
)
ORDER BY price;

What This Does: Returns Electronics products priced above the CHEAPEST Grocery item. If Groceries range from ₹50-₹500, any Electronics over ₹50 qualifies.
Real-World Application: BigBasket uses similar logic to ensure their premium products are appropriately priced compared to other categories.
Example 2 (Hard): Orders Larger Than ALL Orders From a Specific Store
Scenario: The CEO wants to find 'mega orders' - orders that are larger than EVERY order from the Mumbai store (store_id = 1). These represent exceptional sales achievements.
Concepts Used: > ALL operator, aggregate comparison, business logic

-- Find orders larger than ALL orders from Mumbai store
SELECT
    o.order_id,
    c.full_name AS customer_name,
    s.store_name,
    o.order_date,
    o.total_amount
FROM sales.orders o
INNER JOIN customers.customers c ON o.cust_id = c.cust_id
INNER JOIN stores.stores s ON o.store_id = s.store_id
WHERE o.total_amount > ALL (
    SELECT o2.total_amount
    FROM sales.orders o2
    WHERE o2.store_id = 1  -- Mumbai store
    AND o2.total_amount IS NOT NULL
)
ORDER BY o.total_amount DESC;

What This Does: Returns only orders that exceed the MAXIMUM order value from Mumbai. If Mumbai's largest order was ₹50,000, only orders above ₹50,000 appear.
Real-World Application: Retail chains use this to identify exceptional performers and understand what drives unusually large transactions.
