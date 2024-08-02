
https://leetcode.com/problems/combine-two-tables/description/

Approach1:

-- The left join ensures that we include all records from the Person table,
-- and where there is no matching record in the Address table,
-- the result will show NULL for the city and state fields.

select p.firstname,p.lastname,a.city,a.state
from person p
left join address a
on p.personid=a.personid;



#Approach 2:
#we can apply right join by interchanging the table
select p.firstname,p.lastname,a.city,a.state
from address a
right join person p
on a.personid=p.personid;



approach 3:
#we can apply left join (table1 LEFT JOIN table2 USING column_name)
select p.firstname,p.lastname,a.city,a.state
from person p
left join address a
using (personid);
