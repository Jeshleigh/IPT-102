CREATE PROCEDURE [dbo].[Employee_Read]
	
	@Search CHAR(9)

	AS 
	BEGIN

	SELECT
	*
	FROM [EMPLOYEE]
	WHERE

	[Ssn] like @Search or Fname like @Search or Minit like @Search or Lname like @Search or Bdate like @Search or Address like @Search or Sex like @Search 
	or Salary like @Search or Super_ssn like @Search or Dno like @Search


	END