-- ============================================
-- Day 12: Subqueries Part 2 & CTEs - EASY Level
-- Student Question Bank (100 Questions)
-- ============================================
-- Topics Covered: Correlated Subqueries, ANY/SOME/ALL, CTEs (WITH clause), Multiple CTEs, Recursive CTEs
-- 
-- Concepts ALLOWED:
--   - All concepts from Days 1-11 (SELECT, WHERE, JOINs, Aggregates, CASE, Basic Subqueries, Set Operations)
--   - Correlated subqueries
--   - ANY, SOME, ALL operators
--   - WITH clause (Common Table Expressions)
--   - Multiple CTEs in single query
--   - Recursive CTEs (base case + recursive case)
--   - Hierarchical queries
--
-- Concepts NOT ALLOWED:
--   - Window Functions (ROW_NUMBER, RANK, DENSE_RANK, LEAD, LAG, etc.)
--   - OVER clause, PARTITION BY
--   - Transactions, Views, Functions, Procedures
-- ============================================
-- Distribution: 50 Conceptual + 50 Practical Questions
-- ============================================

-- =====================
-- CONCEPTUAL QUESTIONS (Q1-Q50)
-- =====================

-- Q1. Flipkart's training team is explaining subqueries to new analysts. They want to know: what makes a correlated subquery different from a regular subquery? Can you explain with a simple example from daily life, like comparing your salary to the average salary of your department?

-- Q2. BigBasket's data team lead is mentoring a junior developer who asks: "Why does my correlated subquery run so slowly compared to a regular subquery?" Help explain what happens behind the scenes when a correlated subquery executes.

-- Q3. Zomato's analytics team is confused about when to use ANY versus ALL. If a restaurant wants to find dishes priced higher than ANY dish in the "Starters" category versus ALL dishes in "Starters", what's the difference in results?

-- Q4. Amazon India's SQL instructor asks: "If a subquery returns NULL values, how does it affect the behavior of ALL and ANY operators?" What should analysts be careful about?

-- Q5. Paytm's database architect is explaining CTEs to the team. What does CTE stand for, and why might someone call it a "named subquery" or "temporary result set"?

-- Q6. Myntra's reporting team wants to understand: what is the main advantage of using a CTE over writing the same subquery multiple times in different parts of a query?

-- Q7. Reliance Retail's IT head asks during an interview: "Can you explain the basic structure of a CTE? What keyword starts it, and where does the actual query go?"

-- Q8. Swiggy's data science team discusses: "When we write multiple CTEs in one query, do they execute sequentially or all at once?" What's the correct understanding?

-- Q9. IRCTC's technical lead poses a question: "In a recursive CTE, what is the 'anchor member' and what is the 'recursive member'? Why do we need both?"

-- Q10. Ola's analytics manager explains hierarchical data to new joiners. Why are recursive CTEs particularly useful for representing organizational structures like manager-employee relationships?

-- Q11. PhonePe's SQL trainer asks: "What keyword connects the base case and recursive case in a recursive CTE?" Is it AND, OR, or something else?

-- Q12. Flipkart's interview panel asks: "What happens if a recursive CTE doesn't have a proper termination condition? Will PostgreSQL run forever?"

-- Q13. BigBasket's data engineer wonders: "Can I reference a CTE more than once in the main query?" What's the answer?

-- Q14. Zomato's technical team debates: "Is SOME just another name for ANY, or do they work differently?" Clarify this SQL concept.

-- Q15. Amazon India's training module asks: "In the expression 'salary > ALL (subquery)', what does it mean if the subquery returns an empty result set?"

-- Q16. Paytm's analyst asks: "Can a correlated subquery reference columns from multiple outer tables if we have nested queries?" What's the rule?

-- Q17. Myntra's database team discusses: "What's the difference between using EXISTS with a correlated subquery versus using IN with a regular subquery for checking if related records exist?"

-- Q18. Reliance Retail's SQL quiz includes: "In a CTE, can the temporary result set contain aggregated data like totals and averages, or only raw rows?"

-- Q19. Swiggy's junior developer asks: "If I define two CTEs named 'sales_summary' and 'top_products', can the second CTE reference the first one?"

-- Q20. IRCTC's system architect explains: "What is the maximum depth PostgreSQL allows for recursive CTEs by default, and can this be changed?"

-- Q21. Ola's data team wants to know: "When using ALL with a comparison, is 'value > ALL(1, 2, 3)' the same as 'value > 1 AND value > 2 AND value > 3'?"

-- Q22. PhonePe's interview question: "When using ANY with a comparison, is 'value > ANY(1, 2, 3)' the same as 'value > 1 OR value > 2 OR value > 3'?"

-- Q23. Flipkart's SQL bootcamp asks: "Can a CTE be used with INSERT, UPDATE, or DELETE statements, or only with SELECT?"

-- Q24. BigBasket's technical assessment includes: "What does it mean when we say a correlated subquery is 'executed once for each row' of the outer query?"

-- Q25. Zomato's database course asks: "If you want to find employees who earn more than every employee in the Sales department, would you use ANY or ALL?"

-- Q26. Amazon India's quiz: "In a recursive CTE for an employee hierarchy, if an employee has no manager (manager_id is NULL), where does that employee appear in the hierarchy?"

-- Q27. Paytm's learning module: "What's the syntax difference between a non-recursive CTE and a recursive CTE? What keyword makes it recursive?"

-- Q28. Myntra's SQL test: "Can you use ORDER BY inside a CTE definition, or only in the final SELECT that uses the CTE?"

-- Q29. Reliance Retail asks: "When a correlated subquery uses aggregation like AVG() or MAX(), what does it aggregate - all rows in the table or only rows related to the current outer row?"

-- Q30. Swiggy's training: "If a CTE and a physical table have the same name, which one takes precedence in the query?"

-- Q31. IRCTC's SQL fundamentals: "In 'WITH RECURSIVE cte AS (...)', why is the keyword RECURSIVE necessary even though only some CTEs are recursive?"

-- Q32. Ola's interview prep: "What is the UNION ALL doing between the anchor member and recursive member in a recursive CTE?"

-- Q33. PhonePe's concept check: "Can a correlated subquery appear in the SELECT clause, or only in the WHERE clause?"

-- Q34. Flipkart's training: "When using 'price = ANY (subquery)', is it equivalent to 'price IN (subquery)'?"

-- Q35. BigBasket's quiz: "If you need to find categories where ALL products are priced above ₹500, how would the ALL operator help?"

-- Q36. Zomato's learning path: "In a recursive CTE, what happens in each iteration? Does it process one level of hierarchy at a time?"

-- Q37. Amazon India's assessment: "Can multiple CTEs in the same WITH clause have the same column names as each other?"

-- Q38. Paytm's tech interview: "What makes a subquery 'correlated'? Is it the presence of a reference to the outer query, or something else?"

-- Q39. Myntra's SQL workshop: "If a CTE is defined but never used in the main query, does PostgreSQL still execute it?"

-- Q40. Reliance Retail's theory question: "How does PostgreSQL determine when to stop recursion in a recursive CTE?"

-- Q41. Swiggy's concept quiz: "Can you use LIMIT inside a recursive CTE to control how many levels of hierarchy to retrieve?"

-- Q42. IRCTC's SQL basics: "When comparing 'NOT IN (subquery)' vs 'NOT EXISTS (correlated subquery)', which handles NULL values better and why?"

-- Q43. Ola's fundamentals test: "In a CTE, is the result set stored in memory, on disk, or does it depend on the database?"

-- Q44. PhonePe's SQL refresher: "Can you use DISTINCT inside a CTE definition?"

-- Q45. Flipkart's interview: "What is the practical benefit of using CTEs for complex reports compared to nested subqueries?"

-- Q46. BigBasket's assessment: "When would you choose a correlated subquery over a JOIN to solve a problem?"

-- Q47. Zomato's quiz: "In 'value != ALL (subquery)', what does the query check? That value is different from every result, or at least one?"

-- Q48. Amazon India's test: "Can a recursive CTE reference itself multiple times in the recursive member?"

-- Q49. Paytm's learning: "If you write 'WITH a AS (...), b AS (...), c AS (...)' how many CTEs are defined, and can 'c' reference both 'a' and 'b'?"

-- Q50. Myntra's SQL foundations: "What is 'depth-first' vs 'breadth-first' traversal in the context of recursive CTEs for hierarchical data?"


-- =====================
-- PRACTICAL QUESTIONS (Q51-Q100)
-- =====================

-- Q51. Flipkart's HR team wants to identify employees whose salary is higher than the average salary of their own department. The comparison should be specific to each employee's department. Show employee name, salary, and department.

-- Q52. BigBasket's inventory manager needs to find products that are priced higher than the average price of products in the same category. Display product name, price, and category.

-- Q53. Zomato's analytics team wants to list customers who have placed more orders than the average number of orders placed by customers in their same city. Show customer name and city.

-- Q54. Amazon India's sales team needs products whose price is greater than ANY product supplied by supplier_id = 1. Display product name and price.

-- Q55. Paytm's finance team wants to find stores where total expenses exceed ALL stores in the 'South' region. Show store name and city.

-- Q56. Myntra's management wants a simple list of all product categories and their total revenue. Create this using a CTE named 'category_revenue' and then select from it.

-- Q57. Reliance Retail's analyst needs to build a report showing top 5 customers by total purchase amount. First, calculate customer totals in a CTE, then select the top 5.

-- Q58. Swiggy's data team wants to use a CTE to first calculate monthly order counts, then find months where orders exceeded 1000.

-- Q59. IRCTC's HR department maintains a simple employee hierarchy. Using a recursive CTE, show all employees along with their level in the organization (assuming top managers have NULL manager reference in dept_id).

-- Q60. Ola's reporting needs to identify employees who have not taken any leave (no record in attendance with status 'Leave'). Use a correlated subquery with NOT EXISTS.

-- Q61. PhonePe's campaign team wants products that have never been returned. Use EXISTS or NOT EXISTS to find these reliable products.

-- Q62. Flipkart's analyst needs to find stores that have at least one employee earning more than ₹80,000. Use EXISTS with a correlated subquery.

-- Q63. BigBasket's pricing team wants products priced higher than ALL products in the 'Snacks' category. Show product name, category, and price.

-- Q64. Zomato's team needs customers whose total order amount is greater than SOME customer from Mumbai. Display customer name and their total amount.

-- Q65. Amazon India's inventory team wants to list stores where stock quantity for any product is below the average stock quantity for that same product across all stores. Use a correlated subquery.

-- Q66. Paytm's HR wants to find departments where every employee has a salary above ₹40,000. Use ALL operator in your approach.

-- Q67. Myntra needs a report using two CTEs: first CTE calculates total sales per store, second CTE calculates average of those store totals. Then show stores above this average.

-- Q68. Reliance Retail wants to identify products that exist in inventory but have never been ordered. Use a CTE for products in inventory and then check against order_items.

-- Q69. Swiggy's finance team needs stores where expenses are higher than the average expenses of stores in the same region. Show store name, region, and total expenses.

-- Q70. IRCTC's analyst wants to find orders where the total amount is higher than the average order amount for that specific customer. Use a correlated subquery.

-- Q71. Ola's sales head wants to see each store alongside the count of products that are overstocked (stock > 100) in that store. Use a correlated subquery in SELECT.

-- Q72. PhonePe's team needs to find campaigns where ad spend on any channel exceeds ₹50,000. Use EXISTS with a correlated subquery.

-- Q73. Flipkart's category manager wants categories where at least one product is priced above ₹10,000. Use ANY or EXISTS appropriately.

-- Q74. BigBasket's analyst needs to list all customers along with their most recent order date. Use a correlated subquery to find the max order date for each customer.

-- Q75. Zomato's team wants orders placed by customers who have given at least one 5-star review. Use EXISTS to correlate reviews with customers.

-- Q76. Amazon India needs a CTE that lists all departments with their employee count, then selects only departments with more than 5 employees.

-- Q77. Paytm's reporting team wants to create a summary CTE with total payments by payment mode, then find modes that collected more than ₹1,00,000.

-- Q78. Myntra's warehouse team needs to find products where the current stock is less than the total quantity ever ordered for that product. Compare inventory vs order_items using correlated subquery.

-- Q79. Reliance Retail's HR wants employees whose salary is not less than ALL employees in their same role. Show employee name, role, and salary.

-- Q80. Swiggy's analyst needs to identify stores that have never recorded an expense in the 'Marketing' category. Use NOT EXISTS.

-- Q81. IRCTC's team wants to list each product along with the number of distinct stores it's available in. Use a correlated subquery in SELECT.

-- Q82. Ola's manager needs customers who have placed orders worth more than ANY order from the 'Electronics' category. 

-- Q83. PhonePe wants to find suppliers whose products have an average price higher than the overall average product price. Use a CTE for the overall average.

-- Q84. Flipkart's returns team needs products that have been returned more times than the average return count per product. First calculate average in a CTE.

-- Q85. BigBasket's analyst wants to show each region along with its best-performing store (highest total sales). Use a correlated subquery.

-- Q86. Zomato's campaign analyst needs campaigns where all ad channels have achieved at least 100 conversions. Use ALL operator.

-- Q87. Amazon India's team wants a two-CTE query: CTE1 finds customers with more than 5 orders, CTE2 finds their total spending. Combine to show loyal high-spenders.

-- Q88. Paytm's HR needs to identify employees who earn more than at least one employee in a higher-paying role. Use ANY with a salary comparison.

-- Q89. Myntra's inventory team wants stores where every product in inventory has stock greater than 0 (no zero-stock items). Use ALL operator.

-- Q90. Reliance Retail's analyst needs to find products that are available in ALL stores. Use NOT EXISTS to check for missing combinations.

-- Q91. Swiggy's marketing team wants to list each campaign with its ROI (total conversions / budget). Define the calculation in a CTE first.

-- Q92. IRCTC's analyst needs customers whose average order value is higher than their city's average order value. Use correlated subquery.

-- Q93. Ola's finance team wants to find months where total revenue exceeded total expenses. Use two CTEs, one for revenue and one for expenses.

-- Q94. PhonePe's team needs to list products along with the supplier name, but only for products priced higher than the average price of that supplier's products. Use correlated subquery.

-- Q95. Flipkart's team wants to identify customers who have purchased products from every category. Use NOT EXISTS with a double negative approach.

-- Q96. BigBasket's manager needs stores that have recorded expenses on all expense types that exist in the system. Use correlated subquery with NOT EXISTS.

-- Q97. Zomato's analyst wants to find the top 3 most expensive products in each category. Use a CTE to rank and then filter.

-- Q98. Amazon India needs to show each employee alongside the count of other employees who earn more than them in the same store. Use correlated subquery.

-- Q99. Paytm's team wants to list products that have been ordered in every month of 2024 (Jan-Dec). Use a correlated approach to check presence in each month.

-- Q100. Myntra's reporting team wants a comprehensive summary: a CTE for total sales, a CTE for total returns, and a final query showing the net sales figure and return rate percentage.

-- ============================================
-- END OF DAY 12 EASY QUESTIONS
-- ============================================
