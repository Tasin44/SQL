#approach 1
SELECT ROUND(COUNT(*) / (SELECT COUNT(DISTINCT player_id) FROM Activity), 2) AS fraction
FROM Activity AS a
INNER JOIN (
    SELECT player_id, MIN(event_date) AS first_login
    FROM Activity
    GROUP BY 1
) AS b
ON a.player_id = b.player_id 
AND DATEDIFF(a.event_date, b.first_login) = 1;



/*
part 1:
(SELECT player_id, MIN(event_date) AS first_login FROM Activity GROUP BY 1) AS b:

This subquery is used to find the first login date for each player.

MIN(event_date): Finds the earliest event_date (the first login date) for each player_id.

GROUP BY 1: Groups the result by player_id, which is in the first column. 
This can also be written as GROUP BY player_id, 
but GROUP BY 1 is shorthand to reference the first column in the SELECT list.

Output: This will generate a table where each player is associated with their first login date, something like:

Input
Activity =
| player_id | device_id | event_date | games_played |
| --------- | --------- | ---------- | ------------ |
| 1         | 2         | 2016-03-01 | 5            |
| 1         | 2         | 2016-03-02 | 1            |
| 3         | 1         | 2016-01-02 | 10           |
| 3         | 4         | 2016-01-03 | 15           |

Output
| player_id | first_login |
| --------- | ----------- |
| 1         | 2016-03-01  |
| 3         | 2016-01-02  |


part 2:

INNER JOIN (
.........
.........
) AS b
ON a.player_id = b.player_id 
AND DATEDIFF(a.event_date, b.first_login) = 1;

You are joining this subquery result (b) with the original Activity table (a).

a.player_id = b.player_id: 
Ensures that the player from the Activity table matches the player from the subquery result 
(so you are working with the same player).

DATEDIFF(a.event_date, b.first_login) = 1: This is the key part. You are checking if the event_date of the activity record (a.event_date) is exactly 1 day after the player's first login date (b.first_login).

DATEDIFF(a.event_date, b.first_login) = 1 returns only the rows where the event_date is 1 day after the first_login.


part 3:

COUNT(*) / (SELECT COUNT(DISTINCT player_id) FROM Activity):

COUNT(*): 
This counts the number of rows where players logged in on the day after their first login 
(i.e., players who logged in on consecutive days starting from their first login).

(SELECT COUNT(DISTINCT player_id) FROM Activity): 
This subquery gives the total number of distinct players in the Activity table.


The fraction is computed as:
fraction=
(Number of players logged in the day after their first loginTotal number of players/Total number of playersNumber of players logged in the day after their first login​)

ROUND(..., 2): Rounds the result to two decimal places for clarity.

*/

#approach 2

# Write your MySQL query statement below

select round(count(*)/(select count(distinct player_id )from activity),2) as fraction
from activity 
where(player_id,date_sub(event_date,interval 1 day))
in
(
    select player_id ,min(event_date) as first_login
    from activity
    group by player_id 

); 
/*
Logic of the WHERE clause:
where(player_id,date_sub(event_date,interval 1 day))
in
(
...........
); 

Summary of this part:
after decrease -1 from each event_date, 
if it is the first login date ,which is actually means finding consecutive day after first login date?


DATE_SUB(event_date, INTERVAL 1 DAY):
This part of the query subtracts 1 day from each player's event_date.
So, for every event_date, it checks the date one day before.


Checking if this modified date (event_date - 1) is the player's first login:
The query uses the tuple (player_id, DATE_SUB(event_date, INTERVAL 1 DAY)) 
to create a combination of player_id and the event_date - 1 day.


inside IN clause: 
    SELECT player_id, MIN(event_date) AS first_login
    FROM Activity 
    GROUP BY player_id

This subquery finds each player's first login date using MIN(event_date).


What it means practically:

For each player_id, 
the query checks if the day before their current event_date (i.e., event_date - 1 day) 
is equal to their first login date.

If this is true, it means the player logged in on the day after their first login date, 
which indicates consecutive day logins starting from the first login.


*/












