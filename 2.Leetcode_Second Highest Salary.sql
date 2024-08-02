
#https://leetcode.com/problems/second-highest-salary/description/
#176. Second Highest Salary

select max(salary) as SecondHighestSalary
from employee
where salary < (select max(salary) from employee);

#If we use max,it return's NULL when there is no suitable answer


#Another way,it's invalid way because it cann't return null when there is no suitable answer

select salary as SecondHighestSalary
from employee
order by salary desc
limit 1 offset 1;


-- ORDER BY salary DESC:
-- This clause orders the results by the salary column in descending order. This means the highest salary will appear first, followed by the second highest, and so on.

-- LIMIT 1 OFFSET 1:
-- LIMIT 1: This part of the clause restricts the result set to only 1 row.
-- OFFSET 1: This specifies that the query should skip the first row of the result set.
-- Together, LIMIT 1 OFFSET 1 retrieves the second row in the ordered list of salaries.















