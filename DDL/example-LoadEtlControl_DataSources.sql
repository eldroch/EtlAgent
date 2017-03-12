INSERT INTO ctrl.ETL_DataSources_Dim
(
DataSourceName
,DataSourceTypeSK
,DefaultSchema
,DriverString
,HostString
,DbString
,LoginString
,PasswordString
,AccessMethod
)
VALUES
('BigBrother',1,'bb','{SQL Server Native Client 11.0}','CRASH','BigBrother','etl_sa','<password>','BCP')
,('Budget',1,'budget','{SQL Server Native Client 11.0}','CRASH','Budget','etl_sa','<password>','BCP')
,('RecipeDB',1,'rcp','{SQL Server Native Client 11.0}','CRASH','RecipeDB','etl_sa','<password>','BCP')
