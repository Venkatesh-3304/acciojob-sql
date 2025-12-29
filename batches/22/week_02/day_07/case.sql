🎬 THE STORY: The Zomato Rating Badge System!

-- Imagine you're a developer at Zomato. The Product Manager rushes to your desk:

"Bhai, we need to show BADGE ICONS instead of boring numbers! 
When rating is 5, show '⭐ Legendary'
When rating is 4, show '🌟 Excellent'  
When rating is 3, show '👍 Good'
When rating is 2, show '😐 Average'
When rating is 1, show '👎 Poor'"

You think: "I have 50 lakh reviews in the database. 
Should I manually update each one? That'll take 100 years! 😱"

Then you remember: SIMPLE CASE! 

Instead of changing actual data, you write ONE query that 
automatically converts every rating number into a badge!

SELECT restaurant_name, rating,
       CASE rating
           WHEN 5 THEN '⭐ Legendary'
           WHEN 4 THEN '🌟 Excellent'
           WHEN 3 THEN '👍 Good'
           WHEN 2 THEN '😐 Average'
           WHEN 1 THEN '👎 Poor'
       END AS rating_badge
FROM restaurants;

50 lakh rows transformed in 2 seconds! 🚀

The PM is impressed. You get promoted. Life is good! 😎

This is the power of Simple CASE - match ONE column against 
specific values and transform them instantly!



-- Simple CASE Syntax
CASE expression
    WHEN value1 THEN result1
    WHEN value2 THEN result2
    WHEN value3 THEN result3
    ...
    ELSE default_result  -- Optional: handles unmatched cases
END

-- Example with column alias
SELECT column_name,
       CASE column_name
           WHEN 'value1' THEN 'Label 1'
           WHEN 'value2' THEN 'Label 2'
           ELSE 'Other'
       END AS new_column_name
FROM table_name;




-- Convert gender codes to full labels: 'M' → 'Male', 'F' → 'Female'.


Select
	full_name,
	gender,
	case gender
		when 'M' then 'Male'
		when 'F' then 'Female'
		Else 'Not Specified'
	end as gender_full
from
	customers.customers



Convert numeric ratings (1-5) to descriptive text and filter recent reviews.

-- Convert ratings to descriptive stars with filtering
SELECT 
    review_id,
    cust_id,
    rating,
    CASE rating
        WHEN 5 THEN '★★★★★ Outstanding'
        WHEN 4 THEN '★★★★☆ Very Good'
        WHEN 3 THEN '★★★☆☆ Average'
        WHEN 2 THEN '★★☆☆☆ Below Average'
        WHEN 1 THEN '★☆☆☆☆ Poor'
    END AS rating_description,
    review_date
FROM customers.reviews
WHERE review_date >= '2024-01-01'
ORDER BY rating DESC, review_date DESC
LIMIT 150;


Select *  FROM customers.reviews

Scenario:
RetailMart wants a comprehensive store performance dashboard. For each store, they need to see the region converted to regional zone names, 
count of employees, total salary expense, average salary, and categorize each store by its region code into business zones.
Task:
Create a store summary with regional zone classification using GROUP BY with CASE.

-- Cross Join

Select 
	s.store_id,
	s.store_name,
	s.region,
	case s.region
		when 'North' then 'Zone A'
		when 'South' then 'Zone B'
		when 'East' then 'Zone C'
		when 'West' then 'Zone D'
		else 'Zone X'
	end as business_zone,
	count(e.emp_id) as total_emp,
	sum(e.salary) total_salary,
	avg(e.salary) avg_salary
from
	stores.stores s, stores.employees e
where
	s.store_id=e.store_id
group by
	s.store_id,
	s.store_name,
	s.region
having
	count(e.emp_id)>=10


select
	distinct region
from 
	stores.stores

Stores
	200
Employess
	3000

The finance team needs to categorize orders by value into 'Small', 'Medium', 'Large', and 'Enterprise' orders, and also flag the order status.
Task:
Create order value tiers with status indicators.

Select
	order_id,
	cust_id,
	order_date,
	total_amount,
	 CASE 
        WHEN total_amount < 5000 THEN '🟢 Small Order'
        WHEN total_amount >= 5000 AND total_amount < 20000 THEN '🟡 Medium Order'
        WHEN total_amount >= 20000 AND total_amount < 100000 THEN '🟠 Large Order'
        WHEN total_amount >= 100000 THEN '🔴 Enterprise Order'
        ELSE '⚪ Unknown'
    END AS order_tier,
    order_status,
    CASE order_status
        WHEN 'Delivered' THEN '✅ Complete'
        WHEN 'Shipped' THEN '📦 In Transit'
        WHEN 'Processing' THEN '⏳ Processing'
        WHEN 'Cancelled' THEN '❌ Cancelled'
        ELSE '❓ Unknown Status'
    END AS status_flag,
    CASE 
        WHEN order_status = 'Delivered' THEN '✅ Complete'
        WHEN order_status = 'Shipped' THEN '📦 In Transit'
        WHEN order_status = 'Processing' THEN '⏳ Processing'
        WHEN order_status = 'Cancelled' THEN '❌ Cancelled'
        ELSE '❓ Unknown Status'
    END AS status_flag
from
	sales.orders


-- Nested CASE Syntax (CASE inside CASE)

-- Pattern 1: CASE in THEN clause
CASE 
    WHEN outer_condition1 THEN 
        CASE 
            WHEN inner_condition1 THEN result1
            WHEN inner_condition2 THEN result2
            ELSE inner_default
        END
    WHEN outer_condition2 THEN result3
    ELSE outer_default
END

-- Pattern 2: CASE in WHEN clause (less common)
CASE 
    WHEN (CASE WHEN x > 10 THEN 'high' ELSE 'low' END) = 'high'
    THEN 'Above threshold'
    ELSE 'Below threshold'
END

-- Real example structure
SELECT 
    column1,
    CASE 
        WHEN category = 'A' THEN
            CASE 
                WHEN value > 1000 THEN 'A-Premium'
                ELSE 'A-Standard'
            END
        WHEN category = 'B' THEN
            CASE 
                WHEN value > 500 THEN 'B-Premium'
                ELSE 'B-Standard'
            END
        ELSE 'Other'
    END AS classification
FROM table_name;



RetailMart wants to classify employees based on department and then by salary within each department.
Task:
Create a two-level classification: First by department, then by salary range.


select
	e.emp_id,
	e.emp_name,
	e.dept_id,
	e.salary,
	case e.dept_id
		when 1 then
			case
				when e.salary >= 50000 then 'Sales - Senior'
				else 'Sales - Junior'
			end
		when 2 then
			case
				when e.salary >= 50000 then 'Operations - Senior'
				else 'Operations - Junior'
			end
		when 3 then
			case
				when e.salary >= 50000 then 'Marketing - Senior'
				else 'Marketing - Junior'
			end
		when 4 then
			case
				when e.salary >= 50000 then 'Finance - Senior'
				else 'Finance - Junior'
			end
		when 5 then
			case
				when e.salary >= 50000 then 'HR - Senior'
				else 'HR - Junior'
			end
		when 6 then
			case
				when e.salary >= 50000 then 'IT - Senior'
				else 'IT - Junior'
			end
	end as employee_class
from 
	stores.employees e , stores.departments d
where
	e.dept_id=d.dept_id


select * from stores.departments d











