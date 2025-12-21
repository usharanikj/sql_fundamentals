USE sql_fundamentals;

-- DELETE

-- ON DELETE SET NULL:
/*
CREATE TABLE branch(
branch_id INT PRIMARY KEY,
branch_name VARCHAR(40),
mgr_id INT,
mgr_start_date DATE,
FOREIGN KEY(mgr_id) REFERENCES employee(emp_id) ON DELETE SET NULL
)
*/
DELETE FROM employee 
WHERE emp_id = 102;
-- The mgr_id for the Scranton branch (in the branch table) is set to NULL when the above block of code is executed.
-- Executing the code also results in a few rows in the super_id column of the employee table being set to NULL.

SELECT *
FROM branch; 

SELECT * 
FROM employee;

-- ON DELETE CASCADE:
/*
CREATE TABLE branch_supplier (
  branch_id INT,
  supplier_name VARCHAR(40),
  supply_type VARCHAR(40),
  PRIMARY KEY(branch_id, supplier_name),
  FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE CASCADE -- Even though a supplier may exist independently, the branch–supplier relationship does not, so ON DELETE CASCADE is required.
);
*/

DELETE FROM branch
WHERE branch_id = 2;
-- Deleting the Scranton branch (branch_id = 2) would cause all rows in the branch_supplier table that reference branch_id = 2 as a foreign key to be deleted.

SELECT * 
FROM branch_supplier; 

-- TRIGGERS
-- A trigger is a block of SQL code that defines an action to be automatically executed when a specific operation is performed on the database.

CREATE TABLE trigger_test(
	message VARCHAR(50)
);

/*
Example 1:

The block of code below is executed in the terminal:

-- mysql -u root -p (hit enter)
-- (enter the password)
-- use sql_fundamentals (database changed)

-- Creating the trigger:

DELIMITER $$

	CREATE TRIGGER my_trigger
	BEFORE INSERT ON EMPLOYEE
	FOR EACH ROW
	BEGIN
		INSERT INTO trigger_test VALUES('Added a new employee');
	END$$

DELIMITER ; 

(We are basically configuring MySQL to insert a value into the trigger_test table whenever a value gets inserted into the employee table)

*/

-- DELIMITER: This command changes MySQL’s default delimiter (;)

/*

Delimiters other than the default ; are typically used when defining functions, stored procedures, and triggers wherein you must define multiple statements. 
You define a different delimiter like $$ which is used to define the end of the entire procedure, but inside it, individual statements are each terminated by ;. 
That way, when the code is run in the mysql client, the client can tell where the entire procedure ends and execute it as a unit rather than executing 
the individual statements inside.

Note that the DELIMITER keyword is a function of the command line mysql client (and some other clients) only and not a regular MySQL language feature. 
It won't work if you tried to pass it through a programming language API to MySQL. 
Some other clients like PHPMyAdmin have other methods to specify a non-default delimiter.

*/

-- To verify that the trigger is properly set up in MySQL:

INSERT INTO employee VALUES(109, 'Usharani', 'K J', '1995-09-14', 'F', 69000, 106, 3);

SELECT *
FROM trigger_test; 
-- We see that when we inserted something into the employee table, it also updated the trigger_test table with a new entry, 
-- confirming that the trigger was set up correctly.


CREATE TABLE trigger_test2(
	message VARCHAR(50)
);

/*
Example 2:

The block of code below is executed in the terminal:

-- mysql -u root -p (hit enter)
-- (enter the password)
-- use sql_fundamentals (database changed)

-- Creating the trigger:

DELIMITER $$

	CREATE TRIGGER my_trigger2
	BEFORE INSERT ON employee
	FOR EACH ROW
	BEGIN
		INSERT INTO trigger_test2 VALUES(NEW.first_name); -- The NEW keyword allows us to reference column values from the row being inserted (ie., we can access a specific piece of information from the new row being inserted).
	END$$

DELIMITER ;

*/

-- To verify that the trigger is properly set up in MySQL:

INSERT INTO employee VALUES(110, 'Dakshayini', 'K J', '1997-06-26', 'F', 70000, 106, 3);

SELECT *
FROM trigger_test2; 
-- We see that when we inserted something into the employee table, it also updated the trigger_test2 table with a new entry, 
-- confirming that the trigger was set up correctly.

SELECT *
FROM trigger_test; -- The first trigger also executes correctly.


CREATE TABLE trigger_test3(
	message VARCHAR(50)
);

/*
Example 2:

The block of code below is executed in the terminal:

-- mysql -u root -p (hit enter)
-- (enter the password)
-- use sql_fundamentals (database changed)

-- Creating the trigger: Using IF-THEN-ELSE Logic within the trigger body using BEGIN...END blocks.

DELIMITER $$

	CREATE TRIGGER my_trigger3
	BEFORE INSERT ON employee
	FOR EACH ROW
	BEGIN
		IF NEW.sex = 'M' THEN
			INSERT INTO trigger_test3 VALUES('Added a male employee');
		ELSEIF NEW.sex = 'F' THEN
			INSERT INTO trigger_test3 VALUES('Added a female employee');
		ELSE
			INSERT INTO trigger_test3 VALUES('Added an employee');
		END IF;	
	END$$

DELIMITER ;

*/

-- To verify that the trigger is properly set up in MySQL:

INSERT INTO employee VALUES(111, 'Dileep', 'K J', '1993-06-01', 'M', 70000, 106, 3);

SELECT *
FROM trigger_test3; 
-- We see that when we inserted something into the employee table, it also updated the trigger_test3 table with a new entry, 
-- confirming that the trigger was set up correctly.

SELECT *
FROM trigger_test; -- The first trigger also executes correctly.

SELECT *
FROM trigger_test2; -- The second trigger also executes correctly.

/*

A trigger is a special stored procedure in a database that automatically executes when specific events (like INSERT, UPDATE, or DELETE) occur on a table. 
Triggers help automate tasks, maintain data consistency, and record database activities. 
Each trigger is tied to a particular table and runs without manual execution.

Types of SQL Triggers: Triggers can be categorized into different types based on the action they are associated with.
1. DDL Triggers 
The Data Definition Language (DDL) command events such as create_table, create_view, drop_table, drop_view, and alter_table cause the DDL triggers to be activated.
They allow us to track changes in the structure of the database.
(The trigger will prevent any table creation, alteration, or deletion in the database) 

2. DML Triggers
DML triggers fire when we manipulate data with commands like INSERT, UPDATE, or DELETE. 
These triggers are perfect for scenarios where we need to validate data before it is inserted, log changes to a table, or cascade updates across related tables.

3. Logon Triggers
Logon triggers fire in response to user logon events. They are used to monitor login activity, restrict access, or limit active sessions for a login. 
Messages and errors from these triggers appear in the SQL Server error log. However, they cannot handle authentication errors.

*/

/*

There may be situations where we need to remove an existing trigger from a database. This process is accomplished using the DROP TRIGGER statement.

The block of code below is executed in the terminal:
-- Syntax: DROP TRIGGER trigger_name;
By executing the above command, the specified trigger will be permanently deleted from the database.

*/
