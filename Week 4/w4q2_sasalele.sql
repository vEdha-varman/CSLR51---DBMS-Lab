CREATE DATABASE Sasalele;
USE sasalele;

CREATE TABLE Salesman (
  salesman_id INT PRIMARY KEY,
  sname VARCHAR(25) NOT NULL,
  city VARCHAR(21) NOT NULL,
  commission FLOAT(3,2) NOT NULL
);
INSERT INTO Salesman VALUES
  (5001, 'James Hoog', 'New York', 0.15),
  (5002, 'Nail Knite', 'Paris'   , 0.13),
  (5005, 'Pit Alex'  , 'London'  , 0.11),
  (5006, 'Mc Lyon'   , 'Paris'   , 0.14),
  (5007, 'Paul Adam' , 'Rome'    , 0.13),
  (5003, 'Lauson Hen', 'San Jose', 0.12);

CREATE TABLE Customer (
  customer_id INT PRIMARY KEY,
  cust_name VARCHAR(25) NOT NULL,
  city VARCHAR(20) NOT NULL,
  grade INT NOT NULL,
  salesman_id INT,
  FOREIGN KEY (salesman_id) REFERENCES salesman(salesman_id)
);
INSERT INTO Customer VALUES
  (3002, 'Nick Rimando'  , 'New York' , 100, 5001),
  (3007, 'Brad Davis'    , 'New York' , 200, 5001),
  (3005, 'Graham Zusi'   , 'Califonia', 200, 5002),
  (3008, 'Julian Green'  , 'London'   , 300, 5002),
  (3004, 'Fabian Johnson', 'Paris'    , 300, 5006),
  (3009, 'Geoff Cameron' , 'Berlin'   , 100, 5003),
  (3003, 'Jozy Altidor'  , 'Moscow'   , 200, 5007),
  (3001, 'Brad Guzan'    , 'London'   , 300, 5005);

CREATE TABLE Orders (
  ord_no INT PRIMARY KEY,
  purch_amt FLOAT(6,2) NOT NULL,
  ord_date DATE NOT NULL,
  customer_id INT NOT NULL,
  FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
  salesman_id INT NOT NULL,
  FOREIGN KEY (salesman_id) REFERENCES salesman(salesman_id)
);
INSERT INTO Orders VALUES
	(70001,  150.5 , '2012-10-05', 3005, 5002),
	(70009,  270.65, '2012-09-10', 3001, 5005),
	(70002,   65.26, '2012-10-05', 3002, 5001),
	(70004,  110.5 , '2012-08-17', 3009, 5003),
	(70007,  948.5 , '2012-09-10', 3005, 5002),
	(70005, 2400.6 , '2012-07-27', 3007, 5001),
	(70008, 5760   , '2012-09-10', 3002, 5001),
	(70010, 1983.43, '2012-10-10', 3004, 5006),
	(70003, 2480.4 , '2012-10-10', 3009, 5003),
	(70012,  250.45, '2012-06-27', 3008, 5002),
	(70011,   75.29, '2012-08-17', 3003, 5007),
	(70013, 3045.6 , '2012-04-25', 3002, 5001);


-- 2a) From the table, create a view to count the number of customers in each grade. 
CREATE VIEW grade_count (grade, count)
AS SELECT grade, COUNT(*)
FROM customer
GROUP BY grade;

SELECT * from grade_count;


-- 2b) From the following table, create a view to count the number of unique 
-- customer, compute average and total purchase amount of customer orders by 
-- each date. 
CREATE VIEW total_by_date
AS SELECT ord_date, COUNT(DISTINCT customer_id),
AVG(purch_amt), SUM(purch_amt)
FROM orders
GROUP BY ord_date;

SELECT * FROM total_by_date;


-- 2c) Create a view to get the salesperson and customer by name. Return order 
-- name, purchase amount, salesperson ID, name, customer name.
CREATE VIEW order_details
AS SELECT ord_no, purch_amt, a.salesman_id, sname, cust_name
FROM orders a, customer b, salesman c
WHERE a.customer_id = b.customer_id
AND a.salesman_id = c.salesman_id;

SELECT * FROM order_details;


-- 2d) Create a view to find the salespersons who issued orders on October 10th, 
-- 2012. Return all the fields of salesperson.
CREATE VIEW salesman_oct_10
AS SELECT *
FROM salesman
WHERE salesman_id IN
    (SELECT salesman_id
         FROM orders
         WHERE ord_date = '2012-10-10');
         
SELECT * FROM salesman_oct_10;




DELETE FROM Orders;
DELETE FROM Customer;
DELETE FROM Salesman;
DROP TABLE Customer, Salesman, Orders;
DROP DATABASE Sasalele;