CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
-- we cann't write any calculations in the return block 
set N=N-1;
 RETURN (
      # Write your MySQL query statement below.
       select distinct salary from employee order by salary desc
       limit 1 offset N
 );
END
-- LIMIT basically means how much records u are extracting
-- OFFSET means from which record you want extraction ( 0 means from first, 1 means from second record.........)
-- LIMIT 1,N means means LIMIT is N and OFFSET is 1
-- LIMIT N,1 means LIMIT is 1 and OFFSET is N
-- LIMIT 1 OFFSET N is same as first one

  
-- Explanation:
  
-- CREATE FUNCTION getNthHighestSalary(N INT): This defines a new function named getNthHighestSalary that accepts a single integer argument N. The function is intended to return an integer.
-- RETURNS INT: Specifies that the return type of the function is an integer.
-- BEGIN: Marks the beginning of the function's body where the logic will be written.
  
  
-- set N=N-1;: This line decrements the value of N by 1. The reason for this is that MySQL uses zero-based indexing for the OFFSET clause in the LIMIT statement. 
-- Thus, to find the nth highest salary, we need to offset by N-1.
  
-- limit 1 offset N:

-- LIMIT 1 specifies that only one row should be returned.
-- OFFSET N skips the first N rows in the result set.
-- Because N was decremented by 1 earlier, OFFSET N correctly identifies the nth highest distinct salary, given zero-based indexing.

-- END: Marks the end of the function's body.




