-- ============================================
-- Day 11: Subqueries Part 1 - HARD Level
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

-- Q1. Flipkart's investment team is analyzing category performance. They need categories where the total revenue exceeds the average category revenue, but only considering categories that have at least 20 products. Additionally, show how each qualifying category compares to the overall average as a percentage.

-- Q2. Zomato's fraud analytics division has noticed suspicious patterns. They need to identify customers who have placed orders with amounts that are exactly 10%, 20%, or 50% higher than the store's average order amount. List customer details with their suspicious order count.

-- Q3. BigBasket's dynamic pricing algorithm needs refinement. Find products where the price is below the average price of products from the same supplier AND below the average price of products in the same category, creating a potential "double underpriced" situation.

-- Q4. Myntra's customer segmentation model requires identifying "loyal high-value customers" - those who have placed more orders than 90% of other customers AND have an average order value higher than the company average. Show their total lifetime value.

-- Q5. PhonePe's reconciliation team discovered payment anomalies. Find orders where the sum of payment amounts differs from the order total, but only for stores that process more than the average number of orders per day.

-- Q6. Ola's workforce planning team needs to identify overstaffed stores - stores where the number of employees exceeds the ratio of (average orders per employee) by more than 20%, compared to the company-wide average.

-- Q7. Amazon India's product team wants to find "category dominators" - products that individually account for more than 15% of their category's total sales revenue. Include category name and dominance percentage.

-- Q8. Swiggy's supply chain team needs products where inventory turnover (total ordered quantity / current stock) is below the category average, but only in stores where total sales exceed the store average.

-- Q9. IRCTC's revenue optimization team wants to identify "price sensitive" dates - dates where the average order value is significantly below (more than 1.5 standard deviations) the overall average, indicating possible discount periods.

-- Q10. Reliance Retail's expansion team needs cities where: (a) current stores have above-average performance, AND (b) customer density suggests room for more stores. Performance is revenue per store, density is customers per store.

-- Q11. Paytm's marketing effectiveness analysis requires campaigns where the cost per acquisition (total spend / conversions) is below the company average, but only for campaigns that ran for at least 30 days.

-- Q12. Flipkart's returns fraud detection needs customers whose return rate (returns / orders) exceeds twice the overall average, AND whose average refund amount exceeds the average product price of items they ordered.

-- Q13. Zomato's delivery efficiency team wants stores where average delivery time is slower than the city average, but only for stores that have delivered more orders than the store median.

-- Q14. BigBasket's vendor scoring model needs suppliers whose products have: (a) below-average return rates, AND (b) above-average review ratings, AND (c) above-average sales volume. Show composite score.

-- Q15. Myntra's assortment planning team needs brands that have products in categories where the brand doesn't have the top-selling product, indicating growth opportunities.

-- Q16. PhonePe's customer lifetime value team needs customers whose spending increased each quarter (Q1 < Q2 < Q3 < Q4), comparing total amounts across quarters using subqueries.

-- Q17. Ola's strategic accounts team needs to identify stores that have never had a month with below-average sales - consistently high performers.

-- Q18. Amazon's competitor analysis team (hypothetically) wants products whose price is within 5% of the maximum price in their category AND have above-average sales, indicating premium positioning success.

-- Q19. Swiggy's churn prediction model needs customers who were active (ordered) in first 3 months of the year but have no orders in the last 3 months, with above-average historical spend.

-- Q20. IRCTC's seasonal inventory team needs products with high seasonality - where the difference between max monthly sales and min monthly sales exceeds twice the average monthly sales.

-- Q21. Reliance Digital's cross-sell team needs to find products frequently bought together by finding products that appear in orders containing product ID 100 more often than average co-occurrence rate.

-- Q22. Paytm Mall's warehouse optimization needs stores where inventory value (sum of stock_qty * price) is above the median store inventory value, but turnover is below average.

-- Q23. Flipkart's seller quality team needs suppliers who have products with review ratings below category average in more than 50% of their product portfolio.

-- Q24. Zomato's dynamic pricing model needs products where demand (order frequency) is higher than average but price is below category average - underpriced high-demand items.

-- Q25. BigBasket's customer service team needs to identify "high maintenance" customers - those with above-average returns AND above-average customer service contacts (reviews with low ratings).

-- Q26. Myntra's promotion planning team needs products that have never been ordered during any promotion period (between any promo start and end dates) but have high regular sales.

-- Q27. PhonePe's risk team needs payment patterns where a customer's single payment exceeds 3 times their own average payment amount - potential fraud signals.

-- Q28. Ola's compensation review team needs employees whose salary is below the average of others with the same role in different stores, but their store has above-average revenue.

-- Q29. Amazon's inventory optimization needs products where stock quantity in any store is below the average daily sales rate multiplied by 7 (7-day supply threshold).

-- Q30. Swiggy's market basket analysis needs order pairs that always contain products from category A and category B together, identified by customers who ordered both in > 80% of their orders.

-- Q31. IRCTC's loyalty program redesign needs customers whose loyalty points don't correlate with their spending - top 20% spenders who are not in top 40% of loyalty points.

-- Q32. Reliance Retail's real estate team needs to identify underperforming store locations - stores where revenue per square foot (approximated by revenue / employee count) is below regional average.

-- Q33. Paytm's A/B testing analysis needs campaigns where email click rate significantly outperformed (>25% better) the average click rate of campaigns in the same budget tier.

-- Q34. Flipkart's product quality team needs products where the return reason "Defective" appears more frequently than the category average for defective returns.

-- Q35. Zomato's customer acquisition cost analysis needs customers acquired (first order) during high-spend campaigns but who have below-average lifetime value.

-- Q36. BigBasket's pricing elasticity study needs products where a price increase (identified by comparing to previous orders at different prices) resulted in decreased order quantities.

-- Q37. Myntra's brand partnership team needs brands where the average product price is within 15% of the category average price, indicating mainstream positioning.

-- Q38. PhonePe's regulatory compliance team needs transactions above ₹10,000 from customers who typically make transactions below the customer-segment average.

-- Q39. Ola's productivity benchmarking needs employees whose order-handling (orders at their store / employees at their store) ratio exceeds the company-wide ratio by 20%.

-- Q40. Amazon's dead stock identification needs products with no orders in 90 days but inventory > 0, where similar products (same category and price range) have recent orders.

-- Q41. Swiggy's personalization engine needs customers whose category preferences (most ordered category) differs from the most popular category among customers in their city.

-- Q42. IRCTC's fraud ring detection needs orders where multiple orders with the same total amount were placed on the same day from different customers but same city.

-- Q43. Reliance Digital's assortment strategy needs categories where the top 3 products contribute more than 60% of category revenue - high concentration categories.

-- Q44. Paytm's customer win-back team needs churned customers (no orders in 6 months) who were previously in the top 25% by order frequency.

-- Q45. Flipkart's logistics optimization needs stores where average shipment time (order to shipped) exceeds the courier average for that courier.

-- Q46. Zomato's menu engineering needs products where profit margin (approximated as price - avg refund rate * price) is above category average but sales rank is below average.

-- Q47. BigBasket's seasonal planning needs categories where Q4 sales exceed the average of Q1-Q3 sales by more than 30% - holiday seasonal categories.

-- Q48. Myntra's size optimization needs products (assuming category indicates size-relevant info) where return reason indicates size issues more than the category average.

-- Q49. PhonePe's credit risk team needs customers whose payment failures (orders without matching payments) exceed the average failure rate for their spending tier.

-- Q50. Ola's facilities planning needs stores where employee count exceeds the count predicted by: (store revenue / average revenue per employee company-wide).

-- Q51. Amazon's warehouse slotting needs products with high order velocity (orders per day > average) but inventory spread across fewer stores than average for their category.

-- Q52. Swiggy's service recovery team needs customers who received late deliveries (delivered > 7 days after ordered) on more than 30% of their orders when store average is below 20%.

-- Q53. IRCTC's dynamic bundling needs product pairs where buying both saves the customer money compared to buying the more expensive one alone (indicating bundle discount opportunity).

-- Q54. Reliance Retail's markdown optimization needs products whose price is above category average but sales are below category average - candidates for price reduction.

-- Q55. Paytm's credit limit algorithm needs customers whose average order value has increased by more than 50% compared to their first 3 orders' average.

-- Q56. Flipkart's supplier consolidation needs suppliers with fewer than 5 products but where those products have above-average sales - small but mighty suppliers.

-- Q57. Zomato's dark store analysis needs locations (cities) where delivery orders exceed dine-in (orders from stores vs customer city match) by the largest margin.

-- Q58. BigBasket's private label opportunity needs categories where no single brand has more than 25% market share - fragmented categories ideal for own brand.

-- Q59. Myntra's influencer marketing needs products that had spike in orders (>150% of average) during marketing campaign periods but returned to below average after.

-- Q60. PhonePe's gamification team needs customers who are "almost" at the next loyalty tier - within 10% of the next tier threshold based on points distribution.

-- Q61. Ola's workforce scheduling needs stores where weekend orders significantly exceed (>40%) weekday orders, identified using order_date patterns.

-- Q62. Amazon's substitution engine needs products that are frequently ordered when a similar product (same category, similar price ±20%) is out of stock elsewhere.

-- Q63. Swiggy's cloud kitchen recommendations need categories where delivery orders significantly outperform store orders in specific cities.

-- Q64. IRCTC's ancillary revenue team needs customers who have high order values but low add-on purchases (few order_items per order) compared to segment average.

-- Q65. Reliance Digital's showrooming analysis needs products with high in-store views (orders with store presence) but low conversion compared to category average.

-- Q66. Paytm's float optimization needs payment delays - orders where time between order_date and payment_date exceeds the customer's average delay.

-- Q67. Flipkart's review authenticity needs products where 5-star reviews are disproportionately high (>80%) compared to category average 5-star rate.

-- Q68. Zomato's expansion modeling needs regions where customer-to-store ratio exceeds the national average but order-per-customer is below average - underpenetrated markets.

-- Q69. BigBasket's shelf-life management needs products where the gap between inventory last_updated and recent orders suggests slow-moving stock compared to category.

-- Q70. Myntra's markdown automation needs products with declining month-over-month orders for 3 consecutive months while category trend is stable or growing.

-- Q71. PhonePe's high-value customer program needs customers in the top 5% by total spending who haven't been part of any email campaign.

-- Q72. Ola's regional performance needs the region with the highest ratio of (revenue per employee) compared to (expenses per employee).

-- Q73. Amazon's assortment gap analysis needs categories where the number of products is below average but sales per product is above average - underserved demand.

-- Q74. Swiggy's customer journey analysis needs customers whose time between first and second order is shorter than the cohort average.

-- Q75. IRCTC's yield management needs dates where seat utilization (orders / average daily capacity proxy) exceeded 90th percentile of daily orders.

-- Q76. Reliance Retail's shrinkage analysis needs stores where returns as percentage of sales exceed the regional average by more than 2 standard deviations.

-- Q77. Paytm's referral optimization needs customers who made purchases within 7 days of a campaign email, where the campaign had above-average click rates.

-- Q78. Flipkart's new product launch analysis needs products added in the last 6 months that have already exceeded the average lifetime orders of older products in same category.

-- Q79. Zomato's restaurant scoring needs stores where average review rating is below city average but order volume is above city average - review opportunity.

-- Q80. BigBasket's demand forecasting calibration needs products where actual orders deviate from category average by less than 5% - stable demand products.

-- Q81. Myntra's returns processing needs orders where return was initiated in the same week as delivery, but only for customers with above-average order counts.

-- Q82. PhonePe's collections team needs customers with unpaid orders (orders without payments) whose historical payment compliance was above average.

-- Q83. Ola's fleet distribution needs stores where the ratio of orders to employees is in the top quartile of stores in their region.

-- Q84. Amazon's vendor-funded promotions need suppliers whose products' sales increased more than category average during promotion periods.

-- Q85. Swiggy's kitchen capacity planning needs stores where peak hour orders (identified by order patterns) exceed twice the hourly average.

-- Q86. IRCTC's overbooking model needs routes (origin-destination cities from orders) where cancellation rate exceeds 15% of bookings.

-- Q87. Reliance Digital's experience center needs products where in-store demo (approximated by high price + specific categories) correlates with above-average conversion.

-- Q88. Paytm's fraud network needs customer pairs who ordered the exact same products on the same dates from different cities.

-- Q89. Flipkart's inventory health needs products where current stock exceeds 6 months of average sales, but the product has orders in the last month.

-- Q90. Zomato's sustainability team needs packaging impact - orders with high item counts (above average items per order) from stores with above-average order volumes.

-- Q91. BigBasket's route optimization needs customers whose orders span multiple delivery zones (different stores) more frequently than average.

-- Q92. Myntra's luxury segment analysis needs products where average order value of orders containing them exceeds twice the overall average order value.

-- Q93. PhonePe's anti-money laundering needs customers whose transaction patterns (amounts) closely cluster (low variance) around specific amounts.

-- Q94. Ola's surge prediction needs dates where orders exceeded normal daily average by 2x or more, correlated with specific store characteristics.

-- Q95. Amazon's Prime-like program design needs customers whose shipping preference (based on delivery speed requests in shipments) correlates with higher lifetime value.

-- Q96. Swiggy's cloud kitchen launch needs cities where delivery infrastructure (couriers per order) is above average but restaurant count is below average.

-- Q97. IRCTC's loyalty tier restructuring needs the spending thresholds that would evenly distribute customers across 4 tiers based on total order amounts.

-- Q98. Reliance Retail's multi-channel attribution needs customers who have ordered from both online (if trackable) and stores in the same city, with above-average spend.

-- Q99. Paytm's product recommendations need products that are frequently ordered by customers who also ordered the best-selling product in each category.

-- Q100. Flipkart's seller onboarding needs categories where demand (total orders) exceeds supply (total inventory) by more than 30%, indicating seller opportunity.

-- ============================================
-- END OF DAY 11 HARD QUESTIONS
-- ============================================
