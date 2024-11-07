CREATE TABLE [dbo].[Dependent]
(
	[Essn] CHAR(9) NOT NULL , 
    Dependent_name VARCHAR(15) NOT NULL, 
    Sex CHAR NULL, 
    Bdate DATE NULL, 
    Relationship VARCHAR(8)NULL,

    Constraint [PK_Department] Primary Key (Essn, Dependent_name),
    Constraint [FK_Department] Foreign  Key (Essn) REFERENCES Employee(Ssn)
);
GO

CREATE NONCLUSTERED INDEX[IX_Dependent_Sex] ON [Dependent] ([Sex] ASC);

