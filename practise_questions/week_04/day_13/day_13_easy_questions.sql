-- ============================================
-- Day 13: Window Functions Part 1 (Ranking) - EASY Level
-- Student Question Bank
-- ============================================
-- Total Questions: 100 (50 Conceptual + 50 Practical)
-- Focus: ROW_NUMBER(), RANK(), DENSE_RANK(), OVER clause, PARTITION BY basics
-- ============================================
-- Concepts ALLOWED:
--   Days 1-12: All previous concepts (SELECT, WHERE, JOINs, Aggregates, 
--              GROUP BY, HAVING, CASE WHEN, Subqueries, CTEs, Set Operations)
--   Day 13: OVER clause, PARTITION BY, ORDER BY in window functions,
--           ROW_NUMBER(), RANK(), DENSE_RANK(), frame clause basics
-- ============================================
-- Concepts NOT ALLOWED:
--   - LEAD(), LAG()
--   - FIRST_VALUE(), LAST_VALUE(), NTH_VALUE()
--   - Running totals (SUM OVER), Moving averages (AVG OVER)
--   - Advanced window frames (ROWS BETWEEN, RANGE BETWEEN)
--   - NTILE, PERCENT_RANK
--   - Transactions, Views, Functions, Procedures
-- ============================================
-- Database: RetailMart (PostgreSQL 16)
-- ============================================

-- =====================
-- CONCEPTUAL QUESTIONS (Q1-Q50)
-- =====================

-- Q1. Flipkart's analytics team is new to window functions. The manager asks: 
-- "What is the fundamental difference between aggregate functions and window functions 
-- in terms of how they handle the result set?"

-- Q2. A junior developer at Zomato is confused about why window functions are called 
-- "window" functions. How would you explain the concept of a "window" over data to them?

-- Q3. BigBasket's data analyst sees ROW_NUMBER() being used in a query. She asks: 
-- "Will ROW_NUMBER() ever produce duplicate numbers for different rows in the same partition?"

-- Q4. Myntra's reporting team is debating whether to use RANK() or DENSE_RANK() for 
-- their fashion designer leaderboard. What is the key difference between these two functions?

-- Q5. An Amazon India intern asks: "If I use ROW_NUMBER() without PARTITION BY, 
-- what happens? Does it throw an error?"

-- Q6. Swiggy's tech lead explains window functions to freshers. He says OVER() is mandatory. 
-- What does the OVER clause actually define for a window function?

-- Q7. PhonePe's analytics team wants to understand: "When we use PARTITION BY in a window 
-- function, does it reduce the number of rows in the output like GROUP BY does?"

-- Q8. Ola's data team notices that ORDER BY inside OVER() behaves differently than 
-- ORDER BY at the end of a query. What is the purpose of ORDER BY within the OVER clause?

-- Q9. A Paytm developer sees this syntax: RANK() OVER (ORDER BY amount DESC). 
-- She asks: "What happens to ties - rows with the same amount value?"

-- Q10. IRCTC's reporting manager asks: "If three passengers have the same booking amount 
-- and I use RANK(), what numbers will they get, and what number will the next passenger get?"

-- Q11. Reliance Retail's analyst is confused: "If I use DENSE_RANK() and three items 
-- have the same sales, what rank does the next different item receive?"

-- Q12. A Flipkart fresher asks: "Can I use ROW_NUMBER() without any ORDER BY inside OVER()? 
-- What would happen to the numbering?"

-- Q13. Zomato's BI team wants to know: "Can we use multiple columns in the ORDER BY 
-- clause inside OVER()? How does that affect ranking?"

-- Q14. BigBasket's data engineer asks: "What is the purpose of PARTITION BY in window functions? 
-- Can you explain with a simple grocery analogy?"

-- Q15. Myntra's junior developer sees: ROW_NUMBER() OVER (PARTITION BY category ORDER BY sales DESC). 
-- She asks: "Does the numbering restart for each category?"

-- Q16. Amazon India's analyst is curious: "If I have 1000 orders and partition by customer_id, 
-- does each customer's orders get numbered starting from 1?"

-- Q17. A Swiggy intern asks: "Can I combine PARTITION BY and ORDER BY in the same OVER clause? 
-- Which one should come first?"

-- Q18. PhonePe's team lead asks freshers: "What's the output type of ROW_NUMBER(), RANK(), 
-- and DENSE_RANK() - is it integer, decimal, or something else?"

-- Q19. Ola's analytics head explains: "RANK() can skip numbers but DENSE_RANK() cannot." 
-- Can you explain this with a simple driver rating example?

-- Q20. Paytm's data analyst wonders: "If all rows in a partition have the same value 
-- for the ORDER BY column, what ranks does RANK() assign?"

-- Q21. IRCTC's developer asks: "Can window functions be used in the WHERE clause 
-- to filter results directly?"

-- Q22. Reliance Retail's fresher sees an error when putting ROW_NUMBER() in WHERE clause. 
-- Why does this happen, and what's the workaround?

-- Q23. Flipkart's manager asks: "If I want only the top 3 products per category, 
-- can I directly filter using ROW_NUMBER() = 3 in WHERE?"

-- Q24. A Zomato analyst needs top 5 restaurants per city. She asks: 
-- "How do I filter window function results if I cannot use WHERE directly?"

-- Q25. BigBasket's BI developer asks: "What is a derived table or subquery approach 
-- for filtering window function results?"

-- Q26. Myntra's tech lead explains: "CTEs work great with window functions for filtering." 
-- Why are CTEs particularly useful when working with window functions?

-- Q27. Amazon India's junior developer asks: "Can I use window functions alongside 
-- regular aggregate functions like SUM() and COUNT() in the same query?"

-- Q28. Swiggy's analyst wonders: "If I use GROUP BY and then apply ROW_NUMBER(), 
-- does the window function work on grouped results or original rows?"

-- Q29. PhonePe's data team asks: "Can we use expressions or calculations inside 
-- the ORDER BY clause of a window function?"

-- Q30. Ola's reporting team asks: "What happens if we use DESC in ORDER BY inside 
-- OVER() for ROW_NUMBER()? Does row 1 become the highest or lowest value?"

-- Q31. A Paytm intern is confused: "Can I give an alias to a window function result 
-- and use that alias in the same SELECT list?"

-- Q32. IRCTC's developer sees: total_amount, RANK() OVER (ORDER BY total_amount DESC) as rnk. 
-- Can he use 'rnk' in another calculation in the same SELECT?

-- Q33. Reliance Retail's analyst asks: "What's the syntax difference between 
-- ROW_NUMBER() OVER() and ROW_NUMBER() OVER (ORDER BY column)?"

-- Q34. Flipkart's data engineer asks: "When would you use PARTITION BY with multiple columns? 
-- Can you give a retail example?"

-- Q35. Zomato's junior analyst asks: "If I partition by city and restaurant_type, 
-- does each unique combination get separate numbering?"

-- Q36. BigBasket's BI team leader explains frame clause basics. 
-- What does "frame clause" mean in the context of window functions?

-- Q37. Myntra's fresher asks: "For ROW_NUMBER(), RANK(), and DENSE_RANK(), 
-- do I need to worry about frame clauses?"

-- Q38. Amazon India's analyst wonders: "Is there a default frame when I don't specify one? 
-- What is that default?"

-- Q39. Swiggy's tech lead asks: "Can I use CASE WHEN expressions inside the 
-- PARTITION BY clause of a window function?"

-- Q40. PhonePe's reporting team asks: "Can window functions be used in the 
-- HAVING clause to filter grouped results?"

-- Q41. Ola's data analyst asks: "What's the execution order - does the window function 
-- run before or after WHERE clause filtering?"

-- Q42. A Paytm developer asks: "If I have NULL values in my ORDER BY column inside OVER(), 
-- where do NULLs appear in the ranking - first or last?"

-- Q43. IRCTC's fresher asks: "Can I use NULLS FIRST or NULLS LAST inside the 
-- ORDER BY clause of a window function?"

-- Q44. Reliance Retail's analyst wants to know: "How do I handle ties differently - 
-- give me a retail scenario where RANK() is better than DENSE_RANK()?"

-- Q45. Flipkart's BI manager asks: "In what business scenario would ROW_NUMBER() 
-- be preferred over RANK() even when there are ties?"

-- Q46. Zomato's data team asks: "Can we use the same window function multiple times 
-- in a single SELECT with different PARTITION BY clauses?"

-- Q47. BigBasket's analyst sees a query with three different ROW_NUMBER() calls. 
-- She asks: "Does this impact performance significantly?"

-- Q48. Myntra's junior developer asks: "Can I use aggregate functions like COUNT(*) 
-- inside the ORDER BY clause of a window function?"

-- Q49. Amazon India's tech lead asks: "What is a 'window specification' and 
-- can it be named and reused?"

-- Q50. Swiggy's fresher asks: "What does WINDOW clause do? Can I define a named 
-- window and use it with multiple functions?"


-- =====================
-- PRACTICAL QUESTIONS (Q51-Q100)
-- =====================

-- Q51. Flipkart's warehouse manager wants to assign a unique sequence number to 
-- each product in the products table, ordered by product name alphabetically. 
-- Help him create this simple numbered list.

-- Q52. Zomato's operations team needs to see all orders with a sequential number 
-- assigned based on order_date (oldest first). They just want order_id, order_date, 
-- and a sequence number.

-- Q53. BigBasket's inventory team wants to rank all products by their current price, 
-- with the most expensive product getting rank 1. Show prod_id, prod_name, price, and rank.

-- Q54. Myntra's fashion analytics team needs to number all customers in the order 
-- they joined (join_date), with the earliest customer as number 1. 
-- Display cust_id, full_name, join_date, and sequence number.

-- Q55. Amazon India's sales team wants to see all orders with their rank based on 
-- total_amount (highest first). They need order_id, total_amount, and the rank.

-- Q56. Swiggy's delivery analytics needs to number all stores by their store_id 
-- in ascending order. Show store_id, store_name, city, and row number.

-- Q57. PhonePe's reporting needs to rank all payments by amount, but they notice 
-- some payments have the same amount. Use RANK() to show payment_id, amount, and rank.

-- Q58. Ola's driver performance team wants to rank employees by salary using DENSE_RANK(). 
-- Show emp_id, emp_name, salary, and dense rank.

-- Q59. Paytm's analytics team needs to see the difference between RANK() and DENSE_RANK() 
-- for products ordered by price. Show prod_name, price, both RANK and DENSE_RANK side by side.

-- Q60. IRCTC's booking team wants to number all customers within each state separately. 
-- Each state should have numbering starting from 1 based on customer join_date.

-- Q61. Reliance Retail's regional manager wants to rank stores within each region 
-- by their store_id. Show store_name, region, and rank within that region.

-- Q62. Flipkart's HR team needs to rank employees within each department by salary 
-- (highest salary gets rank 1). Show emp_name, dept_id, salary, and rank.

-- Q63. Zomato's restaurant team wants to number orders for each customer separately, 
-- based on order_date. Show cust_id, order_id, order_date, and order sequence per customer.

-- Q64. BigBasket's supplier management needs to rank products within each supplier 
-- by price (cheapest first). Display prod_name, supplier_id, price, and rank.

-- Q65. Myntra's customer analytics wants to rank customers within each city by their age 
-- (youngest first). Show full_name, city, age, and rank within city.

-- Q66. Amazon India's logistics team needs to number shipments within each courier company, 
-- ordered by shipped_date. Show shipment_id, courier_name, shipped_date, and sequence.

-- Q67. Swiggy's finance team wants to see all expenses ranked by amount within each store. 
-- Display store_id, expense_type, amount, and rank for stores schema expenses.

-- Q68. PhonePe's campaign team needs to rank marketing campaigns by their budget 
-- (highest first). Show campaign_name, budget, and rank.

-- Q69. Ola's HR analytics wants to number all attendance records for each employee, 
-- ordered by date. Show emp_id, date, status, and sequence number per employee.

-- Q70. Paytm's sales analysis needs the top 3 orders by total_amount. 
-- Use ROW_NUMBER() and filter using a subquery or CTE.

-- Q71. IRCTC's regional analysis needs to find the highest-priced product in each category. 
-- Use RANK() with PARTITION BY category and filter for rank = 1.

-- Q72. Reliance Retail wants to identify the top 2 employees by salary in each department. 
-- Use ROW_NUMBER() partitioned by dept_id and filter appropriately.

-- Q73. Flipkart's inventory team needs the 3 most recently updated inventory records 
-- per store. Use window functions to identify and extract these records.

-- Q74. Zomato's review analytics needs to find the top-rated review for each product 
-- (highest rating, then most recent review_date as tiebreaker).

-- Q75. BigBasket's promotion team needs to rank promotions by discount_percent 
-- (highest first) and show only the top 5 promotions.

-- Q76. Myntra's store analytics wants the newest employee (by emp_id as proxy for hire order) 
-- in each store. Partition by store_id and filter for row number 1.

-- Q77. Amazon India's payment analysis needs to rank payments within each payment_mode 
-- by amount. Show payment_mode, amount, and rank within that payment mode.

-- Q78. Swiggy's customer segmentation needs to assign customers to numbered tiers 
-- within each region based on their loyalty points (highest points = tier 1).

-- Q79. PhonePe's returns analysis wants to rank returned items by refund_amount 
-- within each order. Show order_id, prod_id, refund_amount, and rank.

-- Q80. Ola's salary analysis needs to show each employee's salary rank within their store 
-- and also their overall rank across all stores. Show both ranks side by side.

-- Q81. Paytm's order analysis wants to display orders with three columns: 
-- overall rank by amount, rank within customer, and rank within store.

-- Q82. IRCTC's date analysis needs to number each day's orders sequentially. 
-- Partition by order_date and number by order_id within each date.

-- Q83. Reliance Retail's brand analysis wants to rank products within each brand 
-- by price. Show brand, prod_name, price, and dense rank within brand.

-- Q84. Flipkart's state-wise analysis needs to rank stores within each state 
-- alphabetically by store_name. Show state, store_name, and rank.

-- Q85. Zomato's gender-based analysis wants to rank customers within each gender 
-- by age (oldest first). Show gender, full_name, age, and rank.

-- Q86. BigBasket's click analysis needs to rank email campaigns by their click count 
-- (derived from email_clicks where clicked = true). Show campaign_id and click rank.

-- Q87. Myntra's expense tracking needs to identify the single largest expense for each store 
-- using window functions. Show store_id, expense_type, amount.

-- Q88. Amazon India's shipment tracking wants to find orders with the fastest delivery 
-- (smallest gap between shipped_date and delivered_date) per courier. Use ranking functions.

-- Q89. Swiggy's department analysis needs to rank departments by the count of employees 
-- in each. First aggregate, then rank the results.

-- Q90. PhonePe's monthly analysis needs to number orders within each month 
-- (extract month from order_date). Show order_id, order_date, month, and sequence within month.

-- Q91. Ola's campaign effectiveness needs to rank ad channels by conversions within each campaign. 
-- Show campaign_id, channel, conversions, and rank within campaign.

-- Q92. Paytm's customer loyalty analysis wants to rank customers by total_points, 
-- but only for customers with more than 1000 points. Show cust_id, total_points, and rank.

-- Q93. IRCTC's product review analysis needs to rank products by their average rating. 
-- First calculate average rating, then rank products.

-- Q94. Reliance Retail's address analysis wants to number addresses for each customer 
-- by address_type alphabetically. Show cust_id, address_type, city, and sequence.

-- Q95. Flipkart's revenue analysis needs to rank stores by their total sales from 
-- revenue_summary table. Show store_id, total_sales, and rank.

-- Q96. Zomato's order status analysis wants to rank orders within each status 
-- by total_amount. Show order_status, order_id, total_amount, and rank within status.

-- Q97. BigBasket's supplier analysis needs to show how many products each supplier has, 
-- then rank suppliers by product count (most products = rank 1).

-- Q98. Myntra's quarterly analysis needs to number customers who joined in each quarter. 
-- Use dim_date or extract quarter from join_date, partition by quarter.

-- Q99. Amazon India's city-wise analysis needs to rank customers within each city 
-- by their join_date (earliest = rank 1), showing ties with DENSE_RANK().

-- Q100. Swiggy's comprehensive ranking needs to show employees with their rank by salary 
-- within department, within store, and overall. Display all three ranks for comparison.

-- ============================================
-- END OF DAY 13 EASY QUESTIONS
-- ============================================
