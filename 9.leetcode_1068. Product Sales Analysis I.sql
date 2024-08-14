#approach1

select product_name , year , price
from Sales as s
left join Product as p
on p.product_id=s.product_id;

/*
Question:
solution to report the product_name, year, and price for each sale_id in the Sales table.

here, we need to perfrom on for each sale_id in the sales table.
The sales table situated is a left table, so we'll perform left join. 

*/
#approach 2:
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


#approach 3
select product_name , year , price
from Product as p
right join Sales as s
on p.product_id=s.product_id;

/*
we can apply right join interchange both table's position 

*/



