DROP DATABASE IF EXISTS w5q1_co;
CREATE DATABASE w5q1_co;
USE w5q1_co;

CREATE TABLE Employee (
	Emp_No INT,
    Emp_Name VARCHAR(30),
    sex VARCHAR(10),
    Salary INT,
    Address VARCHAR(100),
    Dept_No INT
);
INSERT INTO Employee VALUES
	(26, 'Simon L Messerly', 'male', 41000, '4971, Hillcrest Lane, Moreno Valley, California', 291),
    (29, 'Leroy A Preston', 'male', 104000, '1034 Lyon Avenue, Framingham, Massachusetts', 170),
    (56, 'Juanita J Tomlin', 'female', 53000, '2101 Hedge Street, Branchburg, New Jersey', 817),
    (60, 'William J Welton', 'male', 26000, '1475 Sundown Lane, Austin, Texas', 752),
    (25, 'Dianne P Saulsbury', 'female', 53000, '4089 Bernardo Street, Polk City, Florida', 868),
    (34, 'Amy I Taylor', 'female', 57000, '2946 Meadowbrook Mall Road, Playa Del Rey, California', 291),
    (40, 'Keith J Williams', 'male', 41000, '936 Clousson Road, HACKENSACK, New Jersey', 817),
    (22, 'Homer K Linger', 'male', 77000, '4626 Larry Street, NOVELTY, Missouri', 623),
    (66, 'Helga J Beck', 'female', 71000, '3904 Metz Lane, Cambridge, Massachusetts', 170),
    (36, 'William S Burnett', 'male', 50000, '3409 Emily Renzelli Boulevard, Salinas, California', 291);



CREATE TABLE Department (
	Dept_No INT,
    Dept_Name VARCHAR(20),
    Location VARCHAR(20)
);    
INSERT INTO Department VALUES
	(170, 'Technology', 'Massachusetts'),
    (291, 'Entertainment', 'California'),
    (752, 'Agriculture', 'Texas'),
    (817, 'Sales', 'New Jersey'),
    (623, 'Medical', 'Missouri'),
    (868, 'Tourism', 'Florida');


-- 1a) Write a procedure to display employee details given the Emp_No.
-- CREATE PROCEDURE disp_emp(IN eno INT)
-- SELECT * FROM Employee
--    WHERE Emp_no = eno;
-- CALL disp_emp(60);

DELIMITER //
DROP PROCEDURE IF EXISTS show_emp//
CREATE PROCEDURE show_emp (IN eno INT)
BEGIN
SELECT * FROM Employee WHERE Emp_No = eno;
END//
DELIMITER ;
CALL show_emp(60);

-- 1b) Write a procedure to delete an employee record given the Emp_Name.
DELIMITER //
DROP PROCEDURE IF EXISTS del_emp//
CREATE PROCEDURE del_emp(IN ename VARCHAR(30))
BEGIN
	DELETE FROM Employee
    WHERE Emp_name = ename;
END//
DELIMITER ;
CALL del_emp('William S Burnett');
SELECT * FROM Employee;



-- 1c) Write a procedure to list all the employee names belonging to a particular department given
-- the Dept_No.
DELIMITER //
DROP PROCEDURE IF EXISTS disp_emp_dept//
CREATE PROCEDURE disp_emp_dept(IN dept INT)
BEGIN
	SELECT * FROM Employee
    WHERE Dept_No = dept;
END//
DELIMITER ;
CALL disp_emp_dept(170);

-- 1d) Write a procedure to display the number of employees whose salary is greater than 30K.
DELIMITER //
DROP PROCEDURE IF EXISTS sal_30k//
CREATE PROCEDURE sal_30k(OUT numEmp INT)
BEGIN
	SELECT COUNT(Emp_No) INTO numEmp FROM Employee
    WHERE Salary > 30E3;
END//
DELIMITER ;
CALL sal_30k(@N);
SELECT @N as Num_Of_Employees;


-- DROP DATABASE w5q1_co;