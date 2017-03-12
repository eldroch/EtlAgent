

INSERT INTO ctrl.ETL_DataTypes_Dim
(
DataTypeName 
,DataTypeMaxLength
,DataSourceTypeSK
,MasterDataTypeSK
,DefaultValue
)
VALUES
(
'char'
,8000
,(SELECT DataSourceTypeSK FROM ctrl.ETL_DataSourceTypes_Dim WHERE DataSourceTypeName = 'MS SQL Server')
,NULL
,NULL
)
,(
'varchar'
,1073741824
,(SELECT DataSourceTypeSK FROM ctrl.ETL_DataSourceTypes_Dim WHERE DataSourceTypeName = 'MS SQL Server')
,NULL
,NULL
)
,(
'text'
,2000000000
,(SELECT DataSourceTypeSK FROM ctrl.ETL_DataSourceTypes_Dim WHERE DataSourceTypeName = 'MS SQL Server')
,NULL
,NULL
)
,(
'nchar'
,4000
,(SELECT DataSourceTypeSK FROM ctrl.ETL_DataSourceTypes_Dim WHERE DataSourceTypeName = 'MS SQL Server')
,NULL
,NULL
)
,(
'nvarchar'
,536870912
,(SELECT DataSourceTypeSK FROM ctrl.ETL_DataSourceTypes_Dim WHERE DataSourceTypeName = 'MS SQL Server')
,NULL
,NULL
)
,(
'ntext'
,2000000000
,(SELECT DataSourceTypeSK FROM ctrl.ETL_DataSourceTypes_Dim WHERE DataSourceTypeName = 'MS SQL Server')
,NULL
,NULL
)
,(
'bit'
,1
,(SELECT DataSourceTypeSK FROM ctrl.ETL_DataSourceTypes_Dim WHERE DataSourceTypeName = 'MS SQL Server')
,NULL
,NULL
)
,(
'binary'
,8000
,(SELECT DataSourceTypeSK FROM ctrl.ETL_DataSourceTypes_Dim WHERE DataSourceTypeName = 'MS SQL Server')
,NULL
,NULL
)
,(
'varbinary'
,2000000000
,(SELECT DataSourceTypeSK FROM ctrl.ETL_DataSourceTypes_Dim WHERE DataSourceTypeName = 'MS SQL Server')
,NULL
,NULL
)
,(
'image'
,2000000000
,(SELECT DataSourceTypeSK FROM ctrl.ETL_DataSourceTypes_Dim WHERE DataSourceTypeName = 'MS SQL Server')
,NULL
,NULL
)
,(
'tinyint'
,1
,(SELECT DataSourceTypeSK FROM ctrl.ETL_DataSourceTypes_Dim WHERE DataSourceTypeName = 'MS SQL Server')
,NULL
,NULL
)
,(
'smallint'
,2
,(SELECT DataSourceTypeSK FROM ctrl.ETL_DataSourceTypes_Dim WHERE DataSourceTypeName = 'MS SQL Server')
,NULL
,NULL
)
,(
'int'
,4
,(SELECT DataSourceTypeSK FROM ctrl.ETL_DataSourceTypes_Dim WHERE DataSourceTypeName = 'MS SQL Server')
,NULL
,NULL
)
,(
'bigint'
,8
,(SELECT DataSourceTypeSK FROM ctrl.ETL_DataSourceTypes_Dim WHERE DataSourceTypeName = 'MS SQL Server')
,NULL
,NULL
)
,(
'decimal'
,17
,(SELECT DataSourceTypeSK FROM ctrl.ETL_DataSourceTypes_Dim WHERE DataSourceTypeName = 'MS SQL Server')
,NULL
,NULL
)
,(
'numeric'
,17
,(SELECT DataSourceTypeSK FROM ctrl.ETL_DataSourceTypes_Dim WHERE DataSourceTypeName = 'MS SQL Server')
,NULL
,NULL
)
,(
'smallmoney'
,4
,(SELECT DataSourceTypeSK FROM ctrl.ETL_DataSourceTypes_Dim WHERE DataSourceTypeName = 'MS SQL Server')
,NULL
,NULL
)
,(
'money'
,8
,(SELECT DataSourceTypeSK FROM ctrl.ETL_DataSourceTypes_Dim WHERE DataSourceTypeName = 'MS SQL Server')
,NULL
,NULL
)
,(
'float'
,8
,(SELECT DataSourceTypeSK FROM ctrl.ETL_DataSourceTypes_Dim WHERE DataSourceTypeName = 'MS SQL Server')
,NULL
,NULL
)
,(
'real'
,4
,(SELECT DataSourceTypeSK FROM ctrl.ETL_DataSourceTypes_Dim WHERE DataSourceTypeName = 'MS SQL Server')
,NULL
,NULL
)
,(
'datetime'
,8
,(SELECT DataSourceTypeSK FROM ctrl.ETL_DataSourceTypes_Dim WHERE DataSourceTypeName = 'MS SQL Server')
,NULL
,NULL
)
,(
'datetime2'
,8
,(SELECT DataSourceTypeSK FROM ctrl.ETL_DataSourceTypes_Dim WHERE DataSourceTypeName = 'MS SQL Server')
,NULL
,NULL
)
,(
'smalldatetime'
,4
,(SELECT DataSourceTypeSK FROM ctrl.ETL_DataSourceTypes_Dim WHERE DataSourceTypeName = 'MS SQL Server')
,NULL
,NULL
)
,(
'date'
,3
,(SELECT DataSourceTypeSK FROM ctrl.ETL_DataSourceTypes_Dim WHERE DataSourceTypeName = 'MS SQL Server')
,NULL
,NULL
)
,(
'time'
,5
,(SELECT DataSourceTypeSK FROM ctrl.ETL_DataSourceTypes_Dim WHERE DataSourceTypeName = 'MS SQL Server')
,NULL
,NULL
)
,(
'datetimeoffset'
,10
,(SELECT DataSourceTypeSK FROM ctrl.ETL_DataSourceTypes_Dim WHERE DataSourceTypeName = 'MS SQL Server')
,NULL
,NULL
)
,(
'timestamp'
,8
,(SELECT DataSourceTypeSK FROM ctrl.ETL_DataSourceTypes_Dim WHERE DataSourceTypeName = 'MS SQL Server')
,NULL
,NULL
)
,(
'sql_variant'
,8000
,(SELECT DataSourceTypeSK FROM ctrl.ETL_DataSourceTypes_Dim WHERE DataSourceTypeName = 'MS SQL Server')
,NULL
,NULL
)
,(
'uniqueidentifier'
,16
,(SELECT DataSourceTypeSK FROM ctrl.ETL_DataSourceTypes_Dim WHERE DataSourceTypeName = 'MS SQL Server')
,NULL
,NULL
)
,(
'xml'
,2000000000
,(SELECT DataSourceTypeSK FROM ctrl.ETL_DataSourceTypes_Dim WHERE DataSourceTypeName = 'MS SQL Server')
,NULL
,NULL
)
,(
'cursor'
,NULL
,(SELECT DataSourceTypeSK FROM ctrl.ETL_DataSourceTypes_Dim WHERE DataSourceTypeName = 'MS SQL Server')
,NULL
,NULL
)
,(
'table'
,NULL
,(SELECT DataSourceTypeSK FROM ctrl.ETL_DataSourceTypes_Dim WHERE DataSourceTypeName = 'MS SQL Server')
,NULL
,NULL
)