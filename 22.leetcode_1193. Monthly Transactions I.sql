select date_format(trans_date,'%Y-%m') 
as month , 
country , 
count(id) as trans_count ,
sum(if(state = 'approved',1,0)) 
as approved_count ,
sum(amount) as trans_total_amount ,
sum(if(state='approved',amount,0))
as approved_total_amount
from Transactions
group by month,country;
-- we must be group by both month & country


/*
if i use :

if(state='approved',sum(amount),0)
then a error occurs in the " approved_total_amount" row, like 

| id  | country | state    | amount | trans_date |
| --- | ------- | -------- | ------ | ---------- |
| 121 | US      | approved | 1000   | 2018-12-18 |
| 122 | US      | declined | 2000   | 2018-12-19 |
| 123 | US      | approved | 2000   | 2019-01-01 |
| 124 | US      | approved | 2000   | 2019-01-07 |

output:
| month   | country | trans_count | approved_count | trans_total_amount | approved_total_amount |
| ------- | ------- | ----------- | -------------- | ------------------ | --------------------- |
| 2018-12 | US      | 2           | 1              | 3000               | 3000                  |
| 2019-01 | US      | 2           | 2              | 4000               | 4000                  |


expected:
| month   | country | trans_count | approved_count | trans_total_amount | approved_total_amount |
| ------- | ------- | ----------- | -------------- | ------------------ | --------------------- |
| 2018-12 | US      | 2           | 1              | 3000               | 1000                  |
| 2019-01 | US      | 2           | 2              | 4000               | 4000                  |



1.it happens because:
Shortly: it sumup all the rows including declined state because of group by.
(group by er karone sob gula row combined hoye jabe according to same month & country, so sum(amount) jodi 
if er moddhe deya hoy,then eta approved & declined both er sum kore felbe)

IF Condition and Aggregates:
the IF function is evaluated once per row, not per group. However, when you use SUM(amount) inside an 
IF statement as in IF(state='approved', SUM(amount), 0), it creates a logical error:

(i) SUM(amount) is an aggregate function that works on the entire group of rows produced by the GROUP BY clause.

(ii) The IF function is evaluated per row, but SUM(amount) expects to be evaluated per group.

IF(state='approved', SUM(amount), 0) incorrectly combines a row-level operation (IF) with a group-level operation (SUM). 
As a result, it does not properly calculate the total approved amount for transactions where the state is 'approved'.
Instead, it sums up all amounts within the group when at least one row meets the IF condition (state = 'approved').



2.SUM(IF(state = 'approved', amount, 0))

Correct Aggregation: In the second query, you are correctly using the IF statement inside the SUM aggregate function:

This correctly sums up the amount only for rows where state = 'approved'.
The IF function checks each row to see if state = 'approved', and if true, 
it includes the amount in the SUM; otherwise, it adds 0.

Consistent Row-Level Operation: 
The IF function is consistently applied to each row and then aggregated by SUM. This means:

For each row where state = 'approved', amount is included.
For all other rows, 0 is added, effectively ignoring declined transactions in the sum.

*/


#approach 2:
select left(trans_date,7) as month , 
country , 
count(*) as trans_count ,
sum(state = 'approved') as approved_count ,
sum(amount) as trans_total_amount ,
sum((state='approved')*amount) as approved_total_amount
from Transactions
group by month,country;
-- we must be group by both month & country

/*
Approach

Extract Month and Year:
Use the LEFT function to get the YYYY-MM part from the trans_date. The LEFT() function extracts a number of characters from a string (starting from left).

Group By Month and Country:
    Group the transactions by the extracted month and country.

Count Transactions:
    Use COUNT(id) to count all transactions per group.

Count Approved Transactions:
    Use SUM(state = 'approved') to count approved transactions, leveraging the fact that boolean expressions return 1 for true and 0 for false.

Sum Total Amounts:
    Use SUM(amount) to sum the transaction amounts for all transactions per group.

Sum Approved Amounts:
    Use SUM((state = 'approved') * amount) to sum the transaction amounts for approved transactions, ensuring only approved amounts are summed.

*/



