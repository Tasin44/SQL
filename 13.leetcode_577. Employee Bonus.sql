# Write your MySQL query statement below
select e.name , b.bonus
from Employee e
left join Bonus b
on e.empId=b.empId
where b.bonus<1000 or b.bonus is null;
/*

To solve the problem, follow these steps:

Join the Tables:
Use a LEFT JOIN to combine the Employee table with the Bonus table on the empId field.
This ensures that all employees are included, even those without a bonus.

Apply the Filter:
After joining, filter the results to include only employees with a bonus 
less than 1000 or employees who do not have a bonus (i.e., the bonus is NULL).

Select the Required Columns:
Retrieve the name from the Employee table and the bonus from the Bonus table.

The LEFT JOIN ensures that every row from the Employee table is included, 
along with the corresponding bonus if it exists. If an employee has no bonus, b.bonus will be NULL.

*/

#approach 2
SELECT e.name, b.bonus FROM Employee e
LEFT JOIN Bonus b
ON e.empId = b.empId
WHERE COALESCE(bonus,0) < 1000;
/*
COALESCE Function:

The COALESCE function is used to handle NULL values in SQL. It returns the first non-NULL value in the list of arguments provided to it.

In this case, COALESCE(bonus, 0) checks the value of the bonus column.
If bonus is not NULL, COALESCE returns the actual bonus value.
If bonus is NULL (meaning the employee does not have a corresponding bonus in the Bonus table), COALESCE returns 0 instead of NULL.

*/



