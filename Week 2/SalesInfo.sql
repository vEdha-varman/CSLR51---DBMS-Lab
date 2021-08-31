CREATE DATABASE sales;
USE sales;

CREATE TABLE purchase (
   ord_no  INT,
   purch_amt DOUBLE,
   ord_date  DATE,
   customer_id  INT,
   salesman_id INT
);
INSERT INTO purchase (ord_no,purch_amt,ord_date,customer_id,salesman_id) 
  VALUES
	( 70001,150.5,  "2012-10-05",3005,5002),
	(70009,270.65, "2012-09-10",3001,5005),
	(70002,65.26,  "2012-10-05",3002,5001),
	(70004,110.5,  "2012-08-17",3009,5003),
	(70007,948.5,  "2012-09-10",3005,5002),
	(70005,2400.6, "2012-07-27",3007,5001),
	(70008, 5760,  "2012-09-10",3002,5001),
	(70010,1983.43,"2012-10-10",3004,5006),
	(70003,2480.4, "2012-10-10",3009,5003),
	(70012,250.45, "2012-06-27",3008,5002),
	(70011,75.29,  "2012-08-17",3003,5007),
	(70013,3045.6, "2012-04-25",3002,5001)
    ;



SELECT MIN(purch_amt) 
  FROM purchase;
SELECT MAX(purch_amt) 
  FROM purchase;
SELECT SUM(purch_amt) 
  FROM purchase;
SELECT AVG(purch_amt) 
  FROM purchase;
SELECT COUNT(DISTINCT customer_id) 
  FROM purchase;
ALTER TABLE purchase 
	ADD warranty date ;
  UPDATE purchase 
    SET warranty = DATE_ADD(ord_date , INTERVAL 6 MONTH);
  SELECT * 
    FROM purchase;
(SELECT *
  FROM purchase 
    ORDER BY ord_date ASC 
    LIMIT 1) 
  UNION (
    SELECT *
      FROM purchase 
      ORDER BY ord_date DESC 
      LIMIT 1)
	;
SELECT DATE_ADD(ord_date, INTERVAL 1 DAY) AS next_day 
  FROM purchase ;
(SELECT FLOOR(purch_amt) 
	FROM purchase 
	ORDER BY purch_amt ASC LIMIT 1) 
  UNION (
    SELECT CEIL(purch_amt) 
      FROM purchase 
      ORDER BY purch_amt DESC 
      LIMIT 1)
	;
SELECT ROUND(purch_amt, 1) 
  FROM purchase;



DELETE FROM purchase;
DROP TABLE purchase;
DROP DATABASE sales;