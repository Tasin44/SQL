
-- Solution 1: Simple SELECT with WHERE clause
SELECT product_id
FROM Products
WHERE low_fats = 'Y' AND recyclable = 'Y';


-- Solution 2: Using IN clause for ENUM values
SELECT product_id
FROM Products
WHERE low_fats IN ('Y') AND recyclable IN ('Y');


-- Solution 3: INTERSECT with INNER JOIN,subquery

select p1.product_id
from 
    (select product_id from products where low_fats in ('Y')) as p1
inner join
    (select product_id from products where recyclable in ('Y')) as p2
on p1.product_id = p2.product_id;
/*
#if I do this , I'll get error:

select product_id
from 
    (select product_id from products where low_fats in ('Y')) as p1
inner join
    (select product_id from products where recyclable in ('Y')) as p2
on p1.product_id = p2.product_id;


Getting the error:
Column 'product_id' in field list is ambiguous
Explanation:

    Both subqueries return a column called product_id.

    After the JOIN, MySQL sees two product_id columns and needs clarification.

    By using p1.product_id, you're telling MySQL exactly which one to output.
*/

-- Solution 4: Using CASE in WHERE clause

SELECT product_id
FROM Products
WHERE 
  CASE WHEN low_fats = 'Y' THEN 1 ELSE 0 END = 1
  AND
  CASE WHEN recyclable = 'Y' THEN 1 ELSE 0 END = 1;

/*
Why = 1 is Needed

The CASE expression by itself just returns a value (1 or 0 in this case). To use it in a WHERE clause as a filter condition, you need to compare it to something to get a boolean result (true/false).

By adding = 1 at the end:

This becomes:

If the CASE returns 1 (meaning low_fats = 'Y' was true), then 1 = 1 is true
If the CASE returns 0 (meaning low_fats = 'Y' was false), then 0 = 1 is false


*/
