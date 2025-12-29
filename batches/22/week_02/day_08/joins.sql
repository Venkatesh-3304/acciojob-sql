📖 Story: The Flipkart Delivery Chaos 🛒📦

🎬 THE STORY:

Imagine you're a new Data Analyst intern at Flipkart during the Big Billion Days sale. Your manager Priya comes running to you with a problem...

"We have a CRISIS!" she says. "Customers are calling saying they haven't received their orders, but the delivery team says everything is delivered!"

You open your database and find:

📓 Table 1: orders

| order_id | customer_id | order_date | total_amount |
|----------|-------------|------------|--------------|
| 1001     | C101        | 2024-10-10 | ₹2,500       |
| 1002     | C102        | 2024-10-10 | ₹15,000      |
| 1003     | C103        | 2024-10-11 | ₹800         |

📓 Table 2: customers

| customer_id | customer_name | phone        | city      |
|-------------|---------------|--------------|-----------|
| C101        | Rahul Sharma  | 9876543210   | Mumbai    |
| C102        | Priya Patel   | 8765432109   | Delhi     |
| C103        | Amit Kumar    | 7654321098   | Bangalore |

📓 Table 3: shipments

| shipment_id | order_id | status      | delivered_date |
|-------------|----------|-------------|----------------|
| S001        | 1001     | Delivered   | 2024-10-12     |
| S002        | 1002     | In Transit  | NULL           |
| S003        | 1003     | Delivered   | 2024-10-13     |

The Problem: Each table has only PARTIAL information!

Orders table doesn't know customer names or phone numbers
Customers table doesn't know what they ordered
Shipments table doesn't know who the customer is

You need to call customers whose orders are stuck "In Transit"!
But wait... you can't just look at one table. You need:

Customer NAME (from customers table)
Customer PHONE (from customers table)
Order AMOUNT (from orders table)
Shipment STATUS (from shipments table)

SELECT 
    c.customer_name,
    c.phone,
    o.order_id,
    o.total_amount,
    s.status
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN shipments s ON o.order_id = s.order_id
WHERE s.status = 'In Transit';


📖 Why Do We Need JOINs?

The Problem with Single Tables:

If we stored EVERYTHING in one table, we'd have:

| order_id | customer_name | customer_phone | customer_city | product_name | product_price | supplier_name | store_name | ... |

Issues:

Data Redundancy: Same customer info repeated 100 times if they order 100 items
Update Anomalies: Customer changes phone? Update 100 rows!
Storage Waste: Repeating "Mumbai" 10,000 times wastes space
Inconsistency Risk: Typo in one row = confusing data

The Solution: Normalization + JOINs

Store each entity in its own table (customers, products, orders)
Connect them using Foreign Keys
Use JOINs to combine when needed

This is why Day 4's Foreign Keys were SO important! 🔑


📖 Table Aliases - Writing Cleaner Code

Technical Definition:
A table alias is a temporary name given to a table in a query, making the code shorter and more readable, especially when joining multiple tables.

Without Aliases (Painful! 😫):

SELECT 
    customers.customers.customer_name,
    sales.orders.order_id,
    sales.orders.total_amount
FROM customers.customers
JOIN sales.orders ON customers.customers.cust_id = sales.orders.cust_id;


With Aliases (Clean! ✨):

SELECT 
    c.full_name,
    o.order_id,
    o.total_amount
FROM customers.customers c
JOIN sales.orders o ON c.cust_id = o.cust_id;

Alias Rules:
    Defined right after table name (no AS needed, but AS is also valid)
    Typically 1-3 letters representing the table
    Once defined, use alias throughout the query
    Common conventions: c for customers, o for orders, p for products, ot for order_items


✅ SQL Naming Convention Rules (Must-Follow)

1️⃣ Column & Table Alias Rules
✔ Allowed

Must start with a letter
Can contain letters, numbers, underscores
Should be meaningful and short
It can start with alphabet and underscore

SELECT
    salary AS salary_amt,
    department_id AS dept_id
FROM employees e;

❌ Not Allowed
SELECT salary AS 1        -- ❌ numeric alias
SELECT salary AS @amt    -- ❌ special character
FROM employees 123       -- ❌ numeric table alias

2️⃣ Best Naming Style (Industry Standard)

✔ Snake_case (Preferred)
employee_id
order_date
total_amount

❌ Avoid
EmployeeID      -- camel case
employee-id     -- hyphen
Total Amount    -- space

3️⃣ Table Alias Naming Rules
✔ Good
FROM employees e
JOIN departments d

❌ Bad
FROM employees 1      -- invalid
FROM employees emp1   -- confusing

4️⃣ Column Alias Rules
✔ Good
SELECT
    SUM(sales) AS total_sales,
    COUNT(*) AS order_count

❌ Bad
SELECT SUM(sales) AS total sales   -- space without quotes
SELECT SUM(sales) AS 2025_sales    -- starts with number

5️⃣ CASE Expression Alias Rule

Alias is mandatory if you want to reuse output cleanly.

SELECT
    CASE
        WHEN salary > 50000 THEN 'High'
        ELSE 'Low'
    END AS salary_band
FROM employees;


❌ Don’t do:

END AS 1

6️⃣ Positional Reference Rule (Important)
GROUP BY 1   -- refers to first SELECT column
ORDER BY 2   -- refers to second SELECT column


⚠️ Rule:

Valid SQL

Not an alias

Avoid in production (fragile, unreadable)

7️⃣ Reserved Keywords Rule

❌ Avoid SQL keywords as names:

SELECT * FROM order;    -- ❌


✔ Correct:

SELECT * FROM orders;

8️⃣ Interview-Safe Naming Checklist

Use this every time:

✔ lowercase
✔ snake_case
✔ descriptive
✔ no numbers at start
✔ no special characters
✔ no reserved keywords

