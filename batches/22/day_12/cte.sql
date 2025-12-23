COMMON TABLE EXPRESSIONS (CTEs)

📖 Definition
Technical Definition:
A Common Table Expression (CTE) is a temporary named result set defined within a WITH clause that exists only for the duration of a single query. CTEs make complex queries more readable by breaking them into named, logical building blocks that can be referenced multiple times in the main query.

Layman''s Terms (Simple Explanation):

Think of CTEs like making a biryani recipe! Instead of writing everything in one confusing paragraph, you create named steps: Step 1 (marinate_chicken), Step 2 (prepare_rice), Step 3 (layer_ingredients). Each step is clearly named, easy to understand, and you can refer back to any step. CTEs work the same way - breaking complex queries into named, reusable pieces!
📚 The Story: The Zomato Analytics Dashboard
🍕 THE MESSY QUERY NIGHTMARE AT ZOMATO!
Rahul, a new analyst at Zomato, was asked to build a dashboard showing:
• Total orders per restaurant • Average ratings • Revenue comparison with city average
😰 His first attempt was a MONSTER query - 50 lines of nested subqueries that nobody (including himself!) could understand a week later.
💡 His senior showed him CTEs:
"Break it into pieces! Create restaurant_orders CTE, then ratings_summary CTE, then city_averages CTE. Name each piece clearly!"
🎯 Result: Same output, but now the query was:
✅ Easy to read  ✅ Easy to debug  ✅ Easy to modify  ✅ Easy to explain to others
🚀 Career Impact: CTEs are used in 90% of analytics queries at tech companies. Master them, and your SQL instantly becomes senior-level!
⌨️ Syntax
-- Single CTE
WITH cte_name AS (
    SELECT columns FROM table WHERE condition
)
SELECT * FROM cte_name;

-- Multiple CTEs
WITH
    cte1 AS (SELECT ... FROM ...),
    cte2 AS (SELECT ... FROM ... JOIN cte1 ...),
    cte3 AS (SELECT ... FROM cte1 JOIN cte2 ...)
SELECT * FROM cte3;

💡 Key Points: CTEs are defined with WITH, comma-separated if multiple, and can reference each other (later CTEs can use earlier ones)!


Multi-Step Customer Analysis with Multiple CTEs
Scenario: Build a customer value report that: 
(1) calculates total spend per customer, 
(2) calculates average spend per city, 
(3) compares customers to their city average, 
(4) segments them into tiers.


with
-- Step 1 =>	Calculate total spend by customer
customer_spend as (
	Select 
		c.cust_id,
		c.full_name,
		c.city,
		coalesce(sum(o.total_amount),0) as total_spent
	from
		customers.customers c
	left join sales.orders o
		on c.cust_id=o.cust_id
	group by
		c.cust_id,c.full_name,c.city
),
-- Step 2 => Calculate city averages
city_averages as (
	select
		city,
		avg(total_spent) as avg_city_spend
	from
		customer_spend
	group by 
		city
),
-- Step 3 => Compare and segment customers
customer_anlysis as (
	Select
		cs.cust_id,
		cs.full_name,
		cs.city,
		cs.total_spent,
		ca.avg_city_spend,
		round(cs.total_spent-ca.avg_city_spend) as vs_city_avg,
		case
			when cs.total_spent >=  ca.avg_city_spend * 2 then 'VIP'
			when cs.total_spent >=  ca.avg_city_spend then 'High Value'
			when cs.total_spent >=  ca.avg_city_spend * 0.5 then 'Medium'
			else 'Low Value'
		end as customer_tier
	from customer_spend cs
	join city_averages as ca
		on cs.city = ca.city
)

Select * from customer_anlysis



RECURSIVE CTEs

📖 Definition
Technical Definition:
A Recursive CTE is a CTE that references itself, allowing queries to traverse hierarchical or tree-structured data. It consists of two parts: (1) Base Case (Anchor) - the starting point that doesn't reference the CTE, and (2) Recursive Case - references the CTE itself and defines how to get the next level. PostgreSQL executes the base case first, then repeatedly executes the recursive case until no more rows are returned.
Layman's Terms (Simple Explanation):
Think of tracing your family tree! You start with yourself (Base Case), then find your parents, then your grandparents, then great-grandparents... each step goes up one level. A Recursive CTE does the same thing in databases - it starts somewhere and keeps 'climbing' until there's nowhere left to go!
📚 The Story: The Infosys Org Chart Challenge
🏢 THE EMPLOYEE HIERARCHY PUZZLE!
Imagine you just joined Infosys as a Data Analyst. The HR head asks:
"Show me the complete reporting chain from the CEO down to every employee!"
🤔 The Problem:
CEO → VPs → Directors → Managers → Team Leads → Employees
Some chains have 3 levels, some have 7 levels. You don't know how deep it goes!
💡 The Recursive CTE Solution:
1. Start with CEO (Base Case: manager_id IS NULL)
2. Find everyone who reports to CEO (Level 1)
3. Find everyone who reports to Level 1 (Level 2)
4. Keep going until no more reports found!
🎯 Career Connection: Every large company (TCS, Wipro, Google) uses recursive CTEs for org charts, category trees, bill of materials, and folder structures!
⌨️ Syntax
WITH RECURSIVE cte_name AS (
    -- BASE CASE (Anchor): Starting point
    SELECT columns, 1 AS level
    FROM table
    WHERE starting_condition  -- e.g., manager_id IS NULL

    UNION ALL

    -- RECURSIVE CASE: Keep finding next levels
    SELECT t.columns, cte.level + 1
    FROM table t
    INNER JOIN cte_name cte ON t.parent_id = cte.id
)
SELECT * FROM cte_name;

⚠️ CRITICAL POINTS:
• Must use RECURSIVE keyword after WITH
• Base case comes FIRST, before UNION ALL
• Recursive case must eventually return no rows (or infinite loop!)
• Use level counter to track depth
💻 Examples
Example 1 (Medium): Employee Hierarchy - Who Reports to Whom
Scenario: RetailMart wants to visualize the complete employee hierarchy. Note: Since our employees table doesn't have a manager_id column, we'll simulate this by treating dept_id as a hierarchical grouping.
Concepts Used: Recursive CTE, base case, recursive case, level tracking

-- Simple hierarchy: Generate a number sequence (conceptual example)
-- This demonstrates recursive CTE mechanics
WITH RECURSIVE number_sequence AS (
    -- Base Case: Start with 1
    SELECT 1 AS num, 'Level 1' AS description

    UNION ALL

    -- Recursive Case: Add 1 each time, stop at 10
    SELECT num + 1, 'Level ' || (num + 1)::text
    FROM number_sequence
    WHERE num < 10  -- Termination condition!
)
SELECT * FROM number_sequence;

What This Does: Generates numbers 1-10 with level descriptions. This demonstrates the recursive pattern: start with base case (1), keep adding until condition fails (num >= 10).

-- Practical Example: Department hierarchy simulation
WITH RECURSIVE dept_levels AS (
    -- Base Case: Top-level department (lowest dept_id as 'root')
    SELECT
        dept_id,
        dept_name,
        1 AS level,
        dept_name::text AS path
    FROM stores.departments
    WHERE dept_id = (SELECT MIN(dept_id) FROM stores.departments)

    UNION ALL

    -- Recursive Case: Get next department
    SELECT
        d.dept_id,
        d.dept_name,
        dl.level + 1,
        dl.path || ' → ' || d.dept_name
    FROM stores.departments d
    INNER JOIN dept_levels dl ON d.dept_id = dl.dept_id + 1
    WHERE d.dept_id <= (SELECT MAX(dept_id) FROM stores.departments)
)
SELECT * FROM dept_levels ORDER BY level;

Real-World Application: This pattern is used by every HR system to display org charts and reporting structures.
Example 2 (Hard): Building a Date Calendar Using Recursive CTE
Scenario: Generate a complete calendar for a date range - useful for reports that need all dates even when no transactions occurred.
Concepts Used: Recursive CTE with dates, date arithmetic, business logic

-- Generate a calendar for January 2024
WITH RECURSIVE calendar AS (
    -- Base Case: Start date
    SELECT
        DATE '2024-01-01' AS cal_date,
        1 AS day_num,
        TO_CHAR(DATE '2024-01-01', 'Day') AS day_name,
        CASE
            WHEN EXTRACT(DOW FROM DATE '2024-01-01') IN (0, 6)
            THEN 'Weekend' ELSE 'Weekday'
        END AS day_type

    UNION ALL

    -- Recursive Case: Add one day
    SELECT
        cal_date + INTERVAL '1 day',
        day_num + 1,
        TO_CHAR(cal_date + INTERVAL '1 day', 'Day'),
        CASE
            WHEN EXTRACT(DOW FROM cal_date + INTERVAL '1 day') IN (0, 6)
            THEN 'Weekend' ELSE 'Weekday'
        END
    FROM calendar
    WHERE cal_date < DATE '2024-01-31'  -- Stop condition
)
SELECT
    cal_date,
    day_num,
    TRIM(day_name) AS day_name,
    day_type,
    COALESCE(
        (SELECT COUNT(*) FROM sales.orders
         WHERE order_date = calendar.cal_date), 0
    ) AS orders_on_day
FROM calendar
ORDER BY cal_date;

Real-World Application: Analytics teams at Netflix, Spotify use calendar CTEs to ensure reports show all dates, even those with zero activity - essential for trend analysis!
 
