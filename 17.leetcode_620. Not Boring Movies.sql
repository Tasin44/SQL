-- #approach 1:Basic WHERE Clause
SELECT id, movie, description, rating
FROM Cinema
WHERE id % 2 = 1 AND description != 'boring'
ORDER BY rating DESC;

===========================================================================================================================
-- #approach 2: Using MOD Function
SELECT *
FROM Cinema
WHERE MOD(id, 2) = 1  -- odd-numbered IDs
  AND description != 'boring'  -- description is not 'boring'
ORDER BY rating DESC;

'''
id % 2 = 1 and MOD(id, 2) = 1 are functionally the same in SQL — they both check if id is odd.
  
  MOD(id, 2) = 1
    Function form.
'''

===========================================================================================================================

-- #approach 3:
select *
from Cinema
where id%2=1 and  description<>'boring'
order by rating desc;

===========================================================================================================================

-- #approach 4:Using NOT with =
SELECT *
FROM Cinema
WHERE id % 2 = 1
  AND NOT description = 'boring'
ORDER BY rating DESC;


===========================================================================================================================

  -- #approach 5:Using NOT with =
SELECT *
FROM Cinema
WHERE id % 2 = 1
  AND description NOT in  ('boring')
ORDER BY rating DESC;


===========================================================================================================================
  -- #approach 6:Using BITWISE AND

SELECT *
FROM Cinema
WHERE id & 1 = 1 AND description != 'boring'
ORDER BY rating DESC;

===========================================================================================================================
  
  -- #approach 7:Using NOT LIKE
  
SELECT id, movie, description, rating
FROM Cinema
WHERE id % 2 != 0 AND description NOT LIKE 'boring'
ORDER BY rating DESC;

'''
description NOT LIKE 'boring' is functionally similar to description != 'boring', but only if the value is exactly "boring" and case-sensitive.

LIKE allows use of:

        % — wildcard for any sequence of characters

        _ — wildcard for a single character

✅ So:

    LIKE 'boring' → only matches rows where description is exactly "boring".

    LIKE '%boring%' → matches anything containing "boring".

    LIKE 'Boring' → will not match "boring" (case-sensitive in most DBs).

    LIKE '_oring' → matches "boring", "doring", etc.
  
In MySQL:

description LIKE '%boring%'

✅ Will match "boring", "BoRing", "BORING" — because it's case-insensitive by default.
In PostgreSQL:

description LIKE '%boring%'

❌ Will NOT match "BoRing" or "BORING" — it's case-sensitive.
'''







