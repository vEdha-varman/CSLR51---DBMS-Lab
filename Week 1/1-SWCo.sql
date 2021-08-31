/** */
CREATE DATABASE SWCom;
USE SWCom;
CREATE TABLE Employee (
  Empid INT AUTO_INCREMENT PRIMARY KEY,
  EmpName VARCHAR(40) NOT NULL,
  Addr VARCHAR(50),
  DoB DATE,
  Salary INTEGER
);
--DESC Employee;
INSERT INTO
  Employee (Empname, Addr, DoB, Salary)
VALUES
  (
    'IAmGroot',
    'Somewhere in Space',
    '2012-12-12',
    1E5
  ),
  (
    'Suzaku Kururugi',
    'Main Palace, Britannia',
    '2000-07-10',
    1E4
  ),
  ('Amber', 'Mondstadt, Teyvat', '2001-8-10', 1E6),
  (
    'Btuturuu',
    'Dubai st, New York nagar, India',
    '1993-02-01',
    1E7
  );
CREATE TABLE Project (
    Projno INTEGER AUTO_INCREMENT PRIMARY KEY,
    ProjName VARCHAR(50) NOT NULL,
    Duration INT DEFAULT 0,
    Descr VARCHAR(255)
  );
INSERT INTO
  Project (ProjName, Duration, Descr)
VALUES
  ('Storyboard', 2, 'Duration in days'),
  ('Sketching', 3, 'Lot of fleshing out work'),
  ('Final Revisions', 1, 'Consistency check');
CREATE TABLE WorksOn (
    Empid INT,
    FOREIGN KEY (Empid) REFERENCES Employee(Empid),
    Projno INT,
    FOREIGN KEY(Projno) REFERENCES Project(Projno)
  );
INSERT INTO
  WorksOn
VALUES
  (2, 1),
  (4, 1),
  (1, 2),
  (3, 2),
  (4, 3);
SELECT
  *
FROM
  Employee
ORDER BY
  EmpName DESC;
SELECT
  *
FROM
  Project
WHERE
  Projno = 2;
SELECT
  EmpName as Emp_Name
FROM
  Employee
WHERE
  EmpName LIKE 'B%';
SELECT
  Empid
FROM
  WorksOn
WHERE
  Projno = 2;
-- create table employee(datte int);
  -- Drop database db_name;
  -- DELETE FROM Employee, Project, WorksOn;
DELETE FROM
  WorksOn;
DELETE FROM
  Employee;
DELETE FROM
  Project;
DROP TABLE Employee, Project, WorksOn;
DROP DATABASE SWCom;