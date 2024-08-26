
select p.project_id ,round(avg(e.experience_years),2) as average_years
from Project p
join Employee e
on p.employee_id=e.employee_id
group by p.project_id;
/*
on p.employee_id=e.employee_id

on project table, employee_id is a foreign key,
so if we want to connect both table,we 
need to use first table foreign key

if we try to join
ON p.project_id = e.employee_id

The project_id in the Project table is the identifier for a project, not an employee.
The employee_id in the Employee table is the identifier for an employee, not a project.
Joining these two columns does not make logical sense because you are trying to match a project identifier with an employee identifier, 
which will not correctly associate the project with its employees. 
This would lead to an incorrect dataset being formed where unrelated projects and employees are incorrectly linked.

*/






