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
select distinct author_id as id
from Views
where author_id = viewer_id
order by author_id asc;



