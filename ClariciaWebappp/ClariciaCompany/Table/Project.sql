CREATE TABLE [dbo].[Project]
(
	Pname VARCHAR(15) NOT NULL , 
    Pnumber INT       NOT NULL, 
    Plocation VARCHAR(15), 
    Dnum INT           NOT NULL,
    Constraint [PK_Project_Pnumber] PRIMARY KEY (Pnumber),
    Constraint [FK_Project_Pname] UNIQUE        (Pname),
    Constraint [FK_Project_Pnumber]FOREIGN KEY (Dnum) REFERENCES Department(Dnumber)
);
GO

Create Nonclustered Index[IX_Project_Plocation] ON [Project] ([Plocation]ASC)
