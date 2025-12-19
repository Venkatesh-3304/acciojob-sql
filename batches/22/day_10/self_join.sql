Technical Definition

A Self Join is a regular join operation where a table is joined with itself. It uses table aliases to treat the single table as if it were two separate tables, allowing comparison of rows within the same table based on related column values.

Layman's Terms

Imagine you have a class photo of all 50 students. Now you want to find pairs of students who live in the same city. You'd compare the photo with a COPY of itself - checking each student against every other student! That's exactly what Self Join does - it compares rows in a table with OTHER rows in the SAME table. Think of it as looking at a mirror image of your data to find relationships within!

Join
    Inner
    Left
    Right
    Full

Self
    Inner
    Left
    Right
    Full

Syntax

-- Self Join Basic Syntax
SELECT 
    a.column1,
    b.column2
FROM table_name a              -- First alias (treating table as 'a')
INNER JOIN table_name b        -- Second alias (treating same table as 'b')
ON a.related_column = b.id;    -- Join condition
 
-- Common Pattern: Employee-Manager Relationship
SELECT 
    e.emp_name AS employee,
    m.emp_name AS manager
FROM employees e
LEFT JOIN employees m
ON e.manager_id = m.emp_id;


🔑 Key Point: Table aliases (a, b or e, m) are MANDATORY in Self Joins because you're using the same table twice. Without aliases, SQL wouldn't know which instance of the table you're referring to!



Flipkart wants to show "Customers who bought this also liked..." suggestions. Find pairs of products that belong to the same category.



Select 
	p1.prod_name as product_1,
	p2.prod_name as product_2,
	p1.category
from
	products.products p1
	join products.products p2
		on p1.category=p2.category
			and p1.prod_id < p2.prod_id


Get the list of employees and no of colleague from whom he is earning more in same store.


select
	e1.emp_name as high_earner,
	e1.salary,
	e1.store_id,
	count(e2.emp_id) as colleageues_earning_less
from
	stores.employees e1
	join stores.employees e2
		on e1.store_id=e2.store_id
			and e1.salary>e2.salary
group by
	e1.emp_name,e1.salary,e1.store_id
order by 
	e1.store_id,e1.salary desc
	


