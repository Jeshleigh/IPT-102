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
:setvar DefaultDataPath "C:\Users\ASUS\AppData\Local\Microsoft\VisualStudio\SSDT\"
:setvar DefaultLogPath "C:\Users\ASUS\AppData\Local\Microsoft\VisualStudio\SSDT\"

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
USE [$(DatabaseName)];


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ARITHABORT ON,
                CONCAT_NULL_YIELDS_NULL ON,
                CURSOR_DEFAULT LOCAL 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET PAGE_VERIFY NONE,
                DISABLE_BROKER 
            WITH ROLLBACK IMMEDIATE;
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
            SET QUERY_STORE (QUERY_CAPTURE_MODE = ALL, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 367), MAX_STORAGE_SIZE_MB = 100) 
            WITH ROLLBACK IMMEDIATE;
    END


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
ALTER TABLE [dbo].[Department] WITH NOCHECK
    ADD CONSTRAINT [FK_Department_Employee] FOREIGN KEY ([Mgr_ssn]) REFERENCES [dbo].[Employee] ([Ssn]);


GO
PRINT N'Creating Foreign Key [dbo].[FK_Department]...';


GO
ALTER TABLE [dbo].[Dependent] WITH NOCHECK
    ADD CONSTRAINT [FK_Department] FOREIGN KEY ([Essn]) REFERENCES [dbo].[Employee] ([Ssn]);


GO
PRINT N'Creating Foreign Key [dbo].[FK_Dept_Locations_Dnumber]...';


GO
ALTER TABLE [dbo].[Dept_Location] WITH NOCHECK
    ADD CONSTRAINT [FK_Dept_Locations_Dnumber] FOREIGN KEY ([Dnumber]) REFERENCES [dbo].[Department] ([Dnumber]);


GO
PRINT N'Creating Foreign Key [dbo].[FK_Project_Pnumber]...';


GO
ALTER TABLE [dbo].[Project] WITH NOCHECK
    ADD CONSTRAINT [FK_Project_Pnumber] FOREIGN KEY ([Dnum]) REFERENCES [dbo].[Department] ([Dnumber]);


GO
PRINT N'Creating Foreign Key [dbo].[FK_Works_On_Employee]...';


GO
ALTER TABLE [dbo].[Works_on] WITH NOCHECK
    ADD CONSTRAINT [FK_Works_On_Employee] FOREIGN KEY ([Essn]) REFERENCES [dbo].[Employee] ([Ssn]);


GO
PRINT N'Creating Foreign Key [dbo].[FK_Works_On_Pnumber]...';


GO
ALTER TABLE [dbo].[Works_on] WITH NOCHECK
    ADD CONSTRAINT [FK_Works_On_Pnumber] FOREIGN KEY ([Pno]) REFERENCES [dbo].[Project] ([Pnumber]);


GO
PRINT N'Checking existing data against newly created constraints';


GO
USE [$(DatabaseName)];


GO
ALTER TABLE [dbo].[Department] WITH CHECK CHECK CONSTRAINT [FK_Department_Employee];

ALTER TABLE [dbo].[Dependent] WITH CHECK CHECK CONSTRAINT [FK_Department];

ALTER TABLE [dbo].[Dept_Location] WITH CHECK CHECK CONSTRAINT [FK_Dept_Locations_Dnumber];

ALTER TABLE [dbo].[Project] WITH CHECK CHECK CONSTRAINT [FK_Project_Pnumber];

ALTER TABLE [dbo].[Works_on] WITH CHECK CHECK CONSTRAINT [FK_Works_On_Employee];

ALTER TABLE [dbo].[Works_on] WITH CHECK CHECK CONSTRAINT [FK_Works_On_Pnumber];


GO
PRINT N'Update complete.';


GO