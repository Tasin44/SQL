# Write your MySQL query statement below
select  p.product_id ,
coalesce(round(sum(p.price*u.units)/sum(u.units),2),0) as average_price 
from Prices p
left join UnitsSold u
on p.product_id = u.product_id 
and u.purchase_date between p.start_date and p.end_date
group by p. product_id;
/*
Intuition
We cannot use the pre-defined AVG() function as here there are 2 tables and the formula for calaculating average selling price is different.

Why coalesce:
If i don't use coalesce, then it'll return like    3  null  which is incorect
If i use coalesce, then it'll return like          3   0    which is correct


For the corner case(which is given below):

If i include where instead of and like:

on p.product_id = u.product_id 
where u.purchase_date between p.start_date and p.end_date


For product ID 3, since there are no matching entries in UnitsSold, u.purchase_date is NULL, and the WHERE clause filters out this product, resulting in product ID 3 being excluded from the result set.

**The difference between using AND in the LEFT JOIN versus using a where clause. 
Basically, when we use the where clause,
we're filtering out the NULL matches from the left join, as if we used an INNER JOIN. 
The working query keeps those NULL rows and the IFNULL/coalesce makes those 0 to properly calculate the averages.

When we use AND in the LEFT JOIN, 
we're trying to match on both conditions: 
the product IDs are the same, AND the purchase date is between the start and end dates. 
If the product IDs match but the purchase date is outside the given range, 
we get a NULL match in the right side of the join, which we cast to 0 to correctly compute the averages. 
This ensures all of the product IDs are accounted for in the average calculation.


Explanation of other :
SUM(u.units * p.price) / SUM(u.units):

SUM(u.units * p.price): 
This calculates the total revenue for each product 
by multiplying the number of units sold (u.units) by the price (p.price) 
for the relevant date range.

SUM(u.units): This calculates the total number of units sold for each product.


Corner case:
Input

Prices =
| product_id | start_date | end_date   | price |
| ---------- | ---------- | ---------- | ----- |
| 1          | 2019-02-17 | 2019-02-28 | 5     |
| 1          | 2019-03-01 | 2019-03-22 | 20    |
| 2          | 2019-02-01 | 2019-02-20 | 15    |
| 2          | 2019-02-21 | 2019-03-31 | 30    |
| 3          | 2019-02-21 | 2019-03-31 | 30    |

UnitsSold =
| product_id | purchase_date | units |
| ---------- | ------------- | ----- |
| 1          | 2019-02-25    | 100   |
| 1          | 2019-03-01    | 15    |
| 2          | 2019-02-10    | 200   |
| 2          | 2019-03-22    | 30    |

Output
| product_id | average_price |
| ---------- | ------------- |
| 1          | 6.96          |
| 2          | 16.96         |
| 3          | null          |

Expected
| product_id | average_price |
| ---------- | ------------- |
| 1          | 6.96          |
| 2          | 16.96         |
| 3          | 0             |


*/

#approach 2(using ifnull)
select  p.product_id ,
ifnull(round(sum(p.price*u.units)/sum(u.units),2),0) as average_price 
from Prices p
left join UnitsSold u
on p.product_id = u.product_id 
and u.purchase_date between p.start_date and p.end_date
group by p. product_id;













