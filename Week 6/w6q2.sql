DROP DATABASE IF EXISTS w6q2_bills;
CREATE DATABASE w6q2_bills;
USE w6q2_bills;

CREATE TABLE customer (
    ssn INT PRIMARY KEY,
    sname VARCHAR(20) NOT NULL,
    phone_num VARCHAR(20) NOT NULL,
    plan INT NOT NULL
);
INSERT INTO customer VALUES
    (1, 'Lelouch', '9014959259', 100),
    (2, 'Suzaku' , '9390499789', 500),
    (3, 'CC'     , '9398027105', 800);
    
CREATE TABLE bill (
    ssn INT,
    b_month INT,
    b_year INT,
    amount FLOAT,
    FOREIGN KEY (ssn) REFERENCES customer(ssn)
);
INSERT INTO bill VALUES
    (1, 4, 2014, 10000),
    (2, 9, 2015,  6000),
    (3, 6, 2014,  3000);



-- 2a) Adds +91 to all phone numbers as a prefix in the Customer Table

DELIMITER $$
CREATE TRIGGER trig
   BEFORE INSERT ON customer
   FOR EACH ROW
   BEGIN
   SET NEW.phone_num = CONCAT("+91", NEW.phone_num);
   END $$
DELIMITER ;

SELECT * FROM customer;

/* *\/
-- 2b) Updates bill after every call of customer
DELIMITER $$
CREATE TRIGGER phnbilling
    AFTER INSERT ON customer
    FOR EACH ROW
  BEGIN
     UPDATE bill 
       SET amount = amount + NEW.amount
       WHERE bill.ssn = NEW.ssn;
  END $$
DELIMITER ;
/**/

-- 2c) not insert bill older than 2020 (year > 2020)
DROP TRIGGER IF EXISTS phno_bill;
DELIMITER $$
CREATE TRIGGER phno_bill
     BEFORE INSERT ON bill
     FOR EACH ROW
   BEGIN
       IF NEW.b_year > 2020 THEN
         SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "error";
       END IF;
   END $$
DELIMITER ;


INSERT INTO customer VALUES (4, 'Shirley', '9182739829', 150);
INSERT INTO bill VALUES (4, 4, 2019, 100);