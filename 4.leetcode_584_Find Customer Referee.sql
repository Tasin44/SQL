-- 1.another approach 
select name 
from Customer
where referee_id !=2 or referee_id is null ;
-- we cannot use like referee_id=null


-- 2.another approach 

select name from Customer 
-- we wrote here id because it is a primary key,and unique Identification
where id not in(  
    select id 
    from customer 
    where referee_id=2 

);

-- 3.Another approach

select name
from customer
where coalesce(referee_id,0)<>2;

-- COALESCE(referee_id, 0) is used to handle NULL values in the referee_id column.It's a inbuilt function.
-- <> is the SQL operator for "not equal to."
-- The condition COALESCE(referee_id, 0) <> 2
-- means "if the referee_id is not equal to 2," 
-- where 0 is used to represent customers with no referrer (NULL).







