🔹 TOPIC 6: EXCEPTION HANDLING IN PL/pgSQL

📖 Definition

Technical Definition: Exception handling in PL/pgSQL allows catching and handling errors gracefully using BEGIN...EXCEPTION blocks. Instead of crashing, code can handle errors, log them, and take corrective action. RAISE generates messages and errors.

Layman's Terms: Think of exception handling like a safety net in a circus. When an acrobat makes a mistake, the net catches them! Similarly, exception handling catches errors and handles them gracefully instead of crashing everything.

📖 The Story: The Swiggy Order Disaster Recovery 🛵

You're a backend engineer at Swiggy. A customer orders from a restaurant that just closed! What happens?

😱 WITHOUT EXCEPTION HANDLING: Order processing crashes! Payment stuck, no confirmation, angry customer!
✅ WITH EXCEPTION HANDLING: Code catches 'restaurant closed' error → Initiates refund → Notifies customer → Suggests alternatives → Logs incident!



SQL


Transaction

BEGIN   
    STEP1
    STEP2
    STEP3
    STEP4
COMMIT/ROLLBACK


SQL + FLOW => Procedural Language for SQL



Utensil
    Milk / Water
    Boil
    Sugar
    Tea Leaves
    Boil

If Else
Loops
Functions
Procedure


NO SQL


💻 Exception Handling Syntax
-- Basic Exception Handling
DO $$
BEGIN
    -- Your code here
EXCEPTION
    WHEN division_by_zero THEN RAISE NOTICE 'Cannot divide by zero!';
    WHEN unique_violation THEN RAISE NOTICE 'Duplicate value!';
    WHEN foreign_key_violation THEN RAISE NOTICE 'Reference not found!';
    WHEN OTHERS THEN RAISE NOTICE 'Error: %', SQLERRM;
END $$;

-- RAISE Levels:
-- RAISE NOTICE   -- Default, shown to user
-- RAISE WARNING  -- Warnings
-- RAISE EXCEPTION -- Throws error, stops execution
  🔹 TOPIC 6: EXCEPTION HANDLING IN PL/pgSQL
📖 Definition
Technical Definition: Exception handling in PL/pgSQL allows catching and handling errors gracefully using BEGIN...EXCEPTION blocks. Instead of crashing, code can handle errors, log them, and take corrective action. RAISE generates messages and errors.
Layman's Terms: Think of exception handling like a safety net in a circus. When an acrobat makes a mistake, the net catches them! Similarly, exception handling catches errors and handles them gracefully instead of crashing everything.
📖 The Story: The Swiggy Order Disaster Recovery 🛵
You're a backend engineer at Swiggy. A customer orders from a restaurant that just closed! What happens?
😱 WITHOUT EXCEPTION HANDLING: Order processing crashes! Payment stuck, no confirmation, angry customer!
✅ WITH EXCEPTION HANDLING: Code catches 'restaurant closed' error → Initiates refund → Notifies customer → Suggests alternatives → Logs incident!
💻 Exception Handling Syntax
-- Basic Exception Handling
DO $$
BEGIN
    -- Your code here
EXCEPTION
    WHEN division_by_zero THEN RAISE NOTICE 'Cannot divide by zero!';
    WHEN unique_violation THEN RAISE NOTICE 'Duplicate value!';
    WHEN foreign_key_violation THEN RAISE NOTICE 'Reference not found!';
    WHEN OTHERS THEN RAISE NOTICE 'Error: %', SQLERRM;
END $$;

-- RAISE Levels:
-- RAISE NOTICE   -- Default, shown to user
-- RAISE WARNING  -- Warnings
-- RAISE EXCEPTION -- Throws error, stops execution
📝 Example 1 (Medium): Safe Order Processing
-- Safe order processing with exception handling
DO $$
DECLARE v_cust_id INT := 99999; v_stock INT;
BEGIN
    RAISE NOTICE 'Processing order for customer %', v_cust_id;
    
    IF NOT EXISTS (SELECT 1 FROM customers.customers WHERE cust_id = v_cust_id) THEN
        RAISE EXCEPTION 'Customer % not found', v_cust_id USING HINT = 'Verify customer ID';
    END IF;
    
    SELECT stock_qty INTO v_stock FROM products.inventory WHERE prod_id = 101 AND store_id = 1;
    IF v_stock < 1 THEN
        RAISE EXCEPTION 'Product out of stock' USING HINT = 'Check alternative stores';
    END IF;
    
    INSERT INTO sales.orders (order_id, cust_id, store_id, order_date, order_status, total_amount)
    VALUES ((SELECT COALESCE(MAX(order_id),0)+1 FROM sales.orders), v_cust_id, 1, CURRENT_DATE, 'pending', 1000);
    
    RAISE NOTICE 'Order created successfully!';
EXCEPTION
    WHEN OTHERS THEN
        RAISE NOTICE 'ERROR: % - %', SQLSTATE, SQLERRM;
        RAISE NOTICE 'Order processing failed';
END $$;
📝 Example 2 (Hard): Batch Processing with Error Recovery
-- Batch order processing - continue even if one fails
DO $$
DECLARE v_order RECORD; v_success INT := 0; v_fail INT := 0;
BEGIN
    RAISE NOTICE '=== BATCH PROCESSING STARTED ===';
    
    FOR v_order IN SELECT order_id, cust_id, total_amount FROM sales.orders
                   WHERE order_status = 'pending' LIMIT 10
    LOOP
        BEGIN
            RAISE NOTICE 'Processing order %...', v_order.order_id;
            
            IF NOT EXISTS (SELECT 1 FROM customers.loyalty_points WHERE cust_id = v_order.cust_id) THEN
                RAISE EXCEPTION 'No loyalty record for customer %', v_order.cust_id;
            END IF;
            
            UPDATE customers.loyalty_points
            SET total_points = total_points + (v_order.total_amount / 100)::INT
            WHERE cust_id = v_order.cust_id;
            
            UPDATE sales.orders SET order_status = 'processed' WHERE order_id = v_order.order_id;
            v_success := v_success + 1;
        EXCEPTION
            WHEN OTHERS THEN
                v_fail := v_fail + 1;
                RAISE WARNING 'Order % failed: %', v_order.order_id, SQLERRM;
        END;
    END LOOP;
    
    RAISE NOTICE '=== COMPLETE: Success: % | Failed: % ===', v_success, v_fail;
END $$;
 
  🔹 TOPIC 7: DO BLOCKS - Anonymous Code Execution
📖 Definition
Technical Definition: DO blocks allow executing anonymous PL/pgSQL code without creating a stored function. Perfect for one-time scripts, data migrations, and ad-hoc procedural operations. Cannot return values but can perform any DML operations.
Layman's Terms: Think of DO blocks like hiring a one-day contractor. You don't 'employ' them permanently (like stored functions). They come, do the work, and leave. Perfect for quick tasks you need to do once!
📖 The Story: The Midnight Data Fix 🌙
It's 2 AM. You're at Flipkart. A bug caused 10,000 orders to have wrong discounts! Sale ends at 6 AM. You need to fix it NOW! No time to create, test, deploy a function. DO block to the rescue!
💻 DO Block Syntax
-- Basic DO block
DO $$
DECLARE v_count INT;
BEGIN
    SELECT COUNT(*) INTO v_count FROM sales.orders;
    RAISE NOTICE 'Total orders: %', v_count;
END $$;

-- DO block with exception handling
DO $$
BEGIN
    UPDATE sales.orders SET total_amount = total_amount * 1.1;
    RAISE NOTICE 'Update successful!';
EXCEPTION
    WHEN OTHERS THEN RAISE NOTICE 'Error: %', SQLERRM;
END $$;
📝 Example 1 (Medium): Data Quality Check
-- Data quality check using DO block
DO $$
DECLARE v_null INT; v_negative INT; v_future INT; v_total INT;
BEGIN
    RAISE NOTICE '=== DATA QUALITY CHECK ===';
    
    SELECT COUNT(*) INTO v_null FROM sales.orders WHERE total_amount IS NULL;
    RAISE NOTICE 'NULL amounts: %', v_null;
    
    SELECT COUNT(*) INTO v_negative FROM sales.orders WHERE total_amount < 0;
    RAISE NOTICE 'Negative amounts: %', v_negative;
    
    SELECT COUNT(*) INTO v_future FROM sales.orders WHERE order_date > CURRENT_DATE;
    RAISE NOTICE 'Future dates: %', v_future;
    
    v_total := v_null + v_negative + v_future;
    IF v_total = 0 THEN
        RAISE NOTICE 'RESULT: All checks PASSED!';
    ELSE
        RAISE WARNING 'RESULT: % issues found!', v_total;
    END IF;
END $$;
📝 Example 2 (Hard): Customer Loyalty Tier Migration
-- Loyalty tier migration script
DO $$
DECLARE v_customer RECORD; v_purchases NUMERIC; v_processed INT := 0; v_errors INT := 0;
BEGIN
    RAISE NOTICE '=== LOYALTY TIER MIGRATION ===';
    
    FOR v_customer IN SELECT cust_id, full_name FROM customers.customers
    LOOP
        BEGIN
            SELECT COALESCE(SUM(total_amount), 0) INTO v_purchases
            FROM sales.orders WHERE cust_id = v_customer.cust_id
            AND order_status IN ('completed', 'delivered');
            
            INSERT INTO customers.loyalty_points (cust_id, total_points, last_updated)
            VALUES (v_customer.cust_id, (v_purchases / 100)::INT, CURRENT_DATE)
            ON CONFLICT (cust_id) DO UPDATE
            SET total_points = EXCLUDED.total_points, last_updated = CURRENT_DATE;
            
            v_processed := v_processed + 1;
            IF v_processed % 100 = 0 THEN
                RAISE NOTICE 'Processed % customers...', v_processed;
            END IF;
        EXCEPTION
            WHEN OTHERS THEN v_errors := v_errors + 1;
        END;
    END LOOP;
    
    RAISE NOTICE '=== COMPLETE: Processed % | Errors % ===', v_processed, v_errors;
END $$;


Create a flow for Order Processing

DO $$

declare v_cust_id INT := 9999; v_stock INT; v_prod_id INT := 12177;

BEGIN
	raise notice 'Processing order for customer id %',v_cust_id;

	-- This will check if we have customer with given id 
	-- If no customer with the given id it will raise exception => We dont have this customer.
	IF not exists (Select 1 from customers.customers where cust_id = v_cust_id) then
		raise exception 'Customer % not found', v_cust_id Using HInt = 'Verify Customer ID';
	end IF;

	Select stock_qty into v_stock from products.inventory where prod_id = v_prod_id and store_id =1;

	If v_stock is null or v_stock = 0 then
		raise exception 'Product out of stock' using hint ='Check alternative stores';
	end IF;
	
END $$;


customers.customers

sales.orders

sales.order_items

products.inventory

sales.shipments



Store Procedure





DO $$

DECLARE v_count INT;

BEGIN
	Select count(*) into v_count from sales.orders;
	raise notice 'Total orers : %',v_count;

END $$;



DO $$

declare v_null int; v_high_order int;

BEGIN
	RAISE NOTICE '===== Data Quality Check =====';

	Select count(*) into v_null from sales.orders where total_amount is null;
	raise notice 'Null amount : %',v_null;
	
	Select count(*) into v_high_order from sales.orders where total_amount>1000000;
	raise notice 'No Of High Value Orders : %',v_high_order;

	



END $$;