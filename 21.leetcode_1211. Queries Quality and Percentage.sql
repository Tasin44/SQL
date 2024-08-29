# Write your MySQL query statement below
select query_name , 
round(sum(rating/position)/count(query_name) ,2) as quality,  
round(sum(CASE WHEN rating < 3 THEN 1 ELSE 0 END)*100/count(query_name) ,2) as poor_query_percentage 
from Queries
WHERE query_name IS NOT NULL
group by query_name;

/*
To exclude rows with NULL query_name from the calculation, 
adding WHERE clause to filter out those rows before the GROUP BY operation.
If we didn't use where:


Queries =
| query_name | result           | position | rating |
| ---------- | ---------------- | -------- | ------ |
| null       | Golden Retriever | 1        | 5      |
| null       | German Shepherd  | 2        | 5      |
| null       | Mule             | 200      | 1      |
| Cat        | Shirazi          | 5        | 2      |
| Cat        | Siamese          | 3        | 3      |
| Cat        | Sphynx           | 7        | 4      |


Output
| query_name | quality | poor_query_percentage |
| ---------- | ------- | --------------------- |
| Cat        | 0.66    | 33.33                 |

Expected
| query_name | quality | poor_query_percentage |
| ---------- | ------- | --------------------- |
| Cat        | 0.66    | 33.33                 |


*/


#approach: 2

# Write your MySQL query statement below
select query_name , 
round(avg(rating/position) ,2) as quality,  
round(sum(if (rating<3,1,0))*100/count(*) ,2) as poor_query_percentage 
from Queries
WHERE query_name IS NOT NULL
group by query_name;

/*
The IF function in MySQL works similarly to the CASE statement but is more compact for simple conditions. 

The syntax for IF is:
IF(condition, value_if_true, value_if_false)

round(avg(rating/position) ,2):

round is scalar function, avg is aggregate function,
so we can nest them. 
we can't nest multiple aggregate function. 

COUNT(*):
COUNT(*) counts all rows in a specified table or group, without considering the specific column values.
It includes rows with NULL values in any column.
When used with GROUP BY, it returns the number of rows in each group.


Using COUNT(*) to Count Rows in Each Group:

SELECT 
    query_name,
    COUNT(*)
FROM 
    Queries
GROUP BY 
    query_name;

Result:
query_name	  count
Dog	            3
Cat     	    3

Explanation:

COUNT(*) counts the number of rows for each query_name.
For query_name = 'Dog', there are 3 rows.
For query_name = 'Cat', there are 3 rows.
The GROUP BY clause groups the rows by query_name, so COUNT(*) is applied to each group separately.

*/

