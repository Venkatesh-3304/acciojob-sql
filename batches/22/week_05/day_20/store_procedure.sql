Restaurent
    guy1        =>  curry
    guy2        =>  chapati
    guy3        =>  rice
    head_chef   =>  curry,chapati,rice

order at swiggy
    validate order
    deduct money
    notify Restaurent
    assign delivery 
    update points

🔧 TOPIC 1: CREATE PROCEDURE
📖 Definition
Technical Definition:
A Stored Procedure is a named block of PL/pgSQL code stored in the database that performs operations. Unlike functions, procedures do NOT return a value using RETURN (use OUT parameters instead). Procedures are invoked using CALL and can contain COMMIT/ROLLBACK.
Layman's Terms:
Think of a Procedure like a recipe for your database chef! 👨‍🍳 A function is asking 'What's today's special?' (returns answer). A procedure is 'Cook me a full thali!' - chef follows all steps without reporting back until done. Procedures DO things; Functions COMPUTE things!
📚 The Story: Swiggy's Order Automation
🍔 THE STORY: Swiggy's Kitchen Automation
Imagine you're the Database Architect at Swiggy. Every order requires FIVE steps: validate order, deduct wallet, notify restaurant, assign delivery, update points.
Initially, your team ran 5 separate SQL commands. One day, internet flickered between step 2 (money deducted) and step 3 (restaurant not notified). Customer paid ₹500, no food! 😱
💡 SOLUTION: Create a STORED PROCEDURE 'process_order' bundling all 5 steps. If ANY step fails, everything rolls back. Customer''s money is safe!
🎯 CAREER: This is EXACTLY what Flipkart, Amazon, Paytm use! Companies pay ₹12-18 LPA for engineers who design such systems!


⌨️ Syntax
-- Basic CREATE PROCEDURE Syntax
CREATE OR REPLACE PROCEDURE procedure_name(
    param1 datatype,              -- IN parameter (default)
)
LANGUAGE plpgsql
AS $$
DECLARE
    variable1 datatype;           -- Local variables
BEGIN
    -- Procedure logic (can include COMMIT/ROLLBACK)
END;
$$;

-- Calling a Procedure
CALL procedure_name(arg1, arg2, arg3);


🔀 TOPIC 2: IF-ELSE STATEMENTS
📖 Definition
Technical Definition:
IF-ELSE statements provide conditional execution. IF condition is TRUE, THEN block executes; otherwise ELSE block runs. IF-ELSIF-ELSE allows multiple condition checks in sequence, executing the first matching block.
Layman's Terms:
It's like a traffic signal! 🚦 IF green → GO. ELSE (red) → STOP. With ELSIF: IF morning → chai, ELSIF afternoon → coffee, ELSIF evening → lassi, ELSE → water!
⌨️ Syntax
-- Simple IF-ELSE
IF condition THEN
    -- statements when TRUE
ELSE
    -- statements when FALSE
END IF;

-- IF-ELSIF-ELSE (Multiple Conditions)
IF condition1 THEN
    -- statements for condition1
ELSIF condition2 THEN
    -- statements for condition2
ELSIF condition3 THEN
    -- statements for condition3
ELSE
    -- default statements
END IF;
💡 Example: Customer Tier Classification
CREATE OR REPLACE PROCEDURE classify_customer_tier(
    p_cust_id INT,
    OUT p_tier VARCHAR
) LANGUAGE plpgsql AS $$
DECLARE v_points INT;
BEGIN
    SELECT total_points INTO v_points
    FROM customers.loyalty_points WHERE cust_id = p_cust_id;
    
    IF v_points > 5000 THEN
        p_tier := 'PLATINUM 💎';
    ELSIF v_points > 2000 THEN
        p_tier := 'GOLD 🥇';
    ELSIF v_points > 500 THEN
        p_tier := 'SILVER 🥈';
    ELSE
        p_tier := 'BRONZE 🥉';
    END IF;
    
    RAISE NOTICE 'Customer % = % tier', p_cust_id, p_tier;
END; $$;
 
🔄 TOPIC 3: LOOP STRUCTURES
📖 Definition
Technical Definition:
PL/pgSQL provides: LOOP (infinite until EXIT), WHILE (condition-based), FOR (counter or query-based). EXIT terminates loop; CONTINUE skips to next iteration.
Layman's Terms:
Like doing chores! 🧹 LOOP = 'keep sweeping until Mom says STOP'. WHILE = 'sweep while there's dust'. FOR = 'sweep rooms 1 to 10'. Each helps when you need to do something multiple times!
⌨️ Syntax
-- 1. Basic LOOP (infinite until EXIT)
LOOP
    -- statements
    EXIT WHEN condition;  -- Break out
END LOOP;

-- 2. WHILE Loop (condition-based)
WHILE condition LOOP
    -- statements (run while condition is TRUE)
END LOOP;

-- 3. FOR Loop (range-based)
FOR counter IN 1..10 LOOP
    -- statements using counter
END LOOP;

-- 4. FOR IN (query-based - iterate over results)
FOR record IN (SELECT * FROM table_name) LOOP
    -- access record.column_name
END LOOP;

-- CONTINUE and EXIT
CONTINUE;  -- Skip to next iteration
EXIT;      -- Exit the loop completely
💡 Example: Batch Loyalty Points Update
CREATE OR REPLACE PROCEDURE award_monthly_bonus()
LANGUAGE plpgsql AS $$
DECLARE
    rec RECORD;
    v_count INT := 0;
BEGIN
    -- FOR IN loop: iterate through customers with orders last month
    FOR rec IN (
        SELECT DISTINCT cust_id FROM sales.orders
        WHERE order_date >= DATE_TRUNC('month', CURRENT_DATE - INTERVAL '1 month')
          AND order_date < DATE_TRUNC('month', CURRENT_DATE)
    ) LOOP
        UPDATE customers.loyalty_points
        SET total_points = total_points + 100,
            last_updated = CURRENT_DATE
        WHERE cust_id = rec.cust_id;
        
        v_count := v_count + 1;
    END LOOP;
    
    RAISE NOTICE 'Awarded bonus to % customers', v_count;
END; $$;

CALL award_monthly_bonus();
 
💳 TOPIC 4: TRANSACTION CONTROL IN PROCEDURES
📖 Definition
Technical Definition:
Unlike functions, procedures can use COMMIT and ROLLBACK inside their body. This allows committing partial work, creating multiple transaction boundaries, and handling batch operations with intermediate saves.
Layman's Terms:
Like paying EMIs! 💳 You want each EMI saved separately. If EMI 5 fails, you don't want to lose EMIs 1-4! COMMIT inside a procedure = saving your game progress!
⚡ Key Points
✅ Procedures CAN
• Use COMMIT inside body
• Use ROLLBACK inside body
• Create multiple transactions	❌ Functions CANNOT
• Use COMMIT
• Use ROLLBACK
• Control transactions
💡 Example: Batch Processing with Intermediate Commits
CREATE OR REPLACE PROCEDURE process_annual_bonus(
    p_bonus_percent NUMERIC,
    p_batch_size INT DEFAULT 10
) LANGUAGE plpgsql AS $$
DECLARE
    emp_rec RECORD;
    v_count INT := 0;
    v_batch INT := 0;
BEGIN
    FOR emp_rec IN (SELECT emp_id, salary FROM stores.employees) LOOP
        INSERT INTO hr.salary_history (emp_id, effective_date, salary)
        VALUES (emp_rec.emp_id, CURRENT_DATE, emp_rec.salary * (1 + p_bonus_percent/100));
        
        v_count := v_count + 1;
        
        -- Commit every batch_size employees
        IF v_count % p_batch_size = 0 THEN
            v_batch := v_batch + 1;
            COMMIT;  -- Save this batch
            RAISE NOTICE 'Batch % complete. Processed %', v_batch, v_count;
        END IF;
    END LOOP;
    
    COMMIT;  -- Final batch
    RAISE NOTICE 'All done! Total: %', v_count;
END; $$;
