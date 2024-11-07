CREATE PROCEDURE [dbo].[Employee_UPDATE]

@Fname VARCHAR(15),
@Minit CHAR,
@Lname VARCHAR(15),
@Ssn CHAR(9),
@Bdate  VARCHAR(50),
@Address VARCHAR(30),
@Sex CHAR,
@Salary DECIMAL(10,2),
@Super_ssn CHAR(9),
@Dno INT

AS 
BEGIN

UPDATE[EMPLOYEE]
set

Fname = @Fname,
Minit = @Minit,
Lname = @Lname,
Bdate = @Bdate,
Address = @Address,
Sex = @Sex,
Salary = @Salary,
Super_ssn = @Super_ssn,
Dno = @Dno 

WHERE Ssn = @Ssn

END