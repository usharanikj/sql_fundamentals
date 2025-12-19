-- SQL FUNDAMENTALS 

show databases;
create database sql_fundamentals;
use sql_fundamentals;

-- Defining database schema: Populating the database with different tables.

/* 
Data types:
INT - Whole numbers
DECIMAL(M,N) - Decimal numbers (A decimal number with M total digits and N digits after the decimal point) 
VARCHAR(M) - String of text of length M
BLOB - Binary large object (A structure that can store large amounts of binary data. Can use theese for storing images and files in the database)
DATE - 'YYYY-MM-DD'
TIMESTAMP - 'YYYY-MM-DD HH:MM:SS' 
*/

-- Creating tables:

CREATE TABLE student(
student_id INT,
name VARCHAR(20),
major VARCHAR(20),
PRIMARY KEY(student_id)
);

DESCRIBE student;

DROP TABLE student; -- To delete a table.

ALTER TABLE student ADD gpa DECIMAL(4,2); -- To modify a table (Specifically, we are addingg a column)

ALTER TABLE student DROP COLUMN gpa; -- To modify a table (Specifically, we are removing a column)

/*
To create a database, you first define the schema, which involves creating all the tables, their columns, and the constraints (like 
Primary and Foreign Keys) that define the relationships between the tables. Only then can you begin inserting data into the tables.
*/

SELECT * FROM student; -- Gives us all the information from the student table.
-- Most tools (DBeaver, DataGrip, MySQL Workbench, etc.) display one empty row at the bottom of the Result Grid so you can 'manually add' a new row.
-- That row is not part of your query results, it's just a UI feature.

INSERT INTO student VALUES(1, 'Jack', 'Biology');
INSERT INTO student VALUES(2, 'Kate', 'Sociology');
INSERT INTO student(student_id, name) VALUES(3, 'Claire'); -- You can specify what pieces of information you want to insert into the table. 
														   -- In the values section, you just have to add those pieces of information.
INSERT INTO student VALUES(4, 'Jack', 'Biology');
INSERT INTO student VALUES(5, 'Mike', 'Computer Science');

-- Constraints:

-- NOT NULL and UNIQUE
DROP TABLE student;

CREATE TABLE student(
student_id INT ,
name VARCHAR(20) NOT NULL,
major VARCHAR(20) UNIQUE,
PRIMARY KEY(student_id)
);

INSERT INTO student(student_id, major) VALUES(1, 'Biology'); -- Won't execute as the name column can't be NULL
INSERT INTO student VALUES(2, 'Kate', 'Sociology');
INSERT INTO student(student_id, name) VALUES(3, 'Kate'); -- Major column can be NULL
INSERT INTO student VALUES(4, 'Mike', 'Sociology'); -- Won't execute as the major column has to be UNIQUE

SELECT * FROM student;
-- NOTE: Primary key is both NOT NULL and UNIQUE 

DROP TABLE student;

-- AUTO_INCREMENT 
CREATE TABLE student(
student_id INT AUTO_INCREMENT,
name VARCHAR(20),
major VARCHAR(20),
PRIMARY KEY(student_id)
);

INSERT INTO student(name, major) VALUES('Jack', 'Biology');
INSERT INTO student(name, major) VALUES('Kate', 'Sociology');

SELECT * FROM student;

-- Update and Delete:

DROP TABLE student;

CREATE TABLE student(
student_id INT PRIMARY KEY,
name VARCHAR(20),
major VARCHAR(20)
);

INSERT INTO student VALUES(1, 'Jack', 'Biology');
INSERT INTO student VALUES(2, 'Kate', 'Sociology');
INSERT INTO student VALUES(3, 'Claire', 'Chemistry');
INSERT INTO student VALUES(4, 'Jack', 'Biology');
INSERT INTO student VALUES(5, 'Mike', 'Computer Science');

SELECT * FROM student;

SET SQL_SAFE_UPDATES = 0;

UPDATE student
SET major = 'Bio'
WHERE major = 'Biology';

SET SQL_SAFE_UPDATES = 1;
SELECT * FROM student;
-- Safe Updates: When enabled (default), MySQL Workbench will not execute UPDATE or DELETE statements if a key is not defined in the WHERE clause. 
-- In other words, MySQL Workbench attempts to prevent big mistakes, such as deleting a large number of (or all) rows. Set from the SQL Editor preferences tab.
-- For example, DELETE FROM foo is considered unsafe, whereas DELETE FROM foo WHERE id = 1 is safe and will always execute.

UPDATE student
SET major = 'Compute Science'
WHERE student_id = 4;
SELECT * FROM student;

SET SQL_SAFE_UPDATES = 0;

UPDATE student
SET major = 'Biochemistry'
WHERE major = 'Bio' OR major = 'Chemistry';

SET SQL_SAFE_UPDATES = 1;
SELECT * FROM student;

UPDATE student 
SET name = 'Usha', major = 'Undecided' -- You can also set multiple things (you can change multiple columns within the same query)
WHERE student_id = 5;
SELECT * FROM student;

SET SQL_SAFE_UPDATES = 0;
UPDATE student 
SET major = 'Undecided'; -- This is going to apply to every single row in the table (no WHERE statement)
SET SQL_SAFE_UPDATES = 1;
SELECT * FROM student;

DELETE FROM student
WHERE student_id = 5;

SET SQL_SAFE_UPDATES = 0;
DELETE FROM student 
WHERE name = 'Jack' AND major = 'Undecided';
SET SQL_SAFE_UPDATES = 1;
SELECT * FROM student;

SET SQL_SAFE_UPDATES = 0;
DELETE FROM student; -- Deletes every single row inside the student table
SET SQL_SAFE_UPDATES = 1;

-- Query: Is essentially a block of SQL that is designed to ask the databaase management system for a particular piece of information.
/*
SQL Comparison Operators:
=
!= or <>
>
<
>=
<=
AND
OR
*/

INSERT INTO student VALUES(1, 'Jack', 'Biology');
INSERT INTO student VALUES(2, 'Kate', 'Sociology');
INSERT INTO student VALUES(3, 'Claire', 'Chemistry');
INSERT INTO student VALUES(4, 'Jack', 'Biology');
INSERT INTO student VALUES(5, 'Mike', 'Computer Science');
SELECT * FROM student;

-- Basic Queries:

-- SELECT statement:

SELECT *
FROM student;

SELECT name
FROM student;

SELECT name, major
FROM student;
-- or --
SELECT student.name, student.major
FROM student;

-- ORDER BY statement:

SELECT *
FROM student
ORDER BY name ASC;
-- or --
SELECT * 
FROM student
ORDER BY name; -- Ascending is the default 

SELECT *
FROM student
ORDER BY name DESC;

SELECT * 
FROM student
ORDER BY student_id DESC; 

SELECT * 
FROM student
ORDER BY major DESC, student_id ASC; -- Multiple column ordering

-- LIMIT statement
SELECT * 
FROM student
LIMIT 2;

SELECT *
FROM student
ORDER BY student_id DESC
LIMIT 2;

-- Filtering with WHERE using comparison operators 
SELECT * 
FROM student 
WHERE major = 'Biology';

SELECT name
FROM student
WHERE major = 'chemistry' OR major = 'Biology';

SELECT *
FROM student 
WHERE major = 'Biology' OR name = 'Kate';

SELECT *
FROM student 
WHERE major <> 'Chemistry';

SELECT * 
FROM student 
WHERE student_id < 3;

SELECT * 
FROM student 
WHERE student_id <= 3 AND name <> 'Jack';

-- IN keyword
-- The IN operator allows you to specify multiple values in a WHERE clause. The IN operator is a shorthand for multiple OR conditions.

SELECT *
FROM student 
WHERE name IN ('Claire','Kate', 'Mike');

SELECT *
FROM student 
WHERE major IN ('Biology','Chemistry');

SELECT *
FROM student 
WHERE major IN ('Biology','Chemistry') AND student_id > 2;

-- Company database:

/* 
Composite Key:
A composite key is a primary key that is made up of more than one column to uniquely identify records in a table. Unlike a single-column primary key, 
a composite key combines two or more columns to ensure uniqueness. While any of the individual columns in a composite key might not be unique on their own, 
together they form a unique combination that can uniquely identify each row in the table.
*/

DROP TABLE student;

-- Creating company database:

CREATE TABLE employee(
emp_id INT PRIMARY KEY,
first_name VARCHAR(40),
last_name VARCHAR(40),
birth_date DATE, 
sex VARCHAR(1),
salary INT,
super_id INT, -- Foreign key
branch_id INT -- Foreign key
);
/*
A fundamental rule in relational database management systems (RDBMS) is that you must define the referenced table 
before you can define a foreign key that refers to it.
*/
SELECT * FROM employee;

CREATE TABLE branch(
branch_id INT PRIMARY KEY,
branch_name VARCHAR(40),
mgr_id INT,
mgr_start_date DATE,
FOREIGN KEY(mgr_id) REFERENCES employee(emp_id) ON DELETE SET NULL
)
SELECT * FROM branch;

/*
ON DELETE CASCADE and ON DELETE SET NULL are two important options in SQL foreign key constraints 
that define how the database handles related records in a child table when a record in the parent table is deleted. 
These options are crucial for maintaining referential integrity and ensuring a consistent database structure. 

ON DELETE CASCADE:
The "ON DELETE CASCADE" for a foreign key constraint means that if a record in the parent table (referenced table) 
is deleted then all related records in the child table (referencing table) will be automatically deleted. 
This ensures the referential integrity by removing dependent records when the referenced record is removed.

Notes:
Effect on child records - Automatically deletes child records
Referential integrity - Ensures referential integrity by removing dependent records.
Query complexity - Simplifies queries, as child records are deleted.
Impact on database size - Reduces size by deleting child records.

ON DELETE SET NULL:
The ON DELETE SET NULL option updates the foreign key column in the child table to NULL when the corresponding parent record is deleted. 
This approach preserves the child record while removing its reference to the parent. 
This is another way to maintain reference integrity, allowing the child records to exist but with the NULL reference if the parent record is deleted.

Notes:
Effect on child records - Foreign key values in child records are set to NULL.
Referential integrity - Ensures referential integrity by maintaining child records with NULL references.
Query complexity - Requires additional handling for NULL values.
Impact on database size - Retains child records, increasing database size.
*/

ALTER TABLE employee
ADD FOREIGN KEY(branch_id)
REFERENCES branch(branch_id)
ON DELETE SET NULL;

ALTER TABLE employee
ADD FOREIGN KEY(super_id)
REFERENCES employee(emp_id)
ON DELETE SET NULL;

-- ON DELETE SET NULL is used when the relationship can disappear without the entity itself disappearing.

/*
Why SET NULL (not CASCADE)
If a manager is deleted: The subordinate still exists. They just no longer have a manager assigned.

Setting super_id = NULL means:
“This employee currently has no supervisor.”

Why CASCADE would be wrong:
If you used ON DELETE CASCADE: Deleting a manager would delete all subordinates. And then delete their subordinates… Potentially wiping out half the company.

So:
Employee existence ≠ supervisor existence
Relationship is optional → SET NULL
*/

CREATE TABLE client (
  client_id INT PRIMARY KEY,
  client_name VARCHAR(40),
  branch_id INT,
  FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE SET NULL
);
/*
Why SET NULL:
If a branch is deleted: Employees do not stop existing. They are simply unassigned from a branch.

Setting branch_id = NULL means:
“This employee is not currently assigned to any branch.”

Why CASCADE would be wrong: Deleting a branch should not delete all employees. That would represent layoffs, not a branch closure.

Again:
Employee has independent existence
Branch relationship is optional → SET NULL
*/

CREATE TABLE works_with (
  emp_id INT,
  client_id INT,
  total_sales INT,
  PRIMARY KEY(emp_id, client_id),
  FOREIGN KEY(emp_id) REFERENCES employee(emp_id) ON DELETE CASCADE, -- Why on delete cascade here? 
  FOREIGN KEY(client_id) REFERENCES client(client_id) ON DELETE CASCADE
);
/*
ON DELETE CASCADE is used here because works_with is a pure relationship table, 
and its rows should automatically disappear when either the employee or client no longer exists.

works_with(emp_id, client_id, total_sales) is a junction (associative) table that models a many-to-many relationship:
An employee can work with many clients. A client can work with many employees. works_with has no independent existence without both an employee and a client.
*/

CREATE TABLE branch_supplier (
  branch_id INT,
  supplier_name VARCHAR(40),
  supply_type VARCHAR(40),
  PRIMARY KEY(branch_id, supplier_name),
  FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE CASCADE -- Even though a supplier may exist independently, the branch–supplier relationship does not, so ON DELETE CASCADE is required.
);

/*
Why ON DELETE CASCADE:
branch_supplier does not store suppliers as entities. It stores a relationship: which supplier supplies which branch.
The “supplier” here is just a name attribute, not a parent table.

If a branch is deleted: That supply relationship cannot exist anymore. The row has no meaning without a branch.
Therefore, it should be deleted, not partially kept

Why SET NULL is wrong here:
branch_id is part of the PRIMARY KEY. Primary key columns cannot be NULL. SET NULL would violate table integrity.
*/

-- Corporate
INSERT INTO employee VALUES(100, 'David', 'Wallace', '1967-11-17', 'M', 250000, NULL, NULL);

INSERT INTO branch VALUES(1, 'Corporate', 100, '2006-02-09');

UPDATE employee
SET branch_id = 1
WHERE emp_id = 100;

INSERT INTO employee VALUES(101, 'Jan', 'Levinson', '1961-05-11', 'F', 110000, 100, 1);

-- Scranton
INSERT INTO employee VALUES(102, 'Michael', 'Scott', '1964-03-15', 'M', 75000, 100, NULL);

INSERT INTO branch VALUES(2, 'Scranton', 102, '1992-04-06');

UPDATE employee
SET branch_id = 2
WHERE emp_id = 102;

INSERT INTO employee VALUES(103, 'Angela', 'Martin', '1971-06-25', 'F', 63000, 102, 2);
INSERT INTO employee VALUES(104, 'Kelly', 'Kapoor', '1980-02-05', 'F', 55000, 102, 2);
INSERT INTO employee VALUES(105, 'Stanley', 'Hudson', '1958-02-19', 'M', 69000, 102, 2);

-- Stamford
INSERT INTO employee VALUES(106, 'Josh', 'Porter', '1969-09-05', 'M', 78000, 100, NULL);

INSERT INTO branch VALUES(3, 'Stamford', 106, '1998-02-13');

UPDATE employee
SET branch_id = 3
WHERE emp_id = 106;

INSERT INTO employee VALUES(107, 'Andy', 'Bernard', '1973-07-22', 'M', 65000, 106, 3);
INSERT INTO employee VALUES(108, 'Jim', 'Halpert', '1978-10-01', 'M', 71000, 106, 3);

-- BRANCH SUPPLIER
INSERT INTO branch_supplier VALUES(2, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES(2, 'Uni-ball', 'Writing Utensils');
INSERT INTO branch_supplier VALUES(3, 'Patriot Paper', 'Paper');
INSERT INTO branch_supplier VALUES(2, 'J.T. Forms & Labels', 'Custom Forms');
INSERT INTO branch_supplier VALUES(3, 'Uni-ball', 'Writing Utensils');
INSERT INTO branch_supplier VALUES(3, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES(3, 'Stamford Labels', 'Custom Forms');

-- CLIENT
INSERT INTO client VALUES(400, 'Dunmore Highschool', 2);
INSERT INTO client VALUES(401, 'Lackawana Country', 2);
INSERT INTO client VALUES(402, 'FedEx', 3);
INSERT INTO client VALUES(403, 'John Daly Law, LLC', 3);
INSERT INTO client VALUES(404, 'Scranton Whitepages', 2);
INSERT INTO client VALUES(405, 'Times Newspaper', 3);
INSERT INTO client VALUES(406, 'FedEx', 2);

-- WORKS_WITH
INSERT INTO works_with VALUES(105, 400, 55000);
INSERT INTO works_with VALUES(102, 401, 267000);
INSERT INTO works_with VALUES(108, 402, 22500);
INSERT INTO works_with VALUES(107, 403, 5000);
INSERT INTO works_with VALUES(108, 403, 12000);
INSERT INTO works_with VALUES(105, 404, 33000);
INSERT INTO works_with VALUES(107, 405, 26000);
INSERT INTO works_with VALUES(102, 406, 15000);
INSERT INTO works_with VALUES(105, 406, 130000);

-- More basic queries:

-- 1. Select all employees
SELECT *
FROM employee;

-- 2. Find all clients
SELECT *
FROM client;

-- 3. Find all employees ordered by salary 
SELECT *
FROM employee
ORDER BY salary DESC;

-- 4. Find all employees ordered by sex then name
SELECT *
FROM employee
ORDER BY sex, first_name, last_name;

-- 5. Find the first five employees in the table
SELECT *
FROM employee
LIMIT 5;

-- 6. Find the first and last name of all employees
SELECT first_name, last_name
FROM employee;

-- 7. Find the forename and surname of all employees
SELECT first_name AS forename, last_name AS surname
FROM employee;
	-- The AS command is used to rename a column or table with an alias.
	-- An alias only exists for the duration of the query.

-- 8. Find out all the different genders 
SELECT DISTINCT sex
FROM employee;

-- 9. Find out all the different (branch_id)s
SELECT DISTINCT branch_id
FROM employee;
-- Inside a table, a column often contains many duplicate values; and sometimes you only want to list the different (distinct) values.
-- The SELECT DISTINCT statement is used to return only distinct (different) values.

-- SQL Functions:
/*
SQL Functions are built-in programs that are used to perform different operations on the database.

There are two types of functions in SQL:
Aggregate Functions 
Scalar Functions
*/

-- 1. Find the number of employees
SELECT COUNT(*)
FROM employee;

-- 2. How many employees have supervisors 
SELECT COUNT(super_id)
FROM employee;

-- 3. Find the number of female employees born after 1970
SELECT COUNT(*)
FROM employee
WHERE sex = 'F' AND YEAR(birth_date) > 1970;

-- 4. Find the average of salary of employees
SELECT AVG(salary)
FROM employee;

-- 5. Find the average salary of male employees
SELECT AVG(salary)
FROM employee
WHERE sex = 'M';

-- 6. Find the average salary of female employees
SELECT AVG(salary)
FROM employee
WHERE sex = 'F';

-- 7. Find the sum of all employees' salaries
SELECT SUM(salary)
FROM employee;

-- Note: We can use aggregation to organize the data returned by the above functions.

/*
SQL Aggregate Functions:
An aggregate function is a function that performs a calculation on a set of values, and returns a single value.
Aggregate functions are often used with the GROUP BY clause of the SELECT statement. 
The GROUP BY clause splits the result-set into groups of values and the aggregate function can be used to return a single value for each group.

The most commonly used SQL aggregate functions are:
MIN() - returns the smallest value within the selected column
MAX() - returns the largest value within the selected column
COUNT() - returns the number of rows in a set
SUM() - returns the total sum of a numerical column
AVG() - returns the average value of a numerical column

Aggregate functions ignore null values (except for COUNT(*)).
*/

-- 1. Find out how many males and females there are
SELECT sex, COUNT(*) -- SQL does not guarantee row order unless you explicitly ask for it.
FROM employee
GROUP BY sex;
-- GROUP BY only groups rows, it does not sort the results.
-- The database engine is free to return grouped rows in any order.
-- Here, it happens to return M before F, but that’s incidental, not a rule.

-- 2. Find the total sales of each salesman 
SELECT emp_id, SUM(total_sales)
FROM works_with
GROUP BY emp_id;

-- 3. How much money each client spent with the branch
SELECT client_id, SUM(total_sales)
FROM works_with
GROUP BY client_id;

/*
SQL Wildcard Characters:
A wildcard character is used to substitute one or more characters in a string.
Wildcard characters are used with the LIKE operator. The LIKE operator is used in a WHERE clause to search for a specified pattern in a column.

1. The % wildcard represents any number of characters, even zero characters.
2. The _ wildcard represents a single character. It can be any character or number, but each _ represents one, and only one, character.
*/

-- LIKE --> SQL keyword used with wildcards 

-- 1. Find any clients who are an LLC 
SELECT *
FROM client 
WHERE client_name LIKE '%LLC';

-- 2. Find and branch suppliers who are in the label business 
SELECT *
FROM branch_supplier 
WHERE supplier_name LIKE '% label%';

-- 3. Find any employee born in October
SELECT * 
FROM employee
WHERE MONTH(birth_date) =10;

SELECT *
FROM employee
WHERE birth_date LIKE '_____10___';

-- 3. Find any employee born in February
SELECT *
FROM employee
WHERE birth_date LIKE '_____02___';

-- 4. Find any clients who are schools 
SELECT *
FROM client
WHERE client_name LIKE '%school%';

-- UNION 
/*
The SQL UNION Operator:
The UNION operator is used to combine the result-set of two or more SELECT statements.
The UNION operator automatically removes duplicate rows from the result set.

Requirements for UNION:
Every SELECT statement within UNION must have the same number of columns.
The columns must also have similar data types.
The columns in every SELECT statement must also be in the same order.

Note: The column names in the result-set are usually equal to the column names in the first SELECT statement.
*/

/*
The SQL UNION ALL Operator:
The UNION ALL operator is used to combine the result-set of two or more SELECT statements.
The UNION ALL operator includes all rows from each statement, including any duplicates.

Requirements for UNION ALL: 
Every SELECT statement within UNION ALL must have the same number of columns
The columns must also have similar data types
The columns in every SELECT statement must also be in the same order

Note: While the UNION operator removes duplicate values by default, the UNION ALL includes duplicate values.
*/

-- Union: Union basically just combines the results from two SELECT statements. 

-- 1. Find a list of employee and branch names
SELECT first_name AS company_names
FROM employee
UNION
SELECT branch_name 
FROM branch;

-- 2. Find a list of all client and branch supplier names
SELECT client_name
FROM client
UNION 
SELECT supplier_name 
FROM branch_supplier;

-- 3. Find a list of all client and branch supplier names along with the IDs of the branches that they are associated with 
SELECT client_name, client.branch_id
FROM client
UNION
SELECT supplier_name, branch_supplier.branch_id
FROM branch_supplier;

-- 4. Find a list of all money spent or earned by the company
SELECT salary
FROM employee
UNION 
SELECT total_sales
FROM works_with;

-- JOINS: JOIN is basically used to cobine rows from two or more tables based on a related column among them.
INSERT INTO branch VALUES(4, 'Buffalo', NULL, NULL); -- To demonstrate JOINs

-- 1. Find all brnaches and the names of their managers
SELECT b.branch_name, b.mgr_id, e.first_name, e.last_name
FROM employee AS e
JOIN branch AS b -- INNER JOIN
ON b.mgr_id = e.emp_id;

/*
Result of the JOIN (before SELECT): At this stage, SQL builds a wide temporary table that contains ALL columns from BOTH tables for matching rows.
Mental model to remember:
JOIN = build the big combined table first.
SELECT = choose which columns you want to see.

┌──────────────────────── employee columns ───────────────────────┐┌──────── branch columns ────────┐
| emp_id | first_name | last_name | salary | ... | branch_id | branch_name | mgr_id | mgr_start |
---------------------------------------------------------------------------------------------------
| 100    | David      | Wallace   | 250000 | ... | 1         | Corporate   | 100    | 2006-02-09 |
| 102    | Michael    | Scott     | 75000  | ... | 2         | Scranton    | 102    | 1992-04-06 |
| 106    | Josh       | Porter    | 78000  | ... | 3         | Stamford    | 106    | 1998-02-13 |
|___________________________________________________________________________________________________|
*/

-- 2. LEFT JOIN
SELECT *
FROM employee AS e
LEFT JOIN branch AS b
ON e.emp_id = b.mgr_id;

-- 3. RIGHT JOIN
SELECT *
FROM employee as e
RIGHT JOIN branch AS b
ON e.emp_id = b.mgr_id;

/*
SQL joins are fundamental tools for combining data from multiple tables in relational databases.

1. SQL INNER JOIN:
The INNER JOIN keyword selects all rows from both the tables as long as the condition is satisfied. 
This keyword will create the result set by combining all rows from both the tables where the condition satisfies i.e value of the common field will be the same. 

2. SQL LEFT JOIN:
A LEFT JOIN returns all rows from the left table, along with matching rows from the right table. 
If there is no match, NULL values are returned for columns from the right table. LEFT JOIN is also known as LEFT OUTER JOIN.

3. SQL RIGHT JOIN:
RIGHT JOIN returns all the rows of the table on the right side of the join and matching rows for the table on the left side of the join. 
It is very similar to LEFT JOIN for the rows for which there is no matching row on the left side, the result-set will contain null. 
RIGHT JOIN is also known as RIGHT OUTER JOIN. 

4. SQL FULL JOIN:
The result-set will contain all the rows from both tables. For the rows for which there is no matching, the result-set will contain NULL values.
*/

-- NESTED QUERIES: We use multiple SELECT statemnts to obtain a specific piece of information
--  (we are going to use the results of one SELECT statement to inform the results of another SELECT statement)

-- 1. Find names of all employees who have sold over 30,000 to a single client  
SELECT e.first_name, e.last_name
FROM employee AS e
WHERE e.emp_id IN ( 
	SELECT w.emp_id
	FROM works_with AS w
	WHERE w.total_sales > 30000
	); -- RDBMS executes the inner query first

-- 2. Find all clients who are handled by the branch that Michael Scott manages (Assume you know Michael's ID - 102)
SELECT c.client_name
FROM client AS c
WHERE c.branch_id = (
	SELECT b.branch_id 
	FROM branch AS b
	WHERE b.mgr_id = 102
    LIMIT 1 -- Because we are using an equals sign instead of IN, the subquery must return a single value.
    ); 
    
-- 3. If Michael managed multiple branches and the inner query were limited to one result, would it return the branch ID of an arbitrary branch he managed?
-- Yes. If Michael manages multiple branches and the inner query is limited to one result without specifying an order, 
-- the database may return the branch ID of any one of those branches, with no guarantee which one.
    
-- Better solution: If a manager can manage multiple branches, the outer query should reflect that.
SELECT client.client_name
FROM client
WHERE client.branch_id IN (
  SELECT branch.branch_id
  FROM branch
  WHERE branch.mgr_id = 102
);



    







