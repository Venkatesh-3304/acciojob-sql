-- ============================================
-- Day 14: Window Functions Part 2 (Analytics) - EASY Level
-- Student Question Bank
-- ============================================
-- Total Questions: 100 (50 Conceptual + 50 Practical)
-- ============================================
-- Concepts Allowed:
--   Day 14 (NEW): LEAD(), LAG(), FIRST_VALUE(), LAST_VALUE(),
--                 NTH_VALUE(), SUM() OVER, AVG() OVER, 
--                 ROWS BETWEEN, RANGE BETWEEN, NTILE(),
--                 PERCENT_RANK(), CUME_DIST()
--   Days 1-13: All previous concepts including ROW_NUMBER(),
--              RANK(), DENSE_RANK(), CTEs, Subqueries, JOINs,
--              Aggregates, CASE WHEN, etc.
-- ============================================
-- Concepts NOT Allowed:
--   - Transactions (BEGIN, COMMIT, ROLLBACK)
--   - Views & Materialized Views
--   - Functions (PL/pgSQL)
--   - Stored Procedures
--   - Indexing (CREATE INDEX)
--   - Security (GRANT, REVOKE)
-- ============================================
-- Database: RetailMart (PostgreSQL 16)
-- ============================================

-- =====================
-- CONCEPTUAL QUESTIONS
-- =====================

-- Q1. Flipkart's analytics intern is confused about LAG() function. They want to understand what value LAG() returns when there is no previous row available in the partition.

-- Q2. A Zomato data analyst asks: "If I use LEAD(rating, 2) on restaurant reviews ordered by date, what exactly am I trying to access?"

-- Q3. BigBasket's reporting team wants to understand the difference between ROWS BETWEEN and RANGE BETWEEN in window frames. When would the results differ?

-- Q4. An Amazon India analyst is calculating running totals using SUM() OVER. They notice ORDER BY is mandatory inside OVER clause for this. Why is that?

-- Q5. Myntra's business intelligence team is debating: "What's the default window frame when we specify ORDER BY inside OVER clause but don't explicitly define ROWS BETWEEN?"

-- Q6. PhonePe's data team wants to know: If NTILE(4) is applied to 10 rows, how will the rows be distributed across the 4 buckets?

-- Q7. A Swiggy analyst asks their mentor: "What's the difference between PERCENT_RANK() and CUME_DIST() when calculating percentiles?"

-- Q8. Ola's analytics team is confused about FIRST_VALUE() behavior. Does it respect the window frame or always return the first value of the entire partition?

-- Q9. IRCTC's reporting intern wants to understand: When using LAG() with a default value like LAG(amount, 1, 0), when exactly is the default value used?

-- Q10. Reliance Retail's analyst asks: "If I use LAST_VALUE() without specifying a frame clause, why might I get unexpected results?"

-- Q11. A Paytm data scientist is calculating moving averages. They want to know: What does AVG() OVER (ORDER BY date ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) calculate?

-- Q12. Flipkart's junior analyst is puzzled: "Can I use LAG() and LEAD() in the same query on the same column but with different purposes?"

-- Q13. Zomato's team lead explains window frames. What does ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW mean in simple terms?

-- Q14. BigBasket's analyst wants to understand: What happens if I use NTH_VALUE(column, 3) but my partition has only 2 rows?

-- Q15. Amazon India's BI team asks: "What's the practical difference between using ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING versus a 3-row moving average?"

-- Q16. Myntra's data intern is learning about CUME_DIST(). If a value has CUME_DIST() = 0.75, what does this tell us about the value's position?

-- Q17. PhonePe's analyst queries: "Can I combine PARTITION BY and ORDER BY when using running totals with SUM() OVER?"

-- Q18. Swiggy's reporting team wants to know: When comparing today's orders with yesterday's using LAG(), what column should typically go in the ORDER BY clause?

-- Q19. Ola's business analyst asks: "If I want to see the difference between current row value and the next row value, which function should I use - LAG() or LEAD()?"

-- Q20. IRCTC's data team is calculating cumulative ticket sales. What's the purpose of UNBOUNDED PRECEDING in the window frame?

-- Q21. Reliance Retail's analyst wonders: "Can NTILE() create unequal bucket sizes? If yes, which buckets get the extra rows?"

-- Q22. A Paytm intern asks: "What's the result of LEAD(amount, 1) for the very last row in a partition?"

-- Q23. Flipkart's analytics team debates: "Does PERCENT_RANK() ever return exactly 1.0? If yes, for which row?"

-- Q24. Zomato's data scientist explains: "What does ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING calculate when used with SUM()?"

-- Q25. BigBasket's BI team wants clarity: "If I use FIRST_VALUE() with PARTITION BY category ORDER BY price, what value do I get for each row?"

-- Q26. Amazon India's analyst asks: "When calculating week-over-week growth, should I use LAG() with offset 7 or group by week first?"

-- Q27. Myntra's reporting intern is curious: "Can I use expressions inside LAG() like LAG(quantity * unit_price)?"

-- Q28. PhonePe's data team questions: "What's the difference between AVG(amount) and AVG(amount) OVER() without any partition or order?"

-- Q29. Swiggy's analyst wants to know: "If RANGE BETWEEN is used with ORDER BY on a column with duplicate values, how does it behave differently from ROWS BETWEEN?"

-- Q30. Ola's BI team asks: "Can I reference the result of a LAG() function in the WHERE clause of the same query?"

-- Q31. IRCTC's data analyst wonders: "What is the starting value of PERCENT_RANK() - is it 0 or some other value?"

-- Q32. Reliance Retail's team lead explains: "When might you prefer LAST_VALUE() over simply ordering descending and taking the first row?"

-- Q33. A Paytm analyst asks: "If I partition sales data by region and calculate running totals, does the running total reset for each region?"

-- Q34. Flipkart's data intern questions: "Can I use LEAD() with a negative offset to look at previous rows instead of next rows?"

-- Q35. Zomato's analytics team wonders: "What happens to the window frame calculation if there are NULL values in the ORDER BY column?"

-- Q36. BigBasket's reporting analyst asks: "Is there a maximum limit to the offset value I can use in LAG() or LEAD()?"

-- Q37. Amazon India's BI intern wants clarity: "When using NTH_VALUE(column, 1), is it equivalent to FIRST_VALUE(column)?"

-- Q38. Myntra's data team questions: "Can I use multiple window functions with different PARTITION BY clauses in the same SELECT?"

-- Q39. PhonePe's analyst asks: "What's the difference between ROWS 3 PRECEDING and ROWS BETWEEN 3 PRECEDING AND CURRENT ROW?"

-- Q40. Swiggy's business team wants to know: "When calculating month-over-month comparison, should the LAG() offset be 1 if data is aggregated monthly?"

-- Q41. Ola's data analyst is curious: "Does CUME_DIST() include the current row in its calculation or only rows before it?"

-- Q42. IRCTC's BI team asks: "If I use NTILE(10) to create deciles, what does being in NTILE = 1 mean about that row's value?"

-- Q43. Reliance Retail's analyst wonders: "Can I specify a window frame for RANK() or ROW_NUMBER() functions?"

-- Q44. A Paytm data scientist asks: "What's the relationship between PERCENT_RANK() and the formula (rank - 1) / (total rows - 1)?"

-- Q45. Flipkart's reporting team questions: "If my data has gaps in dates, how does LAG() with offset 1 behave - does it get the previous row or the previous date?"

-- Q46. Zomato's analyst wants clarity: "When using LAST_VALUE() with ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING, do I get the actual last value of the partition?"

-- Q47. BigBasket's data team asks: "Can I use aggregate functions inside LAG() or LEAD(), like LAG(SUM(amount))?"

-- Q48. Amazon India's BI analyst wonders: "What value does PERCENT_RANK() return for a single-row partition?"

-- Q49. Myntra's analytics intern asks: "If I want to calculate percentage change from previous row, which functions do I need to combine?"

-- Q50. PhonePe's data lead explains: "What's the purpose of the IGNORE NULLS option in FIRST_VALUE() and LAST_VALUE()?"


-- =====================
-- PRACTICAL QUESTIONS
-- =====================

-- Q51. Flipkart's sales team wants to see each order along with the previous order's amount for the same customer, to track spending patterns.

-- Q52. Zomato's analytics team needs to display each restaurant's daily rating alongside the next day's rating to spot trends.

-- Q53. BigBasket's operations manager wants a running total of daily expenses for each store throughout 2024.

-- Q54. Amazon India's finance team needs to calculate the cumulative sum of payments received, ordered by payment date.

-- Q55. Myntra's marketing team wants to see each customer's purchase amount along with their first-ever purchase amount for comparison.

-- Q56. PhonePe's risk team needs to display each transaction amount with the previous transaction amount to detect unusual spikes.

-- Q57. Swiggy's business team wants to divide all delivery partners into 4 performance quartiles based on their total deliveries.

-- Q58. Ola's operations team needs a 3-day moving average of ride counts for each city.

-- Q59. IRCTC's revenue team wants to see each day's ticket sales along with the sales from 7 days ago for weekly comparison.

-- Q60. Reliance Retail's HR wants to show each employee's salary alongside the department's highest salary using FIRST_VALUE().

-- Q61. Paytm's analytics team needs to calculate the percentage rank of each merchant based on their transaction volume.

-- Q62. Flipkart's inventory team wants running totals of stock quantities replenished for each product throughout the year.

-- Q63. Zomato's customer success team needs to show each review's rating along with the customer's previous review rating.

-- Q64. BigBasket's finance team wants cumulative revenue by month for the entire company.

-- Q65. Amazon India's logistics team needs to calculate the difference between current shipment date and previous shipment date for each order.

-- Q66. Myntra's product team wants to divide all products into 10 price deciles within each category.

-- Q67. PhonePe's business team needs a 7-day moving average of daily transaction amounts.

-- Q68. Swiggy's HR team wants to show each employee's hire date along with the next hired employee's date.

-- Q69. Ola's analytics team needs cumulative sum of cancellation refunds by month.

-- Q70. IRCTC's operations team wants to display each route's booking count alongside the route's last recorded booking count.

-- Q71. Reliance Retail's sales team needs to show each transaction's amount as a percentile rank within its store.

-- Q72. Paytm's reporting team wants to see each customer's latest transaction amount alongside their first transaction amount.

-- Q73. Flipkart's marketing team needs to divide customers into 5 spending tiers based on their total order value.

-- Q74. Zomato's finance team wants a running sum of ad spend for each marketing campaign.

-- Q75. BigBasket's supply chain team needs the difference between current inventory level and previous inventory level for each product.

-- Q76. Amazon India's customer team wants cumulative count of reviews posted by each customer over time.

-- Q77. Myntra's analytics team needs to show each product's price along with the category's minimum price using FIRST_VALUE().

-- Q78. PhonePe's operations team wants to identify the relative position (percent rank) of each store's daily sales.

-- Q79. Swiggy's business intelligence team needs a 5-order moving average of order amounts for each customer.

-- Q80. Ola's finance team wants to show each payment's amount alongside what the next payment amount was.

-- Q81. IRCTC's analytics team needs to calculate cumulative percentage of total annual revenue by month.

-- Q82. Reliance Retail's operations team wants to divide stores into 3 tiers based on monthly revenue using NTILE.

-- Q83. Paytm's data team needs to display each day's active users count alongside the previous day's count.

-- Q84. Flipkart's warehouse team wants a running count of returns processed for each product category.

-- Q85. Zomato's partner team needs to show each restaurant's commission alongside the city's highest commission using FIRST_VALUE().

-- Q86. BigBasket's HR team wants cumulative count of employees joined per department over time.

-- Q87. Amazon India's seller team needs to calculate the gap (in days) between current and previous order for each seller.

-- Q88. Myntra's loyalty team wants to divide loyalty point holders into quartiles for targeted campaigns.

-- Q89. PhonePe's compliance team needs a 30-day rolling sum of transaction amounts per merchant.

-- Q90. Swiggy's analytics team wants to show each order's delivery time alongside the previous order's delivery time.

-- Q91. Ola's business team needs cumulative sum of ride fares by driver, ordered by ride date.

-- Q92. IRCTC's customer team wants to calculate the percent rank of each customer based on total bookings.

-- Q93. Reliance Retail's category team needs to show each product's sales alongside the category's last product's sales using LAST_VALUE().

-- Q94. Paytm's marketing team wants to display campaign performance with running ROI calculations.

-- Q95. Flipkart's delivery team needs the difference between current delivery date and the next scheduled delivery date.

-- Q96. Zomato's operations team wants to divide orders into 100 percentile buckets for detailed analysis.

-- Q97. BigBasket's finance team needs cumulative expenses by expense category for budget tracking.

-- Q98. Amazon India's returns team wants a running count of returns by reason code.

-- Q99. Myntra's sales team needs to show each order's discount alongside the average discount of the previous 3 orders.

-- Q100. PhonePe's analytics team wants cumulative distribution (CUME_DIST) of merchants by transaction count.


-- ============================================
-- END OF DAY 14 EASY QUESTIONS
-- ============================================
-- Total: 100 Questions (50 Conceptual + 50 Practical)
-- Next Step: Wait for approval before generating solutions
-- ============================================
