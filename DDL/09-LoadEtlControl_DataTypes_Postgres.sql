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
,NULL
,(SELECT DataSourceTypeSK FROM ctrl.ETL_DataSourceTypes_Dim WHERE DataSourceTypeName = 'Postgres')
,NULL
,NULL
)
,(
'varchar'
,NULL
,(SELECT DataSourceTypeSK FROM ctrl.ETL_DataSourceTypes_Dim WHERE DataSourceTypeName = 'Postgres')
,NULL
,NULL
)
,(
'text'
,NULL
,(SELECT DataSourceTypeSK FROM ctrl.ETL_DataSourceTypes_Dim WHERE DataSourceTypeName = 'Postgres')
,NULL
,NULL
)
,(
'bit'
,NULL
,(SELECT DataSourceTypeSK FROM ctrl.ETL_DataSourceTypes_Dim WHERE DataSourceTypeName = 'Postgres')
,NULL
,NULL
)
,(
'varbit'
,NULL
,(SELECT DataSourceTypeSK FROM ctrl.ETL_DataSourceTypes_Dim WHERE DataSourceTypeName = 'Postgres')
,NULL
,NULL
)
,(
'smallint'
,2
,(SELECT DataSourceTypeSK FROM ctrl.ETL_DataSourceTypes_Dim WHERE DataSourceTypeName = 'Postgres')
,NULL
,NULL
)
,(
'int'
,4
,(SELECT DataSourceTypeSK FROM ctrl.ETL_DataSourceTypes_Dim WHERE DataSourceTypeName = 'Postgres')
,NULL
,NULL
)
,(
'bigint'
,8
,(SELECT DataSourceTypeSK FROM ctrl.ETL_DataSourceTypes_Dim WHERE DataSourceTypeName = 'Postgres')
,NULL
,NULL
)
,(
'decimal'
,NULL
,(SELECT DataSourceTypeSK FROM ctrl.ETL_DataSourceTypes_Dim WHERE DataSourceTypeName = 'Postgres')
,NULL
,NULL
)
,(
'numeric'
,NULL
,(SELECT DataSourceTypeSK FROM ctrl.ETL_DataSourceTypes_Dim WHERE DataSourceTypeName = 'Postgres')
,NULL
,NULL
)
,(
'real'
,4
,(SELECT DataSourceTypeSK FROM ctrl.ETL_DataSourceTypes_Dim WHERE DataSourceTypeName = 'Postgres')
,NULL
,NULL
)
,(
'double precision'
,8
,(SELECT DataSourceTypeSK FROM ctrl.ETL_DataSourceTypes_Dim WHERE DataSourceTypeName = 'Postgres')
,NULL
,NULL
)
,(
'smallserial'
,2
,(SELECT DataSourceTypeSK FROM ctrl.ETL_DataSourceTypes_Dim WHERE DataSourceTypeName = 'Postgres')
,NULL
,NULL
)
,(
'serial'
,4
,(SELECT DataSourceTypeSK FROM ctrl.ETL_DataSourceTypes_Dim WHERE DataSourceTypeName = 'Postgres')
,NULL
,NULL
)
,(
'bigserial'
,8
,(SELECT DataSourceTypeSK FROM ctrl.ETL_DataSourceTypes_Dim WHERE DataSourceTypeName = 'Postgres')
,NULL
,NULL
)
,(
'money'
,NULL
,(SELECT DataSourceTypeSK FROM ctrl.ETL_DataSourceTypes_Dim WHERE DataSourceTypeName = 'Postgres')
,NULL
,NULL
)
,(
'bool'
,1
,(SELECT DataSourceTypeSK FROM ctrl.ETL_DataSourceTypes_Dim WHERE DataSourceTypeName = 'Postgres')
,NULL
,NULL
)
,(
'date'
,3
,(SELECT DataSourceTypeSK FROM ctrl.ETL_DataSourceTypes_Dim WHERE DataSourceTypeName = 'Postgres')
,NULL
,NULL
)
,(
'time'
,5
,(SELECT DataSourceTypeSK FROM ctrl.ETL_DataSourceTypes_Dim WHERE DataSourceTypeName = 'Postgres')
,NULL
,NULL
)
,(
'timestamp'
,8
,(SELECT DataSourceTypeSK FROM ctrl.ETL_DataSourceTypes_Dim WHERE DataSourceTypeName = 'Postgres')
,NULL
,NULL
)
,(
'timestamp without time zone'
,8
,(SELECT DataSourceTypeSK FROM ctrl.ETL_DataSourceTypes_Dim WHERE DataSourceTypeName = 'Postgres')
,NULL
,NULL
)
,(
'timestamp with time zone'
,8
,(SELECT DataSourceTypeSK FROM ctrl.ETL_DataSourceTypes_Dim WHERE DataSourceTypeName = 'Postgres')
,NULL
,NULL
)
,(
'time without time zone'
,5
,(SELECT DataSourceTypeSK FROM ctrl.ETL_DataSourceTypes_Dim WHERE DataSourceTypeName = 'Postgres')
,NULL
,NULL
)
,(
'time with time zone'
,5
,(SELECT DataSourceTypeSK FROM ctrl.ETL_DataSourceTypes_Dim WHERE DataSourceTypeName = 'Postgres')
,NULL
,NULL
)