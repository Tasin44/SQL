
SELECT MAX(num) AS num 
FROM (
    SELECT num 
    FROM MyNumbers 
    GROUP BY num 
    HAVING COUNT(*) = 1
)as single;
/*
Q1: it is mandatory to give alias to a subquery
ans:
MySQL expects every derived table (i.e., the result of a subquery) to have an alias.

Q2: how is this solution returning null value when there is no such number?
ans:
Actually, NULL is a special value which means empty. 
Here, NULL means that there are no values in this query.

In mysql the select statement return null by default so when you give
that query inside an another select statement it display null when the subquery
has no output


Q3:why not the below query working?
select max(num) as num 
from MyNumbers 
group by num 
having count(num)=1

output for example1:  1, 4, 5, and 6
ans1:
This query has max(num) + group by num. 
This means for each num(group by), it gets the maximum value for num, which is nothing but that num itself.

So basically its just perform de-deduplication, 
but not finding the maximum num after deduplication. 
So we need one sub-query.

ans2: having clauses are parsed after select

ans3: here we are getting the Maximum number for each group. 
Once the Table is partitioned by 'num' with GROUP BY, the MAX is applied to each group

*/
