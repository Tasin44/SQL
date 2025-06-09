
-- -- Solution 1: Using LENGTH() function(Standard SQL Solution)
-- This solution also accepted in oracle(Oracle supports LENGTH() for string length.)
  
select tweet_id 
from Tweets
where length(content)>15;

-- =================================================================================================================================================================================

-- Solution 2: Using CHAR_LENGTH() function (synonym for LENGTH() in most databases)
-- postgreSql
  
select tweet_id from Tweets
where char_length(content)>15;


/*
LENGTH() returns the length of the string measured in bytes.
CHAR_LENGTH() returns the length of the string measured in characters.
*/


-- Using OCTET_LENGTH() in PostgreSQL (counts bytes rather than characters)
SELECT tweet_id
FROM Tweets
WHERE OCTET_LENGTH(content) > 15;

-- =================================================================================================================================================================================
-- ✅ SQL Server Solution: Use LEN()
select tweet_id
from Tweets
where len(content)>15;
-- LEN() is the SQL Server equivalent of LENGTH().


-- Using DATALENGTH() in SQL Server

SELECT tweet_id
FROM Tweets
WHERE DATALENGTH(content) > 15;

-- =================================================================================================================================================================================

-- ✅ Using a Common Table Expression (CTE)



















