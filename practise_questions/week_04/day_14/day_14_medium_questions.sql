-- ============================================
-- Day 14: Window Functions Part 2 (Analytics) - MEDIUM Level
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
-- Database: RetailMart (PostgreSQL 16)
-- ============================================

-- Q1. Flipkart's sales analytics team is preparing their weekly review. They need each store's daily sales along with the previous day's sales and the percentage change between them. The CFO wants to quickly spot stores with declining trends.

-- Q2. Zomato's restaurant success team wants to identify restaurants whose ratings are improving. For each restaurant, they need the current month's average rating alongside last month's average rating, showing only those where ratings improved.

-- Q3. BigBasket's supply chain head is analyzing inventory movements. They need a running total of stock additions for each product, resetting at the start of each month, to understand monthly replenishment patterns.

-- Q4. Amazon India's finance team is tracking payment processing efficiency. They want to see each payment with the time gap (in days) since the previous payment for the same order, flagging orders with gaps exceeding 3 days.

-- Q5. Myntra's category managers need to understand price positioning. For each product, they want to see how its price compares to the first (lowest) and last (highest) priced product in its category when sorted by price.

-- Q6. PhonePe's risk analytics team is building a fraud detection report. They need each transaction with the previous transaction amount for the same customer, highlighting cases where the current amount is more than 5 times the previous.

-- Q7. Swiggy's operations team wants to analyze delivery partner performance trends. They need a 7-day moving average of completed deliveries per partner, comparing it with their overall average to identify consistent performers.

-- Q8. Ola's business intelligence team is calculating driver earnings trends. For each driver, they want weekly earnings with the cumulative earnings year-to-date, plus the percentage of annual target achieved.

-- Q9. IRCTC's revenue optimization team needs route performance analysis. They want each route's monthly bookings alongside the route's peak month bookings (using FIRST_VALUE on sorted data) to measure capacity utilization.

-- Q10. Reliance Retail's HR analytics team is studying attrition patterns. They need each employee's tenure alongside the department's longest-serving employee's tenure, and which quartile each employee falls into by tenure.

-- Q11. Paytm's merchant analytics team wants to segment merchants by transaction volume. They need each merchant's monthly volume, its percentile rank, and which decile they belong to for commission tier discussions.

-- Q12. Flipkart's customer insights team is analyzing purchase frequency. For each customer, they want the average gap between consecutive orders, showing customers whose purchase frequency is accelerating (decreasing gap).

-- Q13. Zomato's marketing team needs campaign effectiveness analysis. They want each campaign's daily spend alongside a 5-day moving average of conversions, and the running ROI since campaign start.

-- Q14. BigBasket's warehouse team is optimizing stock levels. They need each product's current stock, the stock level 30 days ago, and the cumulative stock turnover (quantity sold) in between.

-- Q15. Amazon India's customer service team is tracking complaint resolution. They want each complaint with the days since the previous complaint for that customer, identifying repeat complainers within 7 days.

-- Q16. Myntra's pricing team needs competitive analysis preparation. For each category, they want the median-priced product (using NTILE and filtering) along with products priced above the 90th percentile.

-- Q17. PhonePe's product team is analyzing feature adoption. They need daily active users with the 7-day moving average, and the growth rate compared to the same day previous week using LAG.

-- Q18. Swiggy's finance team needs vendor payment analysis. They want each payment with the cumulative amount paid to each vendor year-to-date, and the percentage of annual contract value utilized.

-- Q19. Ola's surge pricing team needs demand pattern analysis. They want hourly ride requests with a 3-hour moving average, identifying hours where demand exceeds 150% of the moving average.

-- Q20. IRCTC's customer analytics team is building a loyalty segmentation. They need each customer's booking count, their cumulative distribution rank, and categorization into Bronze/Silver/Gold/Platinum tiers.

-- Q21. Reliance Retail's sales team needs store-wise trend analysis. For each store, they want monthly revenue with month-over-month growth percentage and a 3-month moving average for smoothed trends.

-- Q22. Paytm's fraud team is analyzing suspicious patterns. They want each transaction with the count of transactions in the previous 1 hour for the same user, flagging users with more than 10 rapid transactions.

-- Q23. Flipkart's logistics team needs delivery performance tracking. They want each delivery with the previous delivery time for the same route, calculating whether delivery times are improving or worsening.

-- Q24. Zomato's data science team is preparing features for ML models. They need each order with the customer's previous order amount, days since last order, and running average order value.

-- Q25. BigBasket's category team needs price elasticity analysis data. For each product price change, they want the sales before and after (using LAG/LEAD), and the percentage change in sales.

-- Q26. Amazon India's seller performance team needs quality metrics. They want each seller's monthly return rate alongside the platform average return rate (using window without partition) for comparison.

-- Q27. Myntra's inventory team is identifying slow-moving products. They need each product's last sale date, days since last sale, and comparison with category average days-between-sales.

-- Q28. PhonePe's compliance team needs transaction monitoring. They want each transaction with cumulative daily total per user, flagging when cumulative exceeds the user's previous 7-day average by 200%.

-- Q29. Swiggy's restaurant team needs quality trend analysis. For each restaurant, they want weekly average ratings with the trend direction (improving/stable/declining) based on 4-week comparison.

-- Q30. Ola's fleet management team needs maintenance prediction data. They want each vehicle's ride count since last service, the date of last service (using LAG on service records), and projected next service date.

-- Q31. IRCTC's pricing team needs demand forecasting inputs. They want each route's daily bookings with the same-day-previous-week bookings, same-day-previous-month, and year-over-year comparison.

-- Q32. Reliance Retail's promotion team needs campaign lift analysis. They want each store's daily sales during promotions with the pre-promotion 7-day average as baseline for calculating lift percentage.

-- Q33. Paytm's customer team needs engagement scoring. They want each customer's transaction count this month, last month (LAG), and a 3-month trend indicator showing increasing/decreasing/stable engagement.

-- Q34. Flipkart's returns team needs pattern analysis. For each product, they want the return rate trend showing current month's rate alongside 3-month moving average, identifying products with worsening return rates.

-- Q35. Zomato's business team needs market share tracking. They want each city's monthly order count with cumulative percentage of national total, identifying cities contributing to top 80% of orders.

-- Q36. BigBasket's operations team needs delivery efficiency metrics. They want each delivery's time alongside the day's first and last delivery times for the same driver, calculating shift utilization.

-- Q37. Amazon India's buy box team needs pricing dynamics data. For each product, they want hourly price with previous hour's price and next hour's price, identifying price volatility periods.

-- Q38. Myntra's flash sale team needs demand surge analysis. They want minute-by-minute order counts during sales with a 5-minute moving average, identifying peak surge minutes.

-- Q39. PhonePe's rewards team needs point accumulation analysis. For each customer, they want monthly points earned with cumulative total, and months until they reach the next reward tier.

-- Q40. Swiggy's partner team needs commission tier analysis. They want each partner's monthly GMV, their percentile rank, and comparison with the median partner's GMV in their city.

-- Q41. Ola's customer team needs ride pattern analysis. For each customer, they want their typical ride frequency (days between rides) and whether their latest ride was earlier or later than typical.

-- Q42. IRCTC's operations team needs capacity planning data. They want each train's daily occupancy alongside the previous 7-day average occupancy, flagging trains consistently above 90% capacity.

-- Q43. Reliance Retail's buying team needs vendor performance comparison. For each vendor, they want monthly delivery fill rate alongside the category average fill rate (window without partition by vendor).

-- Q44. Paytm's product team needs conversion funnel analysis. They want each step's daily conversion rate with the 7-day moving average, identifying days with significantly lower conversion.

-- Q45. Flipkart's category team needs bestseller tracking. For each category, they want daily top-seller product alongside previous day's top-seller, identifying products that maintained top position for 7+ consecutive days.

-- Q46. Zomato's pricing team needs dynamic pricing inputs. They want hourly order volumes per area with the area's typical hourly volume (monthly average for that hour), calculating demand multiplier.

-- Q47. BigBasket's customer team needs reorder prediction data. For each customer-product pair, they want the typical days between reorders and days since last purchase for proactive marketing.

-- Q48. Amazon India's advertising team needs ROAS trending. They want each campaign's daily ROAS with 7-day moving average ROAS, identifying campaigns with declining returns.

-- Q49. Myntra's personalization team needs browse-to-buy analysis. For each customer, they want the number of sessions before purchase, comparing with their historical average sessions-to-purchase.

-- Q50. PhonePe's business team needs growth metrics. They want monthly transaction values with year-over-year growth rate (comparing to same month last year using LAG with offset 12 in monthly data).

-- Q51. Swiggy's restaurant success team needs review velocity tracking. For each restaurant, they want monthly review count alongside cumulative total reviews, and the restaurant's share of city reviews.

-- Q52. Ola's pricing team needs fare analysis. They want each ride's fare alongside the route's typical fare (median using PERCENTILE_CONT or approximated using NTILE), flagging outlier fares.

-- Q53. IRCTC's marketing team needs booking pattern analysis. They want each booking with the days-before-travel it was made, comparing with the route's typical advance booking period.

-- Q54. Reliance Retail's space planning team needs category productivity data. They want each category's sales per square foot with store rank and comparison to chain average.

-- Q55. Paytm's insurance team needs claim pattern analysis. They want each claim with the customer's previous claim date, days between claims, and cumulative claim amount per customer.

-- Q56. Flipkart's warehouse team needs picking efficiency data. They want each order's picking time alongside the hour's average picking time and the picker's personal average picking time.

-- Q57. Zomato's data team needs cohort retention analysis. For each customer cohort (by join month), they want monthly active users with retention rate compared to the cohort's first month.

-- Q58. BigBasket's pricing team needs margin trend analysis. They want each product's monthly margin alongside 3-month moving average margin, identifying products with declining margins.

-- Q59. Amazon India's search team needs relevance metrics. They want each search query's click-through rate alongside the category's average CTR, identifying underperforming queries.

-- Q60. Myntra's supply team needs vendor lead time analysis. For each order to vendor, they want the lead time alongside the vendor's average lead time and their best/worst lead times.

-- Q61. PhonePe's credit team needs repayment pattern analysis. For each borrower, they want monthly repayment alongside cumulative repaid amount and percentage of loan repaid.

-- Q62. Swiggy's operations team needs zone efficiency tracking. They want each zone's hourly deliveries alongside zone capacity and the percentage capacity utilization with 3-hour moving average.

-- Q63. Ola's driver team needs incentive calculation. For each driver, they want daily rides with cumulative weekly rides and distance to next incentive tier milestone.

-- Q64. IRCTC's revenue team needs yield management data. They want each booking's ticket price alongside the route's average price that day, minimum and maximum prices, for price band analysis.

-- Q65. Reliance Retail's loss prevention team needs shrinkage analysis. They want each store's monthly shrinkage alongside 6-month moving average, flagging stores with worsening shrinkage trends.

-- Q66. Paytm's wallet team needs balance trend analysis. For each user, they want daily closing balance alongside 7-day average balance and comparison with previous month's average.

-- Q67. Flipkart's seller team needs SLA compliance tracking. They want each order's shipping time alongside seller's average shipping time and the platform benchmark, with compliance flag.

-- Q68. Zomato's customer team needs NPS trend analysis. They want monthly NPS score alongside 3-month moving average and comparison with same month previous year.

-- Q69. BigBasket's availability team needs stockout analysis. They want each stockout event with days since previous stockout for the same product, identifying frequently stocking-out items.

-- Q70. Amazon India's FBA team needs storage fee optimization data. They want each product's monthly storage days alongside 3-month average and cumulative storage fees year-to-date.

-- Q71. Myntra's returns team needs quality-related return analysis. For each brand, they want monthly quality returns alongside trend (3-month moving average) and comparison with category average.

-- Q72. PhonePe's support team needs ticket resolution trending. They want each ticket category's daily resolution time alongside 7-day moving average and category benchmark.

-- Q73. Swiggy's marketing team needs promo code effectiveness tracking. For each promo code, they want daily redemptions with running total and percentage of allocated quota used.

-- Q74. Ola's safety team needs incident pattern analysis. For each incident type, they want monthly count alongside 6-month moving average, flagging types with increasing trends.

-- Q75. IRCTC's customer team needs complaint resolution tracking. They want each complaint with resolution time, the category's average resolution time, and percentile rank of resolution time.

-- Q76. Reliance Retail's fresh team needs wastage analysis. For each store, they want daily wastage amount alongside 7-day moving average and comparison with chain average.

-- Q77. Paytm's merchant team needs settlement delay analysis. They want each settlement with delay days, the merchant's average delay, and percentile rank among all merchants.

-- Q78. Flipkart's advertising team needs impression pacing analysis. For each campaign, they want hourly impressions, running total, and percentage of daily target achieved by each hour.

-- Q79. Zomato's kitchen team needs prep time analysis. For each restaurant, they want average prep time by hour alongside restaurant's overall average, identifying peak delay hours.

-- Q80. BigBasket's logistics team needs vehicle utilization analysis. For each vehicle, they want daily trips alongside capacity utilization and comparison with fleet average.

-- Q81. Amazon India's catalog team needs listing quality trending. For each seller, they want monthly listing score alongside 3-month trend and comparison with category median.

-- Q82. Myntra's sizing team needs return analysis by size. For each product-size combination, they want return rate alongside product's overall return rate and category-size return rate.

-- Q83. PhonePe's growth team needs user lifecycle analysis. For each user, they want monthly transaction frequency alongside their all-time monthly average for lifecycle stage classification.

-- Q84. Swiggy's finance team needs working capital analysis. They want daily cash position alongside 7-day moving average and days of operating expenses covered.

-- Q85. Ola's vehicle team needs depreciation tracking. For each vehicle, they want monthly earnings alongside cumulative earnings and percentage of vehicle cost recovered.

-- Q86. IRCTC's catering team needs demand forecasting inputs. They want each route's meal orders alongside previous week's orders and 4-week moving average for ordering.

-- Q87. Reliance Retail's private label team needs performance comparison. For each category, they want private label sales share alongside 6-month trend of share change.

-- Q88. Paytm's checkout team needs abandonment analysis. They want hourly abandonment rate alongside 24-hour moving average, identifying high-abandonment periods.

-- Q89. Flipkart's customer team needs lifetime value trending. For each customer cohort, they want monthly revenue alongside cumulative LTV and comparison with previous cohorts at same age.

-- Q90. Zomato's compliance team needs hygiene score trending. For each restaurant, they want quarterly hygiene scores alongside previous quarter and year-over-year comparison.

-- Q91. BigBasket's slot management team needs capacity optimization data. They want hourly slot bookings alongside slot capacity and cumulative day's bookings by each hour.

-- Q92. Amazon India's brand team needs share of voice analysis. For each brand, they want daily search impressions alongside category total impressions and percentage share.

-- Q93. Myntra's content team needs engagement trending. For each content piece, they want daily views alongside 7-day moving average and comparison with similar content average.

-- Q94. PhonePe's insurance team needs renewal prediction data. For each policy, they want days until renewal, premium amount alongside previous premium, and cumulative premiums paid.

-- Q95. Swiggy's kitchen cloud team needs utilization metrics. For each kitchen, they want hourly orders alongside capacity and peak hour comparison with off-peak moving average.

-- Q96. Ola's corporate team needs account usage trending. For each corporate account, they want monthly rides alongside quarterly moving average and YoY comparison.

-- Q97. IRCTC's tourism team needs package performance analysis. For each package, they want monthly bookings alongside launch month bookings (using FIRST_VALUE) for trend calculation.

-- Q98. Reliance Retail's seasonal team needs year-over-year comparison. For each category, they want monthly sales alongside same month last year sales for seasonal indexing.

-- Q99. Paytm's games team needs retention analysis. For each game, they want daily active users alongside 7-day retention from first play, comparing with category benchmark.

-- Q100. Flipkart's grocery team needs freshness metrics. For each perishable category, they want daily sales alongside inventory days-on-hand and comparison with freshness SLA.


-- ============================================
-- END OF DAY 14 MEDIUM QUESTIONS
-- ============================================
-- Total: 100 Questions
-- Next Step: Wait for approval before generating solutions
-- ============================================
