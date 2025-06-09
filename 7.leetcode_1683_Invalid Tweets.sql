
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
-- ✅ Using CASE Statement (if you want flags)

SELECT tweet_id
FROM Tweets
WHERE CASE 
          WHEN LENGTH(content) > 15 THEN 1
          ELSE 0
      END = 1;

-- =================================================================================================================================================================================

-- ✅ Using a Common Table Expression (CTE)

WITH TweetLengths AS (
  SELECT tweet_id, LENGTH(content) AS content_length
  FROM Tweets
)
SELECT tweet_id
FROM TweetLengths
WHERE content_length > 15;

'''

🔍 Step-by-Step Explanation
  
🔸 Step 1: Define the CTE (TweetLengths)

                  WITH TweetLengths AS (
                    SELECT tweet_id, LENGTH(content) AS content_length
                    FROM Tweets
                  )

    This part creates a temporary table named TweetLengths.

    Inside it, we:

        Select tweet_id
        Calculate the length of the content using LENGTH(content) and give it an alias content_length.

So this temporary result might look like:
  
tweet_id	content_length
1	            11
2	            33
  
🔸 Step 2: Use the CTE to Filter Invalid Tweets

              SELECT tweet_id
              FROM TweetLengths
              WHERE content_length > 15;

    We now select tweet_id only from rows where the tweet content length is greater than 15.

So the final result is:
  
tweet_id
2
'''
