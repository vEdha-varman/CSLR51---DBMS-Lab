CREATE DATABASE Empire;
USE Empire;
CREATE TABLE Employee (
	employee_id INT PRIMARY KEY,
	first_name VARCHAR(25) NOT NULL,
	last_name VARCHAR(25) NOT NULL,
	email VARCHAR(25) NOT NULL,
	phone_number VARCHAR(12) NOT NULL,
	hire_date DATE NOT NULL,
	job_id VARCHAR(13) NOT NULL,
	salary FLOAT(7,2) NOT NULL DEFAULT 0.0,
	commission_pct FLOAT(7,2) /*NOT NULL*/ DEFAULT 0,
	manager_id INT NOT NULL,
	department_id INT NOT NULL  -- ,
	-- CONSTRAINT manager_id CHECK manager_id IN employee_id
);
INSERT INTO Employee 
  VALUES
    (100, "Steven",    "King",      "SKING",    '515.123.4567', '2003-06-17', 'AD_PRES',    24000.00, 0.00,   0,  90),
	(101, "Neena",     "Kochhar",   "NKOCCHAR", '515.123.4568', '2005-09-21', 'AD_VP',      17000.00, 0.00, 100,  40),
	(102, "Lex",       "De Haan",   "LDEHAAN",  '515.123.4569', '2001-01-13', 'AD_VP',      17000.00, 0.00, 100,  90),
	(103, "Alexander", "Hunold",    "AHUNOLD",  '590.423.4567', '2006-01-03', 'IT_PROG',     9000.00, 0.00, 102,  60),
	(104, "Bruce",     "Ernst",     "BERNST",   '590.423.4568', '2007-05-21', 'IT_PROG',     6000.00, 0.00, 103,  60),
	(105, "David",     "Austin",    "DAUSTIN",  '590.423.4569', '2005-06-25', 'IT_PROG',     4800.00, 0.00, 103,  40),
	(106, "Valli",     "Pataballa", "VPATABAL", '590.423.4560', '2006-02-05', 'IT_PROG',     4800.00, 0.00, 103,  60),
	(107, "Diana",     "Lorentz",   "DLORENTZ", '590.423.5567', '2007-02-07', 'IT_PROG',     4800.00, 0.00, 103,  60),
	(108, "Nancy",     "Greenberg", "NGREENBE", '515.124.4569', '2002-08-17', 'FI_MGR',     12008.00, 0.00, 103, 100),
	(109, "Daniel",    "Faviet",    "DFAVIET",  '515.124.4169', '2002-08-16', 'FI_ACCOUNT',  9000.00, 0.00, 103, 100),
	(110, "John",      "Chen",      "JCHEN",    '515.124.4269', '2005-09-28', 'FI_ACCOUNT',  8200.00, 0.00, 103,  40)
	;

-- 2a
SELECT first_name, last_name, department_id 
  FROM Employee
  WHERE employee_id IN (
	  SELECT employee_id 
	    FROM Employee
		WHERE SALARY > 3.7E3
  );
  -- 2a 2nd way
/* SELECT first_name, last_name, department_id 
  FROM Employee
  WHERE salary > 3700
  ;  /*  why only 3700, not 5k?  */
-- 2b
SELECT department_id, SUM(salary) AS Total_Salary
  FROM Employee
  WHERE department_id IN (
	  SELECT DISTINCT department_id 
	    FROM Employee
        -- GROUP BY department_id
        -- HAVING COUNT(department_id) >= 1
  )
  GROUP BY department_id
    HAVING COUNT(department_id) >= 1
  ;
  -- 2b 2nd way
/*SELECT department_id, SUM(salary) AS Total_Salary
  FROM Employee
  GROUP BY department_id
  -- HAVING COUNT(department_id) >= 1
  ;  /**/
-- SELECT DISTINCT department_id FROM Employee;
-- 2c but no nested query? , Insert meme chimp asks "where nested query?"
SELECT DISTINCT department_id 
  FROM Employee 
  WHERE department_id IN (
	  SELECT department_id
	    FROM Employee
  )
  GROUP BY department_id
    HAVING COUNT(department_id) >= 1
  ;
-- 2d
SELECT first_name, last_name, department_id
  FROM Employee
  WHERE salary > (
	  SELECT AVG(salary) 
	    FROM Employee		
  )
  ORDER BY salary DESC;
-- 2e
SELECT first_name, last_name, salary, department_id
  FROM Employee
  WHERE salary > (
	  SELECT MAX(salary)
	    FROM Employee
		WHERE department_id = 40
  );


DELETE FROM Employee;
DROP TABLE Employee;
DROP DATABASE Empire;