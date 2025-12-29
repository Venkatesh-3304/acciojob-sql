-- ============================================
-- Day 13: Window Functions Part 1 (Ranking) - HARD Level
-- Student Question Bank
-- ============================================
-- Total Questions: 100
-- Focus: Interview-level difficulty, real-world ambiguity, edge cases
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

-- Q1. Flipkart's machine learning team is building a recommendation engine. They need 
-- to identify each customer's "signature" purchases - products they've bought multiple times 
-- that other customers rarely buy. For each customer, rank their purchased products by 
-- the combination of: (a) how many times that customer bought it, and (b) how rarely 
-- other customers buy it. This requires multiple CTEs, joins, and window functions.

-- Q2. Zomato's fraud detection system needs to identify suspicious order patterns. 
-- An order is flagged if it ranks in the top 1% by amount within its payment_mode 
-- AND the customer's order frequency rank is unusual (very high order count but 
-- low spending per order, or vice versa). Build a comprehensive flagging query.

-- Q3. BigBasket's dynamic pricing team wants to identify products that are priced 
-- inconsistently with their category peers. For each product, calculate its price rank 
-- within category and compare with its sales rank within category. Products where 
-- these two ranks differ by more than 10 positions should be flagged for review.

-- Q4. Myntra's vendor scorecard system needs to rank suppliers on a composite score 
-- considering: product count (20% weight), average product price (30% weight), 
-- and total revenue generated (50% weight). Create percentile ranks for each factor, 
-- then combine into a weighted final rank.

-- Q5. Amazon India's inventory optimization needs to identify "dead stock" - 
-- products that rank in the bottom 10% by sales quantity within their category 
-- BUT rank in the top 30% by inventory value (stock × price). These represent 
-- capital tied up in slow-moving items.

-- Q6. Swiggy's customer segmentation wants to classify customers into value tiers, 
-- but with a twist: a customer's tier should consider their rank within their city 
-- (to account for regional economic differences). A customer in the top 10% of Mumbai 
-- should be compared differently than top 10% of a smaller city. Build this relative 
-- ranking system.

-- Q7. PhonePe's A/B testing analysis needs to compare campaign performance, but the 
-- complication is that campaigns run in different time periods with different baselines. 
-- Rank campaigns by their conversion rate relative to the average conversion rate 
-- during their active period. This requires date-based joins and normalized rankings.

-- Q8. Ola's employee equity analysis is legally sensitive. The HR team needs to identify 
-- cases where employees with the same role and department have salary ranks that differ 
-- by more than 3 positions when ranked by tenure. This could indicate pay inequity.

-- Q9. Paytm's churn prediction model needs training data. Identify customers whose 
-- order frequency rank (within their cohort by join_year) has dropped by more than 
-- 50% when comparing their first 6 months to their most recent 6 months. This requires 
-- time-window comparisons with ranking.

-- Q10. IRCTC's capacity planning needs to identify stores that are "punching above 
-- their weight" - stores that rank higher in sales than in employee count and 
-- inventory investment. These might need resource allocation increases.

-- Q11. Reliance Retail's promotional calendar optimization needs to rank promotions 
-- by effectiveness, but normalized by the promotional environment. A 10% discount 
-- during a period when competitors offered 20% is more effective than the same 
-- discount when competitors offered nothing. Model this with available data.

-- Q12. Flipkart's seller marketplace (simulated through suppliers) needs a quality score. 
-- Rank suppliers by a composite of: (a) their products' average ratings, (b) return rate 
-- of their products, (c) price competitiveness within categories. Handle suppliers 
-- who have no ratings or returns yet.

-- Q13. Zomato's market expansion analysis needs to rank cities by growth potential. 
-- Calculate each city's current customer penetration (customers / assumed population proxy 
-- via postal code count), order frequency per customer, and average order value. 
-- Combine into a weighted opportunity score and rank cities.

-- Q14. BigBasket's product rationalization needs to identify candidates for discontinuation. 
-- Products that rank in the bottom 20% by sales AND bottom 20% by margin AND have 
-- declining rank over time (comparing 2023 vs 2024 if dates available) should be flagged.

-- Q15. Myntra's personalization engine needs to identify each customer's "brand affinity" - 
-- ranks brands by purchase frequency for each customer, then identifies if this differs 
-- significantly from the overall brand popularity ranking. Customers with unique 
-- preferences are valuable for targeted marketing.

-- Q16. Amazon India's returns analysis needs to rank products by "return severity" - 
-- a composite score of: return rate, average refund amount, and the rank of return 
-- reasons (some reasons like "defective" are more severe than "changed mind"). 
-- Build this severity ranking.

-- Q17. Swiggy's workforce planning needs to rank departments by staffing efficiency. 
-- Calculate revenue per employee, orders processed per employee (if measurable), 
-- and compare ranks across departments. Identify understaffed and overstaffed departments.

-- Q18. PhonePe's cross-sell opportunity analysis needs to rank product pairs by 
-- co-purchase frequency, but normalized by individual product popularity. Products 
-- that are frequently bought together despite one being unpopular indicate strong affinity.

-- Q19. Ola's regional performance review ranks regions by multiple KPIs, but some 
-- regions are much larger. Normalize rankings by region size (store count, customer count) 
-- to identify truly efficient vs. inefficient regions regardless of scale.

-- Q20. Paytm's customer journey analysis wants to identify customers whose shopping 
-- behavior has evolved. Rank customers by category concentration (how focused their 
-- purchases are on few categories vs. diverse) in their first year vs. current year. 
-- Identify those who have significantly diversified or specialized.

-- Q21. IRCTC's pricing strategy needs to identify "anchor products" - products that 
-- rank highly in order appearance frequency (present in many orders) but have lower 
-- revenue rank. These products draw customers but need complementary items for profit.

-- Q22. Reliance Retail's store clustering wants to rank stores by similarity to 
-- top-performing stores. Calculate each store's rank profile across multiple metrics 
-- (sales, traffic, basket size, category mix) and compare rank patterns to identify 
-- stores that could learn from top performers.

-- Q23. Flipkart's inventory redistribution needs to rank products by stockout risk 
-- at each store. Compare sales velocity rank with inventory level rank at each 
-- store-product combination. High sales rank + low inventory rank = critical.

-- Q24. Zomato's menu optimization (simulated through products) needs to identify 
-- products that rank highly in trials (appear in first orders) but poorly in repeats 
-- (appear in subsequent orders). These may have quality or expectation issues.

-- Q25. BigBasket's supplier negotiation preparation ranks suppliers by bargaining position. 
-- A supplier with unique products (no alternatives) and high sales rank has more power. 
-- Calculate supplier criticality score and rank.

-- Q26. Myntra's seasonal planning needs to rank products by seasonality intensity. 
-- Compare a product's sales rank in peak month vs. average month. Products with 
-- high rank variance are highly seasonal and need different inventory strategies.

-- Q27. Amazon India's customer service priority queue needs to rank customers 
-- dynamically by: recent order value, lifetime value, loyalty tier, and current 
-- issue severity (based on return amount if applicable). Build this priority ranking.

-- Q28. Swiggy's marketing attribution wants to rank marketing channels by first-touch 
-- vs. last-touch effectiveness. For customers who engaged with multiple campaigns, 
-- identify which campaign was first vs. which preceded their largest purchase.

-- Q29. PhonePe's payment ecosystem analysis needs to rank payment modes by reliability. 
-- Calculate success rate, average processing time (if derivable), and transaction 
-- value distribution. Rank modes for different use cases (high-value vs. low-value).

-- Q30. Ola's talent management needs to identify "rising stars" - employees whose 
-- salary rank has improved significantly (moved up in percentile) between salary 
-- history records. Compare earliest and latest salary rankings within department.

-- Q31. Paytm's returns policy optimization needs to rank products by return cost impact. 
-- Consider refund amount, estimated handling cost (fixed per return), and opportunity 
-- cost of lost inventory. Build a total return cost rank.

-- Q32. IRCTC's customer lifetime value prediction needs to rank customers by trajectory. 
-- Compare their spending rank in year 1 vs. year 2 (or first half vs. second half). 
-- Identify customers with improving vs. declining trajectories.

-- Q33. Reliance Retail's store renovation priority needs to rank stores by 
-- "improvement potential" - stores with good location signals (high traffic rank) 
-- but poor conversion signals (low sales rank relative to traffic).

-- Q34. Flipkart's category manager competition needs to rank categories by 
-- competitive intensity. Calculate metrics like: number of products, price variance 
-- rank, and promotion frequency. Highly competitive categories need different strategies.

-- Q35. Zomato's delivery partner allocation (simulated through couriers) needs to 
-- rank couriers by performance consistency. A courier with stable rankings across 
-- months is more reliable than one with volatile rankings, even if average is similar.

-- Q36. BigBasket's demand forecasting baseline needs to rank products by forecastability. 
-- Products with consistent sales rankings across time periods are easier to forecast 
-- than those with volatile rankings.

-- Q37. Myntra's influencer marketing (simulated) needs to rank customers by influence 
-- potential. Identify customers who: (a) rank highly in spending, (b) purchase new 
-- products early (rank highly in "days since product launch" when they buy), and 
-- (c) have diverse category purchases.

-- Q38. Amazon India's vendor-managed inventory needs to rank suppliers by forecast accuracy. 
-- Compare supplier's shipment patterns with actual sales velocity of their products. 
-- Suppliers whose products have stable inventory levels rank higher.

-- Q39. Swiggy's surge pricing (simulated through order patterns) needs to identify 
-- time periods when demand rank significantly exceeds capacity rank. This requires 
-- temporal analysis with rankings.

-- Q40. PhonePe's customer win-back needs to rank churned customers (no orders in 6 months) 
-- by win-back probability. Consider: historical value rank, recency of churn, 
-- and engagement history (email clicks if available).

-- Q41. Ola's SKU rationalization needs to identify product variants that cannibalize 
-- each other. Rank products within their brand-category combination by sales. 
-- Products with adjacent ranks and similar prices may be candidates for consolidation.

-- Q42. Paytm's store format optimization needs to rank stores by format effectiveness. 
-- Group stores by size (employee count brackets), then rank within format. 
-- Identify if certain formats consistently outperform others.

-- Q43. IRCTC's order complexity analysis needs to rank orders by fulfillment difficulty. 
-- Consider: number of items, number of distinct categories, total weight/value, 
-- and delivery distance (if derivable from locations). Build composite difficulty rank.

-- Q44. Reliance Retail's brand portfolio optimization needs to rank brands by 
-- portfolio contribution. A brand that fills a unique price/quality niche 
-- (different rank position than alternatives) is more valuable than overlapping brands.

-- Q45. Flipkart's product lifecycle management needs to rank products by lifecycle stage. 
-- New products with rapidly improving sales rank are "rising", stable ranks are "mature", 
-- and declining ranks are "declining". Classify and rank products.

-- Q46. Zomato's customer education opportunity needs to rank customers by 
-- "underdeveloped potential" - customers whose category breadth rank is low 
-- (they shop few categories) despite high total spending rank.

-- Q47. BigBasket's store-in-store analysis needs to rank departments (simulated through 
-- product categories) by their relative performance at each store. A department 
-- that ranks #1 at most stores is a "hero" department.

-- Q48. Myntra's promotion cannibalization needs to identify promotions that hurt 
-- non-promoted items. Compare product sales ranks during promotion periods vs. 
-- non-promotion periods for related products.

-- Q49. Amazon India's package optimization needs to rank orders by packaging efficiency 
-- potential. Orders with many small items from the same category (rankable) may be 
-- candidates for bundled packaging.

-- Q50. Swiggy's loyalty program tier migration needs to rank customers by 
-- tier-change probability. Customers near tier boundaries (rank position close to 
-- threshold) need proactive engagement.

-- Q51. PhonePe's expense management (simulated through store expenses) needs to 
-- rank expense categories by controllability. Compare expense rank with sales rank - 
-- expenses that rank higher than sales may be excessive.

-- Q52. Ola's product substitution needs to rank products by substitutability. 
-- Products frequently purchased when similar products are out of stock 
-- (low inventory rank) may be good substitutes.

-- Q53. Paytm's review solicitation needs to rank products by review deficit. 
-- Products with high sales rank but low review count rank are under-reviewed 
-- and need solicitation campaigns.

-- Q54. IRCTC's express delivery eligibility needs to rank products by express-worthiness. 
-- High-margin products (price rank relative to category) with consistent demand 
-- (stable sales rank) are good candidates.

-- Q55. Reliance Retail's markdown optimization needs to rank products by markdown 
-- urgency. Products with declining sales rank and high inventory rank need 
-- faster markdowns.

-- Q56. Flipkart's supplier development needs to rank suppliers by growth partnership 
-- potential. Suppliers with improving product quality rank (via ratings) and 
-- stable supply (via inventory levels) are good development candidates.

-- Q57. Zomato's store labor scheduling needs to rank time periods by labor 
-- intensity requirement. Compare order count rank with current staffing levels 
-- (if derivable) across time periods.

-- Q58. BigBasket's product placement optimization needs to rank products by 
-- impulse purchase potential. Products with high cross-sell appearance rank 
-- (frequently bought with other products) are good impulse candidates.

-- Q59. Myntra's inventory allocation needs to rank stores by demand certainty. 
-- Stores with stable product-level sales ranks over time are more predictable 
-- for inventory allocation.

-- Q60. Amazon India's customer migration tracking needs to rank customers by 
-- channel shift. If order source data were available, compare rank changes 
-- across channels over time. Simulate with payment mode shifts.

-- Q61. Swiggy's delivery promise optimization needs to rank routes (store-to-region 
-- combinations) by reliability. Routes with consistent delivery time ranks are 
-- safer for tight promises.

-- Q62. PhonePe's campaign budget allocation needs to rank campaigns by 
-- marginal return potential. Campaigns with good conversion rank but low 
-- budget rank might improve with more investment.

-- Q63. Ola's customer segment stability needs to rank segments by membership 
-- volatility. Segments where customer rank positions change frequently are 
-- unstable and need different strategies than stable segments.

-- Q64. Paytm's product review quality needs to rank products by review helpfulness. 
-- Products with longer reviews (text length) and consistent ratings might have 
-- higher quality reviews. Rank by review quality metrics.

-- Q65. IRCTC's returns processing priority needs to rank returns by processing 
-- urgency. High-value returns, returns from top customers (high lifetime value rank), 
-- and returns with "defective" reasons should rank higher.

-- Q66. Reliance Retail's store competition analysis needs to rank stores by 
-- market share trajectory. Compare store's sales rank within its city/region 
-- over different time periods.

-- Q67. Flipkart's email personalization needs to rank products for each customer 
-- based on their purchase history patterns. Products in categories where the 
-- customer ranks high in spending should be recommended.

-- Q68. Zomato's operational efficiency needs to rank stores by orders-per-employee 
-- efficiency, then compare this efficiency rank with profitability rank. 
-- Stores efficient in operations but not in profits may have cost issues.

-- Q69. BigBasket's product bundling needs to identify complementary products. 
-- Rank product pairs by: frequency of co-purchase, difference in category 
-- (cross-category bundles are valuable), and combined margin potential.

-- Q70. Myntra's size/variant optimization needs to rank product variants by 
-- sales velocity within their parent product. Slow-moving variants might be 
-- candidates for discontinuation.

-- Q71. Amazon India's shipping carrier negotiation needs to rank carriers by 
-- performance-cost balance. Carriers with good delivery rank (on-time) but 
-- also good cost rank (lower costs) should be preferred.

-- Q72. Swiggy's menu engineering needs to rank products by contribution margin 
-- AND popularity. Create a 2x2 matrix classification (Stars, Plowhorses, Puzzles, Dogs) 
-- using ranking in both dimensions.

-- Q73. PhonePe's customer risk scoring needs to rank customers by risk indicators. 
-- High return rate rank, payment failure patterns (if derivable), and unusual 
-- ordering patterns contribute to risk ranking.

-- Q74. Ola's territory planning needs to rank regions by expansion priority. 
-- Regions with high population proxy (postal code count) but low store penetration 
-- rank are expansion opportunities.

-- Q75. Paytm's product discovery optimization needs to rank products by 
-- "hidden gem" status - products with high rating rank but low sales rank. 
-- These need better visibility.

-- Q76. IRCTC's employee promotion readiness needs to rank employees by composite 
-- performance: attendance rank, salary growth rank (from history), and department 
-- performance rank. Identify top candidates per department.

-- Q77. Reliance Retail's assortment optimization needs to rank categories by 
-- depth appropriateness. Categories where top-ranked products capture most sales 
-- (high concentration) might need less depth than diverse categories.

-- Q78. Flipkart's customer retention needs to rank customers by churn risk 
-- using behavioral signals: declining order frequency rank, increasing days-between-orders, 
-- and decreasing order value rank trajectory.

-- Q79. Zomato's new product launch needs to rank launch candidates by success 
-- probability. Analyze similar products' launch trajectory (sales rank improvement 
-- over first 3 months) to predict new product success.

-- Q80. BigBasket's capacity planning needs to rank products by demand volatility. 
-- Products with high variance in weekly sales ranks need more safety stock. 
-- Calculate rank volatility and prioritize.

-- Q81. Myntra's influencer collaboration needs to rank products by 
-- social proof effectiveness. Products where rating/review count rank 
-- significantly exceeds sales rank might benefit from influencer push.

-- Q82. Amazon India's subscription candidacy needs to rank products by 
-- replenishment predictability. Products purchased repeatedly by same customers 
-- with consistent intervals (rankable by purchase frequency) are subscription candidates.

-- Q83. Swiggy's kitchen efficiency (simulated through order patterns) needs to 
-- identify peak complexity times. Rank time periods by order complexity 
-- (items per order, category diversity per order).

-- Q84. PhonePe's payment failure analysis needs to rank orders by failure risk. 
-- Large orders (high amount rank), unusual payment modes for the customer, 
-- and first-time payment mode usage increase risk.

-- Q85. Ola's supplier exclusivity analysis needs to rank suppliers by uniqueness. 
-- Suppliers whose products have no alternatives in their category (unique category 
-- coverage) are more critical and should rank higher.

-- Q86. Paytm's store performance diagnosis needs to identify underperformance causes. 
-- Compare each store's rank in: location quality (customer density), assortment 
-- (product variety), and execution (conversion rate). Identify which dimension lags.

-- Q87. IRCTC's order priority in fulfillment needs a comprehensive priority rank. 
-- Consider: order age (older = higher priority), customer tier, order value rank, 
-- and delivery SLA commitment. Build composite priority ranking.

-- Q88. Reliance Retail's seasonal hiring needs to rank months by staffing gap. 
-- Compare order volume rank with average staff availability (from attendance) 
-- across months to identify understaffed periods.

-- Q89. Flipkart's cross-border potential (simulated) needs to rank products by 
-- export-worthiness. Products with high domestic rank, unique category positioning, 
-- and manageable size/weight (via price-as-proxy) are candidates.

-- Q90. Zomato's customer education needs to rank customers by category expansion 
-- potential. Customers who rank high in some categories but have never purchased 
-- from related categories are education opportunities.

-- Q91. BigBasket's returns reverse logistics needs to rank return locations by 
-- processing priority. Locations with high return volume rank but low processing 
-- capacity (store size proxy) need priority attention.

-- Q92. Myntra's loyalty program effectiveness needs to rank customers by loyalty ROI. 
-- Compare points redemption rank with spending increase rank post-enrollment. 
-- High redemption but low spending increase indicates program gaming.

-- Q93. Amazon India's product page optimization needs to rank products by 
-- conversion gap. Products with high page-view rank (simulated via consideration) 
-- but low purchase rank have conversion issues.

-- Q94. Swiggy's supplier payment terms need to rank suppliers by financial importance. 
-- Suppliers with high revenue contribution rank and high product criticality rank 
-- deserve better payment terms.

-- Q95. PhonePe's store expansion needs to rank potential locations. Use existing 
-- store performance in similar regions, customer density, and competition 
-- (existing store proximity) to rank locations.

-- Q96. Ola's customer segment profitability needs to rank segments by true profit 
-- contribution. Consider: revenue rank, return rate rank, service cost proxy rank. 
-- Combine into profitability ranking.

-- Q97. Paytm's product lifecycle automation needs to rank products by intervention 
-- urgency. Products with rapid rank decline need immediate attention; stable 
-- declining ranks need planned intervention.

-- Q98. IRCTC's demand sensing needs to rank products by demand signal strength. 
-- Products where recent sales rank correlates with inventory movement rank 
-- have stronger demand signals.

-- Q99. Reliance Retail's omnichannel integration needs to rank customers by 
-- channel value. Compare in-store purchase rank with online engagement rank 
-- (email clicks). Identify channel-specific high-value customers.

-- Q100. Flipkart's comprehensive health score needs to build a store-level 
-- health index. Combine ranks from: sales performance, customer satisfaction 
-- (from reviews), operational efficiency (orders/employee), inventory health 
-- (stockout incidents), and employee metrics (attendance). 
-- Weight these ranks and create a final composite health ranking for all stores.

-- ============================================
-- END OF DAY 13 HARD QUESTIONS
-- ============================================
