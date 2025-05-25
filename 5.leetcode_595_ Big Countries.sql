
--  1. Basic WHERE with OR condition
  
select name, area ,population from world
where area>=3000000 or population>=25000000;

----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 2nd approach 

select name, area ,population from world
where area>=3000000 

union 

select name,area,population from world
where population>=25000000;

/*
UNION removes duplicates, which is safe here since name is unique.
Benefit of using union:
Using UNION is faster when it comes to cases like scan two different column like this.
Union might be faster in this tiny example, but doing two table scans instead of one is definitely not more optimal. 
Imagine scanning a table with 1 billion rows twice instead of just using an OR operator. The goal of leetcode for most people is to get a job doing this thing.
a good optimizer should take care of this anyway.


if the condition is like
A country is big if:

    it has an area of at least three million (i.e., 3000000 km2), and
    it has a population of at least twenty-five million (i.e., 25000000).
 instead of or, if there was and, then using union should not work, because:

if we use union,
-This returns all countries that meet either condition (like OR), not both.
-UNION combines results, so it includes rows from either query.
-For "AND", we need rows that satisfy both conditions simultaneously.

*/
----------------------------------------------------------------------------------------------------------------------------------------------------------------

-- 3. Using CASE inside WHERE (Not commonly used this way, but syntactically valid.)

-- CASE approach 1
SELECT name, population, area
FROM World
WHERE CASE 
    WHEN area >= 3000000 THEN 1
    WHEN population >= 25000000 THEN 1
    ELSE 0
END = 1;

-- -- CASE approach 2
SELECT name, population, area
FROM World
WHERE CASE 
    WHEN area >= 3000000 THEN 'yes'
    WHEN population >= 25000000 THEN 'yes'
    ELSE 'no'
END = 'yes';


-- CASE approach 3
SELECT name, population, area
FROM World
WHERE CASE 
    WHEN area >= 3000000 or population >= 25000000 THEN 'yes'
    ELSE 'no'
END = 'yes';

-- How This Evaluates
-- For each row, the database evaluates the CASE statement from top to bottom
-- If area >= 3000000 is true → returns 1
-- If not, checks population >= 25000000 → if true, returns 1
-- If neither is true → returns 0
-- Finally, compares the returned value(0 or 1) with 1 (from END = 1)

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------














