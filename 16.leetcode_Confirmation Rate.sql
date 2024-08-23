#approach 1
select s.user_id ,
round(avg(if (c.action='confirmed',1,0)),2) as confirmation_rate 
from Signups as s
left join Confirmations as c
on s.user_id=c.user_id
group by s.user_id;
/*

IF(c.action = 'confirmed', 1, 0):

This part uses the IF function to create a conditional expression:
It checks the value of c.action for each row.
If c.action is 'confirmed', it returns 1.
Otherwise, it returns 0.
This effectively creates a binary indicator for whether a confirmation was 'confirmed' (1) or not (0).

AVG(IF(c.action = 'confirmed', 1, 0)):

This calculates the average of the binary indicator for each user_id.
Since IF(c.action = 'confirmed', 1, 0) outputs 1 for confirmed actions and 0 otherwise, 
taking the average gives the proportion of confirmations that were 'confirmed' out of all confirmations (both 'confirmed' and 'timeout').
For users with no confirmation actions, the average would be calculated over zero rows, resulting in NULL, but due to the use of LEFT JOIN, the presence of rows in Signups ensures each user has a calculation, defaulting to 0.


*/




# approach 2
select s.user_id ,
 coalesce(round(avg(action='confirmed'),2),0) as confirmation_rate
from Signups as s
left join Confirmations as c
on s.user_id=c.user_id
group by s.user_id;

/*
avg(action='confirmed')
This expression is a conditional aggregation. 
In SQL, the expression action = 'confirmed' evaluates to 1 if action is 'confirmed' and 0 otherwise.
The AVG function calculates the average of these 1s and 0s. This effectively computes the proportion of confirmations that are 'confirmed' for each user.

ROUND(..., 2):
The ROUND function rounds the result of the AVG function to two decimal places. 


COALESCE(..., 0):
COALESCE is a function that returns the first non-NULL value in the list of arguments.

In this case, if a user has no records in the Confirmations table (which would make AVG(action = 'confirmed') result in NULL), the COALESCE function returns 0.
Here this function is necessary for userid 6, because it didn't do any action
in Confirmations table.


This whole expression is then given an alias AS confirmation_rate, which names the resulting column confirmation_rate.

*/




