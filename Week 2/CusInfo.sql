CREATE DATABASE Customer;
USE Customer;

CREATE TABLE CustInfo (
	CustId VARCHAR(5) PRIMARY KEY,
	CustName VARCHAR(25),
	CustAdd VARCHAR(50),
	Phone BIGINT(10),
    Email VARCHAR(25),
    CHECK (CustId like "C%"),
    CHECK (Email like "%@%")
);

INSERT INTO CustInfo
  VALUES
	("C0001", "AmitSaha", "L-10, Pitampura", 4564587852, "amitsaha2@gmail.com"),
    ("C0002", "Rehnuma", "J-12, SAKET", 5527688761, "rehnuma@hotmail.com"),
    ("C0003", "CharviNayyar", "10/9, FF, Rohini", 6811635425, "charvi123@yahoo.com"),
    ("C0004", "Gurpreet", "A-10/2, SF, MayurVihar", 3511056125, "gur_singh@yahoo.com")
	;

SELECT LOWER(CustName), UPPER(Email) 
  FROM CustInfo;
SELECT TRIM(TRAILING '.com' FROM Email) AS Trimmed_Email
  FROM CustInfo;
SELECT CustName, LENGTH(CustName) AS Length_CustName
  FROM CustInfo;
SELECT CONCAT(CustId, CustName) AS IdName, 
	POSITION('A' in CustName) AS PosA
  FROM CustInfo;
SELECT * 
  FROM CustInfo
  WHERE CustName LIKE '%a';
SELECT SUBSTR(Email, 2, 3) AS d_Email
  FROM CustInfo;
SELECT SUBSTRING(CustAdd, 1, 20) AS d_CustAdd
  FROM CustInfo;



DELETE FROM CustInfo;
DROP TABLE CustInfo;
DROP DATABASE Customer;