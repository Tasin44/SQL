#approach 1
select contest_id ,
round(count(user_id)*100/(select count(user_id) from users),2) as percentage
from Register
group by contest_id
order by percentage desc,contest_id asc;

/*
1.select contest_id ,
round(count(user_id)
This part is from Register Table,
COUNT(user_id) provides the number of users registered for a specific contestfrom total users.


2.(select count(user_id) from users)
This part is from Users Table ,which denotes total number of users. 

Here, we're not using any join operation,
so that we're using select as a subquery .


3.order by percentage desc,contest_id asc;

This clause orders the results by percentage in descending order, 
so contests with the highest percentage of registered users appear first.
In the case of a tie in the percentage, 
it further sorts those contests by contest_id in ascending order.

*/


#approach 2

with total_user as
(
    select count(user_id) as total
    -- or select count(*) as total
    from Users 
)
select contest_id ,
round(count(user_id)*100/(tu.total),2) as percentage
from Register
join total_user as tu
group by contest_id
order by percentage desc,contest_id asc;


























