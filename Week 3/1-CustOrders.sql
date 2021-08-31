CREATE DATABASE w3q1_orders;
USE w3q1_orders;
CREATE TABLE Salesman(
  salesman_id int,
  sname varchar(50),
  city varchar(50),
  commission float
);
INSERT INTO
  Salesman(salesman_id, sname, city, commission)
VALUES
  (5001, 'James Hoog', 'New York', 0.15),
  (5002, 'Nail Knite', 'Paris', 0.13),
  (5005, 'Pit Alex', 'London', 0.11),
  (5006, 'Mc Lyon', 'Paris', 0.14),
  (5007, 'Paul Adam', 'Rome', 0.13),
  (5003, 'Lauson Hen', 'San Jose', 0.12);
CREATE TABLE Customer(
    customer_id int,
    cust_name varchar(50),
    city varchar(25),
    grade int,
    salesman_id int
  );
INSERT INTO
  Customer(customer_id, cust_name, city, grade, salesman_id)
VALUES
  (3002, 'Nick Rimando', 'New York', 100, 5001),
  (3007, 'Brad Davis', 'New York', 200, 5001),
  (3005, 'Graham Zusi', 'California', 200, 5002),
  (3008, 'Julian Green', 'London', 300, 5002),
  (3004, 'Fabian Johnson', 'Paris', 300, 5006),
  (3009, 'Geoff Cameron', 'Berlin', 100, 5003),
  (3003, 'Jozy Altidor', 'Moscow', 200, 5007),
  (3001, 'Brad Guzan', 'London', 300, 5005);
CREATE TABLE Orders(
    ord_no int,
    purch_amt double,
    ord_date date,
    salesman_id int,
    customer_id int
  );
INSERT INTO
  Orders(
    ord_no,
    purch_amt,
    ord_date,
    customer_id,
    salesman_id
  )
VALUES
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
  /*SELECT
    *
  FROM
    Orders; */
  -- 1a , commission > 12%
SELECT
  Customer.cust_name AS "Customer Name",
  Customer.city,
  Salesman.sname AS "Salesman",
  Salesman.commission
FROM
  Customer
  INNER JOIN Salesman ON Customer.salesman_id = Salesman.salesman_id
WHERE
  Salesman.commission > .12;
-- 1b
SELECT
  Customer.cust_name,
  Customer.city,
  Orders.ord_no,
  Orders.ord_date,
  Orders.purch_amt AS "Order Amount"
FROM
  Customer
  LEFT OUTER JOIN Orders ON Customer.customer_id = Orders.customer_id
order by
  Orders.ord_date;
-- 1c
SELECT
  Customer.cust_name,
  Customer.city,
  Orders.ord_no,
  Orders.ord_date,
  Orders.purch_amt AS "Order Amount",
  Salesman.sname,
  Salesman.commission
FROM
  Customer
  LEFT OUTER JOIN Orders ON Customer.customer_id = Orders.customer_id
  LEFT OUTER JOIN Salesman ON Salesman.salesman_id = Orders.salesman_id;
-- 1d
SELECT
  Customer.cust_name,
  Customer.city,
  Customer.grade,
  Salesman.sname AS "Salesman",
  Salesman.city
FROM
  Customer
  RIGHT OUTER JOIN Salesman ON Salesman.salesman_id = Customer.salesman_id
ORDER BY
  Salesman.salesman_id;
-- 1e
SELECT
  *
FROM
  Salesman
  CROSS JOIN Customer
  -- WHERE Customer.salesman_id = Salesman.salesman_id
  ;
-- 1f
SELECT
  *
FROM
  Salesman
  CROSS JOIN Customer
WHERE
  Salesman.city = Customer.city;
-- 1g
SELECT
  Customer.cust_name,
  Customer.city,
  Customer.grade,
  Salesman.sname AS "Salesman",
  Orders.ord_no,
  Orders.ord_date,
  Orders.purch_amt
FROM
  Customer
  RIGHT OUTER JOIN Salesman ON Salesman.salesman_id = Customer.salesman_id
  LEFT OUTER JOIN Orders ON Orders.customer_id = Customer.customer_id
WHERE
  Orders.purch_amt >= 2000
  AND Customer.grade IS NOT NULL;



DELETE FROM Orders;
DELETE FROM Customer;
DELETE FROM Salesman;
DROP TABLE Salesman, Customer, Orders;
DROP DATABASE w3q1_orders;