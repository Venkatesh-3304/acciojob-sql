-- ============================================
-- Day 10: Self Join, Cross Join & Set Operations - MEDIUM Level
-- Student Question Bank (100 Questions)
-- ============================================
-- Concepts Allowed: All from Day 1-10 including Self Join, CROSS JOIN,
--   UNION, UNION ALL, INTERSECT, EXCEPT, plus all joins, aggregates,
--   CASE WHEN, COALESCE, GROUP BY, HAVING, ORDER BY, LIMIT
-- Concepts NOT Allowed: Subqueries, CTEs, Window Functions, Views, Functions
-- ============================================
-- Database: RetailMart (PostgreSQL)
-- ============================================

-- =====================
-- SECTION A: SELF JOIN WITH AGGREGATES (Q1-Q25)
-- =====================

-- Q1. The HR analytics team at Flipkart wants to count how many employee pairs 
--     work in the same store. This helps in understanding team sizes.

-- Q2. RetailMart's compensation team needs the average salary difference 
--     between employees in the same department who have different roles.

-- Q3. BigBasket wants to find the maximum price difference between products 
--     from the same category. This reveals category price ranges.

-- Q4. The customer insights team wants to count pairs of customers 
--     from the same city grouped by city. Which cities have the most customer pairs?

-- Q5. Myntra's pricing team needs to identify brands where the price gap 
--     between the most expensive and cheapest product exceeds ₹500.

-- Q6. The store network team wants to find regions with more than 3 pairs 
--     of stores in the same state. Focus on dense networks.

-- Q7. Swiggy's HR wants the total number of employee pairs earning 
--     within ₹5000 of each other, grouped by department.

-- Q8. Amazon India wants to count how many product pairs share the same supplier 
--     but have price differences greater than ₹100.

-- Q9. The loyalty team wants to find city-wise count of customer pairs 
--     where both customers have loyalty points above 500.

-- Q10. PhonePe's analytics team needs to identify the top 5 cities 
--      with the most customer pairs having the same gender.

-- Q11. The operations team wants to find stores in the same region 
--      and calculate the average distance in store_id between them.

-- Q12. RetailMart wants employee pairs from the same store 
--      where the salary difference is in the top 10 highest differences.

-- Q13. The category manager wants to count product pairs 
--      from the same brand with at least ₹200 price difference, by brand.

-- Q14. Zomato's expansion team wants regions where customer pairs 
--      from the same state average more than 10 years age difference.

-- Q15. The training team needs department-wise count of employee pairs 
--      where one earns at least 30% more than the other.

-- Q16. BigBasket wants to identify suppliers with more than 5 pairs 
--      of products having different categories.

-- Q17. The customer success team wants to find the average age difference 
--      between customer pairs from the same city, grouped by city.

-- Q18. Flipkart's warehouse team wants pairs of products from the same category 
--      where both have inventory at the same store.

-- Q19. The HR team needs to list departments where employee pairs 
--      have an average salary difference exceeding ₹10,000.

-- Q20. Myntra wants to find brands with more than 3 pairs of products 
--      where both products are priced above ₹1000.

-- Q21. The store planning team wants to count store pairs by region 
--      where both stores are in different cities but same state.

-- Q22. RetailMart's marketing team wants customer pairs from the same state 
--      who joined within 30 days of each other.

-- Q23. The product team needs to find categories with the highest count 
--      of product pairs from different brands.

-- Q24. Amazon India wants to identify the top 3 suppliers 
--      by count of product pairs with price difference over ₹500.

-- Q25. The HR analytics team needs the average salary of employee pairs 
--      in the same department grouped by department.

-- =====================
-- SECTION B: CROSS JOIN WITH FILTERS (Q26-Q45)
-- =====================

-- Q26. RetailMart wants all product-store combinations 
--      but only for products priced above ₹500 and stores in the 'North' region.

-- Q27. The marketing team needs all campaign-store combinations 
--      where the campaign budget exceeds ₹50,000.

-- Q28. BigBasket wants every product-promotion pair 
--      but only for promotions with discount greater than 10%.

-- Q29. The HR team needs all department-store combinations 
--      but only for stores with more than 5 employees.

-- Q30. Flipkart wants to create a matrix of categories and regions 
--      showing total products per combination.

-- Q31. The supplier relationship team needs all supplier-category combinations 
--      with a count of products that exist for each combination.

-- Q32. Myntra wants every brand-store combination 
--      where the brand has at least 3 products in the catalog.

-- Q33. The inventory team needs every product-store combination 
--      where the product is currently out of stock (not in inventory for that store).

-- Q34. RetailMart wants all customer city - store city combinations 
--      where both cities are in the same state.

-- Q35. The campaign team needs every store-campaign combination 
--      along with the store's total sales during the campaign period.

-- Q36. BigBasket wants every category-region combination 
--      with the count of customers who bought from that category-region.

-- Q37. The pricing team needs every product-store combination 
--      showing whether the product is above or below average price for that store.

-- Q38. Amazon India wants every supplier-region combination 
--      with count of products sold in that region.

-- Q39. The store operations team needs every department-month combination 
--      to plan staffing across the year.

-- Q40. RetailMart wants every brand-promotion combination 
--      to analyze which promotions could apply to which brands.

-- Q41. The logistics team needs every store pair combination 
--      to plan inter-store transfer routes (exclude same store pairs).

-- Q42. Flipkart wants every category-quarter combination 
--      with total sales for that category in that quarter.

-- Q43. The marketing team needs every customer segment-campaign combination 
--      where customer segment is based on age groups.

-- Q44. BigBasket wants every product pair combination 
--      to identify bundle opportunities (limit to first 100 products).

-- Q45. The finance team needs every store-month combination 
--      with total expenses for each.

-- =====================
-- SECTION C: UNION WITH CONDITIONS (Q46-Q60)
-- =====================

-- Q46. RetailMart wants all locations (cities) sorted by whether they have 
--      more customers or more stores, with a label indicating which.

-- Q47. The finance team needs a combined list of all amounts above ₹10,000 
--      from both orders and payments, with source labels.

-- Q48. Flipkart wants all dates in 2024 when either a customer joined 
--      or an order was placed, with counts for each.

-- Q49. The HR team needs a combined list of all names (customers and employees) 
--      along with their associated city.

-- Q50. BigBasket wants all product IDs that appear in either orders or returns 
--      along with the count of occurrences in each.

-- Q51. The marketing team needs all email addresses or names of people 
--      who either received marketing emails or placed orders.

-- Q52. RetailMart wants a timeline combining expense dates and revenue dates 
--      with the respective amounts.

-- Q53. The operations team needs all states with either customers or stores 
--      along with a count of entities in each state.

-- Q54. Myntra wants all dates combining campaign starts, campaign ends, 
--      and email sends, labeled by event type.

-- Q55. The customer team needs all customer IDs who either have high loyalty points (>1000) 
--      or have placed orders above ₹5000.

-- Q56. BigBasket wants all store IDs that either had expenses above ₹10,000 
--      or revenue above ₹50,000 in any month.

-- Q57. The product team needs all categories appearing in either products table 
--      or dim_category, with a count of products in each.

-- Q58. RetailMart wants all payment modes used plus all order statuses 
--      as a combined list of transaction attributes.

-- Q59. The HR team needs all dates when either attendance was marked 
--      or salary was updated, with employee counts.

-- Q60. Flipkart wants all cities from customers UNION ALL cities from addresses 
--      to see which cities appear most frequently.

-- =====================
-- SECTION D: INTERSECT WITH AGGREGATES (Q61-Q75)
-- =====================

-- Q61. RetailMart wants cities where both customers live AND stores are located, 
--      along with customer count and store count for each city.

-- Q62. The product team wants product IDs that are both ordered AND returned, 
--      along with order count and return count.

-- Q63. BigBasket wants states appearing in both customers and stores, 
--      with total customers and total stores per state.

-- Q64. The finance team wants dates appearing in both expenses and payments, 
--      with total expense amount and total payment amount for each date.

-- Q65. Myntra wants customer IDs who both ordered AND reviewed, 
--      with order count and review count per customer.

-- Q66. The marketing team wants dates when both campaigns ran AND emails were sent, 
--      with campaign count and email count for each date.

-- Q67. RetailMart wants cities in both stores and customer addresses, 
--      with average order value for each city.

-- Q68. The inventory team wants product IDs in both products and inventory, 
--      with total stock quantity across all stores.

-- Q69. BigBasket wants payment dates that are also order dates, 
--      showing the percentage of orders paid on the same day.

-- Q70. The HR team wants employee IDs appearing in both attendance and salary_history, 
--      with attendance count and salary update count.

-- Q71. Flipkart wants product IDs appearing in both order_items and inventory, 
--      with average order quantity vs average stock quantity.

-- Q72. The supplier team wants products appearing in both products and orders, 
--      grouped by supplier with total revenue per supplier.

-- Q73. RetailMart wants customers appearing in both orders and reviews, 
--      with average rating given by each customer.

-- Q74. The store team wants stores appearing in both orders and expenses, 
--      with net contribution (sales - expenses) per store.

-- Q75. BigBasket wants months appearing in both orders and campaigns, 
--      with total order value and total campaign budget per month.

-- =====================
-- SECTION E: EXCEPT WITH BUSINESS LOGIC (Q76-Q90)
-- =====================

-- Q76. RetailMart wants cities with customers but no stores, 
--      ranked by number of customers. Prime expansion targets.

-- Q77. The catalog team wants products not yet ordered, 
--      grouped by category with count per category.

-- Q78. BigBasket wants stores without any expenses recorded, 
--      which could indicate missing financial data.

-- Q79. The customer team wants customers without loyalty points, 
--      segmented by state for targeted loyalty enrollment.

-- Q80. Flipkart wants products in catalog but not in inventory at any store, 
--      grouped by supplier. These need restocking.

-- Q81. The marketing team wants customers who ordered but never received emails, 
--      ranked by total order value. Marketing missed opportunities.

-- Q82. RetailMart wants order IDs without payments, 
--      with order date and total amount for follow-up.

-- Q83. The HR team wants employees without attendance records, 
--      with their store and department details.

-- Q84. BigBasket wants products ordered but never returned, 
--      ranked by total quantity sold. Customer satisfaction champions.

-- Q85. The finance team wants dates with expenses but no revenue recorded, 
--      to identify non-operational days.

-- Q86. Myntra wants customers who reviewed but never ordered, 
--      which could indicate data quality issues.

-- Q87. The store team wants stores in customer address cities 
--      but not matching customer home city. Delivery expansion opportunities.

-- Q88. RetailMart wants employees at stores not appearing in orders, 
--      which could mean inactive stores.

-- Q89. The supplier team wants suppliers whose products are in products table 
--      but have zero orders. Underperforming suppliers.

-- Q90. BigBasket wants payment modes used in payments 
--      but with order totals not matching payment amounts.

-- =====================
-- SECTION F: COMPLEX COMBINATIONS (Q91-Q100)
-- =====================

-- Q91. RetailMart wants a comprehensive location analysis: cities with only customers, 
--      cities with only stores, and cities with both.

-- Q92. The product team wants to compare products ordered in North vs South regions, 
--      showing products unique to each region and products common to both.

-- Q93. BigBasket wants employee pairs from the same store combined with 
--      their total combined salary vs store's total sales.

-- Q94. The marketing team wants a customer engagement matrix: 
--      customers who only ordered, only reviewed, both, or neither.

-- Q95. Flipkart wants to create a supplier performance report combining 
--      self-join for product pairs with EXCEPT for non-selling products.

-- Q96. RetailMart wants all possible store-to-store transfer combinations 
--      using cross join, excluding same-region transfers.

-- Q97. The HR team wants to compare departments with high-salary pairs 
--      using self-join INTERSECT with departments having high attendance.

-- Q98. BigBasket wants to find product categories appearing in both 
--      top-selling products and most-returned products.

-- Q99. The finance team wants months where expenses exceeded revenue 
--      using EXCEPT logic with actual expense and revenue data.

-- Q100. RetailMart wants a comprehensive customer-store matching: 
--       all customer-store combinations where customer city matches store city 
--       using appropriate joins and set operations.

-- ============================================
-- END OF DAY 10 MEDIUM QUESTIONS
-- ============================================
