CREATE DATABASE College;
USE College;
CREATE TABLE student (
  rno INT,
  sname VARCHAR(20) NOT NULL,
  m1 INT,
  m2 INT,
  m3 INT,
  m4 INT,
  m5 INT,
  m6 INT,
  total INT as (m1 + m2 + m3 + m4 + m5 + m6),
  PRIMARY KEY(rno)
);
INSERT INTO
  student (
    `rno`,
    `sname`,
    `m1`,
    `m2`,
    `m3`,
    `m4`,
    `m5`,
    `m6`
  )
VALUES
  (106119, 'Ravi', 89, 89, 98, 75, 80, 86),
  (106115, 'Kiran', 89, 89, 98, 75, 81, 86),
  (106118, 'Rakesh Kanna', 89, 89, 98, 77, 80, 86),
  (106125, 'Vamsi', 97, 95, 90, 93, 99, 91),
  (106114, 'Hemanth', 95, 96, 95, 96, 98, 97),
  (106116, 'Pavan', 92, 93, 94, 94, 93, 91),
  (106103, 'Durga Naik', 62, 72, 71, 80, 41, 51),
  (106122, 'Susender', 91, 50, 88, 48, 32, 64),
  (106121, 'Sundara Srinivasan', 82, 72, 64, 58, 62, 54),
  (106101, 'Raiden Baal', 100, 99, 89, 97, 96, 95);

CREATE TABLE dept (
  deptid INT PRIMARY KEY,
  deptname VARCHAR(20) NOT NULL,
  HOD VARCHAR(20)
);
INSERT INTO
  dept
VALUES
  (106, 'CSE', "Rajeswari Ma'aM"),
  (105, 'Meta', 'Shankar Sir'),
  (104, 'Prod', 'Karthik Sir')
  ;

CREATE TABLE stud_dept (
  rno INT,
  FOREIGN KEY (rno) REFERENCES student(rno),
  deptid INT,
  FOREIGN KEY (deptid) REFERENCES dept(deptid)
);
INSERT INTO
  stud_dept
VALUES
  (106119, 106),
  (106115, 106),
  (106118, 105),
  (106125, 106),
  (106114, 105),
  (106116, 104),
  (106103, 105),
  (106122, 104),
  (106121, 106),
  (106101, 106);


SELECT
  *
FROM
  student
WHERE
  rno IN (
    SELECT
      rno
    FROM
      stud_dept
    WHERE
      deptid = 105
  );
SELECT
  *
FROM
  dept
WHERE
  deptid IN (
    SELECT
      deptid
    FROM
      stud_dept
    WHERE
      rno = 106121
  );
SELECT
  sname
FROM
  student
WHERE
  total > 500;
SELECT
  HOD
FROM
  dept
WHERE
  deptname = 'CSE';
SELECT
  rno
FROM
  stud_dept
WHERE
  deptid IN (
    SELECT
      deptid
    FROM
      dept
    WHERE
      Deptname = 'CSE'
  );


DELETE FROM stud_dept;
DELETE FROM dept;
DELETE FROM student;
DROP TABLE stud_dept;
DROP TABLE dept;
DROP TABLE student;
DROP DATABASE college;