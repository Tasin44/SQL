-- Solution 1: Simple WHERE clause
select name 
from Customer
where referee_id !=2 or referee_id is null ;
-- we cannot use like referee_id=null

/*
Q: Why we Can't Just Use WHERE referee_id != 2,  Why include referee_id IS NULL?
The question asks for customers "not referred by customer with id = 2". This includes:

    Customers referred by someone else (referee_id = 1, 3, etc.)
    Customers with no referrer at all (referee_id IS NULL)

Both cases represent customers who weren't referred by id 2, so both should be included.
In SQL, NULL represents missing or unknown data, and it behaves differently from other values:

    NULL is not equal to anything - Not even to itself (NULL = NULL is false)
    NULL is not unequal to anything - NULL != 2 is also false (not true as you might expect)
    Any comparison with NULL returns NULL (which SQL treats as false in WHERE clauses)
*/

-- 2.subquery

select name from Customer 
-- we wrote here id because it is a primary key,and unique Identification
where id not in(  
    select id 
    from customer 
    where referee_id=2 

);

-- Solution 3: Use NOT IN
select name
from customer
where referee_id not in(2) or referee_id is Null;
-- NOT IN can behave unexpectedly with NULLs, so always include OR referee_id IS NULL.


-- 3.Another approach

select name
from customer
where coalesce(referee_id,0)<>2;

-- COALESCE(referee_id, 0) is used to handle NULL values in the referee_id column.It's a inbuilt function.
-- <> is the SQL operator for "not equal to."
-- The condition COALESCE(referee_id, 0) <> 2
-- means "if the referee_id is not equal to 2," 
-- where 0 is used to represent customers with no referrer (NULL).







