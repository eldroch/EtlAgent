CREATE TYPE ctrl.[ColumnData] AS TABLE(
[TableSK] int
,[ColumnName] varchar(255)
,SourceCodeSetName varchar(255)
,[DataType] varchar(255)
,[PKFlag] char(1)
,[ColumnMaxLength] int
,[ColumnScale] int
,[SequenceNumber] int
,[ContainsNullsFlag] char(1)
,[ContainsNonprintablesFlag] char(1)
,[CDCEnabledFlag] char(1)
)

GO

CREATE PROCEDURE ctrl.LoadColumnData
    @colData ColumnData readonly
AS
BEGIN
    insert into ctrl.ETL_Columns_Dim
	(
	[TableSK]
      ,[SourceCodeSetSK]
      ,[ColumnName]
      ,[PKFlag]
      ,[DataTypeSK]
      ,[ColumnMaxLength]
      ,[ColumnScale]
      ,[SequenceNumber]
      ,[ContainsNullsFlag]
      ,[ContainsNonprintablesFlag]
      ,[CDCEnabledFlag]
	)
	select 
	   col.[TableSK]
      ,cds.SourceCodeSetSK
      ,col.[ColumnName]
      ,col.[PKFlag]
      ,COALESCE(dty.[DataTypeSK], 0)
      ,col.[ColumnMaxLength]
      ,col.[ColumnScale]
      ,col.[SequenceNumber]
      ,col.[ContainsNullsFlag]
      ,col.[ContainsNonprintablesFlag]
      ,col.[CDCEnabledFlag] 
	from @colData col
	INNER JOIN ctrl.ETL_Tables_Dim tbl ON col.TableSK = tbl.TableSK 
	INNER JOIN ctrl.ETL_DataSources_Dim ds ON tbl.DataSourceSK = ds.DataSourceSK
	LEFT JOIN ctrl.ETL_DataTypes_Dim dty ON ds.DataSourceTypeSK = dty.DataSourceTypeSK AND dty.DataTypeName = col.DataType
	LEFT JOIN ctrl.MST_SourceCodeSets_Dim cds ON col.SourceCodeSetName = cds.SourceCodeSetName
	
END

GO


CREATE PROCEDURE dbo.ETLTool_OutputCreateTemporalTableStmt
(
@TableSK int
)
AS

DECLARE @cmd varchar(MAX)
	   ,@fldList varchar(MAX)
	   ,@tblNm varchar(255)
	   ,@schmNm varchar(50)
	   ,@pkList varchar(MAX)

SELECT @fldList = ctrl.GetFieldListWithTypes(TableSK)
	  ,@tblNm = TableName
	  ,@schmNm = TableSchema
	  ,@pkList = ctrl.GetPkList(TableSK)
FROM ctrl.ETL_Tables_Dim 
WHERE TableSK = @TableSK

SET @cmd = 
'
CREATE TABLE hist.' + @schmNm + '_' + @tblNm + '
(
id_hash bigint, ' + @fldList + ', InsertedDttm datetime
)

CREATE CLUSTERED INDEX CIX_PK ON hist.' + @schmNm + '_' + @tblNm + '
(
id_hash
)

CREATE NONCLUSTERED INDEX NIX_PK ON hist.' + @schmNm + '_' + @tblNm + '
(
' + @pkList + '
)
'

PRINT (@cmd)
SELECT @cmd

GO

CREATE PROCEDURE dbo.ETLTool_OutputCreateReplicationTableStmt
(
@TableSK int
)
AS

DECLARE @cmd varchar(MAX)
	   ,@fldList varchar(MAX)
	   ,@tblNm varchar(255)
	   ,@schmNm varchar(50)
	   ,@pkList varchar(MAX)

SELECT @fldList = ctrl.GetFieldListWithTypes(TableSK)
	  ,@tblNm = TableName
	  ,@schmNm = TableSchema
	  ,@pkList = ctrl.GetPkList(TableSK)
FROM ctrl.ETL_Tables_Dim 
WHERE TableSK = @TableSK

SET @cmd = 
'
CREATE TABLE ' + @schmNm + '.' + @tblNm + '
(
id_hash bigint, ' + @fldList + ', InsertedDttm datetime, UpdatedDttm datetime, DeletedAtSrcFlag char(1), DeletedAtSrcDttm datetime
)

CREATE CLUSTERED INDEX CIX_PK ON ' + @schmNm + '.' + @tblNm + '
(
id_hash
)

CREATE NONCLUSTERED INDEX NIX_PK ON ' + @schmNm + '.' + @tblNm + '
(
' + @pkList + '
)
'

PRINT (@cmd)
SELECT @cmd

GO