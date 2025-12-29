🔐 TOPIC 1: Transaction Fundamentals

📚 Definition

Technical Definition: A transaction is a logical unit of work consisting of one or more SQL statements executed as a single, indivisible operation. Transactions follow ACID properties (Atomicity, Consistency, Isolation, Durability). 

Either ALL operations succeed and are committed, or NONE are applied (rolled back).


Layman's Terms: Imagine transferring ₹10,000 from your SBI account to your friend's HDFC account. This involves TWO steps: (1) Deduct ₹10,000 from YOUR account, (2) Add ₹10,000 to FRIEND's account. What if the system crashes after step 1 but before step 2? Your money is GONE! 😱 A transaction ensures BOTH steps happen together OR neither happens. It's a safety bubble - everything inside either succeeds completely or fails completely!
📖 The PhonePe Diwali Story
🪔 The Diwali Gift Gone Wrong! 🪔
It's Diwali night. Rohan wants to send ₹5,000 to his sister Priya through PhonePe.
Behind the scenes, PhonePe needs to:
Step 1: Deduct ₹5,000 from Rohan's wallet
Step 2: Add ₹5,000 to Priya's wallet
Step 3: Record the transaction in history
💥 DISASTER! Server crashes after Step 1 but BEFORE Step 2!
WITHOUT Transactions: Rohan loses ₹5,000. Priya gets nothing. Money vanishes! 😭
WITH Transactions: System sees incomplete operation. ROLLS BACK everything. Rohan's money restored! 🎉
💡 This is why every UPI app, bank, and e-commerce site uses TRANSACTIONS!


⌨️ Syntax
-- Starting a Transaction
BEGIN;
-- OR: START TRANSACTION;

-- Your SQL operations go here
UPDATE accounts SET balance = balance - 5000 WHERE account_id = 101;
UPDATE accounts SET balance = balance + 5000 WHERE account_id = 202;

-- If successful, make it permanent
COMMIT;

-- If something goes wrong, undo everything
ROLLBACK;


Commit      =>  Ctrl S
ROLLBACK    =>  Ctrl Z
Savepoint   =>  Ctrl Z Ctrl Z Ctrl Z


Adventure
    Chapter 1   =>  BEGIN
    Chapter 15  =>  Commit
    Chapter 10  =>  Savepoint
    Chapter 16  =>  Retry


SAVEPOINT - Creating Checkpoints
📚 Definition
Technical Definition: A SAVEPOINT is a marker within a transaction that allows rolling back to that specific point without undoing the entire transaction. It creates a checkpoint preserving all work done up to that point.
Layman's Terms: Think of SAVEPOINTs like saving progress in a video game! 🎮 When playing Temple Run and you pass a checkpoint, if you fall into a pit, you don't start from the beginning - you restart from your last checkpoint! SAVEPOINT lets you create 'save points' in database work. If something goes wrong, go back to save point instead of losing ALL work!

📖 The Zomato Kitchen Story
🍕 The Perfect Pizza Order Gone Wrong! 🍕

Rahul orders Pizza Party for his birthday from Zomato. Kitchen starts preparing:

Step 1: Pizzas in oven ✓ → SAVEPOINT after_pizzas
Step 2: Garlic bread ready ✓ → SAVEPOINT after_bread
Step 3: Cokes poured ✓ → SAVEPOINT after_drinks
Step 4: Lava Cake... OOPS! Chef dropped it! 💥
WITHOUT Savepoints: ROLLBACK = Throw away everything, start from scratch! 😭
WITH Savepoints: ROLLBACK TO after_drinks = Keep pizzas, bread, cokes. Only remake cake! 🎉
💡 SAVEPOINTs save time, resources, and prevent complete do-overs!
⌨️ Syntax
-- Create a savepoint
SAVEPOINT savepoint_name;

-- Rollback to a specific savepoint
ROLLBACK TO SAVEPOINT savepoint_name;
-- Or: ROLLBACK TO savepoint_name;

-- Release a savepoint (cleanup)
RELEASE SAVEPOINT savepoint_name;




🔐 TOPIC 1: Transaction Fundamentals
📚 Definition
Technical Definition: A transaction is a logical unit of work consisting of one or more SQL statements executed as a single, indivisible operation. Transactions follow ACID properties (Atomicity, Consistency, Isolation, Durability). Either ALL operations succeed and are committed, or NONE are applied (rolled back).
Layman's Terms: Imagine transferring ₹10,000 from your SBI account to your friend's HDFC account. This involves TWO steps: (1) Deduct ₹10,000 from YOUR account, (2) Add ₹10,000 to FRIEND's account. What if the system crashes after step 1 but before step 2? Your money is GONE! 😱 A transaction ensures BOTH steps happen together OR neither happens. It's a safety bubble - everything inside either succeeds completely or fails completely!
📖 The PhonePe Diwali Story
🪔 The Diwali Gift Gone Wrong! 🪔
It's Diwali night. Rohan wants to send ₹5,000 to his sister Priya through PhonePe.
Behind the scenes, PhonePe needs to:
Step 1: Deduct ₹5,000 from Rohan's wallet
Step 2: Add ₹5,000 to Priya's wallet
Step 3: Record the transaction in history
💥 DISASTER! Server crashes after Step 1 but BEFORE Step 2!
WITHOUT Transactions: Rohan loses ₹5,000. Priya gets nothing. Money vanishes! 😭
WITH Transactions: System sees incomplete operation. ROLLS BACK everything. Rohan's money restored! 🎉
💡 This is why every UPI app, bank, and e-commerce site uses TRANSACTIONS!
⌨️ Syntax
-- Starting a Transaction
BEGIN;
-- OR: START TRANSACTION;

-- Your SQL operations go here
UPDATE accounts SET balance = balance - 5000 WHERE account_id = 101;
UPDATE accounts SET balance = balance + 5000 WHERE account_id = 202;

-- If successful, make it permanent
COMMIT;

-- If something goes wrong, undo everything
ROLLBACK;
 
💡 Example 1 (Medium): Processing a RetailMart Order
Scenario: A customer places an order. We need to: (1) Create order record, (2) Deduct inventory, (3) Update loyalty points. All three must succeed together!
Concepts Used: BEGIN, INSERT, UPDATE, COMMIT, ROLLBACK (Day 15), JOINs (Day 8-9), Aggregates (Day 6)
BEGIN;

-- Step 1: Create the order
INSERT INTO sales.orders (order_id, cust_id, store_id, order_date, order_status, total_amount)
VALUES (99999, 1001, 5, CURRENT_DATE, 'Confirmed', 4999.00);

-- Step 2: Deduct inventory (prod_id = 101, quantity = 2)
UPDATE products.inventory
SET stock_qty = stock_qty - 2, last_updated = CURRENT_DATE
WHERE store_id = 5 AND prod_id = 101;

-- Step 3: Add loyalty points (1 point per ₹100)
UPDATE customers.loyalty_points
SET total_points = total_points + 50, last_updated = CURRENT_DATE
WHERE cust_id = 1001;

-- All successful? Make it permanent!
COMMIT;

-- If ANY step fails, use ROLLBACK instead
🎯 Real-World: This is exactly how Amazon, Flipkart, Myntra process orders. If inventory update fails, the order shouldn't be created!
 
💡 Example 2 (Hard): Multi-Store Inventory Transfer
Scenario: Transfer 50 units from Store 1 (Delhi) to Store 3 (Mumbai). Validate stock, update both inventories, record expense - all atomically!
Concepts Used: BEGIN, COMMIT, ROLLBACK (Day 15), Subqueries (Day 11), JOINs (Day 8), UPDATE
BEGIN;

-- Check source store has enough stock
SELECT stock_qty FROM products.inventory WHERE store_id = 1 AND prod_id = 201;

-- Step 1: Deduct from source (Delhi)
UPDATE products.inventory
SET stock_qty = stock_qty - 50, last_updated = CURRENT_DATE
WHERE store_id = 1 AND prod_id = 201 AND stock_qty >= 50;

-- Step 2: Add to destination (Mumbai)
UPDATE products.inventory
SET stock_qty = stock_qty + 50, last_updated = CURRENT_DATE
WHERE store_id = 3 AND prod_id = 201;

-- Step 3: Record logistics expense
INSERT INTO stores.expenses (expense_id, store_id, expense_date, expense_type, amount)
VALUES (
    (SELECT COALESCE(MAX(expense_id), 0) + 1 FROM stores.expenses),
    1, CURRENT_DATE, 'Inter-Store Transfer', 2500.00
);

COMMIT;
🎯 Real-World: This is how Reliance Retail, DMart, BigBasket manage inventory across warehouses!
 
📍 TOPIC 2: SAVEPOINT - Creating Checkpoints
📚 Definition
Technical Definition: A SAVEPOINT is a marker within a transaction that allows rolling back to that specific point without undoing the entire transaction. It creates a checkpoint preserving all work done up to that point.
Layman's Terms: Think of SAVEPOINTs like saving progress in a video game! 🎮 When playing Temple Run and you pass a checkpoint, if you fall into a pit, you don't start from the beginning - you restart from your last checkpoint! SAVEPOINT lets you create 'save points' in database work. If something goes wrong, go back to save point instead of losing ALL work!
📖 The Zomato Kitchen Story
🍕 The Perfect Pizza Order Gone Wrong! 🍕
Rahul orders Pizza Party for his birthday from Zomato. Kitchen starts preparing:
Step 1: Pizzas in oven ✓ → SAVEPOINT after_pizzas
Step 2: Garlic bread ready ✓ → SAVEPOINT after_bread
Step 3: Cokes poured ✓ → SAVEPOINT after_drinks
Step 4: Lava Cake... OOPS! Chef dropped it! 💥
WITHOUT Savepoints: ROLLBACK = Throw away everything, start from scratch! 😭
WITH Savepoints: ROLLBACK TO after_drinks = Keep pizzas, bread, cokes. Only remake cake! 🎉
💡 SAVEPOINTs save time, resources, and prevent complete do-overs!
⌨️ Syntax
-- Create a savepoint
SAVEPOINT savepoint_name;

-- Rollback to a specific savepoint
ROLLBACK TO SAVEPOINT savepoint_name;
-- Or: ROLLBACK TO savepoint_name;

-- Release a savepoint (cleanup)
RELEASE SAVEPOINT savepoint_name;
 
💡 Example 1 (Medium): Order with Payment Retry
Scenario: Customer places order. First payment fails. Use SAVEPOINT to retry just the payment!
BEGIN;

-- Step 1: Create order
INSERT INTO sales.orders (order_id, cust_id, store_id, order_date, order_status, total_amount)
VALUES (88888, 1002, 2, CURRENT_DATE, 'Pending', 2999.00);

-- Step 2: Add order items
INSERT INTO sales.order_items (order_item_id, order_id, prod_id, quantity, unit_price, discount)
VALUES (777777, 88888, 105, 1, 2999.00, 0.00);

-- 🎯 SAVEPOINT: Order created, items added
SAVEPOINT order_created;

-- Step 3: First payment (Credit Card - FAILS!)
INSERT INTO sales.payments (payment_id, order_id, payment_date, payment_mode, amount)
VALUES (666666, 88888, CURRENT_DATE, 'Credit Card', 2999.00);

-- Payment failed! Go back to savepoint
ROLLBACK TO order_created;

-- Step 4: Second payment (UPI - SUCCESS!)
INSERT INTO sales.payments (payment_id, order_id, payment_date, payment_mode, amount)
VALUES (666667, 88888, CURRENT_DATE, 'UPI', 2999.00);

UPDATE sales.orders SET order_status = 'Confirmed' WHERE order_id = 88888;

COMMIT;
🎯 Real-World: This is how PhonePe, Google Pay, Paytm handle payment failures - try another method from same checkpoint!
 
💡 Example 2 (Hard): Bulk Salary Processing
Scenario: Process salaries by department. If Marketing fails, redo just Marketing without affecting Sales and HR!
BEGIN;

-- PHASE 1: Sales Department
INSERT INTO hr.salary_history (emp_id, effective_date, salary)
SELECT e.emp_id, CURRENT_DATE, e.salary
FROM stores.employees e
JOIN stores.departments d ON e.dept_id = d.dept_id
WHERE d.dept_name = 'Sales';
SAVEPOINT sales_done;

-- PHASE 2: HR Department
INSERT INTO hr.salary_history (emp_id, effective_date, salary)
SELECT e.emp_id, CURRENT_DATE, e.salary
FROM stores.employees e
JOIN stores.departments d ON e.dept_id = d.dept_id
WHERE d.dept_name = 'HR';
SAVEPOINT hr_done;

-- PHASE 3: Marketing (fails!)
INSERT INTO hr.salary_history (emp_id, effective_date, salary)
SELECT e.emp_id, CURRENT_DATE, e.salary
FROM stores.employees e
JOIN stores.departments d ON e.dept_id = d.dept_id
WHERE d.dept_name = 'Marketing';

-- Something wrong! Rollback to HR checkpoint (keeps Sales & HR)
ROLLBACK TO hr_done;

-- Retry Marketing with corrected data
INSERT INTO hr.salary_history (emp_id, effective_date, salary)
SELECT e.emp_id, CURRENT_DATE,
       CASE WHEN e.role = 'Manager' THEN e.salary * 1.10 ELSE e.salary END
FROM stores.employees e
JOIN stores.departments d ON e.dept_id = d.dept_id
WHERE d.dept_name = 'Marketing';

RELEASE SAVEPOINT sales_done;
RELEASE SAVEPOINT hr_done;
COMMIT;
 
⏪ TOPIC 3: ROLLBACK TO SAVEPOINT - Partial Undo
📚 Definition
Technical Definition: ROLLBACK TO SAVEPOINT undoes all database changes made after the specified savepoint while preserving changes made before it. The savepoint itself remains valid and can be rolled back to again.
Layman's Terms: Remember 'Choose Your Own Adventure' books? 📚 You read along, make choices, and sometimes think 'Bad choice - hero died!' With ROLLBACK TO SAVEPOINT, you flip back to the last good page and make a DIFFERENT choice, without starting the entire book over!
📖 The Flipkart Flash Sale Story
📱 The Big Billion Day Chaos! 📱
It's Flipkart's Big Billion Day. Amit is buying:
• iPhone 15 Pro - ₹1,29,900 ✓ → SAVEPOINT iphone_added
• AirPods Pro - ₹24,900 ✓ → SAVEPOINT airpods_added
• iPhone Case - ₹1,999 ✓ → SAVEPOINT case_added
• Apply SuperCoins Discount... ❌ ERROR! Invalid coupon!
Full ROLLBACK: Cancel everything. Amit loses iPhone (might go out of stock)! 😱
ROLLBACK TO case_added: Keep all items. Skip discount. Amit can checkout! 🎉
💡 Partial rollbacks save customer experience!
💡 Example 1 (Medium): Customer Returns with Partial Refund
BEGIN;

-- Step 1: Record the return
INSERT INTO sales.returns (return_id, order_id, prod_id, return_date, reason, refund_amount)
VALUES (55555, 10025, 150, CURRENT_DATE, 'Defective product', 4599.00);

-- Step 2: Add item back to inventory
UPDATE products.inventory
SET stock_qty = stock_qty + 1, last_updated = CURRENT_DATE
WHERE prod_id = 150 AND store_id = (
    SELECT store_id FROM sales.orders WHERE order_id = 10025);

SAVEPOINT return_processed;

-- Step 3: Process refund (first attempt - fails)
INSERT INTO sales.payments (payment_id, order_id, payment_date, payment_mode, amount)
VALUES (77777, 10025, CURRENT_DATE, 'Refund-Card', -4599.00);

-- Gateway error! Rollback to savepoint
ROLLBACK TO return_processed;

-- Try refund to bank account instead
INSERT INTO sales.payments (payment_id, order_id, payment_date, payment_mode, amount)
VALUES (77778, 10025, CURRENT_DATE, 'Refund-Bank', -4599.00);

COMMIT;
 
🧹 TOPIC 4: RELEASE SAVEPOINT - Cleanup
📚 Definition
Technical Definition: RELEASE SAVEPOINT removes a previously created savepoint. After releasing, you cannot rollback to that savepoint. Work is merged into parent scope. This is primarily a resource management operation.
Layman's Terms: Like deleting old video game saves to free up space! 🎮 Once you've passed a difficult level and you're confident you won't need that save anymore, you delete it. RELEASE SAVEPOINT says 'I'm confident about this progress, I don't need this checkpoint anymore, free up memory!'
💡 Example 1 (Medium): Cleaning Up After Success
BEGIN;

-- Step 1: Create order
INSERT INTO sales.orders (order_id, cust_id, store_id, order_date, order_status, total_amount)
VALUES (77777, 1005, 3, CURRENT_DATE, 'Processing', 15999.00);
SAVEPOINT step1_order;

-- Step 2: Add items
INSERT INTO sales.order_items (order_item_id, order_id, prod_id, quantity, unit_price, discount)
VALUES (888888, 77777, 201, 1, 15999.00, 0.00);
SAVEPOINT step2_items;

-- Step 2 succeeded, release step1
RELEASE SAVEPOINT step1_order;

-- Step 3: Process payment
INSERT INTO sales.payments (payment_id, order_id, payment_date, payment_mode, amount)
VALUES (999999, 77777, CURRENT_DATE, 'UPI', 15999.00);
SAVEPOINT step3_payment;

RELEASE SAVEPOINT step2_items;

-- Step 4: Update status
UPDATE sales.orders SET order_status = 'Confirmed' WHERE order_id = 77777;

RELEASE SAVEPOINT step3_payment;
COMMIT;
 
⚙️ TOPIC 5: Auto-commit Mode
📚 Definition
Technical Definition: Auto-commit mode is the default behavior where each individual SQL statement is automatically wrapped in its own transaction and committed immediately. When auto-commit is ON, every INSERT, UPDATE, DELETE is immediately permanent. When OFF (inside BEGIN block), changes are held until COMMIT or ROLLBACK.
Layman's Terms: Think of auto-commit like 'auto-save' in Google Docs! ✍️ Every word is immediately saved. Convenient for normal work, but dangerous for experiments. What if you accidentally delete a paragraph? It's gone! When making big, risky changes, you turn off auto-save. That's what BEGIN does - turns off auto-commit so you can review before making permanent!
📖 The IRCTC Booking Story
🚂 The Tatkal Ticket Trap! 🚂
10 AM. Tatkal bookings open. Priya booking Delhi to Mumbai.
IF IRCTC used Auto-commit for everything:
Step 1: Select seat → COMMITTED! (Seat locked)
Step 2: Enter details → COMMITTED! (Stored)
Step 3: Payment... ❌ FAILED! (Bank timeout)
Result: Seat blocked, details stored, but NO ticket! Wait 30 mins for auto-release. Train fills up! 😭
WITH proper transactions: BEGIN → Select → Details → Payment FAILS → ROLLBACK
Result: Everything undone. Seat immediately available. Priya can retry! 🎉
💡 IRCTC actually uses transactions! That's why failed payments don't block seats forever!
💡 Example 1 (Medium): Safe Data Cleanup
-- DANGEROUS with auto-commit ON:
-- DELETE FROM sales.orders WHERE order_date < '2020-01-01';
-- ^ If deletes more than expected, TOO LATE! 😱

-- SAFE approach with explicit transaction:
BEGIN;

-- First, see what we're about to delete
SELECT COUNT(*) AS records_to_delete,
       MIN(order_date) AS oldest,
       MAX(order_date) AS newest,
       SUM(total_amount) AS total_value
FROM sales.orders
WHERE order_date < '2020-01-01';

-- If numbers look right, proceed
DELETE FROM sales.orders WHERE order_date < '2020-01-01';

-- Verify
SELECT COUNT(*) AS remaining FROM sales.orders;

-- If something wrong: ROLLBACK;
-- If everything correct: COMMIT;
 
✨ Transaction Best Practices
✅ DO	❌ DON'T
Keep transactions SHORT and focused	Hold transactions open for long periods
Always COMMIT or ROLLBACK explicitly	Leave transactions hanging/open
Use SAVEPOINTs for complex operations	Create too many unnecessary savepoints
RELEASE savepoints when no longer needed	Forget to clean up savepoints
Test DELETE/UPDATE with SELECT first	Run DELETE without testing first
Handle errors gracefully with ROLLBACK	Ignore errors and hope for the best
🎯 Key Takeaways
•	BEGIN starts a transaction, COMMIT makes it permanent, ROLLBACK undoes everything
•	SAVEPOINT creates checkpoints for partial rollbacks
•	ROLLBACK TO SAVEPOINT undoes work after a checkpoint while keeping earlier work
•	RELEASE SAVEPOINT cleans up checkpoints you no longer need
•	Auto-commit is ON by default - use BEGIN to take control
•	Transactions ensure data integrity - essential for fintech, e-commerce, banking!


BEGIN

COMMIT

ROLLBACK

SAVEPOINT

ROLLBACK to Savepoint


BEGIN
Commit / Rollback