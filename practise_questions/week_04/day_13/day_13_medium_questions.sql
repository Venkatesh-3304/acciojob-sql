-- ============================================
-- Day 13: Window Functions Part 1 (Ranking) - MEDIUM Level
-- Student Question Bank
-- ============================================
-- Total Questions: 100
-- Focus: Multi-table scenarios, business logic with ROW_NUMBER(), RANK(), DENSE_RANK()
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

-- Q1. Flipkart's sales team wants to identify the best-selling product for each category. 
-- Join products with order_items, sum the quantities sold per product, then rank products 
-- within each category. Show category, prod_name, total_qty_sold, and rank.

-- Q2. Zomato's customer success team needs to find each customer's largest order. 
-- Join customers with orders, rank orders by total_amount within each customer, 
-- and filter to show only the top order per customer.

-- Q3. BigBasket's regional analysis requires ranking stores by total revenue within each region. 
-- Join stores with orders, aggregate sales per store, then rank within region. 
-- Show region, store_name, total_revenue, and rank.

-- Q4. Myntra's HR analytics needs to identify the highest-paid employee in each department. 
-- Use employees and departments tables, rank by salary within department, 
-- and show only rank 1 employees with their department names.

-- Q5. Amazon India's supplier performance team wants to rank suppliers by the number 
-- of products they supply. Join suppliers with products, count products per supplier, 
-- then assign ranks. Show supplier_name, product_count, and rank.

-- Q6. Swiggy's loyalty program needs to identify the top 3 customers by loyalty points 
-- within each state. Join customers with loyalty_points, partition by state, 
-- rank by total_points, and filter for top 3.

-- Q7. PhonePe's delivery analysis needs to rank couriers by the number of successful 
-- deliveries. Join shipments where status = 'Delivered', count per courier, 
-- then rank. Show courier_name, delivery_count, and rank.

-- Q8. Ola's expense management wants to identify the top expense category for each store. 
-- Group expenses by store and category, sum amounts, rank within store, 
-- and filter for the top expense category per store.

-- Q9. Paytm's campaign ROI team needs to rank marketing campaigns by their conversion rate 
-- (conversions/clicks). Calculate the rate from ads_spend, then rank campaigns. 
-- Handle cases where clicks = 0.

-- Q10. IRCTC's booking analytics wants to number a customer's orders chronologically, 
-- but only for orders with status 'Delivered'. Join orders with customers, 
-- filter by status, then number per customer by order_date.

-- Q11. Reliance Retail's product team needs to rank products by revenue generated 
-- (quantity × unit_price from order_items). Calculate revenue per product, 
-- then rank overall and within each category.

-- Q12. Flipkart's review team wants to find the most critical reviewer for each product - 
-- the customer who gave the lowest rating. Rank reviewers by rating (ascending) 
-- per product and show the top critic.

-- Q13. Zomato's store manager needs to see employees ranked by salary, but also wants 
-- to see how they rank within their role. Show emp_name, role, salary, 
-- rank within role, and overall rank.

-- Q14. BigBasket's inventory alert system needs to rank products by stock quantity 
-- within each store - lowest stock gets rank 1 (for restocking priority). 
-- Join with products to show prod_name.

-- Q15. Myntra's customer engagement team wants to rank customers by the number of reviews 
-- they've written. Join customers with reviews, count reviews, and rank. 
-- Show full_name, review_count, and rank.

-- Q16. Amazon India's payment analysis needs to identify the most common payment mode 
-- for each customer. Count payments by mode per customer, rank by count, 
-- show the preferred payment mode (rank 1).

-- Q17. Swiggy's seasonal analysis needs to rank months by order volume. 
-- Extract month from order_date, count orders per month, then rank months 
-- by order count (busiest month = rank 1).

-- Q18. PhonePe's return analysis wants to rank products by return rate within each category. 
-- Calculate returns as percentage of total orders per product, then rank within category. 
-- Show category, prod_name, return_rate, and rank.

-- Q19. Ola's HR team needs to track salary rankings over time. Using salary_history, 
-- rank each salary record for an employee by effective_date (most recent = rank 1). 
-- This helps identify current vs. historical salaries.

-- Q20. Paytm's regional expansion team wants to rank cities by customer acquisition. 
-- Count customers per city, rank cities, and identify the top 10 cities for marketing focus.

-- Q21. IRCTC's promotion effectiveness team needs to rank promotions by usage. 
-- Join promotions with order_items (assuming promo applied), count usage, and rank. 
-- Show promo_name, times_used, and rank.

-- Q22. Reliance Retail's attendance tracking needs to rank employees by attendance rate 
-- within each department. Count 'Present' status per employee, calculate rate, 
-- then rank within department.

-- Q23. Flipkart's customer value analysis wants to rank customers by total spending 
-- within their join year. Extract year from join_date, partition by year, 
-- rank by total order amount within that cohort.

-- Q24. Zomato's address analysis needs to identify customers with multiple addresses 
-- and rank those addresses by type priority (Billing before Shipping alphabetically). 
-- Show customers with their address rankings.

-- Q25. BigBasket's category management wants to rank categories by average product price. 
-- Join products with dim_category (if applicable) or use category column, 
-- calculate avg price per category, then rank.

-- Q26. Myntra's brand performance needs to rank brands by total sales revenue 
-- within each category. Join products, order_items, group and aggregate, 
-- then rank brands within category.

-- Q27. Amazon India's warehouse efficiency wants to rank stores by inventory turnover. 
-- Compare stock_qty with quantity sold from order_items, calculate turnover ratio, 
-- rank stores by efficiency.

-- Q28. Swiggy's customer retention team wants to identify each customer's first, second, 
-- and third orders. Use ROW_NUMBER() partitioned by cust_id, ordered by order_date. 
-- Show order details with their sequence number.

-- Q29. PhonePe's fraud detection needs to rank orders by amount within each payment_mode. 
-- Join orders with payments, partition by payment_mode, rank by amount (highest first) 
-- to identify unusually large transactions.

-- Q30. Ola's cross-sell analysis wants to rank products by how often they appear 
-- in the same order as product ID 101 (arbitrary example). Use self-join on order_items, 
-- count co-occurrences, and rank companion products.

-- Q31. Paytm's email campaign team needs to rank campaigns by open rate within each month. 
-- Calculate opens/sent from email_clicks, partition by month of sent_date, 
-- rank by open rate.

-- Q32. IRCTC's store comparison needs to show each store's sales rank within its state 
-- and also within its region. Display both partition-based ranks side by side.

-- Q33. Reliance Retail's employee development wants to rank employees by tenure 
-- within each role. Calculate tenure as difference from a reference date, 
-- rank within role, show employees due for promotion review (rank 1-3).

-- Q34. Flipkart's discount analysis wants to rank order_items by discount percentage 
-- within each order. Show order_id, prod_id, discount, and rank within order 
-- (highest discount = rank 1).

-- Q35. Zomato's peak hour analysis needs to identify the busiest order time for each store. 
-- If order_date includes time, extract hour, count orders per store-hour, 
-- rank hours within store by order count.

-- Q36. BigBasket's product lifecycle wants to rank products by days since last inventory update. 
-- Calculate days from last_updated to current date, rank (most outdated = rank 1) 
-- to prioritize inventory checks.

-- Q37. Myntra's return reason analysis wants to rank return reasons by frequency 
-- within each product category. Join returns with products, group by category and reason, 
-- count occurrences, rank within category.

-- Q38. Amazon India's shipment performance needs to rank couriers by average delivery time 
-- within each region. Calculate avg days between shipped_date and delivered_date, 
-- join with stores for region, rank couriers within region.

-- Q39. Swiggy's expense comparison needs to rank expense types by total amount 
-- within each quarter. Extract quarter from expense_date, group by quarter and type, 
-- sum amounts, rank within quarter.

-- Q40. PhonePe's customer demographics wants to rank age groups by spending. 
-- Create age buckets using CASE WHEN, sum order amounts per bucket, rank buckets 
-- by total spending.

-- Q41. Ola's product pricing strategy wants to show products with their price rank 
-- within their brand and within their category. Display both ranks to identify 
-- premium vs. value positions.

-- Q42. Paytm's refund analysis needs to rank orders by refund amount within each customer. 
-- Join orders with returns, sum refund_amount per order, rank within customer 
-- (highest refund = rank 1).

-- Q43. IRCTC's loyalty tier analysis wants to rank customers within each loyalty point tier 
-- (Bronze: 0-1000, Silver: 1001-5000, Gold: 5001+) by their exact point count. 
-- Show tier, customer name, points, and rank within tier.

-- Q44. Reliance Retail's competitive analysis wants to rank products against others 
-- at similar price points. Create price bands using CASE WHEN, rank products by 
-- actual sales within each price band.

-- Q45. Flipkart's customer segmentation wants to rank customers by order frequency 
-- within each gender. Count orders per customer, partition by gender, rank by count.

-- Q46. Zomato's new customer analysis wants to number the first 5 orders 
-- for customers who joined in 2024. Join customers with orders, filter by join year, 
-- number orders per customer, show only sequence 1-5.

-- Q47. BigBasket's supplier reliability wants to rank suppliers by the percentage 
-- of their products that have been returned. Calculate return rate per supplier, 
-- rank (lowest return rate = rank 1 for best suppliers).

-- Q48. Myntra's state-wise brand preference wants to rank brands by sales within each state. 
-- Join customers, orders, order_items, products. Aggregate sales per brand per state, 
-- rank brands within state.

-- Q49. Amazon India's payment timing wants to rank orders by the gap between order_date 
-- and payment_date within each customer. Calculate date difference, rank within customer 
-- (smallest gap = rank 1 for prompt payers).

-- Q50. Swiggy's store staffing analysis wants to rank stores by employee count 
-- within each region. Count employees per store, join with stores for region, 
-- rank within region.

-- Q51. PhonePe's seasonal product analysis wants to rank products by sales 
-- within each quarter of 2024. Extract quarter from order_date, sum sales per product 
-- per quarter, rank within quarter.

-- Q52. Ola's expense forecasting wants to rank months by total expenses for each store. 
-- Extract month from expense_date, sum amounts per store-month, rank months within store.

-- Q53. Paytm's customer service priority wants to rank customers by recency of their 
-- last order. Calculate days since last order, rank (most recent = rank 1) overall 
-- and within each state.

-- Q54. IRCTC's inventory valuation wants to rank stores by total inventory value 
-- (stock_qty × product price). Join inventory with products, calculate value per store, 
-- rank stores.

-- Q55. Reliance Retail's department budget analysis wants to rank departments 
-- by total salary expense. Sum salaries per department, rank departments.

-- Q56. Flipkart's review sentiment analysis wants to rank products by average rating, 
-- but only for products with at least 10 reviews. Use HAVING in subquery, then rank.

-- Q57. Zomato's order value distribution wants to rank customers by their average order value 
-- within their city. Calculate AOV per customer, partition by city, rank within city.

-- Q58. BigBasket's cross-regional comparison wants to show how each store ranks 
-- within its city, state, and region. Create three different ranking columns.

-- Q59. Myntra's discount effectiveness wants to rank products by the average discount 
-- applied when sold. Calculate avg discount per product from order_items, rank products 
-- (highest avg discount = rank 1).

-- Q60. Amazon India's delivery promise wants to rank orders by delivery performance 
-- within each courier. Calculate expected vs. actual delivery gap, rank orders 
-- within courier.

-- Q61. Swiggy's campaign budget efficiency wants to rank campaigns by cost per conversion 
-- (amount/conversions from ads_spend). Handle zero conversions, rank campaigns 
-- (lowest cost = rank 1).

-- Q62. PhonePe's customer lifetime analysis wants to rank customers by the number 
-- of distinct months they've placed orders. Count distinct months per customer, rank.

-- Q63. Ola's product availability wants to rank products by the number of stores 
-- where they're available (have inventory). Count stores per product, rank products 
-- (most available = rank 1).

-- Q64. Paytm's return speed analysis wants to rank returns by days between order_date 
-- and return_date. Calculate gap, rank (fastest return = rank 1) overall and per product.

-- Q65. IRCTC's employee salary equity wants to compare each employee's salary rank 
-- within their department vs. within employees of the same role. Show both ranks 
-- to identify potential inequities.

-- Q66. Reliance Retail's customer address coverage wants to rank states by the number 
-- of unique postal codes where customers reside. Count distinct postal codes per state, 
-- rank states.

-- Q67. Flipkart's order complexity wants to rank orders by the number of distinct products 
-- in each order. Count distinct prod_id per order from order_items, rank orders.

-- Q68. Zomato's customer loyalty evolution wants to rank customers by loyalty point 
-- growth (if tracking over time via updates). Compare current points, rank by points 
-- within each join_year cohort.

-- Q69. BigBasket's brand diversity wants to rank stores by the number of distinct brands 
-- they stock. Join inventory with products, count distinct brands per store, rank stores.

-- Q70. Myntra's high-value customer identification wants to rank customers by total spending 
-- within each age bracket (18-25, 26-35, 36-50, 50+). Use CASE WHEN for brackets, 
-- rank within bracket.

-- Q71. Amazon India's inventory risk wants to rank product-store combinations by stock level 
-- relative to sales velocity. Calculate stock/avg_daily_sales ratio, rank (lowest = highest risk).

-- Q72. Swiggy's payment diversity wants to rank customers by the number of distinct 
-- payment modes they've used. Count distinct payment_mode per customer, rank customers.

-- Q73. PhonePe's returns by region wants to rank regions by return rate 
-- (return count / order count). Calculate rate per region, rank regions 
-- (lowest rate = rank 1 for best regions).

-- Q74. Ola's email engagement wants to rank customers by click-through rate 
-- from email_clicks. Calculate clicks/sent per customer, rank customers.

-- Q75. Paytm's store profitability wants to rank stores by profit margin 
-- (net_profit / total_sales from revenue_summary). Calculate margin, rank stores.

-- Q76. IRCTC's product bundling opportunity wants to rank products by how often 
-- they're bought with 2+ other products in the same order. Count multi-product 
-- appearances, rank products.

-- Q77. Reliance Retail's customer geographic spread wants to rank customers 
-- by the number of distinct cities they've had orders shipped to. Count cities 
-- per customer (via addresses or stores), rank customers.

-- Q78. Flipkart's promotion timing wants to rank promotions by average order value 
-- during their active period. Join promotions with orders in date range, 
-- calculate AOV per promo, rank promotions.

-- Q79. Zomato's employee retention indicator wants to rank employees by the number 
-- of salary history entries (indicating raises/adjustments). Count entries per employee, 
-- rank (more entries might indicate longer tenure or more reviews).

-- Q80. BigBasket's customer consistency wants to rank customers by the standard deviation 
-- of their order amounts (if possible with available functions). Otherwise, rank by 
-- difference between max and min order amounts (consistency score).

-- Q81. Myntra's seasonal employee scheduling wants to rank days of the week by 
-- total orders. Extract day of week from order_date, count orders per day, rank days.

-- Q82. Amazon India's supplier concentration risk wants to rank categories by 
-- how dependent they are on a single supplier. Calculate top supplier's share 
-- per category, rank categories (highest concentration = rank 1 for risk).

-- Q83. Swiggy's customer reactivation priority wants to rank inactive customers 
-- (no orders in last 6 months) by their historical total spending. Filter inactive, 
-- sum past spending, rank for reactivation campaigns.

-- Q84. PhonePe's returns pattern wants to rank products by the ratio of returns 
-- to total sales quantity. Calculate ratio per product, rank (highest ratio = rank 1 
-- for quality review).

-- Q85. Ola's address type preference wants to rank address types by usage frequency 
-- within each state. Count addresses per type per state, rank types within state.

-- Q86. Paytm's campaign timing wants to rank campaigns by their duration 
-- (end_date - start_date). Calculate duration, rank campaigns (longest = rank 1).

-- Q87. IRCTC's customer order pattern wants to rank customers by the variance 
-- in their order dates (regularity). Calculate avg days between orders per customer 
-- using subqueries, rank by regularity.

-- Q88. Reliance Retail's discount distribution wants to rank products by 
-- the range of discounts applied (max discount - min discount). Calculate range, 
-- rank products (highest range = rank 1 for inconsistent pricing).

-- Q89. Flipkart's store-product affinity wants to rank products by sales within each store. 
-- Sum quantity sold per product per store, rank products within store. 
-- Identify top 5 products per store.

-- Q90. Zomato's review recency wants to rank products by the date of their most recent review. 
-- Find max(review_date) per product, rank products (most recent = rank 1).

-- Q91. BigBasket's customer acquisition channel wants to rank regions by 
-- customer acquisition rate (new customers per month). Count customers by join month 
-- per region, calculate rate, rank regions.

-- Q92. Myntra's expense category comparison wants to rank expense categories 
-- by growth between months. Calculate monthly totals, compare consecutive months, 
-- rank categories by growth rate.

-- Q93. Amazon India's payment delay wants to rank orders by payment processing time 
-- within each payment_mode. Calculate delay, partition by mode, rank within mode.

-- Q94. Swiggy's loyalty tier movement wants to identify customers who moved up 
-- in loyalty rankings. Compare current rank with what their rank would have been 
-- a year ago (using subqueries for historical points).

-- Q95. PhonePe's store-department profitability wants to rank departments by 
-- total employee salary expense within each store. Sum salaries per dept per store, 
-- rank departments within store.

-- Q96. Ola's email campaign comparison wants to rank campaigns by engagement score 
-- (opened * 0.3 + clicked * 0.7 weighted score). Calculate score per campaign from 
-- email_clicks aggregation, rank campaigns.

-- Q97. Paytm's product pricing tier wants to rank products within price tiers 
-- (Budget: 0-500, Mid: 501-2000, Premium: 2000+) by quantity sold. 
-- Create tiers with CASE, aggregate sales, rank within tier.

-- Q98. IRCTC's customer city distribution wants to rank cities by customer density 
-- (customers per unique postal code). Count customers and postal codes per city, 
-- calculate density, rank cities.

-- Q99. Reliance Retail's promotion effectiveness by channel wants to rank 
-- marketing channels by ROI within each campaign. Calculate conversions/amount ratio 
-- per channel per campaign, rank channels within campaign.

-- Q100. Flipkart's comprehensive product ranking wants to show each product with:
-- (a) rank by price within category
-- (b) rank by quantity sold within category  
-- (c) rank by average rating within category
-- Display all three ranks to identify best overall performers.

-- ============================================
-- END OF DAY 13 MEDIUM QUESTIONS
-- ============================================
