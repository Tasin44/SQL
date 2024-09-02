
# Write your MySQL query statement below

select round(sum(if(order_date = customer_pref_delivery_date,1,0))*100/count(*),2)
as immediate_percentage
from Delivery
where (customer_id , order_date)
in
(
select customer_id,min(order_date)
from delivery
group by customer_id
);

/*
Approach to Solve the Problem

To solve this problem, follow these steps:

(i)Identify the First Order for Each Customer:
Find the earliest order_date for each customer_id.

(ii)Determine If the First Order is Immediate:
Check if order_date equals customer_pref_delivery_date for the identified first order.
    
(iii)Calculate the Percentage: Calculate the percentage of customers whose first order is immediate.

*/
/*
why coustomer_id is necessary:
without the customer_id you would have a table of smallest order dates of every customer (like a list [10, 12, 13, 14, ...] 
but you do not know what order date belongs to what customer.
This is a problem because:
It can happen that a customers first order happens on 12. 
July and is not immediate. A second customers first order happens on 14. July.
Now suppose person 1 also ordered on 14. July and it was immediate. 
Because 14. July is in our returned list, our main query keeps the row of customer 1 14.July immediate and the AVG() counts it. 
But this is wrong, since we only want to count first dates of the customers and 14.July was not first order of first customer.
*/



#approach 2
# Write your MySQL query statement below

select round(avg(order_date = customer_pref_delivery_date)*100,2)
#we can minimize the work by using avg function instead of sum,count(*)
as immediate_percentage
from Delivery
where (customer_id , order_date)
in
(
select customer_id,min(order_date)
from delivery
group by customer_id
);

/*
in previous code:
sum(if(order_date = customer_pref_delivery_date,1,0))*100/count(*)
actually we're finding avg of first immidiate order ,then %

to modify it,we can just use avg function,
order_date = customer_pref_delivery_date is a boolean expression that evaluates to TRUE or FALSE.

*/




