-- ============================================
-- Day 10: Self Join, Cross Join & Set Operations - CRAZY HARD Level
-- Student Question Bank (100 Questions)
-- ============================================
-- Concepts Allowed: All from Day 1-10 including Self Join, CROSS JOIN,
--   UNION, UNION ALL, INTERSECT, EXCEPT, all joins, aggregates,
--   CASE WHEN, COALESCE, GROUP BY, HAVING, ORDER BY, LIMIT
-- Concepts NOT Allowed: Subqueries, CTEs, Window Functions, Views, Functions
-- ============================================
-- Database: RetailMart (PostgreSQL)
-- Focus: Long confusing business stories, extracting logic from messy requirements
-- ============================================

-- =====================
-- SECTION A: TANGLED SELF-JOIN NIGHTMARES (Q1-Q25)
-- =====================

-- Q1. It was 11 PM on a Friday when the Flipkart CFO called an emergency meeting. The board had 
--     discovered that some stores were "hiding" high performers. She suspected that in certain stores, 
--     there were employees earning significantly less than their peers in the SAME department at 
--     DIFFERENT stores, despite having similar roles. "I want to see every employee pair where someone 
--     at Store A earns at least 30% less than someone with the SAME role at Store B, and both are in 
--     the same department. But here's the kicker - I only care about cases where the lower-paid employee 
--     works at a store with HIGHER total sales. Something doesn't add up there." The team groaned, 
--     knowing they had a long night ahead.

-- Q2. The BigBasket pricing algorithm crashed, and the data science team discovered a nightmare scenario. 
--     Somewhere in the catalog, there are products from the same supplier that have created a "price 
--     arbitrage opportunity" - where Product A costs less than Product B, but Product B is just Product A 
--     with more quantity (same category). But that's not all - they also found cases where Product A and 
--     Product B are from DIFFERENT suppliers but the same brand, with similar prices (within ₹50), where 
--     one has consistently better reviews than the other. They need both anomalies identified in a single 
--     report, clearly labeled as 'SUPPLIER_ARBITRAGE' or 'BRAND_REVIEW_MISMATCH'.

-- Q3. Swiggy's new VP of Operations had an unusual request on his first day. "I've analyzed your store 
--     network and I believe we have 'shadow stores' - stores that are operationally identical but somehow 
--     produce wildly different results. Find me pairs of stores in the same city where: they have the same 
--     number of employees (±1), similar total salaries (within 10%), similar product inventory counts 
--     (within 15%), BUT one store's revenue is more than 40% higher than the other's. Also, for these pairs, 
--     tell me which store has the higher expense ratio (expenses/revenue) - I bet it's always the 
--     lower-performing one."

-- Q4. The RetailMart loyalty program manager burst into the data team's office waving printouts. "We have a 
--     loyalty fraud ring! Look at these customers - they're gaming the system!" She explained her theory: 
--     customers in the same city who joined within 5 days of each other, where BOTH have loyalty points 
--     significantly above average, but their ORDER PATTERNS are suspiciously complementary - one orders 
--     mostly expensive items (average order > ₹5000) and the other orders mostly cheap items (average 
--     order < ₹1000), yet their total loyalty points are nearly identical (within 100 points). "They're 
--     somehow splitting purchases to maximize points on both accounts!"

-- Q5. Amazon India's category manager for Electronics was panicking. "I think we have a counterfeit problem, 
--     but I can't prove it. Here's what I need: find all product pairs in the same category where they're 
--     from DIFFERENT brands, but their product names are suspiciously similar (share at least the first 
--     5 characters), AND one is priced at least 40% lower than the other, AND the cheaper one has more 
--     returns than the expensive one despite lower sales volume. I also need to know if both products 
--     share the same supplier - that would confirm my suspicions."

-- Q6. The Myntra HR head had received an anonymous complaint about "salary favoritism at flagship stores." 
--     The complaint alleged that employees at high-revenue stores in metropolitan cities were being paid 
--     more for the same roles compared to stores in the same region but smaller cities. "I need you to 
--     find employee pairs with the EXACT same role in stores within the same region but different cities, 
--     where: the metro store employee earns more than 20% higher, but the smaller city store actually has 
--     BETTER performance metrics (higher sales per employee). Group this by role and region, and tell me 
--     if this is a systemic issue or isolated cases."

-- Q7. Zomato's food safety team got a concerning report. They needed to identify "supply chain red flags" - 
--     products from different suppliers that are: in the same category, have similar names (within 3 
--     characters in length), nearly identical prices (within ₹10), but vastly different inventory levels 
--     (one has 10x more stock than the other). "This could mean one supplier is dumping low-quality stock 
--     or there's a fake product issue. But wait - also check if either product has been returned more than 
--     5 times. If BOTH have high returns, it's a category problem. If only ONE has high returns, flag that 
--     specific supplier."

-- Q8. PhonePe's risk team uncovered a potential money laundering pattern. They need to find customer pairs 
--     who: are in the same city, have different genders (to avoid same-person multiple accounts), placed 
--     orders on the exact same dates for the exact same amounts within ₹500, but used different payment 
--     modes. The twist - they want this analysis ONLY for orders above ₹10,000, and they need to know if 
--     these customers ever ordered from the SAME store. If they did, flag as 'HIGH_RISK', otherwise 
--     'MEDIUM_RISK'. They also want to see if these customer pairs have any shared characteristics 
--     (same age group, same join month).

-- Q9. The IRCTC (imagine RetailMart for travel) vendor management team discovered a concerning pattern 
--     during an audit. They found suppliers who might be gaming the system by creating "phantom product 
--     differentiation." They need to find product pairs from the SAME supplier where: products are in 
--     different categories, but have nearly identical prices (within ₹25), similar inventory levels 
--     (within 20%), and the product names share common words. "But here's the real test - check if 
--     customers who buy one product ALSO buy the other product (appear in the same orders). If yes, 
--     they're genuinely different products. If no customer ever buys both, they might be duplicates 
--     listed in different categories to appear in more searches."

-- Q10. BigBasket's dark store optimization team had a complex request. "We're trying to find 'inventory 
--      twins' - product pairs that should be stocked together because they have complementary patterns. 
--      I need product pairs where: they're from the SAME category, one sells well on weekdays (more than 
--      70% of its orders are Mon-Fri) and the other sells well on weekends (more than 50% of orders are 
--      Sat-Sun), AND when BOTH are in stock at a store, that store's total orders are higher than 
--      stores where only one is stocked. This tells us which products create synergy together."

-- Q11. The Flipkart return policy team is investigating potential abuse. They need to find customer pairs 
--      (possibly the same person with multiple accounts) who: live in the same city, have the same gender, 
--      joined within 30 days of each other, and have a suspicious return pattern - one customer orders 
--      expensive items and returns them at a high rate (>30% return rate), while the other customer orders 
--      cheap items and rarely returns (<5% return rate). "We think this is a scheme to game our return 
--      policy. For each such pair, calculate the total 'gaming value' - the difference between what the 
--      high-returner ordered vs. what they kept, compared to the low-returner's behavior."

-- Q12. Myntra's brand strategy team received an unusual request from the CEO. "I want to understand our 
--      'brand ecosystem.' For each brand, find the THREE other brands that are most similar to it based 
--      on: overlapping customer base (customers who buy Brand A also buy Brand B), similar price positioning 
--      (average product price within 30%), and similar category coverage (presence in same categories). 
--      But exclude pairs where one brand has more than 5x the products of the other - that's not a fair 
--      comparison. Rank the similarity and explain which factor contributed most to each match."

-- Q13. The RetailMart logistics team discovered a routing inefficiency. They needed to identify "transfer 
--      opportunity pairs" - store pairs in the same state where: Store A has excess inventory (>100 units) 
--      of products that Store B is running low on (<20 units), AND Store B has excess inventory of 
--      different products that Store A needs. "I want to see the potential two-way transfer value - how 
--      much inventory value could move in each direction. Only show pairs where the bidirectional transfer 
--      value exceeds ₹50,000 in total. Also, flag if these stores have ever had orders from the same 
--      customer - that confirms they serve overlapping markets."

-- Q14. Zomato's customer segmentation team had a peculiar hypothesis. "I believe we have 'shadow customer 
--      pairs' - two different customers who behave identically. Find customer pairs where: they're in 
--      different cities but same region, they joined in the same quarter, their total spending is within 
--      10% of each other, their average order value is within ₹200, they've ordered from the same number 
--      of unique stores (±1), AND they've given similar review ratings (average within 0.5 stars). But 
--      here's the key - they should have ordered from DIFFERENT sets of stores. If they ordered from any 
--      of the same stores, that's normal regional behavior. If they never ordered from the same store 
--      but still have identical patterns, THAT'S interesting."

-- Q15. The Amazon India seller team is investigating "review manipulation networks." They need to find 
--      product pairs from DIFFERENT suppliers where: products have unusually similar review patterns - 
--      same average rating (within 0.3 stars), same number of reviews (within 10%), reviews in the same 
--      time periods, BUT the products are in completely different categories. "This is statistically 
--      unlikely unless there's coordinated reviewing. For each suspicious pair, show me the review dates 
--      overlap and whether the same customers reviewed both products. Cross-check if these products 
--      ever appeared in the same order - if they did, maybe it's legitimate bundling. If not, flag as 
--      'POTENTIAL_MANIPULATION'."

-- Q16. BigBasket's pricing committee had a 3 AM emergency. "Our competitor just launched and is price-matching 
--      us. I need to find all products where we have 'pricing vulnerability' - products where: another product 
--      from a different brand in the SAME category is priced within ₹20, has equal or better reviews, AND 
--      has more stock available. For each vulnerable product, I also want to see: the price gap to our 
--      CHEAPEST product in that category (to understand our price floor), and the price gap to our MOST 
--      EXPENSIVE product in that category (to understand our premium potential). Label products as 
--      'FLOOR_RISK' if they're within 10% of our cheapest, 'CEILING_OPPORTUNITY' if there's more than 
--      30% gap to our most expensive, or 'MID_RANGE' otherwise."

-- Q17. The Flipkart HR analytics team was asked to investigate "compensation band violations." They needed 
--      to find employee pairs where: both are in the same department, one has a role that should be 
--      "senior" to the other (based on role name containing words like 'Senior', 'Lead', 'Manager' vs. 
--      'Junior', 'Associate', 'Trainee'), BUT the supposedly senior employee earns LESS than the junior one. 
--      "For each such pair, also check if they work at the same store or different stores. If same store, 
--      it's definitely a problem. If different stores, calculate if the store performance might justify 
--      the inversion - maybe the 'junior' person is at a much higher-performing store. Show the store 
--      sales per employee for context."

-- Q18. Myntra's vendor management team received a legal notice about "discriminatory pricing." A supplier 
--      claimed they were being treated unfairly compared to other suppliers. The team needs to find 
--      supplier pairs where: both supply products in the same categories, have similar product counts (±20%), 
--      but one supplier's products have significantly better "shelf placement" (measured by total sales) 
--      despite similar pricing. "For each pair, calculate the 'fairness ratio' - the ratio of sales per 
--      product. If one supplier has more than 2x the sales per product while having similar prices, 
--      there might be favoritism. Also check if products from both suppliers are stocked at the same stores - 
--      unequal distribution could explain the difference."

-- Q19. The RetailMart fraud detection team is looking for "ghost employees." They suspect some stores 
--      have employees on payroll who don't actually work. They need to find employee pairs at the same 
--      store where: one employee has consistent attendance (>90% present days), the other has almost 
--      no attendance (<10% present days), BUT the low-attendance employee has salary history showing 
--      regular increases. "For each suspicious pair, show: the attendance disparity, salary progression 
--      of the low-attendance employee, and whether the low-attendance employee's total compensation 
--      over time exceeds what they would have earned with normal attendance. Flag cases where someone 
--      is being paid for not working."

-- Q20. Zomato's "restaurant" (store) quality assurance team needs to identify "rating manipulation pairs." 
--      They want to find store pairs in the same city where: one store has significantly higher average 
--      customer ratings (by >1 star) but LOWER sales, while the other has lower ratings but HIGHER sales. 
--      "This is suspicious - normally higher ratings correlate with higher sales. For each pair, check 
--      if the high-rating/low-sales store has reviews from customers who have NEVER ordered from them 
--      (review exists but no order). That would confirm review fraud. Also check the review text length - 
--      fake reviews are often shorter."

-- Q21. The Amazon India supply chain team needs to solve a complex "supplier substitutability" analysis. 
--      For each supplier, find all other suppliers that could serve as backups based on: category overlap 
--      (supply products in at least 2 of the same categories), price range similarity (average product 
--      price within 25%), and proven quality (average customer rating within 0.5 stars). "But here's 
--      the twist - I want to know which backup suppliers would be 'upgrades' (better ratings and/or 
--      lower prices), 'downgrades' (worse ratings and/or higher prices), or 'lateral moves' (similar 
--      on all dimensions). Also flag if any backup supplier already supplies to stores where the primary 
--      supplier doesn't - that would make the transition easier."

-- Q22. BigBasket's customer analytics team had a philosophical question turned technical. "We want to 
--      find 'customer doppelgangers' - pairs of customers who are statistically indistinguishable but 
--      live in completely different cities. The criteria: same gender, same age group (within 5 years), 
--      same loyalty tier (based on points), same order frequency (orders per month within 0.5), same 
--      average basket value (within ₹300), AND purchased from the same set of categories. For each 
--      doppelganger pair, tell me: which customer has higher total spending (the 'alpha'), and whether 
--      there are product-level overlaps (same products purchased) or just category-level similarities."

-- Q23. The Flipkart inventory management team needs to solve a "stock rotation puzzle." They want to 
--      identify product pairs at the same store where: both products are in the same category, one is 
--      'fast-moving' (sold more than 50% of its average stock this month) and the other is 'slow-moving' 
--      (sold less than 10% of its average stock), BUT the slow-moving product has a higher price point. 
--      "For each such pair, calculate: the revenue opportunity if we converted slow-movers to fast-mover 
--      velocity, the potential dead stock value, and whether the slow-mover is getting cannibalizing by 
--      the fast-mover (if customers who bought the fast-mover typically ordered higher-value items before)."

-- Q24. Myntra's category strategy team needs to understand "brand competition dynamics." For each brand pair 
--      competing in the same categories, calculate: their direct product overlaps (same categories AND 
--      similar price points), their share of voice (% of total category sales), customer exclusivity 
--      (% of Brand A customers who NEVER buy Brand B and vice versa), and cross-shopping (% who buy both). 
--      "Only show brand pairs where the competitive relationship is 'asymmetric' - where one brand has 
--      significantly higher exclusivity than the other. These are brands where customers are loyal on 
--      one side but not the other."

-- Q25. The RetailMart complete store pairing analysis: Find all meaningful store pairs by analyzing 
--      them across MULTIPLE dimensions simultaneously. For each pair: geographical proximity (same city, 
--      same state, same region, or different region), size similarity (based on employee count), 
--      performance similarity (based on sales), product overlap (% of common products stocked), and 
--      customer overlap (% of common customers). Create a composite "pairing score" and flag pairs that 
--      are 'REDUNDANT' (high overlap but both performing), 'CANNIBALIZING' (high overlap with one 
--      underperforming), 'COMPLEMENTARY' (low overlap with both performing), or 'ISOLATED' (low overlap 
--      with one underperforming).

-- =====================
-- SECTION B: CROSS JOIN CATASTROPHES (Q26-Q50)
-- =====================

-- Q26. The Flipkart demand forecasting team's request seemed simple but became a nightmare. "I need a 
--      complete product-store-week matrix for the last 8 weeks. For each cell, show: actual sales (if any), 
--      predicted sales (based on the product's average weekly sales at similar stores), inventory at 
--      week start, and stockout indicator (was there any day that week where stock was 0 but there was 
--      demand?). Then classify each cell as: 'PERFORMING' (actual > predicted), 'UNDERPERFORMING' 
--      (actual < 70% of predicted AND had stock), 'STOCKOUT_LOSS' (actual < predicted AND had stockout), 
--      or 'LOW_DEMAND' (low actual AND low predicted). I need this for all 3,400 product-store combinations."

-- Q27. BigBasket's pricing strategy team had a "what-if" analysis that required cross-joining everything. 
--      "For every product, I want to see its performance under every possible promotion that has ever run. 
--      Calculate: the discounted price, the likely sales lift (based on similar products during that 
--      promotion), the margin impact, and whether this combination has EVER actually happened. Then 
--      flag combinations that would be: 'PROFITABLE_OPPORTUNITY' (never tried but margin positive), 
--      'MARGIN_KILLER' (high sales lift but negative margin), 'ALREADY_OPTIMIZED' (already tried with 
--      good results), or 'PROVEN_FAILURE' (already tried with poor results)."

-- Q28. The RetailMart workforce planning team needed a nightmare matrix. "Cross every employee with 
--      every store in the same region. For each combination, show: current assignment status (assigned, 
--      not assigned, or from different region), the salary difference vs. store's average for that role, 
--      the attendance rate if assigned to that store (or predicted based on similar employees), and 
--      the potential productivity (based on the employee's department and the store's sales in that 
--      department). Then identify 'TRANSFER_OPPORTUNITIES' where an employee would likely perform 
--      better at a different store - higher potential productivity AND the store is understaffed 
--      in that department."

-- Q29. Zomato's "menu engineering" (product optimization) team wants a product-category-store matrix 
--      that's exhaustive. "For every product that exists, show me every category it COULD reasonably 
--      belong to (based on price range and brand), crossed with every store. Then for each cell, show: 
--      current classification status (correctly categorized, potentially miscategorized), current stock, 
--      category performance at that store (% of store's sales from this category), and competitive 
--      position (how does this product's price compare to category average at this store). Flag 
--      'REPOSITIONING_OPPORTUNITIES' where a product might perform better in a different category 
--      based on competitive dynamics."

-- Q30. The Amazon India marketplace team needed the ultimate supplier analysis. "Cross every supplier 
--      with every category in our taxonomy and every region we serve. For each supplier-category-region 
--      combination, show: current participation (active, inactive, never), if active: number of products, 
--      total sales, market share; if inactive or never: the gap (what % of category-region demand they're 
--      NOT capturing), potential revenue (based on their performance in other regions), and competition 
--      intensity (how many other suppliers are active in this category-region). Priority flag for 
--      'EXPANSION_TARGETS' where a supplier is strong in category but weak in region."

-- Q31. Myntra's visual merchandising team requested something that made the data team cry. "Create a 
--      brand-brand adjacency matrix for store displays. Cross every brand with every other brand. 
--      For each pair, calculate: customer overlap (% who buy both), price complementarity (do they 
--      serve different price points?), category adjacency (are they in categories typically shopped 
--      together?), and historical co-purchase rate (how often they appear in the same order). Then 
--      score each pair as: 'NATURAL_PARTNERS', 'COMPETING_BRANDS', 'OPPORTUNITY_GAP' (high potential 
--      but low actual co-purchase), or 'MISALIGNED' (frequently together but shouldn't be based on 
--      target demographics)."

-- Q32. The RetailMart capacity planning team's request: "I need a store-product-month matrix for the 
--      next 12 months (use date dimension). For each cell, project: estimated demand (based on 
--      seasonality and trend from last year's same month), required inventory (demand × safety factor 
--      for that product type), current warehouse capacity used (based on product size/category), 
--      and capacity pressure (% of store's total capacity this product would need). Flag months where 
--      stores will hit 'CAPACITY_CRISIS' (total projected need > 90% of capacity), 'REBALANCING_NEEDED' 
--      (some products over-allocated while others under-allocated), or 'COMFORTABLE' (everything fits)."

-- Q33. PhonePe's customer journey team wanted a customer-touchpoint matrix. "Cross every customer with 
--      every possible marketing touchpoint (campaigns, email types, store visits, etc.). For each 
--      combination, show: has this customer been exposed to this touchpoint?, if yes: response rate 
--      (for emails: open/click, for campaigns: order during campaign), if no: predicted response 
--      (based on similar customers). Then identify 'OVER_MARKETED' customers (exposed to >10 touchpoints 
--      with declining response), 'UNDER_REACHED' customers (high value but few touchpoints), and 
--      'OPTIMAL_MIX' customers (good balance and response)."

-- Q34. The BigBasket route optimization team needed a delivery matrix. "Cross every customer postal code 
--      with every store (dark store). For each combination, estimate: distance category (near, medium, 
--      far based on postal code patterns), average delivery time (based on actual orders for that 
--      store-zone combination), customer demand from that zone (order count and value), and current 
--      allocation (is this store actually serving this zone?). Then identify: 'MISROUTED_DEMAND' 
--      (customers being served by distant stores when nearby stores are available), 'UNDERSERVED_ZONES' 
--      (high demand zones with no nearby stores), and 'OVERLOADED_STORES' (stores serving too many zones)."

-- Q35. Flipkart's assortment planning team: "Create a category-brand-store suitability matrix. 
--      For each combination, calculate: market fit (does this store's customer base typically buy 
--      this brand-category combo?), competition density (how many other brand-category combos are 
--      already at this store?), price positioning (is this brand-category's price appropriate for 
--      this store's average customer?), and current status (stocked, not stocked). Flag 'INTRODUCTION_ 
--      OPPORTUNITIES' (high market fit, low competition, not stocked), 'RATIONALIZATION_CANDIDATES' 
--      (low market fit, high competition, currently stocked), and 'MUST_HAVES' (high fit, essential 
--      category, should definitely be stocked)."

-- Q36. The RetailMart promotion calendar team: "Cross every date in the next quarter with every product 
--      category with every store. For each cell, show: any existing promotions, historical sales on 
--      that day of week for that category-store, predicted sales with current promotions, and 
--      'promotion gap' (days without any promotion). Then identify 'PROMOTION_DESERTS' (high potential 
--      days with no promotions), 'PROMOTION_CONFLICTS' (multiple promotions competing on same day), 
--      and 'OPTIMAL_WINDOWS' (natural high-demand days where promotion could maximize impact)."

-- Q37. Zomato's supplier onboarding team: "I need a supplier capability matrix. Cross every potential 
--      category expansion with every current supplier. For each combination, assess: current capability 
--      (do they already supply this category?), adjacent capability (do they supply similar categories?), 
--      quality track record (their average customer rating in current categories), price competitiveness 
--      (their pricing vs. category average), and reliability (their stockout history). Then rank 
--      suppliers for each category expansion as: 'READY_NOW', 'TRAINABLE' (1-2 gaps to close), 
--      'SIGNIFICANT_GAP', or 'NOT_SUITABLE'."

-- Q38. The Myntra size planning team's request was massive: "Cross every product with every store 
--      with every size (derive sizes from product variations if available, or use category defaults). 
--      For each cell, show: current stock of this product-size, historical demand for this size at 
--      this store (based on returns and orders), size curve (% of this size vs. other sizes), and 
--      deviation from ideal size curve (does this store over or under-stock this size?). Flag 
--      'SIZE_RUN_GAPS' (sizes frequently out of stock at this store), 'SIZE_CURVE_MISMATCH' (store's 
--      demand pattern doesn't match stocking), and 'DEAD_SIZES' (sizes that never sell at this store)."

-- Q39. Amazon India's marketplace balance team: "Cross every product category with every price tier 
--      (derive tiers: Budget <₹500, Mid-range ₹500-2000, Premium ₹2000-5000, Luxury >₹5000) with 
--      every region. For each cell, show: number of products available, total sales, market share 
--      of this tier in this category-region, customer satisfaction (average rating), and competitive 
--      index (how crowded is this cell?). Identify 'MARKET_GAPS' (low competition high demand), 
--      'RED_OCEANS' (high competition low margin), and 'SWEET_SPOTS' (moderate competition good margins)."

-- Q40. The BigBasket basket analysis team needed a frightening matrix. "Cross every product with every 
--      OTHER product. For each pair, calculate: co-occurrence rate (how often bought together), 
--      lift (is co-occurrence higher than random chance?), category relationship (same, complementary, 
--      or unrelated), price relationship (similar tier or different tiers), and sequence (which product 
--      is typically added to cart first?). Then create bundle recommendations: 'OBVIOUS_BUNDLE' (high 
--      co-occurrence, complementary categories), 'SURPRISING_PAIR' (high co-occurrence despite unrelated 
--      categories), 'MISSED_OPPORTUNITY' (complementary categories, low current co-occurrence), and 
--      'CANNIBALIZATION_RISK' (same category, negative correlation)."

-- Q41. RetailMart's financial planning team: "Create an expense-revenue correlation matrix. Cross 
--      every expense category with every store with every month for the past year. For each cell, 
--      show: the expense amount, the revenue that month, the expense-to-revenue ratio, and how this 
--      compares to the network average for that expense type. Then identify 'EFFICIENCY_LEADERS' 
--      (stores with consistently below-average expense ratios), 'CONCERNING_TRENDS' (stores with 
--      rising expense ratios), and 'INVESTIGATION_NEEDED' (stores with expense patterns that don't 
--      correlate with revenue patterns - potentially fraudulent)."

-- Q42. The Flipkart customer migration team: "Cross every customer with every customer segment 
--      (derive segments from spending patterns). For each customer-segment combination, show: 
--      current assignment probability (how well they fit this segment), historical segment membership 
--      (were they ever in this segment?), segment transition likelihood (are they moving toward or 
--      away from this segment?), and segment value (what's the revenue difference if they were in 
--      this segment vs. current). Flag customers who are 'UPGRADING' (moving to higher-value segments), 
--      'DOWNGRADING' (moving to lower-value), 'STABLE', or 'AT_RISK' (exhibiting churn signals)."

-- Q43. Zomato's competitive positioning team: "Create a restaurant (store) competitive matrix. 
--      Cross every store with every other store in the same city. For each pair, calculate: 
--      product overlap (% of shared products), price competition index (how similar are their prices?), 
--      customer overlap (% of shared customers), and performance gap (difference in sales). Then 
--      categorize each pair as: 'DIRECT_COMPETITORS' (high overlap, similar prices, shared customers), 
--      'DIFFERENTIATED' (low overlap, different prices), 'ASYMMETRIC' (one-sided competition where 
--      only one store is affected), or 'COMPLEMENTARY' (customers tend to use both)."

-- Q44. Myntra's inventory aging team: "Cross every product with every store with every age bucket 
--      (0-30 days, 31-60 days, 61-90 days, 90+ days since last sale). For each cell, show: 
--      current stock in this age bucket, value of aged inventory, velocity trend (is it selling 
--      faster or slower over time?), and markdown recommendation (based on age and velocity). 
--      Then aggregate to show 'AGING_HOTSPOTS' (products aging fast at specific stores), 
--      'FRESH_INVENTORY' (healthy age distribution), and 'WRITE_OFF_CANDIDATES' (>90 days with 
--      no movement)."

-- Q45. The Amazon India logistics network team: "Create a warehouse-to-customer coverage matrix. 
--      Cross every store/warehouse with every customer location (aggregate by city). For each cell, 
--      show: number of customers, total order value, current delivery times, delivery success rate, 
--      and return rate. Then calculate network efficiency: 'WELL_SERVED' (good delivery metrics), 
--      'UNDERSERVED' (poor metrics despite volume), 'OVER_INVESTED' (too many warehouses for demand), 
--      and 'ROUTING_ISSUES' (good coverage on paper but poor actual performance)."

-- Q46. BigBasket's product hierarchy team: "Cross every product with every possible category path 
--      in the taxonomy (from top-level to sub-category). For each combination, assess: current 
--      assignment (is product here?), fit score (based on product name, price, brand), customer 
--      search behavior (which paths do customers use to find this product?), and navigation depth 
--      (how many clicks to reach?). Flag 'MISCATEGORIZED' (poor fit score), 'HIDDEN_GEMS' (good 
--      products in low-traffic paths), 'REDUNDANT_PLACEMENT' (product appears in too many paths), 
--      and 'OPTIMAL_PLACEMENT' (good fit and traffic)."

-- Q47. The RetailMart employee scheduling team: "Cross every employee with every shift pattern 
--      (morning/evening/night) with every day of week. For each cell, show: current assignment, 
--      attendance history in that shift, productivity in that shift (sales per hour if applicable), 
--      and preference indicator (based on attendance patterns - do they perform better in certain 
--      shifts?). Then optimize: 'OPTIMAL_ASSIGNMENT' (current = best based on data), 'REASSIGN_ 
--      CANDIDATE' (would perform better in different shift), 'AVAILABILITY_GAP' (willing but 
--      never scheduled), and 'RESISTANCE_LIKELY' (poor performance in attempted shifts)."

-- Q48. Flipkart's returns prediction team: "Cross every product with every customer segment with 
--      every purchase channel (app, web, store pickup). For each cell, show: historical return 
--      rate, average return reason, time to return, and refund vs. exchange ratio. Then model 
--      'RETURN_RISK' for each combination: 'HIGH_RISK' (>30% return rate), 'MODERATE' (15-30%), 
--      'LOW_RISK' (<15%), and 'INSUFFICIENT_DATA' (too few transactions to judge). Flag combinations 
--      where return rate is anomalously high for that product or segment."

-- Q49. Zomato's customer lifetime value team: "Cross every customer cohort (by join quarter) with 
--      every time period (quarters since joining) with every metric (orders, revenue, average order 
--      value, order frequency). For each cell, calculate the cohort's performance on that metric 
--      in that period. Then analyze: 'GROWTH_COHORTS' (improving over time), 'DECLINING_COHORTS' 
--      (degrading performance), 'STEADY_STATE_COHORTS' (stable), and 'ANOMALY_COHORTS' (unusual 
--      patterns). Compare newer vs. older cohorts to understand if customer quality is improving."

-- Q50. The Myntra complete business matrix: "Cross every dimension we have: stores × categories × 
--      brands × time periods × customer segments. This will be massive, so aggregate appropriately. 
--      For each meaningful combination, show: total sales, unique customers, basket size, return rate, 
--      and margin. Then identify: 'POWER_COMBINATIONS' (top 20% driving 80% of profit), 'LONG_TAIL' 
--      (bottom 50% that could be optimized), 'EMERGING_OPPORTUNITIES' (fast-growing combinations), 
--      and 'DECLINING_AREAS' (previously strong now weakening). This is the ultimate business cube."

-- =====================
-- SECTION C: SET OPERATIONS HELL (Q51-Q75)
-- =====================

-- Q51. The Flipkart customer lifecycle team had a breakdown in their segment definitions and needed 
--      to rebuild from scratch. "Our segments have become meaningless because customers fall into 
--      multiple buckets. I need mutually exclusive segments using set operations: 'LOYAL_ACTIVE' 
--      (ordered every month for 6+ months AND have loyalty points AND have reviews), 'LOYAL_DORMANT' 
--      (USED to order monthly but stopped 3+ months ago AND still have high loyalty points), 
--      'SPORADIC_ENGAGED' (order occasionally AND have reviews AND respond to emails), 'SPORADIC_PASSIVE' 
--      (order occasionally but NO reviews and NO email engagement), 'NEW_PROMISING' (joined <90 days 
--      ago AND already 3+ orders), 'NEW_AT_RISK' (joined <90 days ago AND 0-1 orders), and 'UNKNOWN' 
--      (anyone not fitting the above). Every customer must appear in EXACTLY ONE segment."

-- Q52. BigBasket's product lifecycle management team needed to classify every product into exactly 
--      one stage: 'NEW' (listed <30 days, few orders), 'GROWTH' (orders increasing month-over-month 
--      for 3+ months), 'MATURE' (stable orders for 3+ months), 'DECLINING' (orders decreasing for 
--      3+ months), 'ZOMBIE' (exists but almost no orders in 6+ months), 'CASH_COW' (high profit 
--      margin AND high volume), 'STAR' (high growth AND high margin), 'QUESTION_MARK' (high growth 
--      but uncertain margins), and 'DOG' (low growth AND low margin). Use sales, margin, and time 
--      data with INTERSECT and EXCEPT to ensure mutual exclusivity.

-- Q53. The RetailMart store health classification needs to be rebuilt. Using set operations, 
--      create these mutually exclusive categories: 'FLAGSHIP' (top 10% in sales AND top 10% in 
--      profit AND <5% return rate), 'EFFICIENT' (top 20% in profit ratio even if not top in absolute 
--      sales), 'VOLUME_PLAYER' (top 20% in sales but lower profit margin), 'EMERGING' (sales 
--      growing >20% year-over-year), 'TURNAROUND_NEEDED' (below average on most metrics but showed 
--      improvement last month), 'AT_RISK' (declining on all metrics for 3+ months), and 'CLOSURE_ 
--      CANDIDATE' (consistently in bottom 10% with no improvement). Every store in exactly one category.

-- Q54. Myntra's supplier relationship tiers need to be redefined. Create mutually exclusive tiers: 
--      'STRATEGIC_PARTNER' (supplies 5+ categories AND top 10% supplier by revenue AND <2% return 
--      rate AND never had stockout), 'PREFERRED' (supplies 3+ categories OR top 20% by revenue AND 
--      good performance), 'STANDARD' (meets basic performance thresholds but nothing exceptional), 
--      'PROBATION' (has had issues - stockouts OR high returns - but recovering), 'RESTRICTED' 
--      (currently has active issues requiring limitation), and 'EXIT_PLANNED' (relationship ending). 
--      Each supplier exactly one tier.

-- Q55. The Zomato employee classification system using set operations: 'STAR_PERFORMER' (attendance >95% 
--      AND salary in top 20% for their role AND at high-performing store), 'CONSISTENT_CONTRIBUTOR' 
--      (attendance >85% AND meets expectations AND stable salary history), 'HIGH_POTENTIAL' (newer 
--      employee <2 years AND already showing exceptional metrics), 'DEVELOPING' (not yet meeting 
--      expectations but showing improvement), 'UNDERPERFORMING' (below expectations on multiple metrics 
--      for 3+ months), 'SPECIAL_CIRCUMSTANCES' (on leave or special assignment), and 'INVESTIGATION_ 
--      PENDING' (anomalies in their data requiring HR review). Mutually exclusive classification.

-- Q56. Amazon India's product classification challenge: Using INTERSECT and EXCEPT, create these 
--      mutually exclusive product buckets: 'BESTSELLER' (top 5% by units sold), 'HIGH_VALUE' (top 5% 
--      by revenue but not bestseller), 'RELIABLE_SELLER' (consistent sales for 6+ months, mid-tier), 
--      'SEASONAL_STAR' (low normal sales but spikes during specific periods), 'NICHE_PRODUCT' 
--      (low volume but high margin and loyal repeat customers), 'COMMODITIZED' (high volume but 
--      very low margin), 'LONG_TAIL_STABLE' (low volume, low margin, but consistent), 'TROUBLED' 
--      (high returns or declining sales), 'NEW_LAUNCH' (listed <60 days, insufficient data), and 
--      'OBSOLETE' (no sales in 90+ days). Every product exactly once.

-- Q57. The BigBasket marketing channel attribution nightmare. Customers need to be classified by 
--      their dominant acquisition/engagement channel using set operations: 'EMAIL_DRIVEN' (majority 
--      of orders came after email campaigns AND high email open rate), 'ORGANIC' (joined without 
--      any campaign AND continues ordering without marketing), 'CAMPAIGN_DEPENDENT' (only orders 
--      during major campaigns), 'APP_LOYAL' (uses only mobile app, never web), 'WEB_LOYAL' (opposite), 
--      'OMNICHANNEL' (uses multiple channels actively), 'WORD_OF_MOUTH' (joined after a referrer's 
--      order AND no marketing engagement), and 'UNKNOWN_SOURCE' (can't attribute). Mutually exclusive.

-- Q58. RetailMart's complete inventory status classification. For each product-store combination: 
--      'OPTIMAL' (stock between safety stock and max AND selling at expected rate), 'OVERSTOCKED' 
--      (stock > 2x max AND slow-moving), 'CRITICALLY_LOW' (stock < safety stock AND high demand), 
--      'STOCKOUT' (zero stock AND had demand in last 7 days), 'DEAD_STOCK' (has stock AND zero 
--      demand in 30+ days), 'PHANTOM' (in inventory system but physical stock mismatch suspected), 
--      'SEASONAL_BUILDUP' (intentionally high stock for upcoming season), and 'CLEARANCE' 
--      (marked for liquidation). Each product-store exactly one status.

-- Q59. The Flipkart order status matrix needs cleanup. Using set operations, classify each order 
--      into exactly one final status: 'PERFECT_ORDER' (delivered on time AND no returns AND 
--      positive review if any), 'SATISFACTORY' (delivered AND no issues but no positive signal), 
--      'DELAYED_BUT_ACCEPTED' (delivered late but customer kept item), 'RETURNED_REFUND' (returned 
--      for refund), 'RETURNED_EXCHANGE' (returned for exchange), 'CANCELLED_BY_CUSTOMER' (cancelled 
--      before shipment by customer), 'CANCELLED_BY_SYSTEM' (cancelled due to inventory/fraud), 
--      'DELIVERY_FAILED' (could not deliver), 'DISPUTED' (payment or delivery dispute), and 
--      'IN_PROGRESS' (not yet completed). Mutual exclusivity required.

-- Q60. Zomato's customer satisfaction classification: 'PROMOTER' (NPS 9-10 equivalent - high ratings 
--      AND repeat orders AND referred others), 'SATISFIED' (good ratings AND repeat orders but 
--      no referrals), 'PASSIVE' (average ratings AND occasional orders), 'AT_RISK_DETRACTOR' 
--      (showing declining satisfaction - ratings dropping OR order frequency dropping), 'DETRACTOR' 
--      (low ratings OR complaints OR high returns), 'CHURNED' (was active, now no activity for 90+ days 
--      AND last experience was negative), 'DORMANT' (no activity but last experience was fine), and 
--      'UNCLASSIFIED' (insufficient data). Every customer exactly one classification.

-- Q61. Myntra's product-customer affinity classification. For each product-customer pair: 
--      'PURCHASED_LOVED' (bought AND kept AND good review), 'PURCHASED_NEUTRAL' (bought AND kept 
--      AND no review), 'PURCHASED_RETURNED' (bought AND returned), 'BROWSED_NOT_BOUGHT' (viewed 
--      but didn't purchase based on behavior data if available, else skip), 'RECOMMENDED_CONVERTED' 
--      (was recommended this product AND bought it), 'RECOMMENDED_IGNORED' (was recommended AND 
--      didn't buy), and 'NO_EXPOSURE' (customer never saw this product). Create this massive 
--      classification using set operations.

-- Q62. The Amazon India returns classification challenge: For each return, classify as: 
--      'LEGITIMATE_DEFECT' (genuine product defect confirmed), 'LEGITIMATE_MISMATCH' (product 
--      didn't match description), 'BUYER_REMORSE' (customer changed mind, no product issue), 
--      'WARDROBING_SUSPECTED' (product was clearly used before return), 'FRAUD_SUSPECTED' 
--      (return behavior matches fraud patterns), 'SHIPPING_DAMAGE' (product damaged in transit), 
--      'WRONG_ITEM_SENT' (fulfillment error), 'SIZE_FIT_ISSUE' (sizing problem, especially for 
--      fashion), and 'DELAYED_DELIVERY' (returned because it arrived too late). Mutually exclusive 
--      using available data points.

-- Q63. BigBasket's complex customer value segment: Using multiple metrics and set operations, 
--      create these segments: 'DIAMOND' (top 1% spenders AND longest tenure AND highest frequency 
--      AND best retention), 'PLATINUM' (top 5% on at least 2 of the above), 'GOLD' (top 10% on 
--      at least 1 of the above AND good on others), 'SILVER' (above average on all but not 
--      exceptional on any), 'BRONZE' (average or below on most metrics), 'POTENTIAL' (new but 
--      showing early strong signals), 'LAPSED_HIGH_VALUE' (was Diamond/Platinum, now inactive), 
--      'OCCASIONAL' (buys rarely but when they do, it's significant), and 'MINIMAL' (lowest 
--      engagement and value). Every customer exactly one segment.

-- Q64. The RetailMart expense classification using set operations: For each expense entry, 
--      classify as: 'ESSENTIAL_FIXED' (rent, utilities, mandatory costs), 'ESSENTIAL_VARIABLE' 
--      (inventory-related, scales with sales), 'DISCRETIONARY_GROWTH' (marketing, expansion), 
--      'DISCRETIONARY_MAINTENANCE' (nice-to-have but not critical), 'ONE_TIME_CAPEX' (capital 
--      expenditure), 'RECURRING_CAPEX' (regular capital refresh), 'ANOMALOUS_HIGH' (expense 
--      unusually high for this store), 'ANOMALOUS_LOW' (unusually low, might be missing), and 
--      'INVESTIGATION_REQUIRED' (doesn't fit any pattern). Each expense exactly one category.

-- Q65. Flipkart's shipping performance classification: For each shipment, classify as: 
--      'PERFECT_DELIVERY' (on-time, no issues, POD received), 'EARLY_DELIVERY' (delivered before 
--      promise), 'SLIGHTLY_DELAYED' (1-2 days late), 'SIGNIFICANTLY_DELAYED' (3+ days late), 
--      'MULTIPLE_ATTEMPTS' (required multiple delivery attempts), 'RETURNED_TO_ORIGIN' (customer 
--      unavailable, returned), 'LOST_IN_TRANSIT' (never delivered, compensation required), 
--      'DAMAGED_IN_TRANSIT' (delivered but damaged), 'CUSTOMER_REFUSED' (delivered but customer 
--      refused), and 'IN_TRANSIT' (not yet delivered). Mutually exclusive classification.

-- Q66. Zomato's employee career trajectory classification: Using salary history, attendance, 
--      and performance data with set operations: 'FAST_TRACK' (multiple promotions/raises in 
--      short time AND high performance), 'STEADY_GROWTH' (consistent but slower progression), 
--      'PLATEAUED' (no progression in 2+ years despite tenure), 'RECENTLY_PROMOTED' (promotion 
--      in last 6 months), 'NEW_HIRE' (joined <1 year ago), 'LATERAL_MOVE' (changed role/store 
--      but not level), 'DEMOTED' (salary decrease or role decrease), 'RETENTION_RISK' (high 
--      performer but salary below market), and 'STABLE_CONTRIBUTOR' (neither growing nor at 
--      risk). Each employee exactly one trajectory.

-- Q67. The Myntra campaign effectiveness classification: For each campaign, classify as: 
--      'BLOCKBUSTER' (exceeded all targets by >50%), 'SUCCESS' (met or exceeded targets), 
--      'PARTIAL_SUCCESS' (some metrics hit, others missed), 'BREAK_EVEN' (no significant positive 
--      or negative impact), 'UNDERPERFORMER' (below targets but positive ROI), 'FAILURE' (negative 
--      ROI), 'TOO_EARLY' (not enough data yet), 'INCONCLUSIVE' (conflicting signals), and 
--      'CANCELLED' (stopped before completion). Use INTERSECT and EXCEPT to handle overlapping 
--      criteria. Each campaign exactly one classification.

-- Q68. Amazon India's listing quality classification: For each product listing, classify as: 
--      'EXEMPLARY' (complete info, great images, reviews, conversion rate above average), 
--      'GOOD' (complete info, adequate images, some reviews), 'BASIC' (minimum required info), 
--      'INCOMPLETE' (missing key information), 'MISLEADING' (high return rate suggesting 
--      description issues), 'OUTDATED' (information not updated in 6+ months), 'PRICE_ISSUE' 
--      (price seems wrong - too high or too low vs category), 'IMAGE_ISSUE' (image quality 
--      problems flagged), and 'COMPLIANCE_RISK' (may violate policies). Mutually exclusive.

-- Q69. BigBasket's order fulfillment classification: For each order, classify fulfillment as: 
--      'PERFECT_FULFILLMENT' (all items picked, packed, delivered correctly), 'PARTIAL_FULFILLMENT' 
--      (some items unavailable, rest delivered), 'SUBSTITUTION_ACCEPTED' (customer accepted 
--      alternatives), 'SUBSTITUTION_REJECTED' (customer rejected alternatives), 'PICKING_ERROR' 
--      (wrong items picked), 'PACKING_ERROR' (damage during packing), 'DELIVERY_ERROR' (delivered 
--      to wrong address or person), 'COMPLETE_FAILURE' (order not fulfilled at all), and 
--      'EXCEPTIONAL_SERVICE' (went above and beyond - early delivery, extra care, etc.). Each 
--      order exactly one classification.

-- Q70. The RetailMart customer communication classification: For each customer, classify their 
--      communication status as: 'FULLY_OPTED_IN' (all channels enabled), 'EMAIL_ONLY' (only 
--      email enabled), 'SMS_ONLY' (only SMS enabled), 'APP_NOTIFICATIONS_ONLY' (only push), 
--      'MINIMAL' (only transactional communications), 'OPTED_OUT' (no marketing but transactional 
--      allowed), 'COMPLETELY_BLOCKED' (no communications at all), 'PREFERENCE_UNKNOWN' (no clear 
--      preference set), and 'PREFERENCE_CONFLICT' (conflicting signals in their settings). 
--      Mutually exclusive using set operations.

-- Q71. Flipkart's product recommendation classification: For each product pair, classify the 
--      recommendation relationship as: 'FREQUENTLY_BOUGHT_TOGETHER' (high co-purchase rate), 
--      'VIEWED_TOGETHER' (high co-view but not always co-purchase), 'ONE_WAY_RECOMMENDATION' 
--      (buying A leads to buying B but not reverse), 'SUBSTITUTE_PRODUCTS' (rarely bought 
--      together, similar attributes), 'COMPLEMENTARY_THEORETICAL' (should go together but data 
--      doesn't show it), 'CONFLICTING_PRODUCTS' (buying one negatively impacts buying other), 
--      'UNRELATED' (no relationship detected), and 'BUNDLE_CANDIDATE' (strong signal for forced 
--      bundling). Use set operations on transaction data.

-- Q72. Zomato's price position classification: For each product in each store, classify price 
--      position as: 'PRICE_LEADER' (cheapest in category at this store), 'COMPETITIVE' (within 
--      10% of cheapest), 'MARKET_PRICE' (around average), 'PREMIUM' (10-30% above average), 
--      'LUXURY' (>30% above average), 'SUSPICIOUS_LOW' (might be a pricing error - too cheap), 
--      'SUSPICIOUS_HIGH' (might be a pricing error - too expensive), 'NEW_PRICE' (recently 
--      changed, evaluation pending), and 'NO_COMPARISON' (only product in category at this 
--      store). Mutually exclusive classification.

-- Q73. Myntra's inventory reconciliation classification: For each product-store-date combination, 
--      classify reconciliation status as: 'BALANCED' (system matches physical), 'POSITIVE_VARIANCE' 
--      (more physical than system - maybe return not recorded), 'NEGATIVE_VARIANCE' (less physical 
--      than system - maybe theft or damage), 'MAJOR_DISCREPANCY' (variance > 10%), 'RECOUNT_REQUIRED' 
--      (variance exists but within tolerance), 'NOT_COUNTED' (no physical count data), 'CYCLE_COUNT_ 
--      PENDING' (scheduled for count), 'ADJUSTMENT_APPLIED' (variance resolved via adjustment), 
--      and 'INVESTIGATION' (suspicious variance pattern). Mutually exclusive.

-- Q74. The Amazon India seller performance classification: For each seller (supplier), classify as: 
--      'TOP_SELLER' (high volume, high rating, fast shipping, low returns), 'RISING_STAR' 
--      (newer seller with strong early metrics), 'ESTABLISHED' (consistent good performance), 
--      'INCONSISTENT' (fluctuating metrics), 'DECLINING' (used to be good, now deteriorating), 
--      'NEW_SELLER' (<90 days, evaluation period), 'POLICY_VIOLATION' (has had policy issues), 
--      'RESTRICTED' (limited selling privileges), 'SUSPENDED' (currently not active), and 
--      'ELITE' (best of the best with special privileges). Mutually exclusive using set operations.

-- Q75. BigBasket's delivery slot classification: For each delivery slot across all zones, classify as: 
--      'HIGH_DEMAND_AVAILABLE' (popular time, capacity exists), 'HIGH_DEMAND_FULL' (popular time, 
--      no capacity), 'LOW_DEMAND_PROFITABLE' (less popular but efficient), 'LOW_DEMAND_WASTEFUL' 
--      (barely used, resources wasted), 'PEAK_HOUR' (absolute highest demand of day), 'OFF_PEAK' 
--      (lowest demand), 'PREMIUM_SLOT' (charged extra), 'FREE_SLOT' (no additional charge), and 
--      'DISABLED' (not available for ordering). Each slot-zone combination exactly one classification.

-- =====================
-- SECTION D: ULTIMATE INTEGRATION CHALLENGES (Q76-Q100)
-- =====================

-- Q76. The Flipkart executive dashboard is broken and you need to rebuild it from scratch. Create 
--      a SINGLE query that answers all these questions simultaneously: Top 10 products by sales AND 
--      Top 10 products by returns AND Products that appear in BOTH lists. For each product, show 
--      which list(s) they're in, their sales rank, their return rank, and whether they need 
--      attention (high sales AND high returns). Use UNION and INTERSECT appropriately.

-- Q77. BigBasket's Sunday night batch job needs to run a complete "week in review" analysis. Using 
--      all tools available (self-joins, cross-joins, set operations), create a report showing: 
--      Week-over-week sales comparison by store, Stores that improved vs declined, Products that 
--      sold in both weeks vs only one week, New customers this week vs churned from last week, 
--      and a summary of "stable" vs "volatile" stores based on variance in daily sales.

-- Q78. The RetailMart month-end close process requires a comprehensive reconciliation. Build a 
--      query that identifies ALL discrepancies: Orders without payments, Payments without orders, 
--      Shipments without orders, Returns without orders, Inventory counts that don't match sales 
--      (started + received - sold ≠ ended), and Expenses without matching store activity. Use 
--      EXCEPT operations to find each type of discrepancy and UNION ALL to combine them.

-- Q79. Zomato's board meeting requires a competitive positioning analysis. For each store, compare 
--      it to: the best store in its city (self-join), the average store in its city, the best 
--      store in its region, and the network average. Show how many of these benchmarks each 
--      store beats and classify as 'MARKET_LEADER', 'COMPETITIVE', 'BELOW_PAR', or 'CRITICAL'.

-- Q80. The Myntra strategic planning team needs a 5-year scenario model. Using historical data 
--      and cross-joins with a date dimension, project: what if each category grew at its 
--      historical rate, what if each region grew at its historical rate, what if each customer 
--      segment grew at its historical rate. Then identify conflicts (impossible scenarios where 
--      totals exceed capacity) and opportunities (underserved combinations).

-- Q81. Amazon India's fraud detection system needs a relationship graph. Using self-joins on 
--      customers, identify potential fraud networks: customers with the same address as other 
--      customers, customers with similar names in the same city, customers who always order 
--      together (orders on same days at same stores), and customers whose return patterns mirror 
--      each other. Score each potential network by suspicion level.

-- Q82. The BigBasket supply chain optimization requires a complete flow analysis. Trace every 
--      product's journey: from which suppliers (with alternatives), through which warehouses 
--      (with capacity constraints), to which customers (with demand patterns). Use cross-joins 
--      to map all possible paths, then filter to actual paths, then identify bottlenecks and 
--      optimization opportunities using set operations.

-- Q83. RetailMart's complete customer 360 profile builder. For each customer, aggregate: 
--      Transaction history (using orders), Payment behavior (using payments), Review activity 
--      (using reviews), Loyalty status (using loyalty points), Marketing engagement (using email 
--      clicks), and compare to similar customers (using self-join on demographics). Create a 
--      unified profile score and segment assignment.

-- Q84. The Flipkart A/B testing framework needs rebuilding. Using set operations, create control 
--      and treatment groups that are: balanced on demographics (same gender, age, city distribution), 
--      balanced on history (same order frequency, same average spend), but mutually exclusive 
--      (no customer in both groups), and representative (cover all regions, all customer types).

-- Q85. Zomato's restaurant ranking algorithm rebuild. For each store, calculate: absolute metrics 
--      (sales, ratings, orders), relative metrics (vs city average, vs region average, vs network), 
--      trajectory (improving, stable, declining using self-join on time), and competitive position 
--      (vs similar stores using self-join on attributes). Create a composite rank with explanations.

-- Q86. Myntra's fashion trend detection system. Using self-joins and set operations, identify: 
--      Products gaining popularity (sales increasing month-over-month), Products losing popularity 
--      (sales decreasing), Products that always sell together (co-purchase patterns), Products 
--      that are substitutes (when one sells more, the other sells less), and Products that are 
--      trend indicators (their success predicts category success).

-- Q87. The Amazon India partner performance review. For each supplier, compare against: their 
--      own historical performance (self-join on time), their category peers (self-join on category), 
--      new entrants threatening them (self-join on products), and the ideal supplier profile 
--      (cross-join with benchmark metrics). Create a quadrant analysis: 'STARS', 'CASH_COWS', 
--      'QUESTION_MARKS', 'DOGS'.

-- Q88. BigBasket's real-time inventory optimizer. For each product-store combination, determine: 
--      current stock status (using inventory), recent sales velocity (using order items), 
--      supply chain status (using supplier data), competitor pressure (using self-join on 
--      products for alternatives), and customer dependency (using order patterns). Create 
--      action recommendations: 'REORDER_NOW', 'MAINTAIN', 'REDUCE', 'DISCONTINUE'.

-- Q89. The RetailMart complete P&L builder. Using UNION to combine all monetary transactions: 
--      Revenue from orders, Expenses from expense tables, Salaries from employee data, and 
--      compare actual vs expected (using historical averages). Create a complete picture of 
--      financial health with variance analysis for each store, region, and overall.

-- Q90. Flipkart's churn prediction features. For each customer, calculate: recency (days since 
--      last order), frequency (orders per month average), monetary (total and average spend), 
--      trajectory (are these metrics improving or worsening using self-join), and comparison 
--      (how do they compare to similar customers who churned vs retained). Flag risk levels.

-- Q91. Zomato's complete menu optimization. For each product at each store: current performance 
--      (sales, margin), category context (vs other products in same category using self-join), 
--      brand context (vs other products from same brand), store context (is this product a 
--      good fit for this store based on customer profiles), and network context (does this 
--      product perform better elsewhere). Recommend: 'PROMOTE', 'MAINTAIN', 'MARKDOWN', 'REMOVE'.

-- Q92. The Myntra marketing attribution model. For each conversion (order), trace back: which 
--      emails were sent before (using date logic), which campaigns were running (using campaign 
--      dates), what the customer's journey looked like (using activity history), and attribute 
--      the conversion to the most likely touchpoint using set operations to handle customers 
--      exposed to multiple vs single touchpoints differently.

-- Q93. Amazon India's complete marketplace balance. Calculate: category health (using product and 
--      order data), seller concentration (using self-join on suppliers), price competition 
--      intensity (using self-join on products), customer satisfaction by segment (using reviews), 
--      and identify: 'HEALTHY_CATEGORIES', 'MONOPOLY_RISK', 'PRICE_WAR', 'QUALITY_ISSUES'.

-- Q94. The BigBasket workforce analytics. For each employee: individual metrics (attendance, 
--      productivity), team context (how do they compare to team using self-join), store context 
--      (are they at a high or low performing store), role context (are they compensated fairly 
--      for their role using self-join on role), and trajectory (are they improving). Create 
--      development recommendations.

-- Q95. RetailMart's complete inventory lifecycle. For each product, trace: when it was added 
--      (product creation), when it was first stocked (inventory records), when it first sold 
--      (order items), return patterns (returns), review patterns (reviews), and current status 
--      (active, aging, dead). Use UNION to create a timeline and analyze lifecycle patterns.

-- Q96. The Flipkart recommendation engine rebuild. Using all available signals: co-purchase 
--      patterns (products bought together), co-view patterns (if available), category affinity 
--      (customers who buy from category A also buy from B), brand loyalty (customers stick to 
--      brands), price sensitivity (do they trade up or down), create a product-product 
--      recommendation matrix with explanation of why each recommendation was made.

-- Q97. Zomato's complete location intelligence. For each location (city/zone): customer density 
--      (customer count), demand profile (what they order), supply status (what stores exist), 
--      competitive situation (store performance comparison using self-join), and opportunity 
--      score (demand not being met). Identify: 'SATURATED', 'COMPETITIVE', 'UNDERSERVED', 
--      'EMERGING', 'DECLINING'.

-- Q98. Myntra's style profile builder. For each customer: purchase history by category (what they 
--      buy), price preference (what they spend), brand affinity (what brands they prefer), 
--      seasonal patterns (when they buy), and similarity to other customers (using self-join 
--      on purchase patterns). Create style segments: 'TRENDSETTER', 'CLASSIC', 'BUDGET', 
--      'LUXURY', 'OCCASIONAL'.

-- Q99. The Amazon India capacity planner. Using cross-joins and historical data: project demand 
--      by product-store-month, compare to inventory capacity, compare to fulfillment capacity, 
--      identify: 'CAPACITY_CRUNCH' (demand > capacity), 'UNDERUTILIZED' (capacity >> demand), 
--      'BALANCED' (demand ≈ capacity), 'SEASONAL_PEAK' (temporary crunch), 'STRUCTURAL_ISSUE' 
--      (persistent imbalance). Create expansion and rationalization recommendations.

-- Q100. The ultimate RetailMart business health scorecard. Create a single comprehensive query 
--       that answers: Is the business growing? (sales trend using self-join on time), Is it 
--       profitable? (revenue vs expenses), Is it efficient? (sales per employee, inventory 
--       turnover), Are customers happy? (reviews, returns, loyalty), Are employees engaged? 
--       (attendance, tenure, salary progression), Are suppliers reliable? (stockouts, quality), 
--       Are stores performing? (vs benchmarks using self-join). Output a single row per store 
--       with all metrics and an overall grade: 'A' (excellent on all dimensions), 'B' (good 
--       with some areas to improve), 'C' (significant issues), 'D' (urgent action required), 
--       'F' (closure candidate). This is the ultimate test of Day 10 concepts.

-- ============================================
-- END OF DAY 10 CRAZY HARD QUESTIONS
-- ============================================
