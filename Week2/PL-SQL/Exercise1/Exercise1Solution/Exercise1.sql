CREATE DATABASE BankDB;
USE BankDB;

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

SELECT * FROM Customers;

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

CREATE PROCEDURE DiscountSeniorLoan()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE c_id INT;
    DECLARE l_id INT;
    DECLARE dob DATE;
    DECLARE i_rate DECIMAL(5,2);
    DECLARE cur CURSOR FOR 
        SELECT c.CustomerID, l.LoanID, c.DOB, l.InterestRate
        FROM Customers c
        JOIN Loans l ON c.CustomerID = l.CustomerID;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO c_id, l_id, dob, i_rate;
        IF done THEN 
            LEAVE read_loop;
        END IF;

        IF TIMESTAMPDIFF(YEAR, dob, CURDATE()) > 60 THEN
            UPDATE Loans
            SET InterestRate = InterestRate - 1
            WHERE LoanID = l_id;
        END IF;
    END LOOP;
    CLOSE cur;
END$$

DELIMITER ;

CALL DiscountSeniorLoan();

USE bankdb;

DELIMITER $$

CREATE PROCEDURE SetVIPStatus()
BEGIN
    UPDATE Customers
    SET IsVIP = TRUE
    WHERE Balance > 10000;
END$$

DELIMITER ;


CALL SetVIPStatus();


DELIMITER $$

CREATE PROCEDURE LoanReminders()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE cname VARCHAR(100);
    DECLARE due DATE;

    DECLARE cur CURSOR FOR
        SELECT c.Name, l.EndDate
        FROM Loans l
        JOIN Customers c ON l.CustomerID = c.CustomerID
        WHERE l.EndDate <= CURDATE() + INTERVAL 30 DAY;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO cname, due;
        IF done THEN 
            LEAVE read_loop;
        END IF;
        SELECT CONCAT("Reminder: ", cname, " your loan is due on ", due) AS Message;
    END LOOP;
    CLOSE cur;
END$$

DELIMITER ;

CALL LoanReminders();
