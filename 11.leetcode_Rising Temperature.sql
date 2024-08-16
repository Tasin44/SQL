#approach1
select w1.id
from Weather as w1
left join Weather as w2 /*or we can write: join Weather as w2*/
on DATEDIFF(w1.recordDate, w2.recordDate) = 1
where w1.temperature > w2.temperature;
/*it means previous temp is greater than the next temp*/
-- The condition DATEDIFF(w1.recordDate, w2.recordDate) = 1 ensures that 
-- w1 and w2 are consecutive days (i.e., w1 is the day after w2).
/*
The DATEDIFF function is used in SQL to calculate the difference between two dates. 
The basic syntax for DATEDIFF is:
DATEDIFF(date1, date2)
date1 and date2 are the two dates you want to compare.
The result is the number of days between date1 and date2.
The result is positive if date1 is later than date2 and negative if date1 is earlier than date2.*/


/*
Why without DateDiff it is not correct
Say we have 2 consecutive dates in the data :
1998-09-30 and 1998-10-01 ( A and B)

if you indicate A.recordDate + 1 which means 1998-09-30 + 1 , MySQL will return : 1998-09-31, Not 1998-10-01 as expected , 
further more it returns something like this '19980931 '

always use syntax dedicated for Date type data, which is DATEDIFF() function to avoid errors like this.

*/

#approach 2
  
SELECT w2.id 
from Weather w2,Weather w1
WHERE w2.temperature > w1.temperature AND
subdate(w2.recordDate, 1) = w1.recordDate;
/*
SUBDATE(w2.recordDate, 1) subtracts one day from the w2.recordDate. 
This results in the date that is exactly one day before w2.recordDate.
This condition checks if this calculated date (w1.recordDate) exists in the table. If it does, then it confirms that the row w1 is the record for the previous day.

*/

#approach 3
SELECT A.id 
FROM Weather A, Weather B
WHERE A.temperature > B.temperature
AND DATE_ADD(B.recordDate, INTERVAL 1 DAY) = A.recordDate;

/*
DATE_ADD(B.recordDate, INTERVAL 1 DAY) Explanation:

DATE_ADD(B.recordDate, INTERVAL 1 DAY) adds one day to the recordDate of table B.
This results in a date that is one day after B.recordDate.

Matching Logic:

The query uses this to compare B.recordDate + 1 day to A.recordDate. 
This comparison is looking for the case where the recordDate in A is 
exactly one day after the recordDate in B.

Correct Understanding:
When you use DATE_ADD(B.recordDate, INTERVAL 1 DAY), 
you're adding one day to B.recordDate.
This new date (B.recordDate + 1 day) is expected to match 
A.recordDate if A is the next day after B.

So, in simpler terms:
A.recordDate is the date for the current day.
B.recordDate is the date for the previous day.*/








