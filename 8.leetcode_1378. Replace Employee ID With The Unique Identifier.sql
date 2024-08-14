#approach 1:

select EmployeeUNI.unique_id,Employees.name
from Employees
left join EmployeeUNI
on Employees.id=EmployeeUNI.id;
-- on will perform both table's id,it specifies that the id from the Employees table should match the id from the EmployeeUNI table.

-- we'll select what we want to return.In SQL, the SELECT statement is used to specify the columns you want to return in your query result. In your case:

#approach 2:

select eu.unique_id,e.name
from Employees as e
left join EmployeeUNI as eu
on e.id=eu.id;
-- on will perform both table's id,it specifies that the id from the Employees table should match the id from the EmployeeUNI table.

-- we'll select what we want to return.In SQL, the SELECT statement is used to specify the columns you want to return in your query result. In your case:


#approach 3:
select EmployeeUNI.unique_id,Employees.name
from EmployeeUNI
right join Employees
on Employees.id=EmployeeUNI.id;

-- if we want to perform right join,then we'll change the left table 
-- position into the right table 




