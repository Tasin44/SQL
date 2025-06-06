-- 1st approach 
SELECT author_id AS id FROM Views
where author_id = viewer_id
GROUP BY id
ORDER BY id;
/*
If you use GROUP BY author_id, then you typically don't need to use DISTINCT author_id. 
This is because GROUP BY will automatically group all the rows by 
the author_id and return only one row for each unique author_id.
*/

'''
GROUP BY Special Behavior:
  
SQL standard exception: The GROUP BY clause is special - it can reference:
  
Original column names (author_id)
Column aliases defined in SELECT (id)
Column positions (like GROUP BY 1)
Logical processing: Even though GROUP BY technically executes before SELECT, most SQL implementations allow this as a convenience feature.

'''

  
-- ============================================================================================================================================================================


  
-- 2nd approach 
SELECT DISTINCT author_id AS id
FROM views
WHERE author_id = viewer_id
ORDER BY id; -- This works because ORDER BY can use aliases

'''
we can use alias with ''ORDER BY '' but not with ''SELECT '',if we try to do like
  select distinct(author_id) as id
  from views
  where author_id=viewer_id
  order by id asc;

well get error. because 
  Because SQL evaluates the WHERE clause before the SELECT clause, the alias id (which is defined in SELECT) does not exist yet when the WHERE clause is being executed.

    ❗ Aliases defined in the SELECT clause cant be used in WHERE.
  
'''


-- or we can enclose distinct with bracket 

select distinct(author_id) as id
from Views
where author_id = viewer_id
order by author_id asc;



-- ============================================================================================================================================================================


SELECT DISTINCT v1.author_id AS id
FROM Views v1
INNER JOIN Views v2
  ON v1.author_id = v2.author_id 
 AND v1.author_id = v2.viewer_id
ORDER BY id ASC;

/*
 the logic:

    From v1, get all authors.

    Join with v2 where:

        v1.author_id = v2.author_id → same author.

        v1.author_id = v2.viewer_id → author viewed an article.

So essentially:

    Find authors who viewed their own articles.
Step-by-Step Execution

    Self-Join Setup:

        We're joining the Views table to itself (aliased as v1 and v2)

        This allows us to compare author_ids with viewer_ids across records

    Join Conditions:

        v1.author_id = v2.author_id: Ensures we're looking at the same author in both tables

        v1.author_id = v2.viewer_id: Ensures that author viewed their own article

    Processing the Sample Data:

Let's examine each row that satisfies both join conditions:

    Row 3: (2, 7, 7, 2019-08-01)

        v2.author_id = 7 and v2.viewer_id = 7 → matches both conditions

        Will join with any v1 record where v1.author_id = 7

        Result includes author_id 7

    Rows 6-7: (3, 4, 4, 2019-07-21) (both identical rows)

        v2.author_id = 4 and v2.viewer_id = 4 → matches both conditions

        Will join with any v1 record where v1.author_id = 4

        Result includes author_id 4

    Other Rows:

        Rows 1,2,4,5 don't satisfy v2.author_id = v2.viewer_id

        So they don't produce any matches in the join

    Final Output:

        DISTINCT ensures we only get each author once

        ORDER BY sorts the results

        Final output: 4 and 7
*/

Wrong Code :❌❌
select distinct v1.author_id as id
from views as v1
inner join views as v2
on v1.author_id = v2.viewer_id
order by id;

/*
Problem: This finds all authors who have any article that was viewed by someone (not necessarily themselves). 
  The JOIN condition v1.author_id = v2.viewer_id matches when:

    Any viewer (v2.viewer_id) happens to have the same ID as an author (v1.author_id)

    It doesn't ensure the author viewed their own article specifically

Example Scenario

Consider this data:

| article_id | author_id | viewer_id |
|------------|-----------|-----------|
| 1          | 3         | 5         | 
| 2          | 3         | 3         | ← Author 3 viewed their own article
| 3          | 5         | 3         | ← Viewer 3 is also an author


*/
