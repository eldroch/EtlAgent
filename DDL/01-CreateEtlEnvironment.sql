CREATE DATABASE ETL_Environment
GO

CREATE TABLE ETL_Environment.dbo.ETL_Environments_Dim
(
EnvironmentSK int IDENTITY(1,1) PRIMARY KEY
,EnvironmentName varchar(255)
,ControlDatabase varchar(255)
,LoadDttm datetime DEFAULT GetDate()
)

INSERT INTO ETL_Environment.dbo.ETL_Environments_Dim
(
EnvironmentName
,ControlDatabase
)
VALUES
(
'prod'
,'ETL_Control'
)

GO

CREATE DATABASE ETL_Control
GO

USE ETL_Control
GO

CREATE SCHEMA ctrl
GO