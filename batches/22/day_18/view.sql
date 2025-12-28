4. Topic 1: CREATE VIEW
📖 Definition
Technical Definition:

A VIEW is a stored SQL query that behaves like a virtual table. It does not store data physically but dynamically retrieves data from underlying base tables each time it is queried. Views are defined using the CREATE VIEW statement and can include SELECT queries with JOINs, WHERE clauses, aggregations, and other SQL constructs.

Layman''s Terms:
Think of a VIEW like a saved filter on your photo gallery. When you create an album called "Family Photos", you're not copying photos - you're just creating a shortcut that shows only family photos whenever you open it. Similarly, a VIEW is a saved query that shows specific data from your tables whenever you run it - without duplicating the actual data!

🎭 The Story: Rahul''s Dashboard Nightmare
🏢 Setting: Data Analytics Team at BigBasket, Bangalore

Rahul, a junior data analyst at BigBasket, was having the worst Monday of his life. His manager Priya had asked him to create a daily sales report. Simple enough, right?
The problem? The query was 47 lines long! It joined 5 tables, had complex CASE statements, window functions for rankings, and aggregations. Every. Single. Day. Rahul had to copy-paste this monster query.

"Rahul!" Priya called. "Marketing also needs the same report but without customer phone numbers. And Finance needs it with extra columns. And Operations wants it filtered by city!"

Rahul's head was spinning. Three different 47-line queries? What if the logic changes? He'd have to update all three!
That's when senior analyst Meera walked by. "Rahul, why are you suffering? Just create a VIEW!"
"A what?"
Meera smiled. "A VIEW is like saving your query as a virtual table. Instead of copying that 47-line query everywhere, you save it ONCE as a view. Then everyone just writes:

SELECT * FROM daily_sales_view WHERE city = 'Bangalore';
That's it! One line instead of 47. And when the logic changes, you update ONE view, and everyone gets the updated data automatically!"
Rahul's eyes lit up. 💡 "So it's like creating a shortcut that always runs the latest query?"
"Exactly! Welcome to the world of VIEWS - where smart analysts save hours every week!"
🎯 Career Connection: At companies like Flipkart and Amazon, data teams create hundreds of views to standardize reporting. Knowing views well can help you land roles paying ₹8-15 LPA!
'
⚙️ Syntax
-- Basic CREATE VIEW syntax
CREATE VIEW view_name AS
SELECT column1, column2, ...
FROM table_name
WHERE condition;

-- CREATE OR REPLACE VIEW (update existing view)
CREATE OR REPLACE VIEW view_name AS
SELECT new_column1, new_column2, ...
FROM table_name;

-- DROP VIEW
DROP VIEW view_name;
DROP VIEW IF EXISTS view_name;  -- Safe drop

📝 Example 1 (Medium): Customer Order Summary View
Scenario: At RetailMart, the customer support team frequently needs to see customer order summaries. Create a view that shows customer name, total orders, total spending, and their loyalty tier.
Concepts Used: VIEW creation, JOINs (Day 8), Aggregate functions (Day 6), CASE WHEN (Day 7)
-- Create a view for customer order summary
CREATE VIEW customers.vw_customer_order_summary AS
SELECT
    c.cust_id,
    c.full_name,
    c.city,
    COUNT(o.order_id) AS total_orders,
    COALESCE(SUM(o.total_amount), 0) AS total_spending,
    CASE
        WHEN COALESCE(SUM(o.total_amount), 0) >= 50000 THEN 'Platinum'
        WHEN COALESCE(SUM(o.total_amount), 0) >= 20000 THEN 'Gold'
        WHEN COALESCE(SUM(o.total_amount), 0) >= 5000 THEN 'Silver'
        ELSE 'Bronze'
    END AS loyalty_tier
FROM customers.customers c
LEFT JOIN sales.orders o ON c.cust_id = o.cust_id
GROUP BY c.cust_id, c.full_name, c.city;

-- Now customer support can simply run:
SELECT * FROM customers.vw_customer_order_summary
WHERE loyalty_tier = 'Platinum'
ORDER BY total_spending DESC;

💼 Real-World Application: At Amazon, customer support reps use similar views to instantly see customer purchase history, tier status, and Prime membership - all through a single, simple query!
📝 Example 2 (Hard): Store Performance Dashboard View
Scenario: RetailMart's management needs a comprehensive store performance view showing revenue, employee count, revenue per employee, month-over-month growth, and performance ranking.
Concepts Used: VIEW, JOINs (Day 8-9), Window Functions (Day 13-14), CTEs (Day 12), Aggregates (Day 6)
-- Comprehensive store performance dashboard view
CREATE VIEW stores.vw_store_performance_dashboard AS
WITH store_revenue AS (
    SELECT
        s.store_id,
        s.store_name,
        s.city,
        s.state,
        COALESCE(SUM(o.total_amount), 0) AS total_revenue,
        COUNT(DISTINCT o.order_id) AS total_orders
    FROM stores.stores s
    LEFT JOIN sales.orders o ON s.store_id = o.store_id
    GROUP BY s.store_id, s.store_name, s.city, s.state
),
employee_count AS (
    SELECT store_id, COUNT(*) AS emp_count
    FROM stores.employees
    GROUP BY store_id
)
SELECT
    sr.store_id,
    sr.store_name,
    sr.city,
    sr.state,
    sr.total_revenue,
    sr.total_orders,
    COALESCE(ec.emp_count, 0) AS employee_count,
    CASE
        WHEN COALESCE(ec.emp_count, 0) > 0
        THEN ROUND(sr.total_revenue / ec.emp_count, 2)
        ELSE 0
    END AS revenue_per_employee,
    DENSE_RANK() OVER (ORDER BY sr.total_revenue DESC) AS revenue_rank,
    NTILE(4) OVER (ORDER BY sr.total_revenue DESC) AS performance_quartile
FROM store_revenue sr
LEFT JOIN employee_count ec ON sr.store_id = ec.store_id;
💼 Real-World Application: Retail chains like DMart and Reliance Fresh use such views for regional managers to compare store performance without writing complex queries every time!
 
