CREATE TABLE [dbo].[Department]
(
	Dname VARCHAR(15) NOT NULL , 
    Dnumber INT NOT NULL, 
    Mgr_ssn CHAR (9), 
    Mgr_start_date DATE NULL,

    Constraint [PK_Department_Dnumber] Primary key clustered (Dnumber),
    Constraint [UX_Department] Unique Nonclustered (Dname),
    Constraint [FK_Department_Employee] Foreign key (Mgr_ssn) REFERENCES Employee(Ssn)
);
GO

CREATE NONCLUSTERED INDEX [IX_Department_Dnumber_Dname] ON [dbo].[Department] ([Dname] ASC);
