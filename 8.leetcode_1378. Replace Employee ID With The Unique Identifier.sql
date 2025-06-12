
'''
LEFT JOIN
Returns all rows from the left table and matching rows from the right. If no match, returns NULL for the right table.
  
RIGHT JOIN
Returns all rows from the right table and matching rows from the left. If no match, returns NULL for the left table.
  
FULL JOIN

Returns all rows from both tables. If there’s no match on either side, fills with NULL for the missing side.
Supported in postgreSql , ms sql server 

'''
-- #approach 1:Standard SQL (LEFT JOIN)

select EmployeeUNI.unique_id,Employees.name
from Employees
left join EmployeeUNI
on Employees.id=EmployeeUNI.id;
-- on will perform both table's id,it specifies that the id from the Employees table should match the id from the EmployeeUNI table.

-- we'll select what we want to return.In SQL, the SELECT statement is used to specify the columns you want to return in your query result. In your case:

-- #approach 2:

select eu.unique_id,e.name
from Employees as e
left join EmployeeUNI as eu
on e.id=eu.id;
-- on will perform both table's id,it specifies that the id from the Employees table should match the id from the EmployeeUNI table.

-- we'll select what we want to return.In SQL, the SELECT statement is used to specify the columns you want to return in your query result. In your case:

========================================================================================================================================================================

-- #approach 3:RIGHT JOIN variant (less common)
  
select EmployeeUNI.unique_id,Employees.name
from EmployeeUNI
right join Employees
on Employees.id=EmployeeUNI.id;

-- if we want to perform right join,then we'll change the left table 
-- position into the right table 

========================================================================================================================================================================
-- #approach 4:postgresql solution 

-- Write your PostgreSQL query statement below
SELECT eu.unique_id, e.name
FROM Employees e
FULL OUTER JOIN EmployeeUNI eu
ON e.id = eu.id
where e.name is not null;

-- Another way 

-- Write your PostgreSQL query statement below
SELECT eu.unique_id, e.name
FROM Employees e
FULL OUTER JOIN EmployeeUNI eu
ON e.id = eu.id
where e.id is not null;


'''
if we dont use the line "where e.name is not null;" or "where e.id is not null;" we will get error fo the below test case 

Employees =

| id | name     |
| -- | -------- |
| 1  | Alice    |
| 7  | Bob      |
| 11 | Meir     |
| 90 | Winston  |
| 3  | Jonathan |

EmployeeUNI =

| id | unique_id |
| -- | --------- |
| 3  | 101       |
| 11 | 102       |
| 90 | 103       |
| 10 | 104       |

output :

| unique_id | name     |
| --------- | -------- |
| null      | Alice    |
| 101       | Jonathan |
| null      | Bob      |
| 104       | null     |
| 102       | Meir     |
| 103       | Winston  |

We are getting null for the unique_id 104, for this unique_id, the id 10 is not present in the Employees table, 
Thats why we have to filter out  if the name is not null or if the id is not null 
  
Why WHERE e.name IS NOT NULL is used:

    Purpose of the query: The problem asks to show all employees (from Employees table) with their unique_id if it exists.
    The FULL OUTER JOIN returns all records from both tables, but we only want employees (with or without unique_id).

    Data integrity assumptions:

        Employees.id is a primary key (cannot be NULL), but we can use here "where e.id is not null;"

        Employees.name is likely required (business logic suggests every employee has a name)

        EmployeeUNI.unique_id can be NULL for employees without a unique ID

    Filtering strategy:

        WHERE e.name IS NOT NULL ensures we only get records that exist in the Employees table

        This effectively converts the FULL OUTER JOIN to a LEFT JOIN behavior

Why not use other conditions:

    WHERE eu.unique_id IS NOT NULL:

        Would only return employees who HAVE a unique ID

        Would exclude employees without a unique ID (contrary to requirements)

        This would be equivalent to an INNER JOIN

    WHERE e.id IS NOT NULL:(we can use it here ) 

        Since id is the primary key of Employees, this is always true for employee records

'''





========================================================================================================================================================================
























