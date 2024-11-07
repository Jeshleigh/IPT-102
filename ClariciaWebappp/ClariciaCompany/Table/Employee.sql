CREATE TABLE [dbo].[Employee]
(
	[Fname] VARCHAR(15) NOT NULL , 
    Minit   CHAR        NULL, 
    Lname   VARCHAR(15) NOT NULL, 
    Ssn     CHAR(9)        NOT NULL, 
    Bdate    DATE       NULL, 
    [Address] VARCHAR(30) NULL, 
    Sex       CHAR NULL, 
    Salary    DECIMAL(10, 2) NULL, 
    Super_ssn CHAR           NULL, 
    Dno       INT        NOT NULL,
    CONSTRAINT [PK_Employee_Ssn] PRIMARY KEY(Ssn)
)
GO
