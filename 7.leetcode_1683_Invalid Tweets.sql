
-- 1st approach
  
select tweet_id from Tweets
where length(content)>15;


-- 2nd approach
select tweet_id from Tweets
where char_length(content)>15;


/*
LENGTH() returns the length of the string measured in bytes.
CHAR_LENGTH() returns the length of the string measured in characters.
*/
