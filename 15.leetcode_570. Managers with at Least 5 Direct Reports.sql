
#approach:1

select e1.name
from Employee as e1
join Employee as e2
on e1.id=e2.managerId
group by e2.managerId
having count(e2.managerId)>=5;

/*
SELECT e1.name
FROM Employee AS e1
JOIN Employee AS e2
ON e1.id = e2.managerId;

why we use join on e1.id=e2.managerid
because id and managerid columns matching data(id number) is the employee who is manager. 

outuput of this part:
John
John
John
John
John

if we add group by e2.managerId,then output wil be:
John
means all the name of the manager show as group wise.

To apply condition on group,we use having clause
having count(e2.managerId)>=5;

Filters groups that have 5 or more employees (direct reports).

*/

#first approach ,we can write count(e1.id) instead of count(e1.managerid)

select e1.name
from Employee as e1
join Employee as e2
on e1.id=e2.managerId
group by e2.managerId
having count(e1.Id)>=5;
-- it's counting number of employee(id) contains in each manager



#approach: 2
select name from Employee
where id in
(select managerId 
from employee
group by managerId 
having (count(id))>=5);
/*
1. Inner Query (Subquery):
select managerid ,(count(distinct id))
from employee 
group by managerid

ouput of this part is : null-1, 101-5;
means we get the grouped id, here we get 101-5 means 101 is manager of 5 employee

now,

(select managerid 
from employee 
group by managerid
having (count(distinct id))>=5)

output will look like: 101 
means id 101 is the desired manager id


2. Outer Query:
now we need the name of the id 101
so,

select name from employee where id in

Purpose: This outer query uses the result of the subquery to find and return the names of those managers.

WHERE id IN (...):
The IN clause checks whether each employee's id is in the list of managerIds returned by the subquery. If it is,
that employee is a manager with at least 5 direct reports.

SELECT name: This selects and returns the name of each manager who meets the criteria 
(i.e., having at least 5 direct reports).

*/


#approach: 3

SELECT name
FROM Employee
WHERE id IN (
    SELECT managerId
    FROM Employee
    WHERE managerId IS NOT NULL
    GROUP BY managerId
    HAVING COUNT(*) >= 5
);
/*

COUNT(*) in this context:
Since you are grouping by managerId, 
each group corresponds to a specific manager.
COUNT(*) will count all employees in each group
(all employees reporting to that manager).
It gives the total number of employees under each manager, 
which is what you want to check if it is 5 or more.

Inner Query (Subquery):
Purpose: The subquery is designed to identify managerIds that have at least 5 direct reports.

WHERE managerId IS NOT NULL: This condition ensures that only rows where managerId is not NULL are considered. 
This is important because some employees might not have a manager (managerId is NULL), and we want to exclude those cases since they don't report to anyone.

GROUP BY managerId: This clause groups the rows by managerId. Each group represents a manager and the employees who report to them.

HAVING COUNT(*) >= 5: After grouping by managerId, this condition filters the groups to include only those where the number of employees (COUNT(*)) reporting to that managerId is 5 or more. The HAVING clause applies this filter to the groups formed by GROUP BY.

Result: The subquery returns a list of managerIds for managers who have at least 5 direct reports.

*/


















