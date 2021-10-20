DROP DATABASE IF EXISTS w5q2_sasalele;
CREATE DATABASE w5q2_sasalele;
USE w5q2_sasalele;

CREATE TABLE Customer(
	customer_id int,
	cust_name varchar(50),
	city varchar(25),
	grade int,
	salesman_id int
);
INSERT INTO Customer(customer_id, cust_name, city, grade, salesman_id) VALUES
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
INSERT INTO Orders(ord_no,purch_amt,ord_date,customer_id,salesman_id) VALUES
	(70001, 150.5, '2012-10-05', 3005, 5002),
	(70009, 270.65, '2012-09-10', 3001, 5005),
	(70002, 65.26, '2012-10-05', 3002, 5001),
	(70004, 110.5, '2012-08-17', 3009, 5003),
	(70007, 948.5, '2012-09-10', 3005, 5002),
	(70005, 2400.6, '2012-07-27', 3007, 5001),
	(70008, 5760, '2012-09-10', 3002, 5001),
	(70010, 1983.43, '2012-10-10', 3004, 5006),
	(70003, 2480.4, '2012-10-10', 3009, 5003),
	(70012, 250.45, '2012-06-27', 3008, 5002),
	(70011, 75.29, '2012-08-17', 3003, 5007),
	(70013, 3045.6, '2012-04-25', 3002, 5001);



-- 2a) Use SQL functions to find the highest purchaseamount ordered by each customer with theirID and highest purchase amount.
DELIMITER //
CREATE FUNCTION max_purch_amt(c_id int)
RETURNS DECIMAL(10,2) DETERMINISTIC
BEGIN
  DECLARE max_amt DECIMAL(10,2);
  SELECT MAX(purch_amt) INTO max_amt FROM Orders WHERE customer_id = c_id;
  RETURN max_amt;
END //
DELIMITER ;
SELECT customer_id, max_purch_amt(customer_id) FROM Orders GROUP BY customer_id;

-- 2b) Use SQL functions to find the number of customers in each city
DELIMITER //
DROP FUNCTION IF EXISTS cust_per_city//
CREATE FUNCTION cust_per_city(city_name VARCHAR(20))
RETURNS INT DETERMINISTIC
BEGIN
  DECLARE CNT INT;
  -- SET CNT = 0;
  SELECT COUNT(*) INTO CNT FROM Customer WHERE city = city_name;
  RETURN CNT;
END //
DELIMITER ;
SELECT city, cust_per_city(city) FROM Customer GROUP BY city;

-- 2c) Write a user defined function to display customer details given the customer_id.
DELIMITER //
DROP PROCEDURE IF EXISTS disp_cust_info //
CREATE PROCEDURE disp_cust_info(IN customer_id_in INT)
BEGIN
    SELECT * FROM Customer WHERE customer_id = customer_id_in;
END //
DELIMITER ;
CALL disp_cust_info(3002);

-- 2d) Write a user defined function to decrease the purch_amt of an order by 5% given the ord_no.
DELIMITER //
DROP FUNCTION IF EXISTS dec_purch_amt //
CREATE FUNCTION dec_purch_amt(orderno INT)
RETURNS DOUBLE DETERMINISTIC
BEGIN
  DECLARE purch_amt_new DOUBLE;
  SELECT purch_amt INTO purch_amt_new FROM Orders WHERE ord_no = orderno;
  RETURN (purch_amt_new * 0.95);
END //
DELIMITER ;
UPDATE Orders SET purch_amt = dec_purch_amt(ord_no) WHERE ord_no = 70001;
SELECT * FROM Orders;

-- DROP DATABASE w5q2_sasalele;