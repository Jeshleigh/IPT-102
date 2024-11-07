CREATE TABLE [dbo].[Dept_Location]
(
	Dnumber INT NOT NULL , 
    DLocation VARCHAR(15) NOT NULL,
	Constraint [PK_Dept_Locations_Dnumber, PK_DLocation]PRIMARY KEY (Dnumber,DLocation),
	Constraint [FK_Dept_Locations_Dnumber]FOREIGN KEY (Dnumber) REFERENCES Department(Dnumber) 
);
GO

Create Nonclustered Index[IX_Dept_Locations_Dnumber] ON [Dept_Location] ( [Dlocation] ASC);
