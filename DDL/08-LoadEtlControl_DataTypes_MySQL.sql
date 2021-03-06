INSERT INTO [ETL_Control].[ctrl].[ETL_DataTypes_Dim]
(
[DataTypeName]
,[DataTypeMaxLength]
,[DataSourceTypeSK]
,[MasterDataTypeSK]
,[DefaultValue]
,[ActiveFlag]
)
VALUES
('int','4', (SELECT DataSourceTypeSK FROM ctrl.ETL_DataSourceTypes_Dim WHERE DataSourceTypeName = 'MySQL'),NULL,NULL,'Y')
,('tinyint','1', (SELECT DataSourceTypeSK FROM ctrl.ETL_DataSourceTypes_Dim WHERE DataSourceTypeName = 'MySQL'),NULL,NULL,'Y')
,('smallint','2', (SELECT DataSourceTypeSK FROM ctrl.ETL_DataSourceTypes_Dim WHERE DataSourceTypeName = 'MySQL'),NULL,NULL,'Y')
,('mediumint','3', (SELECT DataSourceTypeSK FROM ctrl.ETL_DataSourceTypes_Dim WHERE DataSourceTypeName = 'MySQL'),NULL,NULL,'Y')
,('integer','4', (SELECT DataSourceTypeSK FROM ctrl.ETL_DataSourceTypes_Dim WHERE DataSourceTypeName = 'MySQL'),NULL,NULL,'Y')
,('bigint','8', (SELECT DataSourceTypeSK FROM ctrl.ETL_DataSourceTypes_Dim WHERE DataSourceTypeName = 'MySQL'),NULL,NULL,'Y')
,('float','24', (SELECT DataSourceTypeSK FROM ctrl.ETL_DataSourceTypes_Dim WHERE DataSourceTypeName = 'MySQL'),NULL,NULL,'Y')
,('double','53', (SELECT DataSourceTypeSK FROM ctrl.ETL_DataSourceTypes_Dim WHERE DataSourceTypeName = 'MySQL'),NULL,NULL,'Y')
,('decimal','17', (SELECT DataSourceTypeSK FROM ctrl.ETL_DataSourceTypes_Dim WHERE DataSourceTypeName = 'MySQL'),NULL,NULL,'Y')
,('date','3', (SELECT DataSourceTypeSK FROM ctrl.ETL_DataSourceTypes_Dim WHERE DataSourceTypeName = 'MySQL'),NULL,NULL,'Y')
,('datetime','8', (SELECT DataSourceTypeSK FROM ctrl.ETL_DataSourceTypes_Dim WHERE DataSourceTypeName = 'MySQL'),NULL,NULL,'Y')
,('timestamp','8', (SELECT DataSourceTypeSK FROM ctrl.ETL_DataSourceTypes_Dim WHERE DataSourceTypeName = 'MySQL'),NULL,NULL,'Y')
,('time','5', (SELECT DataSourceTypeSK FROM ctrl.ETL_DataSourceTypes_Dim WHERE DataSourceTypeName = 'MySQL'),NULL,NULL,'Y')
,('year','4', (SELECT DataSourceTypeSK FROM ctrl.ETL_DataSourceTypes_Dim WHERE DataSourceTypeName = 'MySQL'),NULL,NULL,'Y')
,('char','255', (SELECT DataSourceTypeSK FROM ctrl.ETL_DataSourceTypes_Dim WHERE DataSourceTypeName = 'MySQL'),NULL,NULL,'Y')
,('varchar','255', (SELECT DataSourceTypeSK FROM ctrl.ETL_DataSourceTypes_Dim WHERE DataSourceTypeName = 'MySQL'),NULL,NULL,'Y')
,('blob','65535', (SELECT DataSourceTypeSK FROM ctrl.ETL_DataSourceTypes_Dim WHERE DataSourceTypeName = 'MySQL'),NULL,NULL,'Y')
,('text','65535', (SELECT DataSourceTypeSK FROM ctrl.ETL_DataSourceTypes_Dim WHERE DataSourceTypeName = 'MySQL'),NULL,NULL,'Y')
,('tinyblob','255', (SELECT DataSourceTypeSK FROM ctrl.ETL_DataSourceTypes_Dim WHERE DataSourceTypeName = 'MySQL'),NULL,NULL,'Y')
,('tinytext','255', (SELECT DataSourceTypeSK FROM ctrl.ETL_DataSourceTypes_Dim WHERE DataSourceTypeName = 'MySQL'),NULL,NULL,'Y')
,('mediumblob','16777215', (SELECT DataSourceTypeSK FROM ctrl.ETL_DataSourceTypes_Dim WHERE DataSourceTypeName = 'MySQL'),NULL,NULL,'Y')
,('mediumtext','16777215', (SELECT DataSourceTypeSK FROM ctrl.ETL_DataSourceTypes_Dim WHERE DataSourceTypeName = 'MySQL'),NULL,NULL,'Y')
,('longblob','4294967295', (SELECT DataSourceTypeSK FROM ctrl.ETL_DataSourceTypes_Dim WHERE DataSourceTypeName = 'MySQL'),NULL,NULL,'Y')
,('longtext','4294967295', (SELECT DataSourceTypeSK FROM ctrl.ETL_DataSourceTypes_Dim WHERE DataSourceTypeName = 'MySQL'),NULL,NULL,'Y')
,('enum',NULL, (SELECT DataSourceTypeSK FROM ctrl.ETL_DataSourceTypes_Dim WHERE DataSourceTypeName = 'MySQL'),NULL,NULL,'Y')

