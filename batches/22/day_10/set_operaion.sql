📖 TOPIC 4: INTERSECT

4.1 Definition
Technical Definition

INTERSECT is a set operation that returns only the rows that appear in BOTH result sets of two SELECT statements. It finds the common elements between two queries, returning distinct rows that exist in both result sets.

Layman's Terms
Think of a Venn diagram! If you have a list of 'Students who play Cricket' and a list of 'Students who play Football', INTERSECT gives you ONLY the students who play BOTH sports. It's like finding the overlap - the common members between two groups. Perfect for finding customers who bought from BOTH Electronics AND Fashion!
4.2 The Story: The VIP Cross-Category Shoppers 👑
Amazon's marketing head Meera has a brilliant idea for Republic Day sale:
"Find customers who buy from MULTIPLE categories - they're our most valuable! Give them a special 20% coupon!"
She needs to find customers who ordered BOTH Electronics AND Home & Kitchen items.
💡 INTERSECT is perfect! It finds the OVERLAP - customers present in BOTH category purchase lists!

4.3 Syntax
-- INTERSECT Syntax
SELECT column1, column2 FROM table_a
INTERSECT
SELECT column1, column2 FROM table_b;
 
-- Returns: Only rows present in BOTH result sets
-- Automatically removes duplicates
-- Same column count and compatible types required
