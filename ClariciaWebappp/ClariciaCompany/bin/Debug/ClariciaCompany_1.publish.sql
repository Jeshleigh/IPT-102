﻿/*
Deployment script for ClariciaCompany

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "ClariciaCompany"
:setvar DefaultFilePrefix "ClariciaCompany"
:setvar DefaultDataPath "C:\Users\ASUS\AppData\Local\Microsoft\Microsoft SQL Server Local DB\Instances\MSSQLLocalDB\"
:setvar DefaultLogPath "C:\Users\ASUS\AppData\Local\Microsoft\Microsoft SQL Server Local DB\Instances\MSSQLLocalDB\"

GO
:on error exit
GO
/*
Detect SQLCMD mode and disable script execution if SQLCMD mode is not supported.
To re-enable the script after enabling SQLCMD mode, execute the following:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'SQLCMD mode must be enabled to successfully execute this script.';
        SET NOEXEC ON;
    END


GO
USE [master];


GO

IF (DB_ID(N'$(DatabaseName)') IS NOT NULL) 
BEGIN
    ALTER DATABASE [$(DatabaseName)]
    SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE [$(DatabaseName)];
END

GO
PRINT N'Creating database $(DatabaseName)...'
GO
CREATE DATABASE [$(DatabaseName)]
    ON 
    PRIMARY(NAME = [$(DatabaseName)], FILENAME = N'$(DefaultDataPath)$(DefaultFilePrefix)_Primary.mdf')
    LOG ON (NAME = [$(DatabaseName)_log], FILENAME = N'$(DefaultLogPath)$(DefaultFilePrefix)_Primary.ldf') COLLATE SQL_Latin1_General_CP1_CI_AS
GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CLOSE OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
USE [$(DatabaseName)];


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ANSI_NULLS ON,
                ANSI_PADDING ON,
                ANSI_WARNINGS ON,
                ARITHABORT ON,
                CONCAT_NULL_YIELDS_NULL ON,
                NUMERIC_ROUNDABORT OFF,
                QUOTED_IDENTIFIER ON,
                ANSI_NULL_DEFAULT ON,
                CURSOR_DEFAULT LOCAL,
                CURSOR_CLOSE_ON_COMMIT OFF,
                AUTO_CREATE_STATISTICS ON,
                AUTO_SHRINK OFF,
                AUTO_UPDATE_STATISTICS ON,
                RECURSIVE_TRIGGERS OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ALLOW_SNAPSHOT_ISOLATION OFF;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET READ_COMMITTED_SNAPSHOT OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_UPDATE_STATISTICS_ASYNC OFF,
                PAGE_VERIFY NONE,
                DATE_CORRELATION_OPTIMIZATION OFF,
                DISABLE_BROKER,
                PARAMETERIZATION SIMPLE,
                SUPPLEMENTAL_LOGGING OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET TRUSTWORTHY OFF,
        DB_CHAINING OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'The database settings cannot be modified. You must be a SysAdmin to apply these settings.';
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET HONOR_BROKER_PRIORITY OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'The database settings cannot be modified. You must be a SysAdmin to apply these settings.';
    END


GO
ALTER DATABASE [$(DatabaseName)]
    SET TARGET_RECOVERY_TIME = 0 SECONDS 
    WITH ROLLBACK IMMEDIATE;


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET FILESTREAM(NON_TRANSACTED_ACCESS = OFF),
                CONTAINMENT = NONE 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CREATE_STATISTICS ON(INCREMENTAL = OFF),
                MEMORY_OPTIMIZED_ELEVATE_TO_SNAPSHOT = OFF,
                DELAYED_DURABILITY = DISABLED 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE (QUERY_CAPTURE_MODE = ALL, DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_PLANS_PER_QUERY = 200, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 367), MAX_STORAGE_SIZE_MB = 100) 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE = OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET TEMPORAL_HISTORY_RETENTION ON 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF fulltextserviceproperty(N'IsFulltextInstalled') = 1
    EXECUTE sp_fulltext_database 'enable';


GO
PRINT N'Creating Table [dbo].[Department]...';


GO
CREATE TABLE [dbo].[Department] (
    [Dname]          VARCHAR (15) NOT NULL,
    [Dnumber]        INT          NOT NULL,
    [Mgr_ssn]        CHAR (9)     NULL,
    [Mgr_start_date] DATE         NULL,
    CONSTRAINT [PK_Department_Dnumber] PRIMARY KEY CLUSTERED ([Dnumber] ASC),
    CONSTRAINT [UX_Department] UNIQUE NONCLUSTERED ([Dname] ASC)
);


GO
PRINT N'Creating Index [dbo].[Department].[IX_Department_Dnumber_Dname]...';


GO
CREATE NONCLUSTERED INDEX [IX_Department_Dnumber_Dname]
    ON [dbo].[Department]([Dname] ASC);


GO
PRINT N'Creating Table [dbo].[Dependent]...';


GO
CREATE TABLE [dbo].[Dependent] (
    [Essn]           CHAR (9)     NOT NULL,
    [Dependent_name] VARCHAR (15) NOT NULL,
    [Sex]            CHAR (1)     NULL,
    [Bdate]          DATE         NULL,
    [Relationship]   VARCHAR (8)  NULL,
    CONSTRAINT [PK_Department] PRIMARY KEY CLUSTERED ([Essn] ASC, [Dependent_name] ASC)
);


GO
PRINT N'Creating Index [dbo].[Dependent].[IX_Dependent_Sex]...';


GO
CREATE NONCLUSTERED INDEX [IX_Dependent_Sex]
    ON [dbo].[Dependent]([Sex] ASC);


GO
PRINT N'Creating Table [dbo].[Dept_Location]...';


GO
CREATE TABLE [dbo].[Dept_Location] (
    [Dnumber]   INT          NOT NULL,
    [DLocation] VARCHAR (15) NOT NULL,
    CONSTRAINT [PK_Dept_Locations_Dnumber, PK_DLocation] PRIMARY KEY CLUSTERED ([Dnumber] ASC, [DLocation] ASC)
);


GO
PRINT N'Creating Index [dbo].[Dept_Location].[IX_Dept_Locations_Dnumber]...';


GO
CREATE NONCLUSTERED INDEX [IX_Dept_Locations_Dnumber]
    ON [dbo].[Dept_Location]([DLocation] ASC);


GO
PRINT N'Creating Table [dbo].[Employee]...';


GO
CREATE TABLE [dbo].[Employee] (
    [Fname]     VARCHAR (15)    NOT NULL,
    [Minit]     CHAR (1)        NULL,
    [Lname]     VARCHAR (15)    NOT NULL,
    [Ssn]       CHAR (9)        NOT NULL,
    [Bdate]     DATE            NULL,
    [Address]   VARCHAR (30)    NULL,
    [Sex]       CHAR (1)        NULL,
    [Salary]    DECIMAL (10, 2) NULL,
    [Super_ssn] CHAR (1)        NULL,
    [Dno]       INT             NOT NULL,
    CONSTRAINT [PK_Employee_Ssn] PRIMARY KEY CLUSTERED ([Ssn] ASC)
);


GO
PRINT N'Creating Table [dbo].[Project]...';


GO
CREATE TABLE [dbo].[Project] (
    [Pname]     VARCHAR (15) NOT NULL,
    [Pnumber]   INT          NOT NULL,
    [Plocation] VARCHAR (15) NULL,
    [Dnum]      INT          NOT NULL,
    CONSTRAINT [PK_Project_Pnumber] PRIMARY KEY CLUSTERED ([Pnumber] ASC),
    CONSTRAINT [FK_Project_Pname] UNIQUE NONCLUSTERED ([Pname] ASC)
);


GO
PRINT N'Creating Index [dbo].[Project].[IX_Project_Plocation]...';


GO
CREATE NONCLUSTERED INDEX [IX_Project_Plocation]
    ON [dbo].[Project]([Plocation] ASC);


GO
PRINT N'Creating Table [dbo].[Works_on]...';


GO
CREATE TABLE [dbo].[Works_on] (
    [Essn]  CHAR (9)       NOT NULL,
    [Pno]   INT            NOT NULL,
    [Hours] DECIMAL (3, 1) NOT NULL,
    CONSTRAINT [PK_Works_On] PRIMARY KEY CLUSTERED ([Essn] ASC, [Pno] ASC)
);


GO
PRINT N'Creating Index [dbo].[Works_On].[IX_Works_On_Hours]...';


GO
CREATE NONCLUSTERED INDEX [IX_Works_On_Hours]
    ON [dbo].[Works_on]([Hours] ASC);


GO
PRINT N'Creating Foreign Key [dbo].[FK_Department_Employee]...';


GO
ALTER TABLE [dbo].[Department]
    ADD CONSTRAINT [FK_Department_Employee] FOREIGN KEY ([Mgr_ssn]) REFERENCES [dbo].[Employee] ([Ssn]);


GO
PRINT N'Creating Foreign Key [dbo].[FK_Department]...';


GO
ALTER TABLE [dbo].[Dependent]
    ADD CONSTRAINT [FK_Department] FOREIGN KEY ([Essn]) REFERENCES [dbo].[Employee] ([Ssn]);


GO
PRINT N'Creating Foreign Key [dbo].[FK_Dept_Locations_Dnumber]...';


GO
ALTER TABLE [dbo].[Dept_Location]
    ADD CONSTRAINT [FK_Dept_Locations_Dnumber] FOREIGN KEY ([Dnumber]) REFERENCES [dbo].[Department] ([Dnumber]);


GO
PRINT N'Creating Foreign Key [dbo].[FK_Project_Pnumber]...';


GO
ALTER TABLE [dbo].[Project]
    ADD CONSTRAINT [FK_Project_Pnumber] FOREIGN KEY ([Dnum]) REFERENCES [dbo].[Department] ([Dnumber]);


GO
PRINT N'Creating Foreign Key [dbo].[FK_Works_On_Employee]...';


GO
ALTER TABLE [dbo].[Works_on]
    ADD CONSTRAINT [FK_Works_On_Employee] FOREIGN KEY ([Essn]) REFERENCES [dbo].[Employee] ([Ssn]);


GO
PRINT N'Creating Foreign Key [dbo].[FK_Works_On_Pnumber]...';


GO
ALTER TABLE [dbo].[Works_on]
    ADD CONSTRAINT [FK_Works_On_Pnumber] FOREIGN KEY ([Pno]) REFERENCES [dbo].[Project] ([Pnumber]);


GO
PRINT N'Creating Procedure [dbo].[Create]...';


GO
CREATE PROCEDURE [dbo].[Create]
	
	@Fname VARCHAR(15),
	@Minit CHAR,
	@Lname VARCHAR(15),
	@Ssn CHAR(9),
	@Bdate VARCHAR(50),
	@Address VARCHAR(30),
	@Sex CHAR,
	@Salary DECIMAL(10,2),
	@Super_ssn CHAR(9),
	@Dno INT

	AS
	BEGIN

	INSERT [EMPLOYEE]

	(
	Fname,
	Minit,
	Lname,
	Ssn,
	Bdate,
	Address,
	Sex,
	Salary,
	Super_ssn,
	Dno
	)

	VALUES

	(
	@Fname,
	@Minit,
	@Lname,
	@Ssn,
	@Bdate,
	@Address,
	@Sex,
	@Salary,
	@Super_ssn,
	@Dno
	)

	END
GO
PRINT N'Creating Procedure [dbo].[Delete]...';


GO
CREATE PROCEDURE [dbo].[Delete]
	
	@Ssn CHAR(9)

	AS 
	BEGIN

	DELETE FROM [EMPLOYEE] WHERE Ssn = @Ssn
	END
GO
PRINT N'Creating Procedure [dbo].[Employee_Read]...';


GO
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
GO
PRINT N'Creating Procedure [dbo].[Employee_UPDATE]...';


GO
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
GO
DECLARE @VarDecimalSupported AS BIT;

SELECT @VarDecimalSupported = 0;

IF ((ServerProperty(N'EngineEdition') = 3)
    AND (((@@microsoftversion / power(2, 24) = 9)
          AND (@@microsoftversion & 0xffff >= 3024))
         OR ((@@microsoftversion / power(2, 24) = 10)
             AND (@@microsoftversion & 0xffff >= 1600))))
    SELECT @VarDecimalSupported = 1;

IF (@VarDecimalSupported > 0)
    BEGIN
        EXECUTE sp_db_vardecimal_storage_format N'$(DatabaseName)', 'ON';
    END


GO
PRINT N'Update complete.';


GO