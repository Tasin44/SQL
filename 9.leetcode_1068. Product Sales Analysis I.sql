-- #approach1

SELECT p.product_name, s.year, s.price
FROM sales AS s
LEFT JOIN product AS p
  ON s.product_id = p.product_id;
-- Optional: WHERE s.sale_id IS NOT NULL;

'''
Key Understanding:

    The Sales table drives the query, because we care about each sale_id.

    You are doing a LEFT JOIN from Sales to Product, meaning:

        All rows from Sales will be kept.

        If a product_id from Sales doesnt exist in Product, youll get NULL for product_name.

  
Why "WHERE s.sale_id IS NOT NULL" is not necessary:

Because:

    sale_id is the primary key in the Sales table.

    When you do FROM Sales, every row will have a non-null sale_id.

    Youre joining from Sales, so the only possible NULLs will appear in Product columns (like product_name), not in sale_id.

    So WHERE s.sale_id IS NOT NULL does nothing — its redundant.
  
  The LEFT JOIN already ensures we only get sales records:

    Starting with FROM Sales means we only process rows that exist in Sales
    The LEFT JOIN then adds product information to these sales records
'''
  
===============================================================================================================================================================================

  -- #approach 2:most appropriate query
  
select product_name , year , price
from Sales as s
join Product as p
on p.product_id=s.product_id;

/*
the JOIN used in this query is an inner join.
Inner Join:
An inner join returns only the rows where there is a match between the columns being joined in both tables.
in this case, it returns only the rows where Sales.product_id matches Product.product_id.
If there are any product_id values in Sales that do not have a corresponding product_id in Product, those rows will not be included in the result.

*/

===============================================================================================================================================================================
#approach 3
select product_name , year , price
from Product as p
right join Sales as s
on p.product_id=s.product_id;

/*
we can apply right join interchange both table's position 

*/
