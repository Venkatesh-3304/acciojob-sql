4. Topic 1: CREATE VIEW
📖 Definition
Technical Definition:
A VIEW is a stored SQL query that behaves like a virtual table. It does not store data physically but dynamically retrieves data from underlying base tables each time it is queried. Views are defined using the CREATE VIEW statement and can include SELECT queries with JOINs, WHERE clauses, aggregations, and other SQL constructs.
Layman's Terms:
Think of a VIEW like a saved filter on your photo gallery. When you create an album called "Family Photos", you're not copying photos - you're just creating a shortcut that shows only family photos whenever you open it. Similarly, a VIEW is a saved query that shows specific data from your tables whenever you run it - without duplicating the actual data!
🎭 The Story: Rahul's Dashboard Nightmare
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
 
5. Topic 2: Updatable vs Read-Only Views
📖 Definition
Technical Definition:
An Updatable View allows INSERT, UPDATE, and DELETE operations that are passed through to the underlying base table. A Read-Only View only permits SELECT operations. In PostgreSQL, a view is automatically updatable if it references exactly one table, contains all non-nullable columns without defaults, has no DISTINCT, GROUP BY, HAVING, LIMIT, OFFSET, UNION, INTERSECT, EXCEPT, aggregates, or window functions.
Layman's Terms:
Imagine looking through a window at a garden. A Read-Only View is like a sealed window - you can SEE the garden but can't touch the plants. An Updatable View is like an open window - you can reach through and actually water the plants or pluck flowers! The key is: simple windows (no fancy glass, no curtains) let you reach through; complex windows with filters block your hands.
🎭 The Story: The Two Windows of Mumbai Hotel
🏨 Setting: The Taj Hotel's Reception, Mumbai
The Taj Hotel had two special windows in their reception area:
🪟 Window 1 (Read-Only): A beautiful glass display showing the hotel's daily occupancy dashboard - total rooms booked, revenue summary, top-spending guests. It used aggregations and rankings. Guests and staff could VIEW the impressive numbers, but nobody could reach through to change them. It was purely for display.
🚪 Window 2 (Updatable): A simple service window showing individual room bookings - just room_number, guest_name, check_in_date, check_out_date from a single rooms table. The front desk staff could reach through this window to UPDATE guest names if spelled wrong, or DELETE a booking if cancelled.
One day, a new intern tried to UPDATE the occupancy percentage through Window 1. ERROR! 🚫
"Why can't I update this?" he asked.
The senior manager explained: "Window 1 has fancy calculations - SUM, AVG, RANK. How would PostgreSQL know which individual booking to update when you try to change an aggregate? It's like trying to change one apple by updating the total weight of a fruit basket!"
"But Window 2 shows raw data from ONE table with no calculations. PostgreSQL knows exactly which row to update. That's why simple views are updatable, complex views are read-only!"
🎯 Key Insight: The simpler the view (one table, no aggregates, no JOINs), the more likely it's updatable!
📋 Updatable View Requirements
✅ Updatable (Can INSERT/UPDATE/DELETE)	❌ Read-Only (SELECT only)
• References ONE table only
• No DISTINCT clause
• No GROUP BY / HAVING
• No aggregate functions
• No window functions
• No UNION/INTERSECT/EXCEPT
• No LIMIT/OFFSET	• JOINs multiple tables
• Uses DISTINCT
• Has GROUP BY / HAVING
• Contains SUM, COUNT, AVG, etc.
• Uses ROW_NUMBER, RANK, etc.
• Combines with set operations
• Limits result rows
📝 Example 1 (Medium): Creating an Updatable View
Scenario: Create a view for the HR team to manage active employees. They should be able to INSERT new employees and UPDATE salaries through this view.
-- Updatable view: simple, single table, no aggregates
CREATE VIEW hr.vw_active_employees AS
SELECT
    emp_id,
    emp_name,
    role,
    salary,
    dept_id,
    store_id
FROM stores.employees;
-- This view IS updatable! HR can do:
-- Update salary through the view
UPDATE hr.vw_active_employees
SET salary = salary * 1.10  -- 10% raise
WHERE role = 'Sales Associate';
-- Check if a view is updatable
SELECT table_name, is_updatable, is_insertable_into
FROM information_schema.views
WHERE table_name = 'vw_active_employees';
📝 Example 2 (Hard): Understanding Why a View is Read-Only
Scenario: Demonstrate why a complex view with JOINs and aggregates becomes read-only, and show what happens when you try to update it.
-- Read-only view: has JOIN, GROUP BY, aggregates
CREATE VIEW sales.vw_store_daily_summary AS
SELECT
    s.store_id,
    s.store_name,
    o.order_date,
    COUNT(o.order_id) AS order_count,
    SUM(o.total_amount) AS daily_revenue
FROM stores.stores s
INNER JOIN sales.orders o ON s.store_id = o.store_id
GROUP BY s.store_id, s.store_name, o.order_date;
-- This view is READ-ONLY! If you try:
UPDATE sales.vw_store_daily_summary
SET daily_revenue = 50000
WHERE store_id = 1 AND order_date = '2024-01-15';
-- ERROR: cannot update view "vw_store_daily_summary"
-- DETAIL: Views containing GROUP BY are not automatically updatable.
-- Why? daily_revenue = SUM of many orders. Which order to update?
-- PostgreSQL can't figure that out, so it blocks the update!
 
6. Topic 3: Row-Level and Column-Level Security
📖 Definition
Technical Definition:
Column-Level Security: A view that includes only specific columns from the base table, hiding sensitive columns like salaries, phone numbers, or PAN cards. Row-Level Security: A view that includes a WHERE clause to filter rows, ensuring users only see data they're authorized to access (e.g., their own region's data).
Layman's Terms:
Imagine your HR database has employee names, salaries, and Aadhaar numbers. Column-level security is like giving the receptionist a view that shows names and departments but hides salaries - they can't even see that column! Row-level security is like giving each regional manager a view that only shows employees from THEIR region. Same table, different visibility based on WHO is asking!
🎭 The Story: The Three Departments at HDFC Bank
🏦 Setting: HDFC Bank's Customer Database, Mumbai HQ
HDFC Bank has a massive customer table with sensitive data: name, phone, email, account_balance, credit_score, PAN_card, and Aadhaar_number.
Three departments need access, but with VERY different permissions:
📞 Customer Support Team: Needs name, phone, email to help customers. Should NOT see balance, credit score, PAN, or Aadhaar. That's a privacy violation!
💳 Credit Card Team: Needs name, credit_score, and balance to approve cards. But only for customers in Maharashtra (their region).
🔒 Compliance Team: Needs everything, but only for customers with balance > ₹50 lakhs (high-value monitoring).
The DBA Sneha created THREE VIEWS:
1. vw_customer_support → Column-level security (hides sensitive columns)
2. vw_credit_maharashtra → Row + Column security (credit fields, Maharashtra only)
3. vw_high_value_customers → Row security (all columns, balance > 50L)
Now each team has exactly what they need - no more, no less. The base table is protected, and compliance requirements are met! 🎯
🎯 Career Connection: RBI mandates data privacy controls. Banks hire SQL experts at ₹12-20 LPA specifically for building secure data access layers using views!
📝 Example 1 (Medium): Column-Level Security
Scenario: Create a view for the Marketing team that shows customer demographics for campaigns but hides sensitive financial data.
-- Column-level security: Marketing sees demographics, NOT financials
CREATE VIEW marketing.vw_customer_demographics AS
SELECT
    cust_id,
    full_name,
    gender,
    CASE
        WHEN age < 25 THEN '18-24'
        WHEN age < 35 THEN '25-34'
        WHEN age < 45 THEN '35-44'
        WHEN age < 55 THEN '45-54'
        ELSE '55+'
    END AS age_group,  -- Age bucket, not exact age
    city,
    state,
    region_name
FROM customers.customers;
-- Hidden columns: exact age, join_date, and any linked financial data
-- Marketing can analyze demographics without privacy risks!
📝 Example 2 (Hard): Combined Row + Column Security
Scenario: Create a secure view for Regional Managers that shows employee performance data only for their assigned region, hiding salary details while showing performance metrics.
-- Combined Row + Column security with performance metrics
CREATE VIEW stores.vw_regional_employee_performance AS
WITH employee_sales AS (
    SELECT
        e.emp_id,
        e.store_id,
        COUNT(o.order_id) AS orders_handled,
        COALESCE(SUM(o.total_amount), 0) AS revenue_generated
    FROM stores.employees e
    LEFT JOIN sales.orders o ON e.store_id = o.store_id
    GROUP BY e.emp_id, e.store_id
)
SELECT
    e.emp_id,
    e.emp_name,
    e.role,
    -- salary is HIDDEN - column security!
    d.dept_name,
    s.store_name,
    s.city,
    s.region,
    es.orders_handled,
    es.revenue_generated,
    DENSE_RANK() OVER (
        PARTITION BY s.region
        ORDER BY es.revenue_generated DESC
    ) AS regional_rank
FROM stores.employees e
INNER JOIN stores.stores s ON e.store_id = s.store_id
LEFT JOIN stores.departments d ON e.dept_id = d.dept_id
LEFT JOIN employee_sales es ON e.emp_id = es.emp_id;
-- North Region Manager query (row-level filtering at query time)
SELECT * FROM stores.vw_regional_employee_performance
WHERE region = 'North'
ORDER BY regional_rank;
 
7. Topic 4: Materialized Views
📖 Definition
Technical Definition:
A Materialized View is a database object that stores the physical result of a query on disk, unlike a regular view which re-executes the query each time. It provides faster query performance at the cost of storage space and potential data staleness. Materialized views must be manually refreshed using REFRESH MATERIALIZED VIEW to sync with base table changes.
Layman's Terms:
Think of a Regular View as cooking dinner fresh every time someone asks for food - always fresh but takes 30 minutes each time. A Materialized View is like meal prepping on Sunday - you cook once, store the food in containers, and serve instantly during the week! The food is slightly older (not real-time), but service is FAST. When the stored food gets stale, you "refresh" by cooking again!
🎭 The Story: Zerodha's Real-Time Dashboard Crisis
📈 Setting: Zerodha's Trading Analytics Team, Bangalore
It was 9:15 AM - market opening time. Zerodha's CEO dashboard was supposed to show real-time trading metrics: total trades, volume, top performing stocks, sector-wise breakdown.
The problem? The dashboard used a REGULAR VIEW that joined 8 tables with window functions and aggregations. Each page load took 45 SECONDS! 🐌
"I can't wait 45 seconds every time I check the dashboard!" the CEO fumed.
Database architect Kavitha had an idea: "Sir, you don't need real-time data updating every millisecond. If the dashboard refreshes every 5 minutes, would that work?"
"5 minutes? That's fine for high-level metrics!"

Kavitha converted the view to a MATERIALIZED VIEW. She set up a cron job to refresh it every 5 minutes.
⚡ Result: Dashboard load time dropped from 45 seconds to 0.3 seconds!
The magic? The materialized view pre-computed all those complex joins and aggregations ONCE. When anyone queries it, PostgreSQL just reads the stored results - no computation needed!
"It's like the difference between calculating 1+2+3+...+1000 every time vs. just remembering the answer is 500,500!"
The CEO smiled. "Now THAT'S the performance I expected. Ship it!" 🚀
🎯 Career Connection: Data engineers at Zerodha, Groww, and Paytm Money earn ₹15-25 LPA specifically for building high-performance data layers with materialized views!

⚙️ Syntax
-- CREATE MATERIALIZED VIEW
CREATE MATERIALIZED VIEW view_name AS
SELECT column1, column2, ...
FROM table_name
WHERE condition
WITH DATA;  -- Populate immediately (default)
-- Create without populating (faster creation, refresh later)
CREATE MATERIALIZED VIEW view_name AS ... WITH NO DATA;
-- REFRESH MATERIALIZED VIEW (blocking)
REFRESH MATERIALIZED VIEW view_name;
-- REFRESH CONCURRENTLY (non-blocking, requires unique index)
REFRESH MATERIALIZED VIEW CONCURRENTLY view_name;
-- CREATE INDEX on materialized view
CREATE UNIQUE INDEX idx_name ON view_name (column);
-- DROP MATERIALIZED VIEW
DROP MATERIALIZED VIEW IF EXISTS view_name;
📝 Example 1 (Medium): Sales Summary Materialized View
Scenario: Create a materialized view for the executive dashboard showing monthly sales summary. The dashboard is viewed 100+ times daily but data only needs to be current to the hour.
-- Create materialized view for monthly sales dashboard
CREATE MATERIALIZED VIEW sales.mv_monthly_sales_summary AS
SELECT
    DATE_TRUNC('month', o.order_date) AS sales_month,
    s.region,
    COUNT(DISTINCT o.order_id) AS total_orders,
    COUNT(DISTINCT o.cust_id) AS unique_customers,
    SUM(o.total_amount) AS total_revenue,
    ROUND(AVG(o.total_amount), 2) AS avg_order_value,
    NOW() AS last_refreshed  -- Track when data was updated
FROM sales.orders o
INNER JOIN stores.stores s ON o.store_id = s.store_id
WHERE o.order_status = 'Completed'
GROUP BY DATE_TRUNC('month', o.order_date), s.region
WITH DATA;
-- Create unique index for CONCURRENTLY refresh
CREATE UNIQUE INDEX idx_mv_monthly_sales
ON sales.mv_monthly_sales_summary (sales_month, region);
-- Dashboard query now runs in milliseconds!
SELECT * FROM sales.mv_monthly_sales_summary
WHERE sales_month >= '2024-01-01'
ORDER BY sales_month DESC, total_revenue DESC;
-- Refresh hourly (typically via cron job)
REFRESH MATERIALIZED VIEW CONCURRENTLY sales.mv_monthly_sales_summary;
📝 Example 2 (Hard): Product Analytics Materialized View with Rankings
Scenario: Create a comprehensive product performance materialized view with revenue rankings, customer ratings, return rates, and inventory status - used by multiple teams for different purposes.
-- Comprehensive product analytics materialized view
CREATE MATERIALIZED VIEW products.mv_product_analytics AS
WITH product_sales AS (
    SELECT
        oi.prod_id,
        SUM(oi.quantity) AS units_sold,
        SUM(oi.quantity * oi.unit_price) AS gross_revenue,
        SUM(oi.discount) AS total_discounts
    FROM sales.order_items oi
    GROUP BY oi.prod_id
),
product_returns AS (
    SELECT prod_id, COUNT(*) AS return_count,
           SUM(refund_amount) AS total_refunds
    FROM sales.returns
    GROUP BY prod_id
),
product_ratings AS (
    SELECT prod_id, ROUND(AVG(rating), 2) AS avg_rating,
           COUNT(*) AS review_count
    FROM customers.reviews
    GROUP BY prod_id
)
SELECT
    p.prod_id,
    p.prod_name,
    p.category,
    p.brand,
    p.price AS current_price,
    COALESCE(ps.units_sold, 0) AS units_sold,
    COALESCE(ps.gross_revenue, 0) AS gross_revenue,
    COALESCE(ps.gross_revenue, 0) - COALESCE(ps.total_discounts, 0)
        - COALESCE(pr.total_refunds, 0) AS net_revenue,
    COALESCE(pr.return_count, 0) AS return_count,
    CASE WHEN COALESCE(ps.units_sold, 0) > 0
         THEN ROUND(COALESCE(pr.return_count, 0)::numeric /
              ps.units_sold * 100, 2)
         ELSE 0 END AS return_rate_pct,
    COALESCE(prt.avg_rating, 0) AS avg_rating,
    COALESCE(prt.review_count, 0) AS review_count,
    DENSE_RANK() OVER (ORDER BY COALESCE(ps.gross_revenue, 0) DESC)
        AS revenue_rank,
    DENSE_RANK() OVER (
        PARTITION BY p.category
        ORDER BY COALESCE(ps.gross_revenue, 0) DESC
    ) AS category_rank,
    NOW() AS last_refreshed
FROM products.products p
LEFT JOIN product_sales ps ON p.prod_id = ps.prod_id
LEFT JOIN product_returns pr ON p.prod_id = pr.prod_id
LEFT JOIN product_ratings prt ON p.prod_id = prt.prod_id
WITH DATA;
-- Unique index for concurrent refresh
CREATE UNIQUE INDEX idx_mv_product_analytics
ON products.mv_product_analytics (prod_id);
 
8. Topic 5: REFRESH CONCURRENTLY & Indexed Materialized Views
📖 Definition
Technical Definition:
REFRESH CONCURRENTLY: Updates a materialized view without taking an exclusive lock, allowing SELECT queries to continue during refresh. Requires a UNIQUE INDEX on the materialized view. Indexed Materialized Views: Like regular tables, materialized views support indexes to speed up queries on specific columns.
Layman's Terms:
Imagine a restaurant's "Today's Specials" board. Regular REFRESH is like closing the restaurant, erasing the board, and rewriting it - customers must wait outside. REFRESH CONCURRENTLY is like having a duplicate board - you update the backup while customers read the original, then swap them instantly! Indexes are like organizing the menu by category (starters, mains, desserts) - you find dishes faster!
📊 REFRESH vs REFRESH CONCURRENTLY
REFRESH (Blocking)	REFRESH CONCURRENTLY
• Blocks all SELECT queries
• Faster for small views
• No index required
• Drops & recreates all data
• Use for: Low-traffic views	• Allows SELECT during refresh
• Slower (uses diff algorithm)
• REQUIRES unique index
• Only updates changed rows
• Use for: High-traffic dashboards
📝 Example 1 (Medium): Setting Up Concurrent Refresh
Scenario: Convert a blocking refresh to concurrent refresh for a high-traffic store leaderboard materialized view.
-- Step 1: Create the materialized view
CREATE MATERIALIZED VIEW stores.mv_store_leaderboard AS
SELECT
    s.store_id,
    s.store_name,
    s.city,
    s.region,
    COALESCE(SUM(o.total_amount), 0) AS total_revenue,
    COUNT(DISTINCT o.order_id) AS total_orders,
    DENSE_RANK() OVER (ORDER BY COALESCE(SUM(o.total_amount), 0) DESC)
        AS overall_rank
FROM stores.stores s
LEFT JOIN sales.orders o ON s.store_id = o.store_id
GROUP BY s.store_id, s.store_name, s.city, s.region
WITH DATA;
-- Step 2: Create UNIQUE index (REQUIRED for CONCURRENTLY)
CREATE UNIQUE INDEX idx_mv_store_leaderboard_pk
ON stores.mv_store_leaderboard (store_id);
-- Step 3: Create additional indexes for query performance
CREATE INDEX idx_mv_store_leaderboard_region
ON stores.mv_store_leaderboard (region);
-- Step 4: Non-blocking refresh (users can query during refresh)
REFRESH MATERIALIZED VIEW CONCURRENTLY stores.mv_store_leaderboard;
📝 Example 2 (Hard): Automated Refresh Strategy
Scenario: Create a materialized view with multiple indexes for a customer analytics dashboard. Demonstrate how to check refresh status and set up monitoring.
-- Customer analytics with multiple indexes for different queries
CREATE MATERIALIZED VIEW customers.mv_customer_360 AS
WITH customer_orders AS (
    SELECT
        cust_id,
        COUNT(*) AS order_count,
        SUM(total_amount) AS lifetime_value,
        MIN(order_date) AS first_order,
        MAX(order_date) AS last_order
    FROM sales.orders WHERE order_status = 'Completed'
    GROUP BY cust_id
)
SELECT
    c.cust_id, c.full_name, c.city, c.state, c.region_name,
    COALESCE(co.order_count, 0) AS total_orders,
    COALESCE(co.lifetime_value, 0) AS lifetime_value,
    co.first_order, co.last_order,
    CASE WHEN co.lifetime_value >= 50000 THEN 'VIP'
         WHEN co.lifetime_value >= 20000 THEN 'Gold'
         WHEN co.lifetime_value >= 5000 THEN 'Silver'
         ELSE 'Bronze' END AS tier,
    COALESCE(lp.total_points, 0) AS loyalty_points,
    NOW() AS snapshot_time
FROM customers.customers c
LEFT JOIN customer_orders co ON c.cust_id = co.cust_id
LEFT JOIN customers.loyalty_points lp ON c.cust_id = lp.cust_id
WITH DATA;
-- Multiple indexes for different query patterns
CREATE UNIQUE INDEX idx_cust360_pk ON customers.mv_customer_360 (cust_id);
CREATE INDEX idx_cust360_tier ON customers.mv_customer_360 (tier);
CREATE INDEX idx_cust360_region ON customers.mv_customer_360 (region_name);
CREATE INDEX idx_cust360_ltv ON customers.mv_customer_360 (lifetime_value DESC);
-- Check materialized view size and last refresh
SELECT
    schemaname, matviewname,
    pg_size_pretty(pg_relation_size(schemaname||'.'||matviewname)) AS size
FROM pg_matviews
WHERE matviewname LIKE 'mv_%';
 
9. Views vs Materialized Views: Decision Guide
Aspect	Regular View	Materialized View
Data Storage	No (virtual)	Yes (physical)
Data Freshness	Real-time	Stale (until refresh)
Query Speed	Slow (recomputes)	Fast (pre-computed)
Disk Space	None	Requires storage
Indexable	No	Yes
Best For	Security, abstraction, simple queries	Dashboards, reports, analytics
10. Key Takeaways
•	Views are virtual tables that simplify complex queries and provide security through column/row filtering.
•	Updatable Views must reference a single table with no aggregates, JOINs, or DISTINCT.
•	Materialized Views store query results physically for faster access - ideal for dashboards and reports.
•	REFRESH CONCURRENTLY allows non-blocking updates but requires a UNIQUE INDEX.
•	Use Regular Views for real-time data needs; use Materialized Views for performance-critical analytics.




table   =>  physical value available    =>  DML
view    =>  virtual table   =>  no ata available in the disk    =>  read only(no DML)   => when called it willexecute that logic every single time
mv_view =>  virtual + physical value    => read only(no DML)    => control the time when execution will happend =>that data can be old 
        => refresh it will delete all the value available in the mvview then insert new values 


View can take time as per the logic     =>  may be 40s
same logic we can pre run and store the result and  that result can be fetch

view    =>  mv_view 
        =>  increase the efficiency
        