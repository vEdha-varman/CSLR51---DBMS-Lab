CREATE DATABASE Travels;
USE Travels;

CREATE TABLE salesperson (
	ssn INT PRIMARY KEY,
	salesperson_name VARCHAR(50),
	start_year INT, -- YEAR can be used, check range
	dept_no INTEGER
);
INSERT INTO salesperson 
VALUES (1000, 'Kinji Ninomiya',2000,1),
	(2000, 'Maou Sadao',2001,02),
	(3000, "Steve Jobs",2004,001)
	;

CREATE TABLE trip (
	ssn INT,
	from_city VARCHAR(50),
	to_city VARCHAR(50),
	departure_date DATE,
	return_date DATE,
	trip_id INT AUTO_INCREMENT,
	PRIMARY KEY (trip_id),
	FOREIGN KEY (ssn) REFERENCES salesperson(ssn)
);
INSERT INTO trip (ssn, from_city, to_city, departure_date, return_date)
VALUES (1000,'Trichy','Chennai','2001-04-04','2001-04-14'),
	(2000, 'Chennai', 'Time Travel', '2002-04-08', '2000-04-08'),
	(3000,'Mumbai', 'Kolkata', '2013-08-12',  '2013-08-16'),
	(2000,'Hyderabad', 'Bangalore', '2012-04-11', '2012-04-18'),
	(1000,'Delhi', 'Chennai', '2013-08-12',  '2013-08-16')
	;

CREATE TABLE salerep_expense (
	trip_id INT,
	expense_type ENUM('TRAVEL','STAY','FOOD'),
	amount INTEGER,
	FOREIGN KEY (trip_id) REFERENCES trip(trip_id)
);
INSERT INTO salerep_expense
VALUES (1, 'TRAVEL', 14E3),
	(2, 'TRAVEL', 1E3),
	(2, 'STAY', 500),
	(2, 'FOOD', 499),
	(3, 'TRAVEL', 12E3),
	(3, 'STAY', 4E3),
	(3, 'FOOD', 2400)
	;

SELECT trip.* 
FROM trip
WHERE trip.trip_id IN (
	SELECT DISTINCT(trip_id)
	FROM salerep_expense
	GROUP BY trip_id
	HAVING SUM(amount) > 2000
);
SELECT ssn 
FROM trip 
WHERE to_city = 'Chennai'
GROUP BY ssn
HAVING COUNT(to_city) >1
;
SELECT *
FROM salesperson
WHERE ssn = 1000;
;
SELECT * 
FROM salesperson
ORDER BY salesperson_name;

DELETE FROM salerep_expense;
DELETE FROM trip;
DELETE FROM salesperson;
DROP TABLE salerep_expense;
DROP TABLE trip;
DROP TABLE salesperson;
DROP DATABASE Travels;