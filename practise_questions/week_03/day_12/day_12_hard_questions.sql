-- ============================================
-- Day 12: Subqueries Part 2 & CTEs - HARD Level
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

-- Q1. Flipkart's executive compensation committee needs to identify salary outliers across the organization. An employee is considered an outlier if their salary differs from their department's average by more than 2 standard deviations. Without using window functions, construct a query using correlated subqueries to calculate each employee's deviation from their department mean and flag outliers. Consider how to handle departments with only one employee.

-- Q2. BigBasket's market intelligence team is analyzing competitive positioning. They need products priced in the "sweet spot" - higher than the lowest 25% of products in their category but lower than the highest 25%. Using CTEs to establish these percentile boundaries (without window functions), identify products in this middle 50% price range along with their exact position between the bounds.

-- Q3. Zomato's customer lifetime value team needs a sophisticated analysis. Calculate each customer's CLV as their total spending minus estimated acquisition cost (₹500 for customers acquired through campaigns, ₹200 for organic). Then find customers whose CLV exceeds the average CLV of customers in their cohort (same join month). Use multiple CTEs and correlated subqueries.

-- Q4. Amazon India's supply chain resilience team wants to identify "critical suppliers" - suppliers where if they stopped supplying, at least one store would have zero products in at least one category. Use NOT EXISTS with complex correlation to find these single-point-of-failure suppliers.

-- Q5. Paytm's fraud analytics team needs to identify suspicious payment patterns. Find customers where the variance of their payment amounts is greater than ALL customers whose average payment is within ₹1000 of their own average. This isolates erratic spenders among similar-value customers.

-- Q6. Myntra's inventory management needs a reorder point system. Using recursive CTEs, simulate inventory depletion over 30 days assuming average daily sales rate. Identify products that would hit zero stock within this period and show the predicted stockout date.

-- Q7. Reliance Retail's organizational analysis needs a complete hierarchy report. Using recursive CTE, show each employee with their complete management chain (all levels up to CEO), their depth level, and the total number of direct and indirect reports below them. Calculate reports count using correlated subquery.

-- Q8. Swiggy's seasonality analysis requires identifying products with counter-cyclical demand - products that sell MORE in traditionally slow months (Feb, Jun, Sep, Nov) than in peak months. Use CTEs to categorize months and compare average sales between seasonal groups.

-- Q9. IRCTC's pricing strategy team needs products where pricing follows a pattern: current price is lower than the average of recent transactions but higher than older transactions. Compare last 30 days average vs 60-90 days ago average using order_items unit_price as price proxy.

-- Q10. Ola's retention team needs to identify "at-risk" customers using multiple signals: customers where (a) days since last order > 2× their average inter-order gap, AND (b) last order value < their personal average, AND (c) no email engagement in last 30 days. Combine multiple correlated subqueries.

-- Q11. PhonePe's A/B testing needs a sophisticated comparison. For each campaign, calculate the conversion rate, then find campaigns where conversion rate is higher than ALL campaigns with smaller budgets but lower than SOME campaigns with larger budgets. This identifies "optimal budget" campaigns.

-- Q12. Flipkart's vendor negotiation team needs leverage analysis. Find products where the supplier's price (approximated as 60% of retail price) would exceed the average retail price of competing products in the same category. These are overpriced supplier relationships.

-- Q13. BigBasket's store clustering analysis needs stores with similar sales patterns. Two stores are "similar" if their top 3 selling categories are identical. Using CTEs to identify each store's top categories, find pairs of similar stores without using self-join (use correlated EXISTS instead).

-- Q14. Zomato's delivery promise optimization needs to identify cities where average actual delivery time exceeds the promised time (3 days) by more than 50%. Additionally, within those cities, find the worst-performing courier. Use multiple CTEs with city-level and courier-level analysis.

-- Q15. Amazon India's assortment gap analysis needs to find "holes" in their catalog - category-brand combinations that exist at competitor stores (other stores) but not at a given store. Use NOT EXISTS with complex correlation across multiple dimensions.

-- Q16. Paytm's revenue concentration risk needs customers who contribute more than 5% of their city's total revenue but whose order frequency is below their city average. These high-value, low-frequency customers represent volatility risk.

-- Q17. Myntra's promotional calendar team needs to identify promotion conflicts. Find pairs of promotions with overlapping dates where the combined discount on any single product would exceed 40%. Use CTEs to calculate overlapping periods and correlated subquery for product-level discount.

-- Q18. Reliance Retail's labor cost optimization needs stores where labor cost per order exceeds the regional benchmark. Labor cost is total employee salaries, orders from sales.orders. Calculate both metrics using correlated subqueries and compare.

-- Q19. Swiggy's supplier diversification analysis needs categories where Herfindahl-Hirschman Index (sum of squared market shares) exceeds 0.25, indicating concentration. Calculate each supplier's market share within category and the HHI using CTEs.

-- Q20. IRCTC's employee performance curve needs employees whose sales performance (orders at their store) is in the top quartile for their department but whose salary is in the bottom half of their department. Use CTEs for quartile boundaries.

-- Q21. Ola's cannibalization analysis needs products where launch coincided with decline in similar products' sales. Find products where in the month of their first order, other products in the same category experienced >20% sales drop compared to the previous month.

-- Q22. PhonePe's customer migration analysis needs customers who upgraded their spending tier (from Bronze to Silver, Silver to Gold, etc.) within 6 months of joining. Define tiers based on cumulative spending percentiles calculated via CTEs.

-- Q23. Flipkart's returns prediction model needs products where return rate increases with order size - products where orders with quantity > 3 have higher return rate than orders with quantity <= 3. Use correlated subqueries for conditional return rate calculation.

-- Q24. BigBasket's marketing attribution needs customers whose first order was within 7 days of a campaign end date, for each campaign. This attributes acquisitions to campaigns. Use correlated subqueries with date arithmetic.

-- Q25. Zomato's capacity planning needs to identify dates where demand exceeded capacity by more than 20%. "Capacity" is 10× store employee count. Demand is order count. Find such dates for each store using correlated subqueries.

-- Q26. Amazon India's inventory velocity analysis needs products with inconsistent turnover - products where the standard deviation of monthly sales (approximated as MAX-MIN range / 4) exceeds 50% of average monthly sales. High-volatility products.

-- Q27. Paytm's customer concentration by payment mode needs to find payment modes where top 10% of users account for more than 50% of transaction value. Use CTEs to identify top users per mode and calculate concentration.

-- Q28. Myntra's dead inventory recovery needs products that haven't sold in 90 days but were previously selling well (average monthly sales > 50 before going dormant). Identify "fallen stars" using temporal correlated subqueries.

-- Q29. Reliance Retail's territory optimization needs to identify cities where adding one more store would reduce average per-store sales to below profitability threshold (₹10 lakh). Calculate current per-store sales and project impact.

-- Q30. Swiggy's menu depth analysis needs categories with "long tail" - categories where products ranked beyond top 10 by sales collectively account for less than 20% of category sales. Use CTEs to rank and aggregate.

-- Q31. IRCTC's salary compression analysis needs job roles where the difference between maximum and minimum salary is less than 20% of the average salary. This indicates compressed pay scales needing review.

-- Q32. Ola's repeat purchase analysis needs products with low first-time buyer conversion to repeat buyer. Find products where less than 30% of customers who bought it once, bought it again within 90 days.

-- Q33. PhonePe's engagement ladder analysis needs customers who have progressed through engagement stages: (1) email received, (2) email opened, (3) email clicked, (4) made purchase. Find customers who completed all stages in sequence.

-- Q34. Flipkart's supplier quality scorecard needs suppliers ranked by a composite score: 0.4 × (on-time delivery rate) + 0.3 × (return rate inverse) + 0.3 × (average rating). Calculate each component using correlated subqueries and CTEs.

-- Q35. BigBasket's geographic penetration needs to identify states where market penetration (customers / population estimate based on avg customers per city × city count) is below 0.1%. Use CTEs for population proxy calculation.

-- Q36. Zomato's price elasticity estimation needs products where a 10% price increase (from promotions analysis) correlated with more than 15% volume decrease. Compare promotion period volumes with regular period volumes.

-- Q37. Amazon India's cashflow timing analysis needs to identify payment mode preferences by customer value segment. For each value segment (defined by total spending quartile), find the most common payment mode using correlated subqueries.

-- Q38. Paytm's churn prediction needs customers exhibiting "death spiral" pattern: decreasing order frequency AND decreasing order value AND no engagement with campaigns. Use three correlated subqueries to check each condition.

-- Q39. Myntra's store portfolio optimization needs stores that are "portfolio redundant" - stores where more than 80% of their customers have also purchased from another store within 50km (same city as proxy). Use correlated EXISTS.

-- Q40. Reliance Retail's compensation competitiveness needs roles where internal salary midpoint is more than 10% below market (approximated as average salary for that role across all companies/stores). Flag underpaid roles.

-- Q41. Swiggy's order sequence analysis needs to find the most common "next purchase" category for each category. After buying from Category A, what category does the customer most often buy next? Use correlated subqueries with order date comparison.

-- Q42. IRCTC's budget variance analysis needs departments where actual expenses exceeded budgeted (assume budget = 1.1 × previous year average) in more than 3 months. Use temporal correlated subqueries with conditional counting.

-- Q43. Ola's product association rules need pairs of products with support > 5% (appear together in 5% of orders) and confidence > 50% (if A bought, 50% chance B also bought). Use CTEs for basket analysis metrics.

-- Q44. PhonePe's payment timing analysis needs to identify customers who consistently pay late - customers where more than 70% of their orders have payment_date > order_date + 3 days. Use correlated conditional counting.

-- Q45. Flipkart's customer share-of-wallet estimation needs customers whose spending at Flipkart (total orders) represents less than estimated 30% of their retail budget (estimated from demographic proxy: age × ₹1000 monthly). Find under-penetrated customers.

-- Q46. BigBasket's supplier dependency risk needs stores where more than 40% of inventory value comes from a single supplier. Use correlated subqueries to calculate concentration for each store-supplier combination.

-- Q47. Zomato's review sentiment proxy needs products where average rating trend is negative - products where average rating in recent 30 days is lower than average rating in the 30 days before that. Early warning for quality issues.

-- Q48. Amazon India's shipping cost optimization needs to identify regions where average shipment cost per order (courier fees, assume ₹50 per shipment) exceeds 10% of average order value. Use CTEs for both metrics by region.

-- Q49. Paytm's LTV:CAC analysis needs customer cohorts (by join month) where LTV (total spending) / CAC (₹500 for campaign-acquired, ₹200 otherwise) ratio exceeds 3:1. Calculate using multiple CTEs.

-- Q50. Myntra's size-curve optimization needs products where the most-sold size variant accounts for more than 60% of sales. These products have skewed size distribution indicating inventory planning issues.

-- Q51. Reliance Retail's workforce stability needs departments with high turnover indicator - departments where more than 30% of employees have tenure (based on earliest salary_history date) less than 1 year.

-- Q52. Swiggy's menu rationalization needs categories with "paradox of choice" - categories with more than 20 products but where top 5 products account for more than 80% of sales. Too many underperforming products.

-- Q53. IRCTC's performance management needs employees who have been with the company for more than 2 years but have never received a salary increase (only one record in salary_history). Use NOT EXISTS to identify stagnant careers.

-- Q54. Ola's customer effort analysis needs orders where customers had to make multiple payment attempts (more than one payment record for same order). Use correlated COUNT with HAVING equivalent logic.

-- Q55. PhonePe's campaign incrementality needs to measure true campaign impact by comparing: customers who saw AND responded to campaign vs customers who saw but didn't respond. Calculate average spending difference using CTEs.

-- Q56. Flipkart's inventory health score needs products scored by: freshness (days since last inventory update inverse) + availability (stores stocking / total stores) + turnover (orders / stock). Use multiple CTEs for component scores.

-- Q57. BigBasket's customer fatigue analysis needs customers who opened but didn't click on more than 5 consecutive emails. Use correlated subqueries to check sequential email engagement patterns.

-- Q58. Zomato's price point gap analysis needs to identify price ranges (₹0-100, ₹100-500, ₹500-1000, etc.) within each category where they have fewer products than the category average per price range. Find underserved price points.

-- Q59. Amazon India's subscription potential needs customers whose purchase pattern is highly regular - customers where the standard deviation of days between consecutive orders (approximated via MAX gap - MIN gap) is less than 7 days.

-- Q60. Paytm's network effect analysis needs cities where customer count growth rate exceeds revenue growth rate by more than 20 percentage points. This indicates increasing customer base but decreasing per-customer spending.

-- Q61. Myntra's brand portfolio analysis needs brands that are "trapped in the middle" - brands where they're neither in the top 3 by revenue nor in the top 3 by volume in their category. Use correlated rankings.

-- Q62. Reliance Retail's shift scheduling needs stores where peak orders (orders per day > store average × 1.5) occur on weekends more than 60% of the time. Use CTEs for peak identification and day-of-week analysis.

-- Q63. Swiggy's new product success needs to identify products that achieved "escape velocity" - products where monthly sales in month 3 after launch exceeded month 1 sales by more than 50%. Growing products vs dying products.

-- Q64. IRCTC's span of control analysis needs managers (employees who have direct reports) whose direct report count exceeds the company average span of control by more than 2×. Use recursive CTE for hierarchy and correlated count.

-- Q65. Ola's payment method evolution needs customers who switched their primary (most-used) payment mode within the last 6 months. Compare recent payment mode preferences vs historical using CTEs.

-- Q66. PhonePe's geographic arbitrage needs products with price variance across stores greater than 15% of average price. Use correlated subqueries to calculate price range for each product.

-- Q67. Flipkart's customer acquisition efficiency needs campaigns where cost per acquired customer (budget / new customers in campaign period) is lower than ALL campaigns in the previous quarter. Best performing campaigns.

-- Q68. BigBasket's stockout cost estimation needs to identify missed sales: orders for products that were out of stock (stock = 0 at time of order). Use correlated subquery joining orders with inventory state.

-- Q69. Zomato's customer win probability needs to score leads based on similarity to converted customers. For each non-purchasing visitor (if trackable), find how many behaviors they share with purchasers using EXISTS.

-- Q70. Amazon India's markdown optimization needs products where time since last sale correlates with required discount to sell. Products with longer "shelf time" needing deeper discounts to move.

-- Q71. Paytm's cohort retention analysis needs to show for each monthly cohort (by join_date), the percentage still active (made purchase) in months 1, 2, 3, 6, and 12. Use multiple CTEs for each time period.

-- Q72. Myntra's customer journey attribution needs to trace each purchase back to the originating campaign (first campaign email sent before that customer's first order). Use correlated subquery with MIN date logic.

-- Q73. Reliance Retail's inventory carrying cost needs products where holding cost (stock × price × 0.02 per month × months in inventory) exceeds the gross margin of actual sales. Unprofitable inventory.

-- Q74. Swiggy's employee productivity disparity needs stores where the difference between highest and lowest employee salary exceeds 3× the company-wide average salary difference. Compensation equity issues.

-- Q75. IRCTC's organizational hierarchy validation needs to detect circular references or orphan records in the employee-manager relationship. Use recursive CTE with cycle detection (limiting recursion depth and flagging anomalies).

-- Q76. Ola's channel conflict analysis needs products where online (shipment) sales cannibalize store sales - products where stores with high shipment volume have below-average in-store pickup (if applicable).

-- Q77. PhonePe's RFM segmentation without window functions: categorize each customer as High/Medium/Low on each of Recency, Frequency, and Monetary. Use CTEs to calculate tercile boundaries, then correlated CASE statements.

-- Q78. Flipkart's price leadership analysis needs products where they are the lowest-priced option among competing brands. Identify "loss leader" candidates using ALL comparison against same-category products.

-- Q79. BigBasket's customer lifetime prediction needs to extrapolate future value for customers based on their spending trajectory. If spending increased in their second year, project another year of growth using CTEs.

-- Q80. Zomato's operational capacity planning needs to identify the maximum concurrent orders ever experienced by each store and the date it occurred. Use correlated subquery with conditional MAX.

-- Q81. Amazon India's vendor managed inventory needs products where actual stock differs from optimal (calculated as 2× average monthly sales) by more than 50%. Use correlated subquery for optimal calculation.

-- Q82. Paytm's merchant activation needs stores that have processed at least one order but haven't processed any in the last 30 days. "Dormant activated merchants" requiring re-engagement.

-- Q83. Myntra's promotional lift measurement needs products where promotional period sales (during active promotions) exceeded non-promotional period sales by more than 30%. Measure promotion effectiveness.

-- Q84. Reliance Retail's customer journey completion needs customers who have completed the full "funnel": (1) received email, (2) clicked email, (3) viewed product (ordered it later), (4) purchased, (5) gave review. Use multiple EXISTS.

-- Q85. Swiggy's weather-sales correlation proxy needs to identify days where sales deviated significantly from the day-of-week average. Flag dates with sales > 1.5× or < 0.5× the typical for that weekday.

-- Q86. IRCTC's manager effectiveness score needs managers ranked by team productivity: average sales per employee for their direct reports vs company average. Use recursive CTE for team identification and correlated calculation.

-- Q87. Ola's first-mover advantage needs products that were "first to market" in their category (earliest order date) but no longer in the top 3 by sales. Fallen pioneers using CTEs and correlated comparison.

-- Q88. PhonePe's customer reactivation success needs to identify customers who were "churned" (no orders for 90 days) but subsequently returned. Calculate their post-reactivation spending using temporal correlated logic.

-- Q89. Flipkart's cross-border opportunity needs products popular in one region (top 10% by sales) but underperforming in another region (bottom 50%). Use CTEs for regional ranking and correlated comparison.

-- Q90. BigBasket's basket value optimization needs products that, when added to a basket, increase total basket value by more than 20% on average. "Upsell champions" using correlated basket analysis.

-- Q91. Zomato's menu profitability matrix needs products categorized by margin (price - supplier cost proxy) and volume. Create four quadrants: Stars (high/high), Cash Cows (high margin/low volume), Question Marks (low margin/high volume), Dogs (low/low).

-- Q92. Amazon India's fulfillment network optimization needs to identify the optimal number of distribution stores for each region based on: minimize (customer distance × order volume) proxy. Use correlated calculations.

-- Q93. Paytm's customer influence score needs customers whose purchases precede similar purchases by connected customers (same city, similar demographics). Early adopter identification using temporal correlated subqueries.

-- Q94. Myntra's size recommendation needs to identify products where size-related returns (reason contains 'size' or 'fit') exceed 20% of sales. Products needing size guide improvements.

-- Q95. Reliance Retail's labor scheduling efficiency needs hours where labor cost per order is highest. Assuming 8-hour shifts starting at store open, identify underutilized periods using order timestamps.

-- Q96. Swiggy's menu engineering contribution margin needs products contributing above-average profit (price × margin proxy) but below-average sales volume. Hidden gems needing promotion.

-- Q97. IRCTC's succession planning depth needs to identify management positions (employees with reports) where no obvious successor exists - no direct report within 80% salary range of the manager. Use recursive CTE.

-- Q98. Ola's customer segment migration needs to track how customers move between spending segments (Low/Medium/High) over time. For each customer, compare their segment in first 6 months vs most recent 6 months using CTEs.

-- Q99. PhonePe's breakeven analysis needs campaigns where ROI (revenue from converted customers - budget) turned positive. For each campaign, calculate cumulative revenue from acquired customers until it exceeds campaign cost.

-- Q100. Flipkart's end-to-end business intelligence query: Using a minimum of 5 CTEs, create a comprehensive dashboard query that calculates: (1) overall revenue metrics, (2) customer acquisition metrics, (3) product performance metrics, (4) store efficiency metrics, and (5) financial health metrics. The final SELECT should join all CTEs and present a holistic business view with year-over-year comparisons where relevant.

-- ============================================
-- END OF DAY 12 HARD QUESTIONS
-- ============================================
