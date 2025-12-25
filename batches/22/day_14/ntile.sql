Percentiles - NTILE() & PERCENT_RANK()

8.1 Definition
Technical Definition: NTILE(n) divides an ordered partition into n roughly equal groups (buckets) and assigns a bucket number (1 to n) to each row. PERCENT_RANK() calculates the relative rank of a row as a percentage, ranging from 0 (first) to 1 (last), using formula: (rank - 1) / (total_rows - 1).
Layman's Terms: NTILE is like dividing students into groups for a class project - 'Group 1 has the top 25%, Group 2 has the next 25%...' etc. PERCENT_RANK tells you exactly where you stand - 'You scored better than 85% of students' or 'You're in the top 15%'. Both are essential for segmentation!
8.2 The Story - Flipkart's Customer Segmentation
🎯 THE STORY: Flipkart's VIP Customer Program
Flipkart wants to launch a tiered loyalty program. They need to segment their 10 million customers into 4 groups based on total spending:
•	Platinum (Top 25%): First access to sales, free express delivery
•	Gold (25-50%): Priority customer support, occasional perks
•	Silver (50-75%): Standard benefits, growth potential
•	Bronze (Bottom 25%): Basic membership, re-engagement campaigns
NTILE(4) instantly divides all customers into these 4 equal groups! No complex calculations, no hardcoded thresholds - pure elegance.
Meanwhile, PERCENT_RANK helps answer: 'This customer is in the top 3% of spenders' - perfect for personalized messaging!
💼 Real-World Connection: RFM (Recency, Frequency, Monetary) analysis uses NTILE extensively. Airlines use PERCENT_RANK for frequent flyer tiers. These functions are interview GOLD!
8.3 Syntax
-- NTILE(n): Divide into n equal groups
NTILE(number_of_buckets) OVER (
    [PARTITION BY partition_column]
    ORDER BY order_column
)
 
-- PERCENT_RANK(): Relative rank as percentage (0 to 1)
PERCENT_RANK() OVER (
    [PARTITION BY partition_column]
    ORDER BY order_column
)
 
-- Related function: CUME_DIST() - Cumulative Distribution
-- Returns fraction of rows with value <= current row's value
CUME_DIST() OVER (
    [PARTITION BY partition_column]
    ORDER BY order_column
)


Customer Segmentation into Quartiles
Scenario: Divide customers into 4 spending tiers (Platinum, Gold, Silver, Bronze) based on their total purchase history.

with customer_spending as (
	Select
		c.full_name,
		c.city,
		count(o.order_id) as total_orders,
		coalesce(sum(o.total_amount),0) as lifetime_spending
	from
		customers.customers c
	left join sales.orders o
		on o.cust_id=c.cust_id and o.order_status = 'Delivered'
	group by
		c.cust_id,c.full_name,c.city
),
ntile_value as (
	Select
	*,
	ntile(4) over() as spending_quartile,
	CASE NTILE(4) OVER (ORDER BY lifetime_spending DESC)
        WHEN 1 THEN '💎 Platinum'
        WHEN 2 THEN '🥇 Gold'
        WHEN 3 THEN '🥈 Silver'
        WHEN 4 THEN '🥉 Bronze'
    END AS tier_name
from
	customer_spending
)
select
	*
from
	ntile_value

