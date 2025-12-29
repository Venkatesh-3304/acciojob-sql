-- ============================================
-- Day 11: Subqueries Part 1 - EASY Level
-- Student Question Bank (100 Questions)
-- ============================================
-- Concepts Allowed: SELECT, FROM, WHERE, JOINs (all types), 
--   GROUP BY, HAVING, Aggregates, CASE WHEN, COALESCE, NULLIF,
--   Set Operations (UNION, INTERSECT, EXCEPT), Self Join, Cross Join,
--   Subqueries (scalar, multi-row), IN/NOT IN with subqueries,
--   EXISTS/NOT EXISTS, Subqueries in WHERE/SELECT/FROM
-- Concepts NOT Allowed: Correlated subqueries, ANY/SOME/ALL,
--   CTEs, Window Functions, Transactions, Views, Functions
-- ============================================
-- Database: RetailMart
-- Schemas: core, customers, sales, products, stores, hr, finance, marketing
-- ============================================

-- ===========================================
-- SECTION A: CONCEPTUAL QUESTIONS (Q1-Q50)
-- ===========================================

-- Q1. The training team at Flipkart wants to explain what a subquery is to new SQL learners. In simple terms, how would you describe a subquery?

-- Q2. A junior developer at Zomato is confused about where subqueries can be placed in SQL statements. List the three main clauses where subqueries can appear.

-- Q3. BigBasket's analytics team discusses "scalar subqueries" during a meeting. What makes a subquery "scalar" and what does it return?

-- Q4. During a Myntra interview, the candidate is asked about the difference between a single-row subquery and a multi-row subquery. Explain the key distinction.

-- Q5. PhonePe's database administrator mentions that a subquery is also called a "nested query" or "inner query". What is the query that contains the subquery called?

-- Q6. Ola's tech lead explains that subqueries in the WHERE clause are the most common type. What operators can be used with single-row subqueries in WHERE?

-- Q7. Amazon India's training module asks: when using a multi-row subquery, which operators should be used instead of = or >?

-- Q8. Swiggy's interviewer asks about the EXISTS operator. What does EXISTS check for and what does it return?

-- Q9. IRCTC's database team discusses NOT EXISTS. How does it differ from EXISTS in terms of what it checks?

-- Q10. Reliance Retail's analyst wonders about the execution order - does the inner query execute first or the outer query?

-- Q11. A fresher at Paytm asks: can a subquery return multiple columns? Explain when this is possible.

-- Q12. Flipkart's senior developer explains derived tables. What is a derived table and where does it appear in a SQL statement?

-- Q13. Zomato's tech team discusses when to use IN versus EXISTS. In general, when might EXISTS be preferred?

-- Q14. BigBasket's interviewer asks: what happens if a scalar subquery returns more than one row?

-- Q15. Myntra's SQL test includes this concept: what is the key requirement for using a subquery with the = operator?

-- Q16. PhonePe's training asks: can subqueries be nested inside other subqueries? If yes, is there a limit?

-- Q17. Ola's database quiz asks: when a subquery is used in the SELECT clause, what type must it be?

-- Q18. Amazon's technical screening asks about the NOT IN operator with subqueries. What potential issue should developers be aware of when using NOT IN?

-- Q19. Swiggy's team lead explains that subqueries can sometimes be rewritten as JOINs. What is one advantage of using a JOIN instead?

-- Q20. IRCTC's analyst asks: what is the purpose of giving an alias to a derived table in the FROM clause?

-- Q21. Reliance Digital's interviewer asks: in a subquery that uses aggregate functions, is GROUP BY always required?

-- Q22. Paytm's SQL assessment asks: what will happen if an IN subquery returns an empty result set?

-- Q23. Flipkart's training mentions "correlated subqueries" as an advanced topic. Without using them, explain what makes a subquery "non-correlated"?

-- Q24. Zomato's tech discussion covers subquery placement. Can a subquery appear in the ORDER BY clause?

-- Q25. BigBasket's interviewer asks: when using EXISTS, does it matter what columns the subquery selects?

-- Q26. Myntra's assessment asks: what is the difference between using IN with a list of values versus IN with a subquery?

-- Q27. PhonePe's training module asks: if you need to find records that don't exist in another table, should you use NOT IN or NOT EXISTS? What's the safer choice with potential NULL values?

-- Q28. Ola's database team discusses: can you use LIMIT inside a subquery?

-- Q29. Amazon India asks in their quiz: what must be true about the data types when comparing an outer query column with a subquery result?

-- Q30. Swiggy's technical round asks: when a subquery is used after IN, can it select multiple columns?

-- Q31. IRCTC's SQL practice asks: what is the term for the query that contains the subquery - parent query or outer query?

-- Q32. Reliance Retail's interviewer asks about performance: between a subquery and a JOIN that produce the same result, which typically performs better on large datasets?

-- Q33. Paytm's assessment mentions "query within a query". Is this the same as a subquery?

-- Q34. Flipkart's training asks: in what situation would you prefer a subquery over a JOIN?

-- Q35. Zomato's tech lead asks: can aggregate functions like MAX, MIN, AVG be used inside subqueries?

-- Q36. BigBasket's quiz asks: when using a subquery in the FROM clause, is the alias mandatory or optional in PostgreSQL?

-- Q37. Myntra's interviewer asks: what is the result of NOT EXISTS when the subquery returns at least one row?

-- Q38. PhonePe's training discusses: can you use ORDER BY inside a subquery? When would it make sense?

-- Q39. Ola's assessment asks: what happens when you compare a column with a multi-row subquery using the = operator?

-- Q40. Amazon's technical screening asks: can a subquery reference tables from the outer query in a non-correlated subquery?

-- Q41. Swiggy's SQL quiz asks: what is the maximum nesting level for subqueries in PostgreSQL?

-- Q42. IRCTC's training asks: when would you use a subquery in the SELECT clause to display a calculated value?

-- Q43. Reliance Digital asks: if a subquery returns NULL values and you use NOT IN, what unexpected result might occur?

-- Q44. Paytm's interviewer asks: can you use DISTINCT inside a subquery?

-- Q45. Flipkart's SQL assessment asks: what is meant by "subquery flattening" in query optimization?

-- Q46. Zomato's tech team asks: when using EXISTS, does the subquery need to have a WHERE clause?

-- Q47. BigBasket's training asks: can a subquery in the WHERE clause use columns from tables mentioned in the outer FROM clause?

-- Q48. Myntra's quiz asks: what SQL clause do you use to filter groups when the condition involves a subquery with aggregates?

-- Q49. PhonePe's assessment asks: is it possible to use a subquery as a value in an INSERT statement?

-- Q50. Ola's interview asks: what does it mean when we say subqueries "execute once" versus "execute repeatedly"?

-- ===========================================
-- SECTION B: PRACTICAL QUESTIONS (Q51-Q100)
-- ===========================================

-- Q51. Flipkart's inventory manager needs to find all products whose price is higher than the average price across all products. Help them identify these premium products.

-- Q52. Zomato's customer success team wants to find customers who have placed at least one order. They need a list of customer names who exist in the orders table.

-- Q53. BigBasket's category manager needs to identify products that belong to the same category as product ID 101. Find all such products.

-- Q54. Myntra's sales analyst wants to find the most expensive product in the entire catalog. Display its name and price.

-- Q55. PhonePe's operations team needs to find all stores located in the same city as store ID 1. List these stores.

-- Q56. Ola's HR department wants to identify employees who earn more than the average salary in the company.

-- Q57. Amazon India's fulfillment team needs to find orders that were placed on the same date as order ID 1001. Show the order details.

-- Q58. Swiggy's analytics team wants to find all customers who have never placed any order. These are potential targets for re-engagement campaigns.

-- Q59. IRCTC's revenue team needs to find the order with the highest total amount. Display all details of this order.

-- Q60. Reliance Retail wants to find products supplied by the same supplier as product ID 50. List the product names.

-- Q61. Paytm Mall's team needs to identify all products that have never been ordered. Find products with no matching entries in order_items.

-- Q62. Flipkart's promotion team wants to find products whose price is below the minimum price of products in the 'Electronics' category.

-- Q63. Zomato's regional manager needs to find stores that are in the 'North' region, using the stores table only (not joining with any dimension table).

-- Q64. BigBasket's analyst wants to find customers who joined before the earliest order date in the system.

-- Q65. Myntra's merchandising team needs to find the total number of products that are priced above the average price.

-- Q66. PhonePe's audit team wants to list all payments that are for amounts greater than the average payment amount.

-- Q67. Ola's HR needs to find departments that have at least one employee. List department names.

-- Q68. Amazon's warehouse team wants to find products that have inventory in more than one store (just identify the product IDs).

-- Q69. Swiggy's customer team needs to find customers from the same state as customer ID 100.

-- Q70. IRCTC's finance team wants to identify stores that have recorded expenses. List store IDs that exist in the expenses table.

-- Q71. Reliance Digital's analyst needs to find the product with the lowest price in the 'Clothing' category.

-- Q72. Paytm's marketing team wants to find campaigns that have ads_spend records. List campaign names that appear in the ads_spend table.

-- Q73. Flipkart's returns department needs to find orders that have at least one return recorded. List order IDs.

-- Q74. Zomato's operations wants to find the total revenue from orders placed in the same city as the store with the highest total sales.

-- Q75. BigBasket's inventory team needs to count how many products have stock quantity above the average stock quantity.

-- Q76. Myntra's HR team wants to find employees who work in stores that are located in 'Mumbai'.

-- Q77. PhonePe's analyst needs to find the order ID that has the maximum number of items (based on count of order_items).

-- Q78. Ola's finance team wants to list all expense categories that have been used by at least one store.

-- Q79. Amazon's category team needs to find all products in categories that have more than 10 products.

-- Q80. Swiggy's customer support needs to find customers who have written at least one review.

-- Q81. IRCTC's shipping team wants to find orders that have not been shipped yet (no entry in shipments table).

-- Q82. Reliance Retail's HR needs to find the highest paid employee in each department (showing employee name and department).

-- Q83. Paytm's analyst wants to find products whose price matches the maximum price among all products from the same brand.

-- Q84. Flipkart's regional team needs to list all regions that have at least one store operating.

-- Q85. Zomato's campaign manager wants to find emails sent to customers who have placed more than 5 orders.

-- Q86. BigBasket's pricing team needs to find products that are priced exactly at the average price (rounded to 2 decimals).

-- Q87. Myntra's analytics wants to display each product name along with the overall average product price as a separate column.

-- Q88. PhonePe's operations needs to find customers whose total order value exceeds the average total order value per customer.

-- Q89. Ola's HR team wants to find employees who have never been marked absent (no 'Absent' status in attendance).

-- Q90. Amazon's vendor team needs to find suppliers who supply products in more than one category.

-- Q91. Swiggy's loyalty team wants to find customers whose loyalty points are above the average loyalty points.

-- Q92. IRCTC's sales team needs to find the second highest total_amount among all orders (using subqueries, not LIMIT with OFFSET).

-- Q93. Reliance Digital's inventory team needs to identify stores that don't have any inventory records.

-- Q94. Paytm's marketing wants to find all campaigns that have not received any clicks (conversions = 0 or no ads_spend records).

-- Q95. Flipkart's analyst needs to list products along with a column showing if their price is 'Above Average' or 'Below Average'.

-- Q96. Zomato's HR needs to find employees whose salary is between the minimum and average salary of their department.

-- Q97. BigBasket's delivery team needs to find orders shipped by couriers that have delivered more than 100 orders.

-- Q98. Myntra's finance team needs to find stores whose total expenses exceed the average store expenses.

-- Q99. PhonePe's analyst wants to find customers who have ordered products from every category (using EXISTS).

-- Q100. Ola's strategy team needs to find the store with the highest number of employees and display its details.

-- ============================================
-- END OF DAY 11 EASY QUESTIONS
-- ============================================
