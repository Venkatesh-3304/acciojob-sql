
Hi Good Morning

Hi


You Tube
    Live
        Buffering


Wedding Party
    Shagun  =>  1000000
    Set the money to your cousin

    Step 1  =>  First deducted from your account
    Step 2  =>  Second it wil deposited to your cousin account

Begin;

Inserted 1
Inserted 2
Inserted 3
inserted 4
inserted 5

Commit;

  🔹 TOPIC 1: ATOMICITY - All or Nothing

📖 Definition
Technical Definition: Atomicity guarantees a transaction is treated as a single, indivisible unit of work. Either ALL operations within the transaction complete successfully (COMMIT), or NONE take effect (ROLLBACK). There is no partial execution.

Layman's Terms: Think of atomicity like sending a WhatsApp message - either your entire message is delivered (blue ticks ✓✓), or it's not sent at all. You never see half a message! Similarly, in databases, either your entire transaction works, or nothing happens.
📖 The Story: The Wedding Shagun Disaster 💒
Picture this: It's your cousin's grand wedding in Jaipur. Your family decides to give ₹1,00,000 as shagun through a digital transfer. The transfer involves TWO operations: (1) Deduct from YOUR account, (2) Add to COUSIN''s account.
😱 WITHOUT ATOMICITY: What if Step 1 completes but Step 2 fails due to server crash? Your ₹1,00,000 vanishes! Your account is debited, cousin never received money!
✅ WITH ATOMICITY: If ANY step fails, the ENTIRE transaction rolls back. Your money stays safe. Either the full shagun reaches cousin, or nothing happens!
💼 Real-World: This is exactly how Google Pay, PhonePe, and Paytm work! Banks like HDFC, ICICI process millions of atomic transactions daily!

💻 Syntax
-- Atomicity is automatically enforced within transactions
BEGIN;
    UPDATE accounts SET balance = balance - 100000 WHERE account_id = 'sender';
    UPDATE accounts SET balance = balance + 100000 WHERE account_id = 'receiver';
COMMIT;  -- Either BOTH succeed, or NEITHER happens

-- If error occurs:
ROLLBACK;  -- Undoes everything

📝 Example 1 (Medium): Order Processing with Atomicity
Scenario: A customer places an order. We need to: 
(1) Create order, 
(2) Deduct inventory, 
(3) Record payment. 
All must succeed together.

-- Atomic order processing
BEGIN;
    -- Step 1: Create order
    INSERT INTO sales.orders (order_id, cust_id, store_id, order_date, order_status, total_amount)
    VALUES (99999, 1001, 5, CURRENT_DATE, 'pending', 15000.00);
    
    -- Step 2: Reduce inventory
    UPDATE products.inventory 
    SET stock_qty = stock_qty - 2, last_updated = CURRENT_DATE
    WHERE prod_id = 101 AND store_id = 5;
    
    -- Step 3: Record payment
    INSERT INTO sales.payments (payment_id, order_id, payment_date, payment_mode, amount)
    VALUES (299999, 99999, CURRENT_DATE, 'UPI', 15000.00);
COMMIT;


-- Either ALL 4 operations complete, or NONE do!
📝 Example 2 (Hard): Multi-Store Inventory Transfer
Scenario: Transfer 50 units from Mumbai store to Delhi store with stock validation and audit logging.
-- Complex atomic inventory transfer
BEGIN;
    -- Step 1: Verify source has sufficient stock
    DO $$
    DECLARE v_available INT;
    BEGIN
        SELECT stock_qty INTO v_available FROM products.inventory
        WHERE prod_id = 101 AND store_id = 1;
        IF v_available < 50 THEN
            RAISE EXCEPTION 'Insufficient stock: only % available', v_available;
        END IF;
    END $$;

    -- Step 2: Deduct from Mumbai (store_id = 1)
    UPDATE products.inventory SET stock_qty = stock_qty - 50, last_updated = CURRENT_DATE
    WHERE prod_id = 101 AND store_id = 1;
    
    -- Step 3: Add to Delhi (store_id = 2)
    UPDATE products.inventory SET stock_qty = stock_qty + 50, last_updated = CURRENT_DATE
    WHERE prod_id = 101 AND store_id = 2;
    
    -- Step 4: Log transfer expense
    INSERT INTO stores.expenses (expense_id, store_id, expense_date, expense_type, amount)
    VALUES ((SELECT COALESCE(MAX(expense_id),0)+1 FROM stores.expenses), 1, CURRENT_DATE, 'Transfer', 500);
COMMIT;
-- If ANY step fails, entire transfer is rolled back!


Rating should be between 1 and 5
every customer can rate a restaurent once

There was one Bug
    Rating 10 star
    rating as -1000 star
    One customer who gave rating 100000


who is ensuring that these rules, contraisnts are checked whenever we are interting the data
    Constraints

  🔹 TOPIC 2: CONSISTENCY - Valid State Transitions
📖 Definition
Technical Definition: Consistency ensures a transaction brings the database from one valid state to another. All data integrity constraints (CHECK, FOREIGN KEY, UNIQUE, NOT NULL) must be satisfied before and after every transaction.
Layman's Terms: Think of consistency like cricket rules - you can't score 7 runs off a single ball because rules don't allow it! Similarly, if your 'rating' column has CHECK(rating BETWEEN 1 AND 5), you can never insert rating = 6.
📖 The Story: The Zomato Rating Chaos 🍕
Imagine you're at Zomato managing millions of restaurant ratings. Rules: Ratings must be 1-5 stars (CHECK), each user rates once per restaurant (UNIQUE), rating must reference existing restaurant (FOREIGN KEY).
😱 WITHOUT CONSISTENCY: A bug allows 10-star ratings! Or same user rates 100 times to manipulate rankings! The rating system becomes meaningless!
✅ WITH CONSISTENCY: Database automatically rejects invalid data! 10-star rating? REJECTED. Duplicate rating? REJECTED. Data stays clean!
💻 How Consistency Works
-- Consistency is enforced through constraints (Day 4!)
CREATE TABLE customers.reviews (
    review_id INT PRIMARY KEY,
    cust_id INT REFERENCES customers.customers(cust_id),  -- FK
    rating INT CHECK (rating BETWEEN 1 AND 5),  -- Must be valid
    review_date DATE NOT NULL  -- Cannot be empty
);

-- Trying to violate:
INSERT INTO customers.reviews VALUES (1, 999999, 6, CURRENT_DATE);
-- ERROR: Check constraint violated (rating 6 > 5)
-- ERROR: Foreign key violation (cust_id 999999 doesn't exist)
📝 Example 1 (Medium): Maintaining Financial Consistency
Scenario: Process a refund ensuring refund amount doesn't exceed original order amount.
-- Consistent refund processing
BEGIN;
    DO $$
    DECLARE v_original NUMERIC; v_refund NUMERIC := 500.00;
    BEGIN
        SELECT total_amount INTO v_original FROM sales.orders WHERE order_id = 1001;
        IF v_refund > v_original THEN
            RAISE EXCEPTION 'Refund % exceeds order amount %', v_refund, v_original;
        END IF;
    END $$;

    INSERT INTO sales.returns (return_id, order_id, prod_id, return_date, reason, refund_amount)
    VALUES ((SELECT COALESCE(MAX(return_id),0)+1 FROM sales.returns),
            1001, 101, CURRENT_DATE, 'Customer request', 500.00);
    
    UPDATE sales.orders SET order_status = 'partially_refunded' WHERE order_id = 1001;
COMMIT;
📝 Example 2 (Hard): Employee Salary Consistency
Scenario: Update salary ensuring it doesn't decrease and doesn't exceed 3x department average.
-- Consistent salary update with validation
BEGIN;
    DO $$
    DECLARE v_current NUMERIC; v_new NUMERIC := 85000; v_dept_avg NUMERIC;
    BEGIN
        SELECT salary INTO v_current FROM stores.employees WHERE emp_id = 1;
        IF v_new < v_current THEN
            RAISE EXCEPTION 'Salary decrease not allowed: % -> %', v_current, v_new;
        END IF;
        
        SELECT AVG(salary) INTO v_dept_avg FROM stores.employees e
        WHERE e.dept_id = (SELECT dept_id FROM stores.employees WHERE emp_id = 1);
        
        IF v_new > (v_dept_avg * 3) THEN
            RAISE EXCEPTION 'Salary % exceeds 3x dept avg %', v_new, v_dept_avg * 3;
        END IF;
    END $$;

    INSERT INTO hr.salary_history (emp_id, effective_date, salary) VALUES (1, CURRENT_DATE, 85000);
    UPDATE stores.employees SET salary = 85000 WHERE emp_id = 1;
COMMIT;
 


🔹 TOPIC 3: ISOLATION - Concurrent Transaction Control
📖 Definition
Technical Definition: Isolation ensures concurrent transactions execute as if running sequentially. Each transaction is isolated from others, preventing interference. PostgreSQL supports: READ COMMITTED (default), REPEATABLE READ, and SERIALIZABLE.
Layman's Terms: Think of isolation like exam halls - each student writes their own exam without seeing others' answer sheets! Even though 1000 students write simultaneously, each exam is 'isolated'.
📖 The Story: The IPL Ticket Booking War 🏏
It's IPL finals ticket booking! 1 lakh fans trying to book 50,000 tickets simultaneously on BookMyShow at 10:00 AM...
😱 WITHOUT ISOLATION: Rahul sees seat A-15 available. Priya ALSO sees A-15 available. Both complete payment for SAME seat! Match day: Two people for one seat!
✅ WITH ISOLATION: Once Rahul starts booking A-15, it's 'locked'. Priya's transaction waits or sees seat as 'processing'. No double-booking!
💻 Isolation Levels Syntax
-- Level 1: READ COMMITTED (Default)
BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;
-- Sees only committed data, may see different data on re-read

-- Level 2: REPEATABLE READ
BEGIN TRANSACTION ISOLATION LEVEL REPEATABLE READ;
-- Same query returns same results throughout transaction

-- Level 3: SERIALIZABLE (Strictest)
BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;
-- Transactions behave as if executed one-by-one

SHOW transaction_isolation;  -- Check current level
📝 Example 1 (Medium): Report with REPEATABLE READ
Scenario: Generate sales report where all metrics must come from the same data snapshot.
-- Consistent report with REPEATABLE READ
BEGIN TRANSACTION ISOLATION LEVEL REPEATABLE READ;
    -- All queries see SAME data snapshot
    SELECT SUM(total_amount) as total_revenue, COUNT(*) as total_orders
    FROM sales.orders WHERE order_date BETWEEN '2024-01-01' AND '2024-12-31';
    
    SELECT st.store_name, SUM(o.total_amount) as store_revenue,
           RANK() OVER (ORDER BY SUM(o.total_amount) DESC) as revenue_rank
    FROM sales.orders o JOIN stores.stores st ON o.store_id = st.store_id
    WHERE o.order_date BETWEEN '2024-01-01' AND '2024-12-31'
    GROUP BY st.store_id, st.store_name;
COMMIT;
-- All metrics consistent with each other!
📝 Example 2 (Hard): Flash Sale with SERIALIZABLE
Scenario: Limited-stock flash sale with only 10 items. Must prevent overselling with thousands of concurrent buyers.
-- Flash sale - MUST prevent overselling
BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;
    DO $$
    DECLARE v_available INT; v_order_qty INT := 2;
    BEGIN
        SELECT stock_qty INTO v_available FROM products.inventory
        WHERE prod_id = 999 AND store_id = 1 FOR UPDATE;
        
        IF v_available < v_order_qty THEN
            RAISE EXCEPTION 'Only % items left!', v_available;
        END IF;
        
        UPDATE products.inventory SET stock_qty = stock_qty - v_order_qty
        WHERE prod_id = 999 AND store_id = 1;
    END $$;

    INSERT INTO sales.orders (order_id, cust_id, store_id, order_date, order_status, total_amount)
    VALUES ((SELECT COALESCE(MAX(order_id),0)+1 FROM sales.orders), 1001, 1, CURRENT_DATE, 'pending', 999);
COMMIT;
-- SERIALIZABLE ensures no two customers can buy the "last item"!


  🔹 TOPIC 4: DURABILITY - Permanent Changes
📖 Definition
Technical Definition: Durability guarantees that once a transaction is committed, it remains committed even after power failure, crash, or any error. PostgreSQL uses Write-Ahead Logging (WAL) to ensure durability.
Layman's Terms: Think of durability like carving your name on a temple wall - once carved, it survives for centuries! Even if there's an earthquake, your carving remains. Once PostgreSQL says 'COMMIT successful', your data is permanent!
📖 The Story: The IRCTC Tatkal Nightmare 🚂
It's Tatkal booking - 10:00 AM! After 30 minutes, your payment goes through! ₹3,500 deducted! 'Booking Successful' appears for 0.5 seconds... then website CRASHES!
😱 WITHOUT DURABILITY: Server crashed before saving! Money gone, ticket not booked, 'No booking found'. ₹3,500 lost, sister's wedding missed!
✅ WITH DURABILITY: Even though website crashed, COMMIT was logged! When servers restart, booking recovers. 'Booking Confirmed'! Durability saved the day!
💻 How PostgreSQL Ensures Durability
-- PostgreSQL durability is automatic!
-- Write-Ahead Logging (WAL) ensures data survives crashes

BEGIN;
    INSERT INTO sales.orders (order_id, cust_id, store_id, order_date, order_status, total_amount)
    VALUES (88888, 1001, 1, CURRENT_DATE, 'completed', 50000.00);
COMMIT;
-- After COMMIT returns, this order is GUARANTEED to survive any crash!

SHOW synchronous_commit;  -- Default: on (safest)
📝 Example 1 (Medium): Critical Payment Recording
-- Critical payment with durability guarantee
BEGIN;
    INSERT INTO sales.payments (payment_id, order_id, payment_date, payment_mode, amount)
    VALUES ((SELECT COALESCE(MAX(payment_id),0)+1 FROM sales.payments),
            1001, CURRENT_DATE, 'Bank Transfer', 250000.00);
    
    UPDATE sales.orders SET order_status = 'paid' WHERE order_id = 1001;
COMMIT;
-- Once COMMIT succeeds, payment is DURABLE - survives any crash!

SELECT p.payment_id, p.amount, o.order_status
FROM sales.payments p JOIN sales.orders o ON p.order_id = o.order_id
WHERE p.order_id = 1001;
📝 Example 2 (Hard): End-of-Day Financial Closure
-- End-of-day financial closure (durability critical)
BEGIN;
    WITH daily_sales AS (
        SELECT store_id, SUM(total_amount) as total_revenue
        FROM sales.orders WHERE order_date = CURRENT_DATE
        AND order_status IN ('completed', 'delivered') GROUP BY store_id
    ),
    daily_expenses AS (
        SELECT store_id, SUM(amount) as total_expenses
        FROM stores.expenses WHERE expense_date = CURRENT_DATE GROUP BY store_id
    )
    INSERT INTO finance.revenue_summary (summary_date, store_id, total_sales, total_expenses, net_profit)
    SELECT CURRENT_DATE, ds.store_id, ds.total_revenue, COALESCE(de.total_expenses, 0),
           ds.total_revenue - COALESCE(de.total_expenses, 0)
    FROM daily_sales ds LEFT JOIN daily_expenses de ON ds.store_id = de.store_id;
COMMIT;
-- Financial record is PERMANENTLY stored - survives any failure!
 
  🔹 TOPIC 5: CONCURRENCY ISSUES
📖 Definition
Technical Definition: Concurrency issues arise when multiple transactions access same data simultaneously. Key issues: Dirty Reads (reading uncommitted data), Phantom Reads (new rows appear), Deadlocks (transactions waiting for each other).
Layman's Terms: Think of concurrency issues like traffic problems. Dirty Read = Following a car that suddenly reverses. Phantom Read = A car appears from nowhere. Deadlock = Two cars facing each other, neither willing to reverse!
📖 The Story: The Food Court Chaos 🍔
Issue	Food Court Analogy
Dirty Read	Kitchen says 'burger ready!' but chef cancels. You already told customer!
Phantom Read	You count 10 pending orders. While serving, 5 new orders appear!
Deadlock	You need fryer, colleague has it but needs your grill. Both wait forever!
💻 Prevention Methods
-- 1. DIRTY READ - PostgreSQL prevents by default (minimum: READ COMMITTED)

-- 2. NON-REPEATABLE READ - Use REPEATABLE READ
BEGIN TRANSACTION ISOLATION LEVEL REPEATABLE READ;
    SELECT stock_qty FROM products.inventory WHERE prod_id = 101;  -- 100
    -- Even if another commits changes...
    SELECT stock_qty FROM products.inventory WHERE prod_id = 101;  -- Still 100!
COMMIT;

-- 3. PHANTOM READ - Use SERIALIZABLE
BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;
    SELECT COUNT(*) FROM sales.orders WHERE order_date = CURRENT_DATE;  -- 50
    -- Even if another inserts new orders...
    SELECT COUNT(*) FROM sales.orders WHERE order_date = CURRENT_DATE;  -- Still 50!
COMMIT;

-- 4. DEADLOCK - PostgreSQL auto-detects and resolves
-- Best practice: Always access tables in same order!
📝 Example 1 (Medium): Deadlock Understanding
-- Understanding Deadlock (PostgreSQL handles automatically)
-- Session 1:
BEGIN;
    UPDATE products.products SET price = price * 1.1 WHERE prod_id = 101;
    -- Has lock on product 101
    -- Tries to update employee 1 (which Session 2 holds)
    UPDATE stores.employees SET salary = salary * 1.05 WHERE emp_id = 1;
    -- WAITS...

-- Session 2 (simultaneously):
BEGIN;
    UPDATE stores.employees SET salary = salary * 1.05 WHERE emp_id = 1;
    -- Has lock on employee 1
    -- Tries to update product 101 (which Session 1 holds)
    UPDATE products.products SET price = price * 1.1 WHERE prod_id = 101;
    -- DEADLOCK!

-- PostgreSQL detects and cancels one transaction automatically
-- ERROR: deadlock detected
-- SOLUTION: Always update tables in same order in all transactions!
📝 Example 2 (Hard): Preventing Phantom Reads in Compliance Report
-- Compliance report with phantom read prevention
BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;
    WITH order_summary AS (
        SELECT COUNT(*) as order_count, SUM(total_amount) as total_revenue
        FROM sales.orders WHERE order_date = CURRENT_DATE AND order_status = 'completed'
    ),
    order_details AS (
        SELECT order_id, total_amount FROM sales.orders
        WHERE order_date = CURRENT_DATE AND order_status = 'completed'
    )
    SELECT os.order_count as reported_count, os.total_revenue,
           COUNT(od.order_id) as verified_count, SUM(od.total_amount) as verified_total,
           CASE WHEN os.order_count = COUNT(od.order_id) THEN 'PASS' ELSE 'FAIL' END as status
    FROM order_summary os CROSS JOIN order_details od
    GROUP BY os.order_count, os.total_revenue;
COMMIT;
-- SERIALIZABLE ensures count ALWAYS matches - no phantom rows!
