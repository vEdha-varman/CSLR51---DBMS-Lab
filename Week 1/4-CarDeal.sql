CREATE DATABASE CarDealers;
USE CarDealers;

CREATE TABLE Car (
	serial_no INT AUTO_INCREMENT PRIMARY KEY,
	model VARCHAR(25),
	manufacturer VARCHAR(25),
	price INTEGER
);
INSERT INTO car(model, manufacturer, price) VALUES 
	('Swift ZDI', 'Maruthi Suzuki', 7E5),
	('Sumo', 'Tata', 1E6),
	('Veyron', 'Bugatti', 1.3E8),
	('Portofino', 'Ferrari', 7.5E8)
	;

CREATE TABLE options (
	serial_no INTEGER,
	option_name VARCHAR(50),
	price INTEGER,
	FOREIGN KEY (serial_no) REFERENCES Car(serial_no)
);
INSERT INTO options VALUES 
	(1, 'Stepney Tyre', 7.3E3),
	(1, 'ABS Brakes', 7.5E3),
	(2, 'Stepney Tyre', 1.2E4),
	(2, 'Suspension', 1.4E4)
	;

CREATE TABLE salesperson (
	salesperson_id INT AUTO_INCREMENT PRIMARY KEY,
	salesperson_name VARCHAR(50),
	phone VARCHAR(16)
);
INSERT INTO salesperson (salesperson_name, phone) VALUES 
	('Woody Woodpecker', '1223334444'),
	('John', '1234567890'),
	('Kinji Ninomiya', '1000000000')
	;

CREATE TABLE sales (
	salesperson_id INT,
	serial_no INT,
	date_ofsale DATE,
	sale_price INTEGER,
	FOREIGN KEY (salesperson_id) REFERENCES salesperson(salesperson_id),
	FOREIGN KEY (serial_no) REFERENCES car(serial_no)
);
INSERT INTO sales VALUES 
	(1, 2, '2015-05-06', 1.2E7),
	(3, 2, '2014-04-10', 1.4E7),
	(2, 3, '2018-09-24', 1.35E8),
	(3, 1, '2017-12-30', 7.5E5),
	(2, 4, '2012-09-24', 7.6E8),
	(1, 1, '2016-10-01', 7.3E5)
	;

SELECT sales.serial_no, car.manufacturer, sale_price 
FROM sales, car, salesperson 
WHERE salesperson_name = 'John' 
	AND salesperson.salesperson_id = sales.salesperson_id
	AND sales.serial_no = car.serial_no
	;
SELECT DISTINCT car.serial_no, model 
FROM car, options 
WHERE car.serial_no NOT IN (
	SELECT DISTINCT options.serial_no 
	FROM options
	);
SELECT DISTINCT car.serial_no, model 
FROM car, options 
WHERE car.serial_no = options.serial_no
	;
UPDATE salesperson
SET phone = '1020304050'
WHERE salesperson_id = 2
	;

-- Verify whether relation table can exist after deleting the tables it relates
/** Verified, we have to delete the refercing column or all entries before deleting others */
DELETE FROM sales;
DELETE FROM options;
DELETE FROM car;
DELETE FROM salesperson;
DROP TABLE sales, options, car, salesperson;
DROP DATABASE CarDealers;