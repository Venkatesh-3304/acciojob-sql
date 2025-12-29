Calculate Average Product Price
📋 Scenario:
The Pricing team wants to know the average price of products in the catalog.
📝 Task:
Calculate the average product price.


select
	round(avg(price),2) as average_price
from
	products.products

Customer Review Analysis
📋 Scenario:
The Product team wants to analyze customer review patterns:

Average rating overall
How many reviews are above average (good products)?
How many reviews are below average (need attention)?




Average Order Value by Time Period Comparison
📋 Scenario:
The Strategy team wants to understand AOV (Average Order Value) patterns:

Overall AOV
AOV for high-value orders (above ₹5000)
AOV for low-value orders (below ₹500)
Compare AOV between 2023 and 2024

📝 Task:
Comprehensive AOV analysis with multiple segments.








	





