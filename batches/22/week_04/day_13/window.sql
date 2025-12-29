🎯 TOPIC 1: Introduction to Window Functions
📘 Definition
Technical Definition: A Window Function performs calculations across a set of table rows that are somehow related to the current row. Unlike regular aggregate functions, window functions do not collapse rows into a single output row - they retain the individual row identity while computing values across a 'window' of related rows.
Layman's Terms: Imagine you're standing in a queue at an Indian railway station booking counter. A window function is like having a magic board above your head that shows: your position in line (rank), how many people are ahead of you, what's the total count, AND the average waiting time - ALL while you stay in your position! You don't merge with others; you just gain extra information about your surroundings. That's the magic - you keep your row AND get calculations!
📖 The Story: The IPL Analytics Revolution
🏏 Imagine you're a Data Analyst at BCCI during IPL 2024...
The IPL auction is coming up. Your boss, the BCCI Secretary, rushes to your desk:
"I need a report showing each batsman's runs, their rank in their team, AND their rank overall - but I want to see EVERY player's row, not just team totals!"
You think about using GROUP BY... but wait! GROUP BY would collapse all players into team totals. You'd lose individual player rows! 😰
Then you remember: WINDOW FUNCTIONS! 💡
With window functions, you can:
•	Keep every player's row visible
•	Add their rank within their team
•	Add their overall rank across all teams
•	Show running totals, averages, comparisons - ALL IN ONE QUERY!
The Secretary is amazed! You deliver the report in minutes. That's the power of Window Functions! 🏆
💼 Career Connection: At Flipkart, analysts use window functions to rank sellers by sales within each category. At Zomato, they rank restaurants by ratings within each city. At Amazon, they track product rankings in real-time. This skill alone can land you ₹8-15 LPA jobs!

'
⚙️ Syntax
-- Basic Window Function Syntax
SELECT 
    column1,
    column2,
    WINDOW_FUNCTION() OVER (
        [PARTITION BY partition_column]
        [ORDER BY order_column]
    ) AS result_column
FROM table_name;

-- Key Components:
-- WINDOW_FUNCTION(): ROW_NUMBER, RANK, DENSE_RANK, SUM, AVG, etc.
-- OVER(): Defines the "window" of rows for calculation
-- PARTITION BY: Divides data into groups (like GROUP BY but keeps rows)
-- ORDER BY: Defines the order within each partition



TCS HR wants to see each employee's salary along with their department's average salary - keeping every employee row visible.

Select
	*
from stores.employees e
left join (select dept_id, avg(salary) as dept_salary from stores.employees group by dept_id) as d 
	on d.dept_id=e.dept_id

Select
	*,
	avg(e.salary) over(partition by dept_id) as dept_salary
from stores.employees e


select
	prod_id,
	supplier_id,
	-- rank() over(order by price desc) as rnk_price
	row_number() over(order by supplier_id desc) as row_number_supplier,
	rank() over(order by supplier_id desc) as rnk_supplier,
	dense_rank() over(order by supplier_id desc) as dense_rnk_supplier
from
	products.products 


select
	prod_id,
	supplier_id,
	price,
	row_number() over(partition by supplier_id order by price desc) as row_number_supplier,
	sum(price) over(partition by supplier_id order by price desc) as row_number_supplier,
	sum(price) over(partition by supplier_id) as row_number_supplier,
	avg(price) over(partition by supplier_id order by price desc) as row_number_supplier,
	avg(price) over(partition by supplier_id) as row_number_supplier,
	max(price) over(partition by supplier_id order by price desc) as row_number_supplier,
	max(price) over(partition by supplier_id) as row_number_supplier,
	min(price) over(partition by supplier_id order by price desc) as row_number_supplier,
	min(price) over(partition by supplier_id) as row_number_supplier
from
	products.products 






