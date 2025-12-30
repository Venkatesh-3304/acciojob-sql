-- ============================================
-- Day 14: Window Functions Part 2 (Analytics) - HARD Level
-- Student Question Bank
-- ============================================
-- Total Questions: 100
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
-- Interview Focus: Real-world ambiguity, edge cases,
-- complex multi-step analysis, performance considerations
-- ============================================
-- Database: RetailMart (PostgreSQL 16)
-- ============================================

-- Q1. Flipkart's board meeting requires a "momentum score" for each category. The score should reflect whether sales are accelerating (positive momentum), stable, or decelerating. Calculate month-over-month growth rate for each category, then compute the change in growth rate (second derivative). Categories where growth rate itself is increasing should be flagged as "Accelerating" even if absolute growth is negative.

-- Q2. Zomato's data science team is building a customer churn prediction model. They need to identify "at-risk" customers whose order frequency is declining. For each customer, calculate the average gap between their last 3 orders and compare it with the average gap between their first 3 orders. Flag customers where recent gaps are more than 50% longer than initial gaps.

-- Q3. BigBasket's inventory team discovered that simple reorder points don't work well. They need a dynamic reorder point based on the product's 30-day moving average daily sales, plus 2 standard deviations as safety stock. Calculate this for each product using window functions, considering only days with actual sales (ignore zero-sale days).

-- Q4. Amazon India's search ranking team needs relevance decay analysis. For each search term, calculate how quickly click-through rates decay for results beyond position 1. Show each position's CTR as a percentage of position 1's CTR, and identify search terms where position 3+ results get disproportionately low engagement.

-- Q5. Myntra's fashion trend team needs to identify "flash trends" versus "sustained trends." For each product, calculate the 7-day moving average of sales, and flag products where sales exceeded 3x the moving average for more than 3 consecutive days, then dropped below the moving average within 14 days.

-- Q6. PhonePe's risk team needs velocity checks. For each user, identify transactions that occurred within 5 minutes of the previous transaction AND where the cumulative amount in the past hour exceeded the user's typical daily average. Include the time gap and cumulative amounts in the output.

-- Q7. Swiggy's dynamic pricing team needs demand elasticity analysis. For each restaurant, when prices changed, calculate the percentage change in orders for the 7 days after versus 7 days before. Only include restaurants with at least 3 price change events for statistical significance.

-- Q8. Ola's driver allocation algorithm needs heat map predictions. For each zone and hour, calculate the current demand, the demand at the same hour yesterday, same hour last week, and a weighted average (50% today's previous hours, 30% yesterday, 20% last week) as the prediction baseline.

-- Q9. IRCTC's revenue management team needs price sensitivity analysis. For each route, identify booking patterns at different price points. Calculate the conversion rate (bookings/searches) at each price tier, and find the price point with the highest revenue per search (price × conversion rate).

-- Q10. Reliance Retail's market basket analysis needs sequential pattern mining. For customers who bought product A, what did they buy next (in their next order)? Calculate the probability of each follow-up product and identify the top 3 most likely next purchases for each product.

-- Q11. Paytm's credit scoring team needs payment behavior scoring. For each borrower, calculate the consistency of their payment amounts (coefficient of variation), the trend in payment amounts (increasing/decreasing), and the gap between due date and actual payment date trend over time.

-- Q12. Flipkart's seller health dashboard needs comprehensive metrics. For each seller, calculate: (a) month-over-month sales growth, (b) 90-day moving average of order defect rate, (c) improvement trajectory of shipping SLA compliance over last 6 months. Combine these into a health score using weighted averages.

-- Q13. Zomato's restaurant recommendation engine needs freshness scoring. Calculate a "review recency" score for each restaurant where recent reviews (last 30 days) count more than older ones. Use exponential decay: reviews lose 50% weight every 30 days. Show the weighted average rating using this decay.

-- Q14. BigBasket's fresh produce team needs wastage prediction. For each product, analyze the pattern between days-to-expiry at arrival and eventual wastage percentage. Calculate the running correlation between these metrics over rolling 30-day windows to detect seasonal changes in the relationship.

-- Q15. Amazon India's A/B testing platform needs statistical significance calculation. For each experiment, calculate daily conversion rates for control and treatment, running Z-scores for the difference, and the first day when the running Z-score exceeded 1.96 (95% confidence) and stayed above for 3 consecutive days.

-- Q16. Myntra's size recommendation engine needs return pattern analysis. For each product-size combination, calculate the return rate alongside the product's overall return rate. Flag sizes where return rate is more than 2 standard deviations above the product mean, suggesting sizing issues.

-- Q17. PhonePe's international remittance team needs exchange rate timing analysis. For each currency pair, calculate the 30-day high, 30-day low, current rate's percentile within that range, and the optimal time to transact based on day-of-week patterns in historical rates.

-- Q18. Swiggy's kitchen optimization team needs prep time prediction. For each restaurant-dish combination, calculate the base prep time (median), the impact of order volume on prep time (correlation), and peak hour multipliers by comparing peak vs off-peak average prep times.

-- Q19. Ola's subscription team needs lifetime value modeling. For each subscription cohort (by start month), track monthly revenue, cumulative revenue, monthly churn rate, and survival rate. Project the cohort's ultimate LTV using the observed decay pattern.

-- Q20. IRCTC's dynamic availability team needs overbooking optimization. For each route-class combination, calculate the historical no-show rate (30-day moving), the variance in no-shows, and the optimal overbooking level that maximizes expected revenue while keeping bumping probability below 5%.

-- Q21. Reliance Retail's assortment planning team needs lifecycle analysis. For each product, identify the lifecycle stage based on sales trajectory: Introduction (accelerating growth), Growth (high positive growth), Maturity (stable), Decline (negative growth). Use 3-month trends for classification.

-- Q22. Paytm's customer service needs workload forecasting. For each support category, calculate hourly ticket volume alongside 4-week historical pattern for that hour-day combination. Identify hours consistently exceeding capacity (90th percentile of historical volume for that hour).

-- Q23. Flipkart's mobile app team needs engagement funnel analysis. For each user session, calculate time between funnel stages (browse→cart→checkout→payment→confirm), compare with user's historical average times, and flag sessions with unusually long delays at specific stages.

-- Q24. Zomato's partner success team needs early warning indicators. For each restaurant, calculate the 7-day moving trend of: order volume, average rating, prep time, and cancellation rate. Combine these into an "at-risk" score where declining trends in 3+ metrics triggers an alert.

-- Q25. BigBasket's demand forecasting needs seasonality decomposition. For each product category, calculate the seasonal index for each month (current month sales / 12-month moving average), then use these indices to de-seasonalize recent sales for true trend analysis.

-- Q26. Amazon India's Sponsored Products team needs bid optimization data. For each keyword, calculate the relationship between bid amount and impression share using moving window correlation. Identify keywords where higher bids show diminishing returns (correlation drops in recent data).

-- Q27. Myntra's visual search team needs similarity scoring validation. For each product, when shown as a similar item to another product, calculate the click-through rate and compare with the overall similar items CTR. Rank products by how well they convert as similar recommendations.

-- Q28. PhonePe's bill payments team needs autopay success prediction. For each user-biller combination, calculate the historical success rate, trend in success rate, and the pattern of which attempt (1st, 2nd, 3rd) typically succeeds. Flag combinations likely to fail on first attempt.

-- Q29. Swiggy's cloud kitchen placement team needs demand density analysis. For each locality, calculate the order density (orders per sq km per hour) across different hours, compare with city average density at those hours, and identify localities with peak demand higher than nearest kitchen capacity.

-- Q30. Ola's EV fleet team needs range optimization data. For each vehicle-route combination, calculate actual range achieved alongside predicted range, the gap trend over time (battery degradation proxy), and comparison with fleet average degradation rate for similar vehicles.

-- Q31. IRCTC's tatkal quota optimization needs demand pattern analysis. For each route-day combination, calculate the time when 25%, 50%, 75%, and 90% of tatkal quota gets consumed, comparing with previous 4 weeks' patterns to identify demand surges.

-- Q32. Reliance Retail's private label team needs price gap analysis. For each category, calculate the price difference between the leading national brand and the private label, track how this gap has changed over time, and correlate gap changes with private label market share changes.

-- Q33. Paytm's first-party data team needs user identity resolution confidence. For each potential match (phone-email-device combination), calculate the confidence score based on co-occurrence frequency, recency of co-occurrence, and pattern consistency (same location, time patterns).

-- Q34. Flipkart's catalog quality team needs attribute coverage scoring. For each category, calculate the percentage of products with each key attribute filled, track the improvement trend, and identify categories where coverage is declining despite more products being added.

-- Q35. Zomato's Gold membership team needs value perception analysis. For each Gold member, calculate the savings from membership (discounts received vs subscription cost), compare with their expected savings based on visit frequency, and identify members at risk of not renewing.

-- Q36. BigBasket's supplier financing team needs working capital analysis. For each supplier, calculate the average days-sales-outstanding (DSO) trend, compare with category average DSO, and identify suppliers whose DSO is improving faster than average (good financing candidates).

-- Q37. Amazon India's Subscribe & Save team needs optimal frequency recommendation. For each customer-product combination, calculate the actual consumption rate (based on reorder timing), compare with the selected subscription frequency, and identify mismatches causing early/late deliveries.

-- Q38. Myntra's influencer marketing team needs ROI attribution analysis. For each influencer campaign, calculate sales lift in the 7 days post-campaign versus 7 days pre-campaign, control for overall platform sales trends using ratio-to-moving-average method.

-- Q39. PhonePe's mutual fund team needs SIP behavior analysis. For each SIP holder, calculate the consistency score (actual investments vs planned), the trend in investment amounts, and correlation between market drops and SIP pauses/cancellations.

-- Q40. Swiggy's food safety team needs inspection prioritization. For each restaurant, calculate a risk score based on: time since last inspection, complaint trend, hygiene score trend, and order volume. Weight recent data more heavily using exponential decay.

-- Q41. Ola's carpool matching algorithm needs reliability scoring. For each user offering carpool, calculate their commitment rate (rides offered vs rides completed), punctuality score (actual vs promised pickup time), and trend in these metrics over the past 30 days.

-- Q42. IRCTC's tourism packages need dynamic pricing data. For each package-departure combination, calculate the booking pace (cumulative bookings by days-before-departure) compared with similar packages' historical pace. Flag packages running significantly behind pace for price adjustments.

-- Q43. Reliance Retail's fresh replenishment team needs demand synchronization analysis. For each store-product combination, calculate the correlation between order timing and actual sales patterns, identifying products where current ordering cadence doesn't match demand patterns.

-- Q44. Paytm's UPI team needs transaction success prediction. For each bank-time combination, calculate historical success rates, trend in success rates, and identify bank-specific peak failure times. Provide a "safe to transact" confidence score for each combination.

-- Q45. Flipkart's Plus membership needs engagement decay analysis. For each Plus member, calculate their platform visit frequency trend, purchase frequency trend, and benefits utilization trend since joining. Identify members showing engagement decay patterns.

-- Q46. Zomato's kitchen partner team needs menu optimization data. For each restaurant, calculate each dish's contribution to revenue, trend in that contribution, and identify dishes whose share is declining but still heavily promoted in the menu.

-- Q47. BigBasket's customer acquisition team needs cohort quality comparison. For each acquisition channel and cohort month, calculate 30-day, 60-day, and 90-day retention alongside cohort LTV at each milestone. Compare cohort quality across channels controlling for seasonality.

-- Q48. Amazon India's logistics cost optimization needs route efficiency analysis. For each delivery route, calculate cost per package alongside volume handled, identify the volume threshold where route becomes efficient, and track how many days the route operates below efficiency threshold.

-- Q49. Myntra's personalization team needs fashion affinity scoring. For each customer, calculate their purchase distribution across style clusters, track how these preferences are evolving (shifting between clusters), and identify customers with unstable preferences needing more exploration.

-- Q50. PhonePe's merchant category team needs business health indicators. For each merchant, calculate: days since last transaction, 30-day transaction trend, average transaction value trend, and weekly pattern consistency. Flag merchants showing signs of business decline.

-- Q51. Swiggy's customer happiness team needs experience degradation analysis. For each customer, calculate the moving average of their order ratings, identify inflection points where ratings started declining, and correlate with specific experience factors (delay, missing items, etc.).

-- Q52. Ola's pricing strategy team needs competitive response analysis. When competitor pricing changed (detected through booking pattern shifts), calculate the time lag before own bookings were affected, the magnitude of impact, and the recovery time after price match.

-- Q53. IRCTC's accessibility team needs assistance demand forecasting. For each station, calculate wheelchair assistance requests by train-time combination, compare with similar requests at nearby major stations, project demand for new trains based on comparable route patterns.

-- Q54. Reliance Retail's markdown optimization needs price elasticity by lifecycle stage. For each product, calculate how price elasticity differs between regular season and markdown period, identify products where deeper markdowns don't proportionally increase sales.

-- Q55. Paytm's rewards program needs point velocity analysis. For each user tier, calculate the average time to earn enough points for common redemptions, compare with the redemption expiry period, and identify tier-reward combinations with poor earn-burn balance.

-- Q56. Flipkart's Supermart needs basket building analysis. For each order, calculate items added over time, identify the "anchor item" (first item with highest correlation to basket size), and measure how basket value grows after anchor item is added.

-- Q57. Zomato's Pro membership needs dining pattern analysis. For each Pro member, calculate dining frequency by restaurant tier, trend in tier preference (trading up/down), and correlation between Pro discount availability and tier selection.

-- Q58. BigBasket's slot capacity team needs no-show prediction. For each customer-slot combination, calculate historical no-show probability based on: day-of-week pattern, order value, time-since-booking, and customer's overall no-show rate. Create a no-show risk score.

-- Q59. Amazon India's returns processing needs cost prediction. For each return request, calculate expected processing cost based on: product category cost pattern, customer's return condition history, and distance to nearest processing center. Compare actual vs predicted.

-- Q60. Myntra's studio content team needs style performance analysis. For each photoshoot style (model pose, background, etc.), calculate the conversion rate impact, control for product quality using product's historical baseline, and identify style treatments that consistently lift conversion.

-- Q61. PhonePe's insurance claims team needs fraud ring detection inputs. For each claim, calculate behavioral similarity scores with previous claims: same device, same location pattern, same beneficiary bank, time gap from policy purchase. Aggregate into risk score.

-- Q62. Swiggy's brand partnership team needs campaign attribution. When a brand runs a promotion, calculate incremental orders by comparing actual orders with prediction based on pre-campaign trend. Account for overall platform growth during the same period.

-- Q63. Ola's vehicle quality team needs maintenance prediction refinement. For each vehicle, calculate how actual maintenance needs compare with mileage-based predictions, identify vehicles aging faster than expected, and quantify the gap in maintenance schedule accuracy.

-- Q64. IRCTC's feedback team needs sentiment trend analysis preparation. For each route, calculate the proportion of each complaint category over time, identify categories with increasing share, and correlate with operational metrics (delays, cleanliness scores).

-- Q65. Reliance Retail's store clustering team needs performance peer comparison. For each store, identify the 5 most similar stores (by size, location type, demographics), calculate each metric as deviation from peer group average, enabling true performance assessment.

-- Q66. Paytm's stock broking team needs portfolio risk indicators. For each customer's portfolio, calculate the rolling beta (correlation with market index), identify periods of increased correlation (systemic risk exposure), and compare with historical pattern.

-- Q67. Flipkart's brand protection team needs counterfeit detection signals. For each seller-brand combination, calculate: price deviation from brand average, return rate versus brand average, customer complaint rate trend. Score combinations for investigation priority.

-- Q68. Zomato's hyperlocal team needs demand redistribution analysis. When a popular restaurant goes offline, calculate how orders redistribute to nearby restaurants of similar cuisine, the time for normal patterns to resume, and permanent share shifts.

-- Q69. BigBasket's private label team needs cannibalization measurement. When a new private label SKU launches, calculate the sales impact on competing national brands and other private label SKUs. Separate true market expansion from cannibalization.

-- Q70. Amazon India's fashion team needs size curve optimization. For each product style, calculate the actual size distribution of sales versus inventory distribution, identify sizes consistently over/understocked, and quantify lost sales from stockouts.

-- Q71. Myntra's retention team needs win-back timing optimization. For churned customers, analyze their historical activity decay pattern before churn, calculate the optimal time to send win-back campaigns based on when similar customers responded best.

-- Q72. PhonePe's switch team needs provider affinity analysis. For each utility category, calculate customer switching patterns between providers, time between switches, and correlation between service issues and switching. Identify sticky vs. switching-prone segments.

-- Q73. Swiggy's store operations team needs prep capacity planning. For each restaurant, calculate peak concurrent order load, compare with observed prep time degradation at different load levels, and identify the capacity ceiling where quality suffers.

-- Q74. Ola's demand prediction team needs event impact quantification. When major events occur (concerts, matches), calculate the demand multiplier at nearby pickup points, the geographic spread of demand increase, and the lead time before demand spikes.

-- Q75. IRCTC's catering team needs meal preference prediction. For each route-meal combination, calculate preference patterns by passenger demographics, time-of-day patterns, and seasonal variations. Improve load factors by better matching supply to predicted demand.

-- Q76. Reliance Retail's energy team needs consumption forecasting. For each store, calculate hourly energy consumption patterns, correlation with footfall, and variance from baseline by season. Project daily energy needs for cost management.

-- Q77. Paytm's postpaid team needs credit limit optimization. For each user, calculate their utilization pattern (% of limit used), repayment timing consistency, and correlation between limit increases and utilization. Identify users likely to utilize more limit responsibly.

-- Q78. Flipkart's video commerce team needs engagement-to-conversion analysis. For each live session, calculate viewership decay curve (viewers remaining at each minute), correlation between specific moments and purchase spikes, and optimal session length by category.

-- Q79. Zomato's cloud kitchen team needs cuisine demand gap analysis. For each locality, calculate cuisine-wise order share, compare with city-average share, identify cuisines with suppressed demand (lower share due to limited supply), and quantify the opportunity.

-- Q80. BigBasket's quality team needs vendor quality trending. For each vendor-product combination, calculate defect rate trend, seasonality in defect rates, and comparison with category benchmark. Identify combinations needing intervention before they breach thresholds.

-- Q81. Amazon India's deals team needs conversion decay analysis. For each deal, calculate hour-by-hour conversion rate, the decay rate (how quickly conversion drops from launch), and comparison with similar deals. Optimize deal duration based on decay patterns.

-- Q82. Myntra's styling team needs outfit completion analysis. For each product purchase, calculate the probability of follow-up complementary purchases, the typical time gap, and which complementary items are most likely. Build outfit recommendation timing logic.

-- Q83. PhonePe's expense management team needs spending anomaly detection. For each user, calculate category-wise spending patterns, identify months with unusual distribution (high Z-score in any category), and flag for potential fraud or life event detection.

-- Q84. Swiggy's membership team needs upgrade propensity modeling data. For each free-tier user, calculate behaviors that correlate with eventual upgrade: order frequency trend, discount sensitivity, peak hour ordering pattern. Score users for upgrade targeting.

-- Q85. Ola's corporate team needs policy compliance monitoring. For each corporate account, calculate: policy violation frequency, trend in violations, categories of violations, and comparison with similar accounts. Identify accounts needing policy review.

-- Q86. IRCTC's station team needs amenity utilization analysis. For each station amenity (lounge, parking, cloakroom), calculate utilization by hour-day combination, revenue per user trend, and correlation with train schedules. Optimize operating hours.

-- Q87. Reliance Retail's omnichannel team needs channel migration analysis. For each customer, track their channel usage evolution over time, identify migration triggers (first online purchase after store-only, or vice versa), and quantify impact on overall spending.

-- Q88. Paytm's soundbox team needs merchant activity decay detection. For each soundbox, calculate daily transaction count trend, compare with merchant's overall transaction trend (across channels), and flag soundboxes being abandoned despite active merchant.

-- Q89. Flipkart's fulfillment team needs delivery promise accuracy analysis. For each promise type (same-day, next-day, standard), calculate actual vs promised delivery rate trend, identify routes with deteriorating reliability, and correlate with capacity utilization.

-- Q90. Zomato's nutrition team needs healthy choice trends. For each locality, calculate the proportion of "healthy tag" orders over time, compare with city trend, and identify localities with growing health consciousness for targeted restaurant onboarding.

-- Q91. BigBasket's substitution team needs preference learning. For each customer, analyze their acceptance pattern for substitutions: acceptance rate by category, price-tier tolerance, brand flexibility. Build personalized substitution preference scores.

-- Q92. Amazon India's advertising team needs incrementality measurement. For each advertiser, calculate sales during and after ad campaign, establish baseline using pre-campaign trend, control for seasonality using same-period-last-year data, and quantify true ad incrementality.

-- Q93. Myntra's customer support needs issue escalation prediction. For each ticket, calculate probability of escalation based on: issue type historical escalation rate, customer's previous escalation pattern, current ticket age vs average resolution time. Prioritize high-risk tickets.

-- Q94. PhonePe's lending team needs early warning indicators for default. For each borrower, calculate: payment timing deterioration (are they paying later each month?), partial payment trend, balance utilization trend. Score borrowers for collections outreach.

-- Q95. Swiggy's sustainability team needs packaging optimization data. For each restaurant, calculate the relationship between order frequency and packaging waste (estimated from order size), identify restaurants with high waste per order, and quantify potential savings from package right-sizing.

-- Q96. Ola's ride quality team needs driver behavior trending. For each driver, calculate smoothness score trend (based on accelerometer data), correlation between ride ratings and smoothness, and identify drivers whose behavior is deteriorating for coaching.

-- Q97. IRCTC's crowd management needs platform congestion prediction. For each station platform, calculate historical passenger density by train-arrival combination, variance in density, and correlation with delay. Predict congestion risk for upcoming train arrivals.

-- Q98. Reliance Retail's loyalty team needs breakage prediction refinement. For each customer tier, calculate the distribution of points expiring unutilized, patterns before expiry (were customers active?), and identify at-risk customers for reminders.

-- Q99. Paytm's travel team needs trip pattern prediction. For each user, analyze their travel seasonality (when do they typically book?), preferred booking lead time, and correlation between work calendar (weekend/holiday patterns) and travel bookings.

-- Q100. Flipkart's ONDC team needs catalog gap analysis. For each category in new geographies, calculate the demand proxy (searches without results), compare with supply in nearby established geographies, and prioritize seller onboarding by gap magnitude.


-- ============================================
-- END OF DAY 14 HARD QUESTIONS
-- ============================================
-- Total: 100 Questions
-- Focus: Interview-level complexity, real-world ambiguity,
-- multi-step analysis, edge cases
-- Next Step: Wait for approval before generating solutions
-- ============================================
