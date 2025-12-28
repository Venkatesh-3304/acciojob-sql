-- ============================================
-- Day 10: Self Join, Cross Join & Set Operations - EASY Level
-- Student Question Bank (100 Questions)
-- ============================================
-- Concepts Allowed: SELECT, FROM, WHERE, AND, OR, NOT, comparison operators,
--   LIKE, BETWEEN, IN, IS NULL, DISTINCT, ORDER BY, LIMIT, OFFSET,
--   COUNT, SUM, AVG, MIN, MAX, GROUP BY, HAVING, CASE WHEN, COALESCE, NULLIF,
--   INNER JOIN, LEFT JOIN, RIGHT JOIN, FULL OUTER JOIN,
--   Self Join, CROSS JOIN, UNION, UNION ALL, INTERSECT, EXCEPT
-- Concepts NOT Allowed: Subqueries, CTEs, Window Functions, Views, Functions
-- ============================================
-- Database: RetailMart (PostgreSQL)
-- ============================================

-- =====================
-- SECTION A: SELF JOIN (Q1-Q35)
-- =====================

-- Q1. The HR head at RetailMart wants to identify pairs of employees who work in the same store. 
--     This will help in understanding team compositions across different locations.

-- Q2. Flipkart's talent acquisition team is curious about employees who earn exactly the same salary. 
--     They want to spot potential pay band patterns.

-- Q3. The regional manager wants to find customers who reside in the same city. 
--     This helps in planning city-specific marketing campaigns.

-- Q4. BigBasket's category manager notices some products share identical prices. 
--     They need to identify such product pairs for pricing review.

-- Q5. The store operations team wants to know which stores are located in the same state. 
--     This is needed for regional inventory sharing programs.

-- Q6. Zomato's HR team needs to find employees belonging to the same department. 
--     They're planning department-wise team building activities.

-- Q7. The inventory team at Myntra wants to identify products from the same brand. 
--     This helps in creating brand-specific promotional bundles.

-- Q8. RetailMart's customer success team wants to find pairs of customers who joined on the same date. 
--     These could be referral pairs.

-- Q9. The payroll team wants to compare each employee's salary with other employees in their department 
--     to find who earns more than their colleagues.

-- Q10. Amazon India's warehouse team wants to identify products from the same supplier 
--      but with different prices. This helps in supplier negotiation.

-- Q11. The Ola driver management team (imagine employees as drivers) wants to find pairs of employees 
--      who have the same role but different salaries. This is for salary standardization.

-- Q12. PhonePe's analytics team wants to find customers from the same region 
--      who might have similar purchasing behaviors.

-- Q13. The store planning team needs to identify stores in the same city 
--      to analyze cannibalization effects.

-- Q14. Swiggy's HR wants to find employees with different roles but similar salaries 
--      to understand role-salary alignment.

-- Q15. The marketing team wants to find pairs of customers with the same gender 
--      who live in different cities. This is for diverse focus group selection.

-- Q16. IRCTC's operations team wants to compare stores where one store's name 
--      comes before another alphabetically. Simple listing for directory purposes.

-- Q17. The product team wants to find products in the same category 
--      but from different brands for competitive analysis.

-- Q18. Reliance Retail's HR wants to identify employees at the same store 
--      who have different departments. This shows store department diversity.

-- Q19. The customer insights team wants to find pairs of customers 
--      where one is older than the other and both are from the same state.

-- Q20. BigBasket wants to find products from the same category 
--      where one product costs at least double the other.

-- Q21. The training team wants to find employee pairs from the same department 
--      where one earns at least 20% more than the other.

-- Q22. Myntra's merchandising team wants to spot products from the same supplier 
--      in different categories. This shows supplier diversification.

-- Q23. The store network team wants to identify stores in different cities 
--      but the same region. This helps understand regional spread.

-- Q24. Flipkart's people team wants to find employees with the same role 
--      across different stores. This helps in role standardization.

-- Q25. The loyalty team wants to find customer pairs from the same city 
--      with significantly different loyalty points (difference > 1000).

-- Q26. Amazon's pricing team wants to compare products where both are from the same brand 
--      and one is priced higher than the other.

-- Q27. The recruitment team wants to find departments that share employees with other departments 
--      (employees who could be cross-trained).

-- Q28. Zomato's city expansion team wants to know which cities have both customers and stores. 
--      Start by finding customer pairs in same cities.

-- Q29. The HR analytics team wants to find employees in different stores 
--      but earning identical salaries. This could indicate pay band alignment.

-- Q30. RetailMart wants to identify customers of the same age group (same age) 
--      but different genders for demographic analysis.

-- Q31. The vendor management team wants to find suppliers whose names start with the same letter. 
--      This is for alphabetical directory grouping.

-- Q32. Paytm Mall wants to find stores in the same state where one store's name 
--      is alphabetically after the other. Simple listing exercise.

-- Q33. The customer service team wants to identify pairs of customers 
--      where both have addresses in the same city (using addresses table).

-- Q34. BigBasket's assortment team wants to find product pairs from different categories 
--      but same brand. This shows brand category coverage.

-- Q35. The analytics team wants to find employee pairs where one joined 
--      at a store in a different region than the other's store.

-- =====================
-- SECTION B: CROSS JOIN (Q36-Q55)
-- =====================

-- Q36. RetailMart's inventory planning team wants to see every possible combination 
--      of products and stores. This is the starting point for stock allocation planning.

-- Q37. The marketing team at Flipkart wants to generate all possible combinations 
--      of regions and product categories for campaign targeting.

-- Q38. Zomato's promotion team needs a list showing every product 
--      paired with every available promotion. This is for promotion eligibility analysis.

-- Q39. The HR team wants to create a matrix of all departments and all stores 
--      to plan potential team placements.

-- Q40. BigBasket's pricing team wants to see every combination of brands and categories 
--      to understand market coverage opportunities.

-- Q41. The logistics team wants to pair every store with every region 
--      to analyze potential delivery route expansions.

-- Q42. Myntra's visual merchandising team wants to combine every category 
--      with every store for display planning purposes.

-- Q43. The campaign planning team needs to pair every marketing campaign 
--      with every store to track campaign reach.

-- Q44. Amazon India's expansion team wants to see every city (from stores) 
--      combined with every region for market analysis.

-- Q45. The supplier relationship team wants to pair every supplier 
--      with every category to identify partnership gaps.

-- Q46. PhonePe's analytics team wants to combine every payment mode 
--      (imagine distinct payment modes) with every store.

-- Q47. The product launch team wants to pair the first 5 products 
--      with the first 5 stores for pilot launch planning.

-- Q48. Swiggy's planning team wants to combine all unique states from customers 
--      with all unique states from stores.

-- Q49. The training department wants to pair every department 
--      with every employee role to create training matrices.

-- Q50. RetailMart's market research team wants to combine every brand 
--      with every region for brand awareness studies.

-- Q51. The space planning team wants to pair the top 10 products by price 
--      with all stores for premium placement analysis.

-- Q52. Flipkart's category team wants to combine categories with brands 
--      to find gaps in product assortment.

-- Q53. The events team wants to pair every store with every month (1-12) 
--      for annual event planning. Use generate_series or dim_date.

-- Q54. BigBasket wants to create a matrix of customer cities 
--      and store cities for delivery feasibility analysis.

-- Q55. The sales planning team wants to pair every quarter (from dim_date) 
--      with every store for quarterly target setting.

-- =====================
-- SECTION C: UNION & UNION ALL (Q56-Q75)
-- =====================

-- Q56. The operations team wants a combined list of all cities 
--      where either a customer lives or a store is located, without duplicates.

-- Q57. Zomato's data team needs a master list of all person names, 
--      combining customer names and employee names, removing duplicates.

-- Q58. The geographic team wants all states mentioned in the database, 
--      whether from customers, stores, or addresses, without repeats.

-- Q59. RetailMart's finance team wants to combine expense dates from stores 
--      with expense dates from finance, including all occurrences.

-- Q60. The marketing analytics team wants a list of all dates 
--      when either an order was placed or a campaign started.

-- Q61. Flipkart's contact center wants all unique city names 
--      from both customer addresses and store locations.

-- Q62. The compliance team needs all dates when money moved: 
--      either payment dates or expense dates.

-- Q63. BigBasket's catalog team wants a combined list 
--      of all category names from products and dim_category.

-- Q64. The PR team wants all unique brand names 
--      appearing in either products table or dim_brand table.

-- Q65. Myntra's customer team wants to combine customer join dates 
--      with order dates to see all significant customer activity dates.

-- Q66. The audit team needs a complete list of all amounts: 
--      order totals and expense amounts combined, keeping duplicates.

-- Q67. RetailMart wants all city names where either customers live 
--      or where they have addresses, removing duplicates.

-- Q68. The logistics team wants to combine shipped dates and delivered dates 
--      from shipments to get all logistics activity dates.

-- Q69. Swiggy's finance team wants all unique amounts that appear 
--      either as order totals or as payment amounts.

-- Q70. The HR team wants a combined list of dates 
--      when employees either attended work or received salary updates.

-- Q71. The product team wants to combine all product names 
--      with all store names into one master list of entity names.

-- Q72. Amazon's campaign team wants all dates relevant to marketing: 
--      campaign start dates, end dates, and email sent dates.

-- Q73. The customer 360 team wants all dates associated with customers: 
--      join dates, order dates, and review dates combined.

-- Q74. RetailMart's master data team wants a single list 
--      containing customer IDs and employee IDs together (as a number list).

-- Q75. The inventory team wants to combine product IDs from products table 
--      with product IDs from inventory table, keeping all occurrences.

-- =====================
-- SECTION D: INTERSECT (Q76-Q88)
-- =====================

-- Q76. The market penetration team wants to find cities 
--      where both customers live AND stores are located.

-- Q77. Flipkart's data quality team wants to identify product IDs 
--      that exist in both the products table and the order_items table.

-- Q78. The regional planning team wants states 
--      that appear in both customer data and store data.

-- Q79. BigBasket's inventory team wants to find product IDs 
--      present in both products and inventory tables.

-- Q80. The order fulfillment team wants dates 
--      when both orders were placed AND payments were made.

-- Q81. Myntra's customer insights team wants to find customer IDs 
--      who have both placed orders AND written reviews.

-- Q82. The pricing team wants amounts that appear 
--      as both payment amounts and order totals.

-- Q83. RetailMart wants to find product IDs 
--      that have been both ordered AND returned.

-- Q84. The email marketing team wants customer IDs 
--      who received emails AND also placed orders.

-- Q85. Zomato's analytics team wants to find dates 
--      when both campaigns were active AND orders were placed.

-- Q86. The store expansion team wants cities appearing 
--      in both stores table and customer addresses table.

-- Q87. The supplier team wants to find supplier IDs 
--      whose products appear in both products and inventory.

-- Q88. The finance team wants dates appearing 
--      in both expenses and revenue_summary tables.

-- =====================
-- SECTION E: EXCEPT (Q89-Q100)
-- =====================

-- Q89. The market expansion team wants cities where customers live 
--      but no store is located yet. Prime spots for new stores.

-- Q90. Flipkart's catalog team wants product IDs in the products table 
--      that have never been ordered.

-- Q91. The delivery team wants cities where stores exist 
--      but no customers currently live there.

-- Q92. BigBasket's dead stock team wants product IDs in inventory 
--      that haven't been ordered yet.

-- Q93. The customer acquisition team wants states with stores 
--      but no registered customers.

-- Q94. Myntra's engagement team wants customer IDs who placed orders 
--      but never wrote a review.

-- Q95. The returns analysis team wants product IDs that were ordered 
--      but never returned. These are satisfaction champions.

-- Q96. RetailMart's loyalty team wants customer IDs in the customers table 
--      who don't have loyalty points yet.

-- Q97. The payment reconciliation team wants order IDs 
--      that don't have corresponding payments.

-- Q98. Swiggy's campaign team wants customer IDs 
--      who placed orders but never received marketing emails.

-- Q99. The supplier performance team wants supplier IDs in products 
--      whose products are not in inventory at any store.

-- Q100. The HR team wants employee IDs 
--       who don't have any attendance records yet.

-- ============================================
-- END OF DAY 10 EASY QUESTIONS
-- ============================================
