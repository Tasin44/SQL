
select  s.student_id , s.student_name , sb.subject_name ,count(ex.student_id) as attended_exams
from Students as s
cross join Subjects as sb
left join Examinations as ex
on s.student_id= ex.student_id
and sb.subject_name=ex.subject_name
group by s.student_id , s.student_name , sb.subject_name
order by s.student_id , sb.subject_name;

/*
Approach
Cross Join Students and Subjects:
First, create a combination of all students and all subjects. This ensures that even if a student did not attend an exam for a particular subject, that combination will still appear in the result.

Left Join with Examinations:
Join the cross product with the Examinations table using a left join to fetch the count of exams attended by each student for each subject. This join will also handle cases where a student did not attend an exam (resulting in NULL values).
We cann't apply here right or other join because we need all data of left table including null.

Aggregation:
Use the COUNT() function to count the number of times each student attended each exam.

**If we use any aggregate functions, then there must be use group by

Grouping and Ordering:
Group the results by student_id and subject_name to ensure the correct aggregation.
Finally, sort the results by student_id and subject_name.


student_id	student_name	subject_name
1	            Alice	        Math
1	            Alice	        Physics
1	            Alice	        Programming
2	            Bob	          Math
2	            Bob	          Physics
2	            Bob	          Programming
13	          John	        Math
13	          John	        Physics
13	          John	        Programming
6	            Alex	        Math
6	            Alex	        Physics
6	            Alex	        Programming
*/



select s.student_id ,s.student_name ,sb.subject_name ,COALESCE(e.attended_exams, 0) AS attended_exams
from Students as s
cross join subjects as sb
left join(
    select student_id,subject_name,count(*) as attended_exams
    from examinations
    group by student_id,subject_name
)e on s.student_id=e.student_id and sb.subject_name=e.subject_name
order by s.student_id,sb.subject_name;

/*
Subquery:

The subquery (SELECT student_id, subject_name, COUNT(*) 
AS attended_exams FROM Examinations GROUP BY student_id, subject_name) 
groups the Examinations table by student_id and subject_name.

COUNT(*) counts how many times each student attended each exam (subject). 
This result is aliased as attended_exams.
The result of this subquery will be a table with columns student_id, subject_name, and attended_exams.


why we write alias e after () instead of FROM Examinations as e?
Explanation:

This alias allows you to reference the results of the subquery by the simple name e in the rest of the JOIN condition.

Using the Alias in the ON Clause:
When you write e ON, you're using the alias e to refer to the result set produced by the subquery. 
This is shorthand for saying, "use the table that I defined as e to join on the specified columns."
So, e.student_id refers to the student_id column in the result set of the subquery, and e.subject_name refers to the subject_name column in the result set of the subquery.

Why Not Write FROM Examinations as e Directly?
If you were to write FROM Examinations as e, it would mean you're directly referring to the Examinations table as e. However, in this case, you're not using the Examinations table directly; you're using a derived table created by the subquery.

*/





