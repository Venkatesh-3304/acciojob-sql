-- ============================================
-- Day 12: Subqueries Part 2 & CTEs - MEDIUM Level
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

-- Q1. Flipkart's HR analytics team is building an employee performance dashboard. They need to identify employees whose salary exceeds the average salary of employees in their same department, but only for departments with more than 10 employees. Show employee name, department, salary, and how much above the department average they earn.

-- Q2. BigBasket's category management team wants to discover products that are priced at least 20% higher than the average price of their category. Additionally, these products should have been ordered at least once. Display product name, category, price, and the category average for comparison.

-- Q3. Zomato's customer success team is analyzing order patterns. They need customers whose total spending exceeds the average spending of customers who joined in the same year. Include customer name, join year, total spent, and the join-year average.

-- Q4. Amazon India's warehouse optimization team wants to find stores where the total inventory value (sum of stock_qty × price for all products) is greater than ANY store in the 'North' region. Show store name, city, and total inventory value.

-- Q5. Paytm's finance compliance team needs to identify payment transactions where the amount is higher than ALL payments made through 'Cash' payment mode. Display payment details including order_id and amount.

-- Q6. Myntra's seasonal planning team needs a report showing monthly sales trends. Create a CTE that calculates total sales per month, then identify months where sales exceeded ₹10,00,000. Show month, year, and total sales.

-- Q7. Reliance Retail's vendor management team wants to analyze supplier performance. Using a CTE, calculate the average product price per supplier, then find suppliers whose average exceeds the overall average across all suppliers.

-- Q8. Swiggy's operations team is tracking delivery performance. Create a CTE listing orders with their shipment delivery times (delivered_date - shipped_date), then find orders where delivery took longer than the average delivery time.

-- Q9. IRCTC's organizational development team needs to visualize the company hierarchy. Using a recursive CTE, show all employees with their reporting chain and level in the hierarchy. Employees with NULL in their manager reference are at level 1.

-- Q10. Ola's revenue assurance team wants to find customers who have placed orders at every store in their city. Use correlated subqueries to verify this "all stores" condition for each customer.

-- Q11. PhonePe's product team needs to identify products that have never received a rating below 3. Use NOT EXISTS to find these consistently well-reviewed products, showing product name and category.

-- Q12. Flipkart's promotional planning team wants products whose price is less than the maximum price of any product in the 'Accessories' category but greater than the minimum price in 'Electronics'. Use ANY/ALL appropriately.

-- Q13. BigBasket's loss prevention team needs to identify stores where return amounts exceed the average return amount of stores in the same region. Show store name, region, and total return amount.

-- Q14. Zomato's marketing ROI team is evaluating campaigns. Using two CTEs - one for campaign spending and one for campaign conversions - calculate the cost per conversion for each campaign and find those with cost per conversion below ₹100.

-- Q15. Amazon India's inventory planning team needs products where current stock is less than 50% of the maximum stock ever recorded for that product across all stores. Use a correlated subquery against the inventory history.

-- Q16. Paytm's customer retention team wants to find customers whose average order value has decreased over time - specifically, customers where their recent orders (2024) average less than their historical average (before 2024). Use multiple CTEs.

-- Q17. Myntra's pricing analytics team needs to identify products priced higher than ALL products from the same brand that were added in the last 6 months. This helps spot pricing inconsistencies within brands.

-- Q18. Reliance Retail's workforce analytics team wants employees who earn more than the median-approximated salary (average of employees earning above and below them) in their department. Use correlated subqueries creatively.

-- Q19. Swiggy's regional expansion team needs to compare store performance. Create a CTE ranking stores by total sales in each region, then show the top 3 stores per region (use LIMIT and filtering, not window functions).

-- Q20. IRCTC's succession planning team needs to find employees who could be promoted - specifically, those whose salary is higher than at least one (ANY) employee at a more senior role in their department.

-- Q21. Ola's fraud detection team wants to identify orders where the payment amount differs from the order total by more than 5%. For each such order, show the order details and the discrepancy amount using a correlated approach.

-- Q22. PhonePe's campaign effectiveness team needs campaigns where ALL channels (in ads_spend) achieved positive ROI (conversions > clicks / 10). Use ALL operator with a subquery.

-- Q23. Flipkart's vendor payment team needs suppliers whose products have generated total revenue (from order_items) exceeding ₹50,00,000. Use a CTE to calculate product-level revenue first.

-- Q24. BigBasket's customer insights team wants to find customers who have purchased products from more categories than the average customer. Show customer name and their category count.

-- Q25. Zomato's store performance team needs stores where average employee salary exceeds the company-wide average salary, but only for stores with at least 5 employees.

-- Q26. Amazon India's returns analytics team wants to identify products with return rate higher than the average return rate for their category. Calculate return rate as (returned quantity / ordered quantity) using correlated subqueries.

-- Q27. Paytm's geographic analytics team needs regions where total sales exceed ALL other regions. Display region name and total sales amount.

-- Q28. Myntra's loyalty program team wants customers whose loyalty points are in the top 25% (above 75th percentile approximation). Use a CTE to calculate the threshold and then filter.

-- Q29. Reliance Retail's expense management team needs to find expense categories where spending has exceeded budget for at least 3 stores. Use correlated subqueries with COUNT.

-- Q30. Swiggy's delivery optimization team wants orders shipped by couriers whose average delivery time is faster than the overall average. First identify fast couriers in a CTE, then find their orders.

-- Q31. IRCTC's compensation analysis team needs employees whose salary increase (comparing salary_history records) percentage exceeds the average increase percentage in their department.

-- Q32. Ola's product assortment team wants to find stores that stock ALL products in the 'Electronics' category. Use NOT EXISTS to verify no electronics product is missing from a store's inventory.

-- Q33. PhonePe's customer acquisition team needs to identify months where new customer sign-ups (based on join_date) exceeded the 3-month moving average. Use multiple CTEs for this calculation.

-- Q34. Flipkart's email marketing team wants customers who opened at least one email but never clicked. Use EXISTS and NOT EXISTS in combination.

-- Q35. BigBasket's inventory replenishment team needs products where stock has fallen below the reorder point (defined as 20% of maximum historical stock for that product). Use correlated subquery.

-- Q36. Zomato's competitive pricing team wants products priced within ₹100 of ANY competitor's product in the same category. Products from other suppliers represent "competitors."

-- Q37. Amazon India's HR planning team needs departments where total salary expenditure exceeds ₹50,00,000 and every employee earns above the minimum wage (₹25,000). Use ALL operator.

-- Q38. Paytm's reconciliation team needs orders where payment amount equals the order total exactly, and the payment was made within 24 hours of order placement. Use correlated subquery to match orders and payments.

-- Q39. Myntra's supplier evaluation team wants suppliers whose average product rating (from reviews) is higher than ALL suppliers in their same category. Show supplier name and average rating.

-- Q40. Reliance Retail's promotional effectiveness team needs promotions where at least 50% of associated products saw increased sales during the promotion period. Use correlated subquery with conditional counting.

-- Q41. Swiggy's customer segmentation team needs to categorize customers into spending tiers using a CTE: 'Platinum' (top 10% spenders), 'Gold' (next 20%), 'Silver' (next 30%), 'Bronze' (rest). Show customer name and tier.

-- Q42. IRCTC's workforce distribution team wants to find departments where employee count exceeds the average department size, but the average salary is below the company average. Use multiple conditions with CTEs.

-- Q43. Ola's revenue leakage team needs orders where discount applied (from order_items) is higher than ANY promotion discount that was active on the order date. This identifies unauthorized discounts.

-- Q44. PhonePe's product profitability team needs products where profit margin (price minus supplier cost approximated as 70% of price) is higher than the category average margin. Use CTE for calculation.

-- Q45. Flipkart's seasonal inventory team wants products that were ordered in December 2024 but had zero stock (inventory) as of January 2025. Use EXISTS with date filtering.

-- Q46. BigBasket's customer loyalty team needs customers who have made purchases in ALL quarters of 2024 (Q1, Q2, Q3, Q4). Use NOT EXISTS to check for missing quarters.

-- Q47. Zomato's store expansion analytics needs cities where total sales exceed ₹1 crore but where no store has more than 30% market share of that city's sales. Use CTEs and correlated subqueries.

-- Q48. Amazon India's review authenticity team wants to find customers who have reviewed more than 5 products but whose reviews all have the same rating. Use GROUP BY and HAVING with correlated approach.

-- Q49. Paytm's payment gateway team needs to identify payment modes where average transaction value is higher than SOME (at least one) other payment mode's average. Show payment mode and its average.

-- Q50. Myntra's dead stock identification team wants products that exist in inventory (stock > 0) but haven't been ordered in the last 90 days. Use NOT EXISTS with date calculation.

-- Q51. Reliance Retail's staff scheduling team wants stores where total employee count exceeds the store's daily average order count. Both metrics should be calculated using correlated subqueries.

-- Q52. Swiggy's customer win-back team needs inactive customers - those who haven't ordered in 60 days but whose historical average order value was above ₹2000. Use CTEs for both conditions.

-- Q53. IRCTC's product bundling team wants pairs of products that are frequently ordered together. Find products where more than 30% of orders containing Product A also contain Product B. Use correlated subqueries.

-- Q54. Ola's employee retention team needs to identify employees who have received salary increases every year they've been employed. Use recursive or iterative logic with EXISTS.

-- Q55. PhonePe's market basket analysis needs customers whose average basket size (items per order) exceeds the store average where they most frequently shop. Use multiple correlated subqueries.

-- Q56. Flipkart's supplier diversification team wants categories where more than 80% of products come from a single supplier. Identify concentration risk using correlated subquery with COUNT.

-- Q57. BigBasket's dynamic pricing team needs products where price changes would affect revenue significantly - products where a 10% price increase would still keep them below ANY competitor's price in the category.

-- Q58. Zomato's HR equity team needs to identify pay disparities - employees whose salary is more than 50% below the average salary for their role, excluding part-time roles.

-- Q59. Amazon India's shipping optimization team wants orders where actual delivery time exceeded the promised delivery time (assume 5 days standard). Show order details and delay in days.

-- Q60. Paytm's campaign overlap analysis needs campaigns that were running simultaneously (overlapping dates) and targeted the same customers. Use CTEs to identify overlaps.

-- Q61. Myntra's inventory turnover analysis needs products where days of inventory (current stock / average daily sales) exceeds 90 days. Calculate using correlated subquery for daily sales.

-- Q62. Reliance Retail's new product launch team wants to compare new products (added in last 90 days) against established products - specifically, new products whose sales exceeded the average sales of established products in their category.

-- Q63. Swiggy's payment reconciliation team needs orders where total payment received (from payments table) differs from order total amount. Show order_id and the difference.

-- Q64. IRCTC's capacity planning team needs departments that have grown by more than 20% in headcount over the last year. Compare current employee count with a correlated historical count.

-- Q65. Ola's cross-selling team needs customers who bought products from Category A but never from Category B. Use EXISTS and NOT EXISTS combination.

-- Q66. PhonePe's churn prediction team needs customers whose order frequency has decreased - customers placing fewer orders in recent 3 months compared to the 3 months before. Use multiple CTEs.

-- Q67. Flipkart's vendor SLA team wants suppliers whose products have an average delivery time longer than ALL suppliers in the 'Premium' tier (assume top 5 suppliers by revenue).

-- Q68. BigBasket's store comparison team needs a report showing each store's sales as a percentage of total company sales. Use a CTE for total sales and correlated calculation for each store.

-- Q69. Zomato's review quality team wants products where the average review length (character count of review_text) is shorter than the category average. Use correlated subquery with LENGTH function.

-- Q70. Amazon India's express delivery team needs to identify regions where more than 50% of orders were delivered within 2 days. Use conditional aggregation in a CTE.

-- Q71. Paytm's merchant analytics team needs stores whose revenue per employee exceeds the company average revenue per employee. Use multiple calculations with CTEs.

-- Q72. Myntra's markdown optimization team wants products where current price is less than the average of ALL historical prices for that product (from a price history perspective based on order_items unit_price).

-- Q73. Reliance Retail's operational efficiency team needs stores where expense-to-revenue ratio is better (lower) than ANY store in a larger city. Use correlated subquery with city comparison.

-- Q74. Swiggy's customer acquisition cost analysis needs campaigns where the cost per new customer acquired is lower than the company average. Define "new customer" as first order coinciding with campaign period.

-- Q75. IRCTC's product lifecycle team wants products that have been in the catalog for more than 1 year but have never achieved monthly sales of more than 100 units. Use NOT EXISTS with temporal logic.

-- Q76. Ola's regional parity team needs to ensure no region has average order value more than 2x ANY other region's average. Identify regions violating this using ALL operator.

-- Q77. PhonePe's supplier credit team needs suppliers whose products have total outstanding return refunds (returns not yet processed) exceeding ₹1,00,000. Use CTE to aggregate returns by supplier.

-- Q78. Flipkart's employee productivity team wants to identify salespeople (role = 'Sales') whose associated store's sales exceed the average sales of all stores by more than 20%. Use correlated subquery.

-- Q79. BigBasket's assortment optimization team needs stores missing high-performing products - products in the top 10% by sales that are not in a particular store's inventory. Use NOT EXISTS with CTE.

-- Q80. Zomato's customer feedback loop needs customers who gave low ratings (1-2) but continued to purchase. Use EXISTS to find customers with both low reviews AND subsequent orders.

-- Q81. Amazon India's competitive intelligence team wants price points where they have no products but competitors (other brands in same category) do. Use NOT EXISTS creatively.

-- Q82. Paytm's loyalty program ROI team needs to compare spending patterns: customers with loyalty points vs without. Create two CTEs and compute average spending for each group.

-- Q83. Myntra's supply chain team wants products where lead time (time between order and shipment) varies significantly across orders - standard deviation proxy using MAX-MIN approach with correlated subquery.

-- Q84. Reliance Retail's franchisee performance team needs stores outperforming their regional average but underperforming the national average. Use multiple correlated subqueries.

-- Q85. Swiggy's menu engineering team wants products contributing to 80% of category revenue (Pareto principle). Use CTE to calculate running totals and identify the vital few.

-- Q86. IRCTC's skill gap analysis needs departments where no employee has been with the company for more than 2 years. Use NOT EXISTS to find departments lacking experience.

-- Q87. Ola's pricing elasticity team wants products where a 10% discount (in promotions) resulted in more than 20% increase in quantity sold. Compare promotion vs non-promotion periods.

-- Q88. PhonePe's fraud pattern analysis needs customers whose average payment amount suddenly increased by more than 3x their historical average. Use CTE for historical vs recent comparison.

-- Q89. Flipkart's inventory optimization team wants to find the optimal reorder quantity for each product based on average monthly sales. Use CTE to calculate monthly averages and recommend stock levels.

-- Q90. BigBasket's customer profitability analysis needs customers whose return rate (returns/orders) is higher than their city's average return rate. Unprofitable customers to watch.

-- Q91. Zomato's A/B test analysis needs to compare campaigns: campaigns with budget > ₹5 lakhs vs campaigns with budget <= ₹5 lakhs. Show average conversion rate for each group using CTEs.

-- Q92. Amazon India's inventory aging team wants products where oldest stock (earliest last_updated date) is more than 180 days old. Identify stale inventory using correlated subquery.

-- Q93. Paytm's payment success team needs to identify payment modes where success rate (successful payments / total attempts) exceeds the overall average success rate.

-- Q94. Myntra's brand health team wants brands where average product rating exceeds ALL other brands in the same category. Use ALL operator for this top-performing brand identification.

-- Q95. Reliance Retail's holiday planning team needs to identify dates (from dim_date) where sales historically exceeded 200% of average daily sales. Use CTE for average and correlated comparison.

-- Q96. Swiggy's operational excellence team wants stores where every expense category has stayed within budget (expense < budgeted amount, assume budget = 1.2 × average expense). Use ALL operator.

-- Q97. IRCTC's succession planning hierarchy needs to show each employee with the complete chain of command above them, concatenated as a path string. Use recursive CTE with STRING_AGG.

-- Q98. Ola's geographic expansion analysis needs cities where customer acquisition rate (new customers per month) has consistently increased for 3 consecutive months. Use multiple CTEs with self-comparison.

-- Q99. PhonePe's risk assessment team needs customers whose order-to-payment time (days between order and payment) is longer than ALL other customers in their city. Identify slow payers.

-- Q100. Flipkart's comprehensive business review needs a multi-CTE query that calculates: total revenue (CTE1), total costs (CTE2), total returns (CTE3), and then computes net profit margin percentage in the final SELECT.

-- ============================================
-- END OF DAY 12 MEDIUM QUESTIONS
-- ============================================
