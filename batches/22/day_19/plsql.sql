we have to build the flow or logic
    SQL + Flow (programming) =  plSQL


variable
    named location which can store value
    scalar
    column
    table

parameter   =>  input   
return      =>  output

Sum(5,5)    =>  10


plSQL   
    SQL
        variables
        loops
        conditional
        exception


CREATE OR REPLACE FUNCTION function_name(
    parameter1 datatype,
    parameter2 datatype DEFAULT default_value
)
RETURNS return_datatype
LANGUAGE plpgsql
AS $$
DECLARE
    variable_name datatype;  -- Variable declarations
BEGIN
    -- Function logic goes here
    RETURN result;
EXCEPTION
    WHEN exception_type THEN -- Error handling
END;
$$;




🔧 Topic 1: Introduction to PL/pgSQL
📖 Definition
🎓 Technical Definition:
PL/pgSQL (Procedural Language/PostgreSQL) is a loadable procedural language that extends SQL with procedural constructs like variables, loops, conditionals, and exception handling. It allows developers to write complex business logic directly within the database.
🗣️ Layman's Terms:
Think of PL/pgSQL as giving your database a BRAIN! 🧠 Regular SQL gives instructions one at a time. PL/pgSQL lets you write a complete RECIPE that the database follows on its own - with decisions (if-else), repetitions (loops), and error handling. It's like giving your mom the entire recipe book instead of each cooking step!
📖 The Story: The Smart Dabbawaala of Mumbai
🚴 The Dabbawaala's Dilemma
Imagine Ramesh, a Mumbai Dabbawaala who delivers 50 lunch boxes daily. Every day his supervisor calls with step-by-step instructions:
📞 "Pick up tiffin from Mrs. Sharma..." 📞 "Check if extra roti needed..." 📞 "Calculate bill..." 📞 "Deliver to Nariman Point..." - 200+ calls daily! 😫
💡 The Smart Solution:
Ramesh creates ONE instruction card: FUNCTION: deliver_lunch(customer_name)
1. Pick up tiffin → 2. Check special_requests → 3. IF extra → add to bill → 4. Deliver → 5. RETURN status
Now supervisor just says: "deliver_lunch('Mrs. Sharma')" - ONE call, entire process handled! 🎉
🎯 This is EXACTLY what PL/pgSQL Functions do!
💼 Real Job Connection: At Flipkart, when you click "Buy Now", ONE function handles inventory check, payment, order creation, seller notification, and tracking. Functions can land you a ₹10-18 LPA backend role! 🚀
 
🔧 Topic 2: CREATE FUNCTION Syntax
⌨️ Basic Syntax
CREATE OR REPLACE FUNCTION function_name(
    parameter1 datatype,
    parameter2 datatype DEFAULT default_value
)
RETURNS return_datatype
LANGUAGE plpgsql
AS $$
DECLARE
    variable_name datatype;  -- Variable declarations
BEGIN
    -- Function logic goes here
    RETURN result;
EXCEPTION
    WHEN exception_type THEN -- Error handling
END;
$$;
📝 Example 1: GST Calculator (Medium)
-- Function to calculate price with GST based on category
CREATE OR REPLACE FUNCTION calculate_gst_price(
    base_price NUMERIC, product_category VARCHAR
) RETURNS NUMERIC LANGUAGE plpgsql AS $$
DECLARE
    gst_rate NUMERIC;
BEGIN
    gst_rate := CASE
        WHEN product_category = 'Electronics' THEN 0.18
        WHEN product_category = 'Clothing' THEN 0.05
        WHEN product_category = 'Food' THEN 0.00
        ELSE 0.12 END;
    RETURN ROUND(base_price * (1 + gst_rate), 2);
END; $$;

-- Usage:
SELECT calculate_gst_price(1000, 'Electronics');  -- Returns 1180.00
SELECT calculate_gst_price(500, 'Food');         -- Returns 500.00
 
🔧 Topic 3: Parameters (IN, OUT, INOUT)
📖 Definition
🎓 Technical Definition:
Parameters allow data to flow between caller and function. IN (input only, default), OUT (output only), INOUT (bidirectional).
🗣️ Layman's Terms (Restaurant Analogy):
• IN: Like ordering "Masala Dosa" - you GIVE information (one-way in) • OUT: Waiter bringing your bill - he GIVES you info (one-way out) • INOUT: Giving ₹500, getting ₹137 change - two-way exchange!
📝 Example: Store Summary with OUT Parameters (Medium)
-- Multiple OUT parameters return multiple values!
CREATE OR REPLACE FUNCTION get_store_summary(
    p_store_id INT,              -- IN parameter
    OUT total_orders INT,         -- OUT parameter 1
    OUT total_revenue NUMERIC,    -- OUT parameter 2
    OUT avg_order_value NUMERIC   -- OUT parameter 3
) LANGUAGE plpgsql AS $$
BEGIN
    SELECT COUNT(*), COALESCE(SUM(total_amount), 0),
           COALESCE(ROUND(AVG(total_amount), 2), 0)
    INTO total_orders, total_revenue, avg_order_value
    FROM sales.orders WHERE store_id = p_store_id;
END; $$;

SELECT * FROM get_store_summary(1);
-- Result: total_orders | total_revenue | avg_order_value
 
🔧 Topic 4: Return Types (Scalar, TABLE, SETOF, VOID)
Type	What It Returns	Example
Scalar	Single value (INT, VARCHAR)	get_age(101) → 28
TABLE	Multiple rows, defined columns	get_products() → (id, name, price)
SETOF	Multiple rows of existing table	SETOF customers.customers
VOID	Nothing (side-effect only)	log_activity() → does INSERT
📝 Example: Product Search with RETURNS TABLE (Hard)
CREATE OR REPLACE FUNCTION search_products_by_price(
    p_min NUMERIC DEFAULT 0, p_max NUMERIC DEFAULT 999999
) RETURNS TABLE (
    product_id INT, product_name VARCHAR, price NUMERIC, stock INT
) LANGUAGE plpgsql AS $$
BEGIN
    RETURN QUERY
    SELECT p.prod_id, p.prod_name, p.price,
           COALESCE(SUM(i.stock_qty), 0)::INT
    FROM products.products p
    LEFT JOIN products.inventory i ON p.prod_id = i.prod_id
    WHERE p.price BETWEEN p_min AND p_max
    GROUP BY p.prod_id ORDER BY p.price;
END; $$;

SELECT * FROM search_products_by_price(500, 2000);
 
🔧 Topic 5: DECLARE Section & Variables
DECLARE
    customer_name VARCHAR(100);       -- Basic string
    total_amount NUMERIC := 0;        -- With initial value
    order_count INT DEFAULT 0;        -- Alternative syntax
    v_price products.products.price%TYPE;  -- Copy column type!
    customer_row customers.customers%ROWTYPE; -- Copy row structure!
    GST_RATE CONSTANT NUMERIC := 0.18;  -- Cannot change!
🔧 Topic 6: Exception Handling & RAISE
RAISE Level	Behavior
NOTICE	Shows message, continues execution - for progress updates
WARNING	Shows warning, continues - for potential issues
EXCEPTION	STOPS execution, rolls back - for critical errors
📝 Example: Safe Division with Exception Handling
CREATE OR REPLACE FUNCTION get_customer_aov(p_cust_id INT)
RETURNS NUMERIC LANGUAGE plpgsql AS $$
DECLARE
    v_total NUMERIC; v_count INT;
BEGIN
    SELECT COALESCE(SUM(total_amount), 0), COUNT(*)
    INTO v_total, v_count FROM sales.orders
    WHERE cust_id = p_cust_id;
    RETURN ROUND(v_total / v_count, 2);  -- May fail!
EXCEPTION
    WHEN DIVISION_BY_ZERO THEN
        RAISE NOTICE 'Customer % has no orders', p_cust_id;
        RETURN 0;  -- Graceful recovery!
END; $$;

