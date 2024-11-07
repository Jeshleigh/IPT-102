CREATE TABLE [dbo].[Works_on]
(
	Essn CHAR(9) NOT NULL , 
    Pno INT NOT NULL, 
    Hours DECIMAL(3, 1) NOT NULL
   
   Constraint [PK_Works_On] Primary KEY (Essn,Pno),
    Constraint [FK_Works_On_Employee] Foreign Key(Essn) References dbo.Employee(Ssn),
    Constraint [FK_Works_On_Pnumber]Foreign Key (Pno) References dbo.Project(Pnumber)
);
go

Create Nonclustered Index[IX_Works_On_Hours] On [Works_On] ([Hours] ASC)
