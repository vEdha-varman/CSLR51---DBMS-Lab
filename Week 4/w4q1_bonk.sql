CREATE DATABASE w4q1_Bonk;
USE w4q1_Bonk;

CREATE TABLE branch (
  branch_name VARCHAR(255) PRIMARY KEY,
  branch_city VARCHAR (255) NOT NULL,
  assets INT NOT NULL
);
INSERT INTO branch (branch_name, branch_city, assets) VALUES
	("Brighton"  , "Brooklyn"  , 71E6),
	("Downtown"  , "Brooklyn"  , 90E5),
	("Mianus"    , "Horseneck" ,  4E5),
	("North Town", "Rye"       , 37E5),
	("Perryridge", "Horseneck" , 17E5),
	("Pownal"    , "Bennington",  3E5),
	("Redwood"   , "Palo Alto" , 21E5),
	("Round Hill", "Horseneck" , 80E5);

CREATE TABLE customer (
  customer_name VARCHAR(255) PRIMARY KEY,
  customer_street VARCHAR(255) NOT NULL,
  customer_city VARCHAR(255) NOT NULL
);
INSERT INTO customer (customer_name, customer_street, customer_city) VALUES
	("Adams"   , "Spring"   , "Pittsfield"),
	("Brooks"  , "Senator"  , "Brooklyn"  ),
	("Curry"   , "North"    , "Rye"       ),
	("Glenn"   , "Sand Hill", "Woodside"  ),
	("Green"   , "Walnut"   , "Stamford"  ),
	("Hayes"   , "Main"     , "Harrison"  ),
	("Johnson" , "Alma"     , "Palo Alto" ),
	("Jones"   , "Main"     , "Harrison"  ),
	("Lindsay" , "Park"     , "Pittsfield"),
	("Smith"   , "North"    , "Rye"       ),
	("Turner"  , "Putnam"   , "Stamford"  ),
	("Jackson" , "East"     , "Downtown"  ),
    ("Williams", "West"     , "Downtown"  );

-- Seems like `account` can be used as variable 
-- and is not actually a keyword
CREATE TABLE accounts (
  account_number VARCHAR(255) PRIMARY KEY,
  branch_name VARCHAR(255) NOT NULL,
  balance INT NOT NULL,
  FOREIGN KEY (branch_name) REFERENCES branch(branch_name),
  CHECK (account_number REGEXP '^A\-[1-9][0-9]*$')
);
INSERT INTO accounts (account_number, branch_name, balance) VALUES
	("A-101", "Downtown"  , 500),
	("A-102", "Perryridge", 400),
	("A-201", "Brighton"  , 900),
	("A-215", "Mianus"    , 700),
	("A-217", "Brighton"  , 750),
	("A-222", "Redwood"   , 700),
	("A-305", "Round Hill", 350);

CREATE TABLE loan (
  loan_number VARCHAR(255) PRIMARY KEY,
  branch_name VARCHAR(255) NOT NULL,
  amount INT NOT NULL,
  FOREIGN KEY (branch_name) REFERENCES branch(branch_name),
  CHECK (loan_number REGEXP '^L\-\[1-9][0-9]*$')
);
INSERT INTO loan (loan_number, branch_name, amount) VALUES
	("L-11", "Round Hill",  900),
	("L-14", "Downtown"  , 1500),
	("L-15", "Perryridge", 1500),
	("L-16", "Perryridge", 1300),
	("L-17", "Downtown"  , 1000),
	("L-23", "Redwood"   , 2000),
	("L-93", "Mianus"    ,  500);

CREATE TABLE depositor(
  customer_name VARCHAR(255) NOT NULL,
  account_number VARCHAR(255) NOT NULL,
  FOREIGN KEY (customer_name) REFERENCES customer(customer_name),
  FOREIGN KEY (account_number) REFERENCES accounts(account_number)
);
INSERT INTO depositor (customer_name, account_number) VALUES
	("Hayes"  , "A-102"),
	("Jackson", "A-101"),
	("Johnson", "A-201"),
	("Jones"  , "A-217"),
	("Lindsay", "A-222"),
	("Smith"  , "A-215"),
	("Turner" , "A-305");

CREATE TABLE borrower(
  loan_number VARCHAR(255) NOT NULL,
  customer_name VARCHAR(255) NOT NULL,
  FOREIGN KEY (loan_number) REFERENCES loan(loan_number),
  FOREIGN KEY (customer_name) REFERENCES customer(customer_name)
);
INSERT INTO borrower (customer_name, loan_number) VALUES
	("Adams"   , "L-16"),
	("Curry"   , "L-93"),
	("Hayes"   , "L-15"),
	("Jackson" , "L-14"),
	("Jones"   , "L-17"),
	("Smith"   , "L-11"),
	("Smith"   , "L-23"),
	("Williams", "L-17");


-- 1a) Create a view consisting of branch names and the names of customers who have either 
-- an account or a loan at that branch. Assume that view to be called all-customer.
CREATE VIEW all_customer AS 
SELECT branch_name, customer_name
FROM depositor, accounts
WHERE depositor.account_number = accounts.account_number
UNION
(SELECT branch_name , customer_name
FROM borrower , loan 
WHERE borrower.loan_number = loan.loan_number);
-- For Output
SELECT * FROM all_customer;

-- 1b) Create  a  view  gives  for  each  branch  the  sum  of  the amounts  of  all  the  loans  at the branch
CREATE VIEW sum_of_loans AS
SELECT branch_name , SUM(amount)
FROM loan
GROUP BY branch_name;
-- For Output
SELECT * FROM sum_Of_Loans;

-- 1c) Using the view all-customer, we can find all customersof the Perryridgebranch
SELECT customer_name
FROM all_customer
WHERE branch_name = "Perryridge";

-- 1d Write a Query for below Relational algebraic notation :
SELECT depositor.customer_name 
FROM depositor
UNION
(SELECT  borrower.customer_name 
FROM borrower);


DELETE FROM customers;
DROP TABLE depositor;
DROP DATABASE w4q1_bonk;