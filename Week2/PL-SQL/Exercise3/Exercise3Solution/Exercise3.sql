CREATE DATABASE BankDataBase;
USE BankDataBase;

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(100),
    DOB DATE,
    Balance DECIMAL(10,2),
    LastModified DATE,
    IsVIP BOOLEAN DEFAULT FALSE
);

CREATE TABLE Accounts (
    AccountID INT PRIMARY KEY,
    CustomerID INT,
    AccountType VARCHAR(20),
    Balance DECIMAL(10,2),
    LastModified DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE Loans (
    LoanID INT PRIMARY KEY,
    CustomerID INT,
    LoanAmount DECIMAL(10,2),
    InterestRate DECIMAL(5,2),
    StartDate DATE,
    EndDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(100),
    Position VARCHAR(50),
    Salary DECIMAL(10,2),
    Department VARCHAR(50),
    HireDate DATE
);

INSERT INTO Customers VALUES (1, 'John Doe', '1950-01-01', 12000, CURDATE(), FALSE);
INSERT INTO Customers VALUES (2, 'Jane Smith', '1990-05-10', 8000, CURDATE(), FALSE);

INSERT INTO Loans VALUES (1, 1, 5000, 6.5, CURDATE(), DATE_ADD(CURDATE(), INTERVAL 20 DAY));
INSERT INTO Loans VALUES (2, 2, 3000, 5.0, CURDATE(), DATE_ADD(CURDATE(), INTERVAL 40 DAY));

INSERT INTO Accounts VALUES (1, 1, 'Savings', 1000, CURDATE());
INSERT INTO Accounts VALUES (2, 2, 'Checking', 1500, CURDATE());

INSERT INTO Employees VALUES (1, 'Alice', 'Manager', 70000, 'HR', '2010-05-15');
INSERT INTO Employees VALUES (2, 'Bob', 'Developer', 60000, 'IT', '2018-04-10');

SELECT * FROM Customers;
SELECT * FROM Loans;
SELECT * FROM Accounts;
SELECT * FROM Employees;

DELIMITER $$

CREATE PROCEDURE ProcessMonthlyInterest()
BEGIN
    UPDATE Accounts
    SET Balance = Balance + (Balance * 0.01)
    WHERE AccountType = 'Savings';
END$$

DELIMITER ;

CALL ProcessMonthlyInterest();  

DELIMITER $$

CREATE PROCEDURE UpdateEmployeeBonus(IN dept VARCHAR(50), IN bonus DECIMAL(5,2))
BEGIN
    UPDATE Employees
    SET Salary = Salary + (Salary * bonus / 100)
    WHERE Department = dept;
END$$

DELIMITER ;

CALL UpdateEmployeeBonus('HR', 10);  


DELIMITER $$

CREATE PROCEDURE TransferFunds(IN fromID INT, IN toID INT, IN amt DECIMAL(10,2))
BEGIN
    DECLARE bal DECIMAL(10,2);
    
    SELECT Balance INTO bal FROM Accounts WHERE AccountID = fromID;

    IF bal >= amt THEN
        UPDATE Accounts SET Balance = Balance - amt WHERE AccountID = fromID;
        UPDATE Accounts SET Balance = Balance + amt WHERE AccountID = toID;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Insufficient funds!';
    END IF;
END$$

DELIMITER ;


CALL TransferFunds(1, 2, 500);
