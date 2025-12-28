-- ============================================
-- Day 10: Self Join, Cross Join & Set Operations - HARD Level
-- Student Question Bank (100 Questions)
-- ============================================
-- Concepts Allowed: All from Day 1-10 including Self Join, CROSS JOIN,
--   UNION, UNION ALL, INTERSECT, EXCEPT, all joins, aggregates,
--   CASE WHEN, COALESCE, GROUP BY, HAVING, ORDER BY, LIMIT
-- Concepts NOT Allowed: Subqueries, CTEs, Window Functions, Views, Functions
-- ============================================
-- Database: RetailMart (PostgreSQL)
-- Focus: Interview-level difficulty, real-world ambiguity, edge cases
-- ============================================

-- =====================
-- SECTION A: ADVANCED SELF JOIN SCENARIOS (Q1-Q30)
-- =====================

-- Q1. During Flipkart's annual compensation review, the HR analytics team discovered an alarming pattern. 
--     They need to identify all employee pairs within the same department where the junior employee 
--     (lower emp_id) actually earns MORE than the senior employee (higher emp_id). This could indicate 
--     either exceptional talent or a pay equity issue that needs immediate attention.

-- Q2. BigBasket's category management team is conducting a competitive price analysis within their own catalog. 
--     They want to find all product pairs from the SAME brand where one product is priced at least 40% higher 
--     than the other, but both products belong to DIFFERENT categories. This reveals brand pricing strategies 
--     across categories.

-- Q3. The RetailMart store network optimization team needs to identify "cannibalizing store pairs" - 
--     stores in the SAME city where one store's total sales are less than 30% of the other store's sales. 
--     Include the sales figures and the percentage difference for management review.

-- Q4. Swiggy's customer intelligence unit wants to identify potential "influencer pairs" - customers 
--     from the same city who joined within 7 days of each other, where both have placed at least 5 orders, 
--     and one has spent more than double what the other has spent. These could be referral relationships.

-- Q5. The Amazon India supplier relationship team has noticed pricing inconsistencies. Find all product pairs 
--     from the same supplier where: (a) both products are in the same category, (b) the price difference 
--     exceeds ₹300, and (c) the cheaper product actually has more inventory than the expensive one.

-- Q6. Myntra's HR department is investigating salary compression issues. Identify employee pairs 
--     in the same store where they have DIFFERENT roles but their salaries differ by less than ₹2000. 
--     This indicates potential role-salary misalignment that needs correction.

-- Q7. The PhonePe fraud detection team wants to find customer pairs from the same state who placed orders 
--     on the SAME date, at the SAME store, and both orders have the status 'Cancelled'. These could be 
--     coordinated fraudulent activities.

-- Q8. RetailMart's inventory optimization team needs to identify product pairs in the same category 
--     where one product is overstocked (stock > 100) at stores where the other product is understocked 
--     (stock < 10). This helps in substitution recommendations.

-- Q9. The Zomato restaurant analytics team (imagining stores as restaurants) wants to find store pairs 
--     in the same region where one store has expenses more than 50% higher than the other, but their 
--     sales are within 10% of each other. These stores have efficiency gaps.

-- Q10. BigBasket's customer retention team wants to identify "customer churn pairs" - customers from 
--      the same city who joined in the same month, but one has ordered in the last 30 days while the 
--      other hasn't ordered in over 90 days. Use the most recent order dates for comparison.

-- Q11. The Flipkart logistics team needs to find store pairs where transferring inventory makes sense: 
--      both stores are in the SAME state but DIFFERENT cities, and the total inventory value 
--      (quantity × product price) at one store is more than 3x the other for the SAME products.

-- Q12. Ola's driver management system (imagining employees as drivers) wants to identify employee pairs 
--      at the same store who have the same role but vastly different attendance patterns - one with 
--      more than 80% attendance and the other with less than 50% attendance in the same month.

-- Q13. The IRCTC vendor team wants to find supplier pairs whose products have overlapping categories. 
--      For each such pair, calculate how many categories they share and how many are unique to each supplier.

-- Q14. RetailMart's pricing team wants to identify "price sandwich" products - products where there exists 
--      another product from the SAME brand that is both cheaper AND more expensive, meaning the product 
--      sits in the middle of the brand's price range.

-- Q15. The Amazon India customer service team needs to find customers who have reviewed the SAME product 
--      but given vastly different ratings (difference of 3 or more stars). These conflicting reviews 
--      need investigation.

-- Q16. Myntra's marketing team wants to find "demographic twins" - customer pairs of the SAME gender 
--      and age (within 2 years) but from DIFFERENT states, who have both spent more than ₹10,000 total. 
--      These pairs help understand regional preferences.

-- Q17. The BigBasket operations team needs to identify store pairs where inventory levels are inversely 
--      correlated: for products stocked at both stores, one store has high stock (>50) while the other 
--      has low stock (<20). Aggregate this across all common products.

-- Q18. Flipkart's campaign analytics team wants to find campaign pairs that overlapped in time 
--      (one campaign's date range intersects with another's) and compare their budget efficiency 
--      (total orders during campaign / budget).

-- Q19. The RetailMart HR team wants to identify "salary progression pairs" - employees in the same 
--      department where one employee's current salary equals another employee's salary from their 
--      salary history. This shows typical career progression paths.

-- Q20. Zomato's expansion team wants to find city pairs where: one city has customers but no stores, 
--      the other has stores but fewer customers per store than average. These represent demand-supply 
--      mismatches for strategic planning.

-- Q21. The PhonePe reconciliation team needs to find order pairs at the same store, same date, 
--      where one order was paid via 'UPI' and the other via 'Cash', and the payment amounts are 
--      suspiciously similar (within ₹100). This could indicate payment mode gaming.

-- Q22. BigBasket's assortment team wants to identify "portfolio gaps" by finding brand pairs 
--      where one brand has products in categories that the other brand doesn't cover, 
--      despite both brands having similar total product counts.

-- Q23. The Amazon India returns team needs to find product pairs from the same category 
--      where one product has a return rate (returns/orders) above 20% while the other has 
--      below 5%. Understanding this difference could improve product quality.

-- Q24. Myntra's store performance team wants to identify "efficiency leaders and laggards" - 
--      store pairs in the same region where one store achieves 50% higher sales per employee 
--      than the other. This identifies best practices to replicate.

-- Q25. The RetailMart finance team needs to find expense pairs at the same store in the same month 
--      where one expense is categorized as 'Rent' and another as 'Utilities', and the ratio of 
--      rent to utilities is outside the normal range of 3:1 to 5:1.

-- Q26. Flipkart's customer segmentation team wants to find customer pairs from the same state 
--      who have ordered from the SAME set of product categories (exact match) but have vastly 
--      different average order values (2x or more difference).

-- Q27. The BigBasket supplier evaluation team needs to identify supplier pairs where one supplier's 
--      products consistently outperform the other's in the same categories (higher total sales), 
--      grouped by category with performance ratios.

-- Q28. Zomato's HR wants to find employee pairs at different stores but same department, 
--      where the salary difference is more than 25% despite similar attendance rates (within 5%). 
--      This could indicate location-based pay disparities.

-- Q29. The Amazon India catalog team wants to find products that are "orphaned" within their brand - 
--      products where no other product from the same brand exists in the same price range (±20%). 
--      These products might be mis-categorized or need companions.

-- Q30. RetailMart's cross-selling team wants to identify product pairs from DIFFERENT categories 
--      that are frequently ordered together (appear in the same order at least 10 times). 
--      These are natural bundle candidates.

-- =====================
-- SECTION B: COMPLEX CROSS JOIN APPLICATIONS (Q31-Q50)
-- =====================

-- Q31. The Flipkart demand planning team needs to create a comprehensive stock allocation matrix. 
--      Generate all product-store combinations, then flag each combination as 'Stocked', 'Out of Stock', 
--      or 'Never Stocked' based on current inventory status, with current quantity if stocked.

-- Q32. BigBasket's promotion team wants to analyze promotion eligibility. Create a matrix of all 
--      products and promotions, then calculate the potential discount amount for each combination. 
--      Flag combinations where the discount would exceed 50% of the product price as 'High Risk'.

-- Q33. The RetailMart workforce planning team needs a department-store staffing matrix. 
--      Show all department-store combinations with: current employee count, average salary, 
--      and whether the department is 'Overstaffed' (>5), 'Understaffed' (<2), or 'Optimal'.

-- Q34. Myntra's regional strategy team wants to analyze brand penetration by region. 
--      Create a brand-region matrix showing: number of products, total inventory value, 
--      and presence status ('Strong', 'Weak', 'Absent' based on product count thresholds).

-- Q35. The Amazon India logistics team needs to plan inter-city delivery routes. 
--      Generate all city-pair combinations (from customer cities to store cities), 
--      calculate the customer demand (total orders) and supply capacity (total inventory) for each route.

-- Q36. Flipkart's category expansion team wants a supplier-category opportunity matrix. 
--      Show all supplier-category combinations with: current product count, average product price, 
--      and flag as 'Opportunity' if supplier has no products in that category.

-- Q37. The BigBasket campaign targeting team needs a customer segment-campaign matrix. 
--      Create segments based on loyalty points (Bronze/Silver/Gold) and pair with all campaigns. 
--      Calculate potential reach (customer count) and value (total past spending) for each.

-- Q38. RetailMart's financial planning team needs a store-month budget matrix for the year. 
--      Generate all store-month combinations and show: actual expenses (if any), actual revenue (if any), 
--      and calculate variance from the average monthly figures.

-- Q39. The Zomato menu planning team (products as menu items) wants a category-store matrix 
--      showing which categories are available at which stores, with average price per category 
--      and whether the store is 'Competitive' (below average price) or 'Premium' for that category.

-- Q40. Myntra's inventory redistribution team needs a product-store gap analysis. 
--      For each product-store combination, show current stock, store's sales velocity for that product 
--      (if any), and calculate days of inventory remaining.

-- Q41. The PhonePe merchant analytics team wants a payment mode-store acceptance matrix. 
--      Show all payment modes that have EVER been used, crossed with all stores, 
--      and flag each combination as 'Active' or 'Inactive' based on last 30 days of transactions.

-- Q42. Amazon India's seasonal planning team needs a quarter-category sales matrix. 
--      Cross all quarters with all categories and show: total sales, order count, 
--      and whether that quarter is 'Peak', 'Average', or 'Low' for that category.

-- Q43. The BigBasket freshness team needs a product-store last-updated matrix. 
--      For all product-store combinations, show the last inventory update date 
--      and flag as 'Stale' if not updated in over 7 days, 'Fresh' otherwise.

-- Q44. RetailMart's employee development team wants a role-department skill matrix. 
--      Cross all roles with all departments and show: employee count in that combination, 
--      average salary, and whether this is a 'Common' (>3 employees) or 'Rare' combination.

-- Q45. The Flipkart returns prevention team needs a product-reason matrix. 
--      Cross all products with all return reasons and show the count of returns for each combination. 
--      Flag high-risk combinations (>5 returns with same reason).

-- Q46. Zomato's dynamic pricing team wants a store-day pricing matrix. 
--      Cross all stores with all days of the week and show: average order value, 
--      order count, and classify each as 'High Demand', 'Medium', or 'Low Demand'.

-- Q47. The Myntra size planning team wants a category-store size distribution. 
--      For all category-store combinations, show the diversity of products available 
--      (count of unique products) and average price range.

-- Q48. BigBasket's dark store planning team needs a customer area-store coverage matrix. 
--      Cross all unique customer postal codes with all stores, calculating the demand 
--      (customer count and total orders) for each postal code that could be served.

-- Q49. The RetailMart supplier diversification team wants a category-supplier dependency matrix. 
--      For each category, show all suppliers and their market share (% of products in that category), 
--      flagging categories where one supplier has >50% share as 'Risky'.

-- Q50. Amazon India's warehouse capacity team needs a month-store capacity utilization matrix. 
--      Cross all months with all stores, showing total inventory movements (orders + restocks) 
--      and flagging months where a store was 'Overloaded' vs 'Underutilized'.

-- =====================
-- SECTION C: ADVANCED SET OPERATIONS (Q51-Q75)
-- =====================

-- Q51. The Flipkart customer lifecycle team wants to categorize all customers into exactly one group: 
--      'Active Buyers' (ordered in last 30 days), 'Dormant' (ordered 31-90 days ago), 
--      'Churned' (no orders in 90+ days), or 'Never Ordered'. Use set operations to ensure 
--      no customer appears in multiple groups.

-- Q52. BigBasket's product health analysis requires identifying: products that are 'Stars' (high sales AND low returns), 
--      'Problems' (high sales AND high returns), 'Opportunities' (low sales AND low returns), 
--      and 'Dead Weight' (low sales AND high returns). Use INTERSECT and EXCEPT appropriately.

-- Q53. The RetailMart geographic expansion team needs to find three city lists: 
--      'Established Markets' (have both customers AND stores AND orders), 
--      'Demand Only' (customers but no stores), 'Supply Only' (stores but no customers). 
--      Show customer/store counts for each.

-- Q54. Myntra's customer engagement funnel analysis: Find customers at each stage - 
--      'Registered Only' (no orders, no reviews), 'Bought Only' (orders but no reviews), 
--      'Engaged' (orders AND reviews), using set operations and show counts per stage.

-- Q55. The Zomato supplier performance team needs to identify: 'Elite Suppliers' (all their products 
--      have been ordered AND are in stock), 'Struggling Suppliers' (products ordered but often out of stock), 
--      'New Suppliers' (products never ordered yet).

-- Q56. Flipkart's payment reconciliation team needs three transaction lists: 
--      'Fully Paid' (orders with exact matching payments), 'Partially Paid' (orders with payments but different amounts), 
--      'Unpaid' (orders with no payments at all). Show order totals for each category.

-- Q57. The BigBasket category rationalization team wants to find: 'Anchor Categories' (in dim_category AND have products 
--      AND have orders), 'Planned Categories' (in dim_category but no products yet), 
--      'Orphan Categories' (products exist but not in dim_category).

-- Q58. RetailMart's HR compliance team needs to identify employees in three groups: 
--      'Fully Compliant' (have attendance AND salary history), 'Attendance Only' (no salary history), 
--      'Salary Only' (no attendance records). This identifies data gaps.

-- Q59. The Amazon India inventory control team wants three product lists: 
--      'Well Distributed' (in inventory at 80%+ stores), 'Limited Distribution' (in inventory at 20-80% stores), 
--      'Concentrated' (in inventory at <20% stores). Calculate store coverage for each product.

-- Q60. Myntra's marketing reach analysis needs three customer lists: 
--      'Fully Reached' (received emails AND opened AND clicked), 'Partially Reached' (received but didn't open), 
--      'Unreached' (never received emails). Show customer counts and total spending for each.

-- Q61. The PhonePe merchant health team needs to categorize stores: 
--      'Thriving' (have orders AND expenses AND profit), 'Struggling' (have orders AND expenses but loss), 
--      'Inactive' (no orders in last month). Calculate metrics for each category.

-- Q62. BigBasket's product assortment team needs: 'Core Products' (ordered from all regions), 
--      'Regional Products' (ordered from some but not all regions), 
--      'Pilot Products' (ordered from only one region). Show regional distribution.

-- Q63. The RetailMart loyalty program team wants to identify: 'Super Loyalists' (high points AND recent orders), 
--      'Passive Earners' (high points but no recent orders), 'Active Non-Earners' (recent orders but low points), 
--      'Disengaged' (low points AND no recent orders).

-- Q64. Flipkart's return pattern analysis: 'Never Returned' (ordered products never returned), 
--      'Sometimes Returned' (products returned by some customers but not others), 
--      'Always Returned' (products returned by every customer who bought them).

-- Q65. The Zomato campaign effectiveness team: 'Campaign Winners' (campaigns where order value during campaign > before), 
--      'Neutral Campaigns' (no significant change), 'Campaign Failures' (order value dropped during campaign).

-- Q66. BigBasket's supplier rationalization: 'Strategic Suppliers' (supply products in 3+ categories AND have sales), 
--      'Specialists' (supply in 1-2 categories with sales), 'Underperformers' (supply but no sales).

-- Q67. The RetailMart cross-sell opportunity finder: Identify product pairs where buying one is strongly 
--      associated with buying the other, but the reverse is not true (asymmetric correlation).

-- Q68. Myntra's pricing consistency check: Find products where the order item unit_price has varied 
--      (different prices in different orders) vs. products with consistent pricing. Show variance stats.

-- Q69. The Amazon India delivery performance: 'On Time Always' (all shipments delivered on or before expected), 
--      'Sometimes Late' (some late deliveries), 'Chronic Late' (most deliveries late). Categorize by store.

-- Q70. PhonePe's customer value segmentation: 'High Value Consistent' (top 20% spending AND ordered every month), 
--      'High Value Sporadic' (top 20% but inconsistent), 'Steady Mid-Tier' (middle 60% with regular orders), 
--      'Low Engagement' (bottom 20% OR infrequent).

-- Q71. The BigBasket fresh vs. staple analysis: Products that appear in ONLY daily orders (fresh), 
--      products that appear in ONLY weekly/monthly orders (staples), products that appear in both patterns.

-- Q72. RetailMart's employee mobility analysis: Employees who have ONLY worked at one store, 
--      employees whose salary has changed stores (via history), employees at multiple stores currently.

-- Q73. The Flipkart promotion stacking finder: Products that have been sold with single promotions only, 
--      products sold with multiple overlapping promotions, products never sold with any promotion.

-- Q74. Zomato's order pattern analysis: Customers who order ONLY on weekdays, customers who order ONLY 
--      on weekends, customers who order on both. Show order counts and values for each pattern.

-- Q75. The Myntra brand loyalty analysis: Customers who buy from ONLY one brand, customers who buy from 
--      exactly 2-3 brands, customers who buy from 4+ brands. Show spending distribution.

-- =====================
-- SECTION D: MULTI-CONCEPT INTEGRATION (Q76-Q100)
-- =====================

-- Q76. The Flipkart comprehensive store comparison: Using self-joins, compare each store pair in the same region 
--      on 5 metrics (sales, expenses, employees, products stocked, order count). Rank which store is better 
--      on more metrics.

-- Q77. BigBasket's supplier negotiation prep: For each supplier, find their products that compete with 
--      products from other suppliers (same category, ±20% price). Calculate their competitive position 
--      (higher price = weaker position).

-- Q78. The RetailMart complete customer 360: Combine order history, loyalty points, reviews, and marketing 
--      engagement into a single customer profile. Use UNION to combine different data sources and 
--      self-joins to compare customers.

-- Q79. Myntra's inventory optimization matrix: Cross-join products with stores, then use left joins to find 
--      actual inventory. Flag each combination based on: current stock vs. sales velocity vs. similar 
--      products' performance at that store.

-- Q80. The Amazon India seller scorecard: For each supplier, calculate: product diversity (categories covered), 
--      sales performance (vs. category average), stock reliability (out-of-stock incidents), 
--      and return rate. Compare suppliers using self-join.

-- Q81. PhonePe's fraud pattern detection: Find suspicious patterns by identifying order pairs at the same store, 
--      same day, from customers in the same city, where payment modes alternate (one cash, one digital) 
--      and amounts are similar.

-- Q82. The BigBasket demand forecasting prep: Create a complete date-product-store matrix for the last quarter. 
--      Fill in actual sales where available, mark gaps. Identify patterns in the gaps.

-- Q83. RetailMart's complete financial reconciliation: Match every order with its payment(s), every store 
--      with its expenses, and create a daily cash flow statement using UNION to combine inflows and outflows.

-- Q84. The Flipkart customer cohort analysis: Group customers by join month, then compare cohorts on: 
--      first order timing, average order value, retention (repeat orders), and review behavior. 
--      Use self-joins to compare cohorts.

-- Q85. Zomato's menu optimization: For each category, find products that are 'Price Leaders' (cheapest), 
--      'Volume Leaders' (most ordered), and 'Margin Leaders' (highest price with good sales). 
--      Identify gaps where no leader exists.

-- Q86. The Myntra complete assortment analysis: Cross brands with categories, identify coverage gaps, 
--      compare filled positions on: price range, inventory depth, sales velocity. Use set operations 
--      to find white spaces.

-- Q87. BigBasket's operational efficiency dashboard: For each store-month, calculate: revenue per employee, 
--      orders per employee, inventory turnover. Use self-join to compare each store to the network average.

-- Q88. The RetailMart customer referral detection: Using self-joins and date comparisons, identify potential 
--      referral chains - customers from the same city who joined within 3 days of each other, where the 
--      earlier joiner had already placed an order.

-- Q89. Amazon India's complete product lifecycle: Track each product through: listing (products table), 
--      stocking (inventory), first sale, returns, reviews. Use UNION to create a timeline of events.

-- Q90. The PhonePe loyalty program ROI: Compare customers with high loyalty points vs. low loyalty points 
--      on: order frequency, order value, return rate, review sentiment. Use self-joins and set operations.

-- Q91. Flipkart's complete promotion analysis: For each promotion period, calculate: 
--      orders with promotion vs. without, revenue impact, customer overlap (who bought with and without). 
--      Use set operations to segment.

-- Q92. The BigBasket supplier dependency risk: Identify categories where a single supplier provides >50% 
--      of products. For these risky categories, find alternative suppliers (from other categories) 
--      who could potentially fill the gap.

-- Q93. RetailMart's employee career path analysis: Using salary history and self-joins, identify employees 
--      who have had similar career trajectories (same sequence of salary increases). 
--      These could be used for mentorship matching.

-- Q94. Myntra's complete campaign attribution: For customers who ordered during campaign periods, 
--      determine if they received emails, if they clicked, and compare conversion rates. 
--      Use set operations to create proper attribution groups.

-- Q95. The Zomato store clustering: Using self-joins, find stores that are "similar" based on multiple 
--      criteria: same region, similar sales range (±20%), similar employee count (±2), similar expense patterns.

-- Q96. Amazon India's customer acquisition cost: Calculate for each customer: marketing emails sent before 
--      first order, campaigns running during acquisition, and compare CAC across different acquisition 
--      channels using set operations.

-- Q97. The BigBasket substitution recommendation engine: Using self-joins, find products that could substitute 
--      for each other (same category, same brand, price within ±15%, both in stock). 
--      Rank by similarity score.

-- Q98. RetailMart's complete revenue leakage analysis: Find all orders without payments, shipments without 
--      orders, returns without valid orders. Use EXCEPT operations to identify each type of leakage.

-- Q99. The Flipkart network optimization: Create all possible store-to-store transfer routes. 
--      For each route, calculate: inventory imbalance (difference in stock), demand difference 
--      (orders per store), and prioritize routes where transfer would help both stores.

-- Q100. The comprehensive RetailMart business health check: Create a unified view combining: 
--       store performance (sales, expenses, profit), inventory health (stock levels, turnover), 
--       customer engagement (orders, reviews, loyalty), and employee productivity. 
--       Use UNION, self-joins, and cross-joins to build this complete picture.

-- ============================================
-- END OF DAY 10 HARD QUESTIONS
-- ============================================
