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

























