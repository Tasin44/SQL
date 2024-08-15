
select  v.customer_id , count(*) as count_no_trans
from Visits as v
left join Transactions as t
on v.visit_id=t.visit_id
where t.transaction_id is null
group by v.customer_id ;

/*
1.first marge both table transactions id 
2.Identify visits without transactions
3.Group these visits by customer_id
4.count the occurrences.
here,we count visit_id because it's primary key
*/

#approach 2

select  v.customer_id , count(*) as count_no_trans
from Visits as v
left join Transactions as t
on v.visit_id=t.visit_id
where t.transaction_id is null/*also write here: where t.visit_id is null*/
group by v.customer_id ;

/*
-- COUNT(*) counts all rows in the group,including rows with NULL values in any column. 
-- Since we're counting the number of visits without any transactions, 
-- using COUNT(*) captures the count of all rows returned after applying 
the WHERE t.visit_id IS NULL condition.

*/

#approach 3:

select v.customer_id ,count(*) as count_no_trans
from Visits as v
where visit_id not in/*means visit id will not be in transactions table*/
(
    select visit_id
    from Transactions
)
group by v.customer_id ;




















