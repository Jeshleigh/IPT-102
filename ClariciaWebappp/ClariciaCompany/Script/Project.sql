USE [ClariciaCompany]
GO

DROP TABLE IF EXISTS dbo.PROJECT;
GO

CREATE TABLE dbo.PROJECT
(
    [Pname]     VARCHAR(15) NOT NULL,
    [Pnumber]   INT         NOT NULL,
    [Plocation] VARCHAR(15),
    [Dnum]      INT         NOT NULL,
    CONSTRAINT PK_PROJECT PRIMARY KEY (Pnumber),
    CONSTRAINT UI_PROJECT_Pname UNIQUE (Pname)
);
GO

CREATE NONCLUSTERED INDEX IX_PROJECT_Plocation ON dbo.PROJECT ([Plocation] ASC);
GO

INSERT INTO PROJECT (Pname, Pnumber, Plocation, Dnum)
VALUES 
(N'TECHVOC', 22, N'Mid, Cot', 34);  
GO

SELECT * FROM PROJECT;
GO

UPDATE dbo.PROJECT
SET Plocation = 'NEW LOCATION',  
    Dnum = 40  
WHERE Pnumber = 22;  
GO

SELECT * FROM PROJECT;
GO

DELETE FROM dbo.PROJECT WHERE Pnumber = 22;  
GO

SELECT * FROM PROJECT;
GO

-- LEFT JOIN between DEPARTMENT and PROJECT
SELECT D.Dname, D.Dnumber, P.Pname, P.Plocation
FROM dbo.DEPARTMENT D
LEFT JOIN dbo.PROJECT P
ON D.Dnumber = P.Dnum;
GO

-- RIGHT JOIN between DEPARTMENT and PROJECT
SELECT D.Dname, D.Dnumber, P.Pname, P.Plocation
FROM dbo.DEPARTMENT D
RIGHT JOIN dbo.PROJECT P
ON D.Dnumber = P.Dnum;
GO

-- CROSS JOIN between DEPARTMENT and PROJECT
SELECT D.Dname, D.Dnumber, P.Pname, P.Plocation
FROM dbo.DEPARTMENT D
CROSS JOIN dbo.PROJECT P;
GO
