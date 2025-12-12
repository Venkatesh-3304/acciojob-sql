### 📘 TOPIC 2.2: NULLIF - Prevent Division Errors

#### Definition

**Technical Definition:**
NULLIF takes two arguments and returns NULL if they are equal; otherwise, it returns the first argument. It's particularly useful for preventing division-by-zero errors by converting zero to NULL before division.

**Layman's Terms:**
-- Imagine you're calculating average runs per match for cricketers! 🏏

-- - Virat Kohli: 500 runs in 10 matches = 500/10 = 50 avg ✅
-- - Rohit Sharma: 400 runs in 8 matches = 400/8 = 50 avg ✅
-- - New Player: 0 runs in 0 matches = 0/0 = 💥 ERROR! Math breaks!

-- NULLIF saves the day:
-- NULLIF(0, 0) = NULL (converts zero to NULL)
-- 0 / NULL = NULL (not an error!)

-- NULLIF is like a security guard that says: "If this value is dangerous (zero), turn it into NULL so nothing breaks!"

-- ---

-- #### Story/Analogy
-- ```
-- 🎬 THE STORY: The Swiggy Restaurant Rating Disaster!

-- Friday evening. You're the data analyst at Swiggy. Everything's running smoothly.

-- Then BOOM! 💥 The restaurant dashboard crashes!

-- ERROR: Division by zero

-- The CEO calls: "Fix it NOW! Restaurant partners can't see their ratings!"

-- You investigate. The rating calculation is:
--     total_rating_sum / total_reviews = average_rating

-- The problem? Three new restaurants have ZERO reviews:
--     500 / 50 = 10 ✅ (works)
--     300 / 30 = 10 ✅ (works)
--     0 / 0 = 💥 CRASH!

-- Even 100 / 0 = 💥 CRASH!

-- You need to make ZERO behave like NULL. Enter NULLIF!

-- SELECT 
--     restaurant_name,
--     total_rating_sum,
--     total_reviews,
--     total_rating_sum / NULLIF(total_reviews, 0) AS avg_rating
-- FROM restaurants;

-- What NULLIF does:
-- - NULLIF(50, 0) → 50 (not equal to 0, returns first value)
-- - NULLIF(30, 0) → 30 (not equal to 0, returns first value)  
-- - NULLIF(0, 0) → NULL (equals 0, returns NULL!)

-- Now: 100 / NULL = NULL (no crash, shows as blank)

-- Dashboard fixed. Crisis averted. You're the hero! 🦸

-- NULLIF = Division-by-zero insurance policy! 🛡️



select
	12/nullif(0,10)

select
	nullif(10,10),
	nullif(0,0),
	nullif('B','A')

If both values are same
	null
if not equal
	first value


select 
	*,
	(quantity*unit_price)/nullif(discount,0),
	case
		when (quantity*unit_price)/nullif(discount,0) is NULL THEN 'No Discount'
		else cast((quantity*unit_price)/nullif(discount,0) as varchar)
	end as discount_
from
	sales.order_items
where
	discount =0

Create an employee compensation report showing base salary, derived tax deductions, PF contribution, and take-home salary.
Task:
Build comprehensive salary breakdown using derived calculations.

-- Employee Compensation Breakdown
SELECT 
    emp_id,
    emp_name,
    role,
    salary AS gross_salary,
	salary/12 as monthly_salary,
    
    -- Derived: Income Tax (based on salary slabs)
    CASE 
        WHEN salary <= 300000 THEN 0
        WHEN salary <= 600000 THEN ROUND(salary * 0.05, 2)
        WHEN salary <= 900000 THEN ROUND(salary * 0.10, 2)
        WHEN salary <= 1200000 THEN ROUND(salary * 0.15, 2)
        ELSE ROUND(salary * 0.20, 2)
    END AS income_tax,
    
    -- Derived: PF (12% of salary, max ₹21,600/year = ₹1,800/month)
    CASE 
        WHEN salary * 0.12 / 12 > 1800 THEN 1800
        ELSE ROUND(salary * 0.12 / 12, 2)
    END AS monthly_pf,
    
    -- Derived: Professional Tax (₹200/month for salary > ₹15,000)
    CASE WHEN salary > 15000 THEN 200 ELSE 0 END AS professional_tax,
    
    -- Derived: Total Deductions
    CASE 
        WHEN salary <= 300000 THEN 0
        WHEN salary <= 600000 THEN ROUND(salary * 0.05, 2)
        WHEN salary <= 900000 THEN ROUND(salary * 0.10, 2)
        WHEN salary <= 1200000 THEN ROUND(salary * 0.15, 2)
        ELSE ROUND(salary * 0.20, 2)
    END +
    CASE 
        WHEN salary * 0.12 / 12 > 1800 THEN 1800
        ELSE ROUND(salary * 0.12 / 12, 2)
    END +
    CASE WHEN salary > 15000 THEN 200 ELSE 0 END AS total_deductions,
    
    -- Derived: Net Take-Home
    salary - (
        CASE 
            WHEN salary <= 300000 THEN 0
            WHEN salary <= 600000 THEN ROUND(salary * 0.05, 2)
            WHEN salary <= 900000 THEN ROUND(salary * 0.10, 2)
            WHEN salary <= 1200000 THEN ROUND(salary * 0.15, 2)
            ELSE ROUND(salary * 0.20, 2)
        END +
        CASE 
            WHEN salary * 0.12 / 12 > 1800 THEN 1800
            ELSE ROUND(salary * 0.12 / 12, 2)
        END +
        CASE WHEN salary > 15000 THEN 200 ELSE 0 END
    ) AS net_take_home

FROM stores.employees
WHERE salary IS NOT NULL
ORDER BY salary DESC
LIMIT 15;


┌─────────────────────────────────────────────────────────────┐
│ SIMPLE CASE - Match one value against options               │
│ CASE column WHEN value1 THEN result1 WHEN value2...END      │
│ Example: CASE gender WHEN 'M' THEN 'Male' END               │
├─────────────────────────────────────────────────────────────┤
│ SEARCHED CASE - Check multiple conditions                    │
│ CASE WHEN condition1 THEN result1 WHEN condition2...END     │
│ Example: CASE WHEN age < 25 THEN 'Youth' END                │
├─────────────────────────────────────────────────────────────┤
│ COALESCE - Return first non-NULL value                       │
│ COALESCE(value1, value2, value3, 'default')                 │
│ Example: COALESCE(phone, email, 'No Contact')               │
├─────────────────────────────────────────────────────────────┤
│ NULLIF - Return NULL if values equal (prevents /0)           │
│ NULLIF(expression1, expression2)                            │
│ Example: amount / NULLIF(quantity, 0)                       │
├─────────────────────────────────────────────────────────────┤
│ DERIVED COLUMNS - Calculated on-the-fly                      │
│ SELECT price * quantity AS total FROM orders                │
├─────────────────────────────────────────────────────────────┤
│ COLUMN ALIASES - Rename for readability                      │
│ SELECT column AS "Nice Name" FROM table                     │
└─────────────────────────────────────────────────────────────┘

💡 REMEMBER:
- CASE is evaluated TOP to BOTTOM (first match wins!)
- Always include ELSE for safety
- COALESCE checks LEFT to RIGHT
- NULLIF prevents division by zero errors
- Use aliases for professional reports
- Derived columns don't get stored - calculated each time

	