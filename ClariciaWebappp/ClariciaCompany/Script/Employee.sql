USE [ClariciaCompany]
GO

DROP TABLE IF EXISTS dbo.EMPLOYEE;
GO

CREATE TABLE dbo.EMPLOYEE
(
    [Fname]     VARCHAR(15) NOT NULL, 
    [Minit]     CHAR(1),    
    [Lname]     VARCHAR(15) NOT NULL,
    [Ssn]       CHAR(9)     NOT NULL,
    [Bdate]     DATE,
    [Address]   VARCHAR(30),
    [Sex]       CHAR(1),    
    [Salary]    DECIMAL(10,2),
    [Super_ssn] CHAR(9),
    [Dno]       INT         NOT NULL,
    CONSTRAINT PK_EMPLOYEE PRIMARY KEY(Ssn) 
);
GO

CREATE NONCLUSTERED INDEX IX_EMPLOYEE_Name ON dbo.EMPLOYEE ([Lname] ASC, [Fname] ASC);
GO

INSERT INTO EMPLOYEE (Fname, Minit, Lname, Ssn, Bdate, Address, Sex, Salary, Super_ssn, Dno)
VALUES 
(N'Oroc', N'5', N'Jaison', N'123456789', '2004-06-08', N'Upper Glad 1, MID, COT', N'M', 1000.00, N'123456789', 40);
GO

SELECT * FROM EMPLOYEE;
GO

UPDATE dbo.EMPLOYEE
SET Salary = 1000.00,
    Address = 'Midsayap, Cotabato' 
WHERE Ssn = '123456789';
GO

SELECT * FROM EMPLOYEE;
GO

DELETE FROM dbo.EMPLOYEE WHERE Ssn = '123456789';
GO

SELECT * FROM EMPLOYEE;
GO
