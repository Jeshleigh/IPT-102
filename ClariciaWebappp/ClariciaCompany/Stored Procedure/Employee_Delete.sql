﻿CREATE PROCEDURE [dbo].[Delete]
	
	@Ssn CHAR(9)

	AS 
	BEGIN

	DELETE FROM [EMPLOYEE] WHERE Ssn = @Ssn
	END