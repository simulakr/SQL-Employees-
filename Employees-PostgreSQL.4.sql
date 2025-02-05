--1.Overview Tables
SELECT * from departments
SELECT * from dept_emp        
SELECT * from employees       
SELECT * from salaries       
        

-- 2.How many employees are in the company?
SELECT COUNT(*) as Number_of_employees	
	from employees --11797


-- 2.2: Is there any employee without a first name?        
SELECT 	count(*) from employees 
		WHERE first_name is NULL
        
-- 2.3:How many records are in the salaries table
SELECT count(*) from salaries       

-- 2.4: How many annual contracts with a value higher than or equal to
-- $100,000 have been registered in the salaries table?
SELECT COUNT(*) from salaries 
	WHERE salary >= 100000


-- 2.5: How many times have we paid salaries to employees?
SELECT COUNT(salary) as salary_count
from salaries
 
-- SELECT DISTINCT & GROUP BY

-- Select first name from the employees table
SELECT first_name from employees
LIMIT 5

-- 3.1: How many different first name are in the employees table
-- and order by first name in descending order?
SELECT DISTINCT first_name , COUNT(*)
FROM employees
	GROUP by first_name
    ORDER by 2 desc
    LIMIT 5

-- 3.2: How many different names can be found in the employees table?
SELECT COUNT(DISTINCT first_name) 
from employees


-- 3.6 (Ex.): How many different departments are there in the "employees" database?
SELECT COUNT(DISTINCT dept_no) as number_of_departments 
from departments

-- 3.7: Retrieve a list of how many employees earn over $80,000 and
-- how much they earn. Rename the 2nd column as emps_with_same_salary?
SELECT salary , COUNT(emp_no) as emps_with_same_salary
from salaries
	where salary > 80000
    GROUP by salary 
    ORDER by 2 desc

-- HAVING
-- 4.1: Retrieve a list of all employees who were employed on and before 1st of January, 2000
SELECT emp_no, hire_date from employees 
	WHERE hire_date <= '2000-01-01'

-- Will this produces the same result?
SELECT emp_no, hire_date from employees 
    GROUP by emp_no, hire_date
    	HAVING hire_date <= '2000-01-01'


-- 4.2: Extract a list of names of employees, where the number of employees is more than 15
-- Order by first name.
SELECT first_name, COUNT(*) from employees 
    GROUP by first_name 
    	HAVING COUNT(first_name) > 15 
    ORDER by COUNT(*) DESC
    LIMIT 5

-- 4.3: Retrieve a list of employee numbers and the average salary.
-- Make sure the you return where the average salary is more than $120,000

-- Select all records from the salaries table
SELECT * FROM salaries;

-- Solution to 4.3
SELECT emp_no, avg(salary) from salaries 
	GROUP by emp_no 
    HAVING AVG(salary) > 120000 
    order by 2 desc 
    LIMIT 5

-- 4.4: Extract a list of all names that have encountered less than 20
-- times. Let the data refer to people hired after 1st of January, 1990
SELECT first_name, COUNT(first_name) as number_of_names, hire_date 
from employees 
	WHERE hire_date >= '1990-01-01'
    GROUP by first_name , hire_date
    HAVING COUNT(first_name) < 20 
    ORDER by 2 DESC
    LIMIT 5
    

-- 4.5 (Ex.): Select the employees numbers of all individuals who have signed 
-- more than 1 contract after the 1st of January, 2000

-- Retrieve all records from dept_emp
SELECT * FROM dept_emp;

-- Solution to 4.5
SELECT emp_no, COUNT(from_date) 
from dept_emp 
WHERE from_date > '2000-01-01'
GROUP by emp_no 
HAVING COUNT(from_date) >1

--How many employees solution 4.5
SELECT COUNT(*)
from (SELECT emp_no, COUNT(from_date) 
from dept_emp 
WHERE from_date > '2000-01-01'
GROUP by emp_no 
HAVING COUNT(from_date) >1) 

-- SUM()
-- 5.1: Retrieve the total amount the company has paid in salary?
SELECT sum(salary) as total_salary
from salaries
    

-- 5.2: What is the total amount of money spent on salaries for all 
-- contracts starting after the 1st of January, 1997?

SELECT SUM(salaries) as total_sale
FROM salaries
 WHERE hire_date > '1997-01-01'

-- MIN() and MAX()

-- 6.1: What is the highest salary paid by the company?
SELECT max(salary) as maximum_salary
from salaries

-- 6.2: What is the lowest salary paid by the company?
SELECT MIN(salary) as minimum_salary
from salaries
  
-- 6.3 (Ex.): What is the lowest employee number in the database?
SELECT MIN(emp_no) lowest_emp_no
from employees

-- 6.4 (Ex.): What is the highest employee number in the database?
SELECT max(emp_no) as highest_emp_no
from employees

-- AVG()
-- 7.1: How much has the company paid on average to employees?
SELECT ROUND(avg(salary),2) as average_salary 
from salaries

-- 7.2: What is the average annual salary paid to employees who started
-- after the 1st of January, 1997
SELECT ROUND(avg(salary),2) as average_salary 
from salaries 
WHERE from_date > '1997-01-01' 

-- ROUND()
-- 8.1: Round the average salary to the nearest whole number
SELECT ROUND(avg(salary)) as average_salary 
from salaries  

-- 8.2: Round the average salary to a precision of cents.
SELECT ROUND(avg(salary),2) as average_salary 
from salaries

-- 8.3: Round the average amount of money spent on salaries for all
-- contracts that started after the 1st of January, 1997 to a precision of cents
SELECT ROUND(avg(salary),2) as average_salary 
from salaries 
WHERE from_date > '1997-01-01' 

-- 8.4: Arithmetic operations can also be performed in PostgreSQL
-- Finding the range for salary
SELECT ROUND(MAX(salary) - MIN(salary)) as salary_range
FROM salaries
--
SELECT max(salary) as highest_salary, MIN(salary) as lowest_salary,
	ROUND(MAX(salary) - MIN(salary)) as salary_range
	FROM salaries


