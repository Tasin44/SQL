
-- 1st approach
  
select name, area ,population from world
where area>=3000000 or population>=25000000;


-- 2nd approach 

select name, area ,population from world
where area>=3000000 

union 

select name,area,population from world
where population>=25000000;

/*
Using UNION is faster when it comes to cases like scan two different column like this.
Union might be faster in this tiny example, but doing two table scans instead of one is definitely not more optimal. 
Imagine scanning a table with 1 billion rows twice instead of just using an OR operator. The goal of leetcode for most people is to get a job doing this thing.
a good optimizer should take care of this anyway.*/
