
sp_MSforeachtable @command1='DROP TABLE ?'

/*********************************
/ ETL Control tables
/
**********************************/

CREATE TABLE ctrl.ETL_Tables_Dim
(
TableSK int IDENTITY(1,1) PRIMARY KEY
,TableName varchar(255) NOT NULL
,TableSchema varchar(50) NOT NULL
,SrcObjectName varchar(255) NOT NULL
,SrcSchemaName varchar(255) NULL
,DataSourceSK int NOT NULL
,LoadFrequency varchar(255) NOT NULL
,TableType varchar(50) NOT NULL
,LoadType varchar(50) NOT NULL
,ExtractType varchar(50) NOT NULL
,CustomReplicationFlag char(1) DEFAULT 'N' NOT NULL
,DeleteTrackingFlag char(1) DEFAULT 'N' NOT NULL
,DeleteHandling varchar(255) NULL --('Flag','Physical Delete')
,IDTrackingFlag char(1) NOT NULL
,ActiveFlag char(1) DEFAULT 'Y' NOT NULL
,LoadDttm datetime DEFAULT GetDate() NOT NULL
)

CREATE TABLE ctrl.ETL_TablesEXT_Dim
(
TableSK int PRIMARY KEY
,GpLoadHost varchar(255) DEFAULT 'pr-etl1.ad.mhsil.com' NOT NULL
,LoadDttm datetime DEFAULT GetDate() NOT NULL
)


CREATE TABLE ctrl.ETL_TableExtractLogic_Fact --For incremental extracts, the logic to construct the extracts goes here
(
ExtractLogicSK int IDENTITY(1,1) PRIMARY KEY
,TableSK int NOT NULL
,ExtractString varchar(MAX) NOT NULL
,FilterString varchar(MAX) NULL
,ActiveFlag char(1) DEFAULT 'Y' NOT NULL
,LoadDttm datetime DEFAULT GetDate() NOT NULL
)

CREATE TABLE ctrl.ETL_Columns_Dim
(
ColumnSK int IDENTITY(1,1) PRIMARY KEY
,TableSK int NOT NULL
,SourceCodeSetSK int NULL
,ColumnName varchar(255) NOT NULL
,PKFlag char(1) DEFAULT 'N' NOT NULL
,DataTypeSK int NOT NULL
,ColumnMaxLength int NULL
,ColumnScale int NULL
,SequenceNumber int NOT NULL
,ContainsNullsFlag char(1) DEFAULT 'N' NOT NULL
,ContainsNonprintablesFlag char(1) DEFAULT 'N' NOT NULL
,CDCEnabledFlag char(1) DEFAULT 'Y' NOT NULL
,ActiveFlag char(1) DEFAULT 'Y' NOT NULL
,LoadDttm datetime DEFAULT GetDate() NOT NULL
)

CREATE TABLE ctrl.ETL_ColumnsEXT_Dim
(
ColumnSK int IDENTITY(1,1)
,PreserveNonprintablesFlag char(1) DEFAULT 'N' NOT NULL
,LoadDttm datetime DEFAULT GetDate() NOT NULL
)

CREATE TABLE ctrl.ETL_DataSources_Dim
(
DataSourceSK int IDENTITY(1,1) PRIMARY KEY
,DataSourceName varchar(255) NOT NULL
,DataSourceTypeSK int NOT NULL
,DefaultSchema varchar(255) NOT NULL
,DriverString varchar(255) NULL
,HostString varchar(255) NOT NULL
,DbString varchar(255) NULL
,LoginString varchar(255) NULL
,PasswordString varchar(255) NULL
,AccessMethod varchar(50) NOT NULL
,ActiveFlag char(1) DEFAULT 'Y' NOT NULL
,LoadDttm datetime DEFAULT GetDate() NOT NULL
)



/*********************************
/ Queue Processing tables
/
**********************************/


CREATE TABLE ctrl.ETL_TableDependencies_Fact
(
TableDependencySK int IDENTITY(1,1) PRIMARY KEY
,TableQueueSK int NOT NULL
,ContingentTableQueueSK int NOT NULL
,ActiveFlag char(1) DEFAULT 'Y' NOT NULL
,LoadDttm datetime DEFAULT GetDate() NOT NULL
)

CREATE TABLE ctrl.ETL_TableQueueControl_Dim
(
TableQueueSK int IDENTITY(1,1) PRIMARY KEY
,TableSK int NOT NULL
,QueueSK int NOT NULL
,OrderSequence int NOT NULL
,ActiveFlag char(1) DEFAULT 'Y' NOT NULL
,LoadDttm datetime DEFAULT GetDate() NOT NULL
)

CREATE TABLE ctrl.ETL_Batches_Fact
(
BatchSK int IDENTITY(1,1) PRIMARY KEY
,BatchProfileSK int
,BatchDescription varchar(255)
,BatchStatus varchar(50)
,BatchCreatedDttm datetime
,BatchScheduledStartDttm datetime
,BatchActualStartDttm datetime
,BatchActualEndDttm datetime
,PriorityCode int
,QueuedCount bigint
,ProcessingCount bigint
,CompletedCount bigint
,ErrorCount bigint
,NotificationList varchar(MAX)
,LoadDttm datetime DEFAULT GetDate()
)

CREATE TABLE ctrl.ETL_BatchProfileItems_Fact
(
BatchProfileItemSK int IDENTITY(1,1) PRIMARY KEY
,BatchProfileSK int
,TableName varchar(255)
,TableSchema varchar(255)
,QueueName varchar(255)
,FilterCriteria varchar(MAX)
,LoadDttm datetime DEFAULT GetDate()
)

CREATE TABLE ctrl.ETL_BatchProfiles_Dim
(
BatchProfileSK int IDENTITY(1,1) PRIMARY KEY
,BatchDescription varchar(255)
,LoadFrequency varchar(255)
,PriorityCode int
,NotificationList varchar(MAX)
,BatchProfileEnabledFlag char(1) DEFAULT 'N'
,EffectiveDttm datetime
,ExpirationDttm datetime
,LoadDttm datetime DEFAULT GetDate()
)

CREATE TABLE ctrl.ETL_QueuedTasks_Fact
(
QueuedTaskSK int IDENTITY(1,1) PRIMARY KEY
,BatchSK int NOT NULL
,TableQueueSK int NOT NULL
,QueuedDttm datetime DEFAULT GetDate() NOT NULL
,ExecutingFlag char(1) DEFAULT 'N' NOT NULL
,ExecutedFlag char(1) DEFAULT 'N' NOT NULL
,ExecuteStartDttm datetime NULL
,ExecuteEndDttm datetime NULL
,ErrorCount int DEFAULT 0 NOT NULL
,TableQueueSequenceNumber int
,BatchTableSequenceNumber int
,LoadDttm datetime DEFAULT GetDate() NOT NULL
)

CREATE TABLE ctrl.ETL_QueuedTaskMessages_Fact
(
QueuedTaskMessageSK int IDENTITY(1,1) PRIMARY KEY
,QueuedTaskSK int NOT NULL
,MessageString varchar(MAX) NOT NULL
,ErrorFlag char(1) DEFAULT 'N' NOT NULL
,LoadDttm datetime DEFAULT GetDate() NOT NULL
)

CREATE TABLE ctrl.ETL_ErrorMessages_Fact
(
ErrorMessageSK int IDENTITY(1,1) PRIMARY KEY
,ErrorProcessName varchar(255) NOT NULL
,ErrorDesc varchar(255) NOT NULL
,ErrorMessage varchar(MAX) NOT NULL

,LoadDttm datetime DEFAULT GetDate() NOT NULL
)

/*********************************
/ Load Monitor tables
/
**********************************/

CREATE TABLE ctrl.ETL_LoadMonitors_Dim
(
LoadMonitorSK int IDENTITY(1,1) PRIMARY KEY
,LoadMonitorName varchar(255) NOT NULL
,MonitorSrc varchar(MAX) NOT NULL
,ExecuteCondition varchar(MAX) NOT NULL  --SQL statement that returns an int.  0 = don't execute; >0 = execute
,NotificationGroupList varchar(MAX) NOT NULL
,HeaderMessage varchar(MAX)
,FooterMessage varchar(MAX)
,ActiveFlag char(1) DEFAULT 'Y' NOT NULL
,LoadDttm datetime DEFAULT GetDate() NOT NULL
)

CREATE TABLE ctrl.ETL_LoadMonitorMessages_Fact
(
MessageSK int IDENTITY(1,1) PRIMARY KEY
,LoadMonitorSK int NOT NULL
,ToLine varchar(MAX) NOT NULL
,SubjectLine varchar(MAX) NOT NULL
,EmailBody varchar(MAX) NOT NULL
,MsgPriority varchar(50) NOT NULL
,SentFlag char(1) DEFAULT 'N' NOT NULL
,SentDttm datetime NULL
,LoadDttm datetime DEFAULT GetDate()
)

CREATE TABLE ctrl.ETL_LoadMonitorNotificationMappings_Fact
(
LoadMonitorNotificationMappingSK int IDENTITY(1,1) PRIMARY KEY
,LoadMonitorSK int NOT NULL
,NotificationGroupSK int NOT NULL
,ActiveFlag char(1) DEFAULT 'Y' NOT NULL
,LoadDttm datetime DEFAULT GetDate() NOT NULL
)

CREATE TABLE ctrl.ETL_NotificationGroups_Dim
(
NotificationGroupSK int IDENTITY(1,1) PRIMARY KEY
,NotificationGroupName varchar(255) NOT NULL
,Notes varchar(MAX) NULL
,ActiveFlag char(1) DEFAULT 'Y' NOT NULL
,LoadDttm datetime DEFAULT GetDate() NOT NULL
)

CREATE TABLE ctrl.ETL_NotificationGroupMappings_Fact
(
NotificationGroupMappingSK int IDENTITY(1,1) PRIMARY KEY
,NotificationGroupSK int NOT NULL
,UserSK int NOT NULL
,ActiveFlag char(1) DEFAULT 'Y' NOT NULL
,LoadDttm datetime DEFAULT GetDate() NOT NULL
)


/*********************************
/ Support tables
/
**********************************/

CREATE TABLE ctrl.ETL_DataSourceTypes_Dim
(
DataSourceTypeSK int IDENTITY(1,1) PRIMARY KEY
,DataSourceTypeName varchar(255) NOT NULL
,DefaultAccessMethod varchar(50) NOT NULL
,ActiveFlag char(1) DEFAULT 'Y' NOT NULL
,LoadDttm datetime DEFAULT GetDate() NOT NULL
)

CREATE TABLE ctrl.ETL_Drivers_Dim
(
DriverSK int IDENTITY(1,1) PRIMARY KEY
,DriverString varchar(255)
,DataSourceTypeSK int
,DriverType varchar(50)
,ActiveFlag char(1) DEFAULT 'Y' NOT NULL
,LoadDttm datetime DEFAULT GetDate() NOT NULL
)

CREATE TABLE ctrl.ETL_DataTypes_Dim
(
DataTypeSK int IDENTITY(1,1) PRIMARY KEY
,DataTypeName varchar(255) NOT NULL
,DataTypeMaxLength bigint NULL
,DataSourceTypeSK int
,MasterDataTypeSK int NULL
,DefaultValue varchar(MAX)
,ActiveFlag char(1) DEFAULT 'Y' NOT NULL
,LoadDttm datetime DEFAULT GetDate() NOT NULL
)

CREATE TABLE ctrl.ETL_Queues_Dim
(
QueueSK int IDENTITY(1,1) PRIMARY KEY
,QueueName varchar(255) NOT NULL
,DefaultOrderSequence int NOT NULL
,ActiveFlag char(1) DEFAULT 'Y' NOT NULL
,LoadDttm datetime DEFAULT GetDate() NOT NULL
)

CREATE TABLE ctrl.ETL_Parameters_Dim
(
ParameterSK int IDENTITY(1,1) PRIMARY KEY
,ParameterName varchar(MAX) NOT NULL
,ParameterValue varchar(MAX) NOT NULL
,ParameterContext varchar(255) NOT NULL
,ContextObjectIdentifier varchar(255) NOT NULL
,ActiveFlag char(1) DEFAULT 'Y' NOT NULL
,LoadDttm datetime DEFAULT GetDate() NOT NULL
)

CREATE TABLE ctrl.ETL_Users_Dim
(
UserSK int IDENTITY(1,1) PRIMARY KEY
,UserName varchar(255) NOT NULL
,EmailAddress varchar(MAX) NULL
,PhoneNumber varchar(50) NULL
,UserType varchar(255) NULL
,AccessLevel varchar(255) NULL
,ActiveFlag char(1) DEFAULT 'Y' NOT NULL
,LoadDttm datetime DEFAULT GetDate() NOT NULL
)

/*********************************
/ Source Code mastering tables
/
**********************************/

CREATE TABLE ctrl.MST_SourceCodeSets_Dim
(
SourceCodeSetSK int IDENTITY(1,1) PRIMARY KEY
,DataSourceSK int NOT NULL
,SourceCodeSetName varchar(255) NOT NULL

,ActiveFlag char(1) DEFAULT 'Y' NOT NULL
,LoadDttm datetime DEFAULT GetDate() NOT NULL
)

CREATE TABLE ctrl.MST_SourceCodes_Dim
(
SourceCodeSK int IDENTITY(1,1) PRIMARY KEY
,SourceCodeSetSK int NOT NULL
,SourceCodeValue varchar(MAX) NOT NULL
,SourceCodeDesc varchar(MAX) NOT NULL
,CleanCodeValue varchar(MAX) NOT NULL
,CleanCodeDesc varchar(MAX) NOT NULL
,ActiveFlag char(1) DEFAULT 'Y' NOT NULL
,LoadDttm datetime DEFAULT GetDate() NOT NULL
)

CREATE TABLE ctrl.MST_SourceCodeExtract_Fact
(
SourceCodeExtractSK int IDENTITY(1,1) PRIMARY KEY
,SourceCodeSetSK int NOT NULL
,FromClause varchar(MAX) NOT NULL
,WhereClause varchar(MAX) NOT NULL
,ActiveFlag char(1) DEFAULT 'Y' NOT NULL
,LoadDttm datetime DEFAULT GetDate() NOT NULL
)