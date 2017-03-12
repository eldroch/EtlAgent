CREATE FUNCTION ctrl.GetFieldList
(@TableSK int)
RETURNS varchar(MAX)
AS
BEGIN
DECLARE @fldList varchar(MAX) =
 (Select distinct  
		substring(
        (
            Select ','+ col.ColumnName  AS [text()]
            From ctrl.ETL_Columns_Dim col
            Where col.TableSK = col2.TableSK
            ORDER BY col.SequenceNumber
            For XML PATH ('')
        ), 2, 1000) [Columns]
  From ctrl.ETL_Columns_Dim col2
  WHERE col2.TableSK = @TableSK
	   )

RETURN (@fldList)
END

GO

CREATE FUNCTION ctrl.GetPkList
(@TableSK int)
RETURNS varchar(MAX)
AS
BEGIN
DECLARE @fldList varchar(MAX) =
 (Select distinct  
		substring(
        (
            Select ','+ col.ColumnName  AS [text()]
            From ctrl.ETL_Columns_Dim col
            Where col.TableSK = col2.TableSK
			AND col.PKFlag = 'Y'
            ORDER BY col.SequenceNumber
            For XML PATH ('')
        ), 2, 8000) [Columns]
  From ctrl.ETL_Columns_Dim col2
  WHERE col2.TableSK = @TableSK
  AND col2.PKFlag = 'Y'
	   )

RETURN (@fldList)
END

GO

CREATE FUNCTION ctrl.GetFieldListWithTypes
(@TableSK int)
RETURNS varchar(MAX)
AS
BEGIN
DECLARE @fldList varchar(MAX) =
 (Select distinct  
		substring(
        (
            Select ','+ col.ColumnName + ' ' 
			+ CASE WHEN COALESCE(mdty.DataTypeName, dty.DataTypeName) IN ('numeric','decimal') THEN COALESCE(mdty.DataTypeName, dty.DataTypeName) + COALESCE('(' + CAST(col.ColumnMaxLength as varchar(25)) + COALESCE(',' + CAST(col.ColumnScale as varchar(25)), '') + ')', '')
			       WHEN COALESCE(mdty.DataTypeName, dty.DataTypeName) IN ('char','nchar','varchar','nvarchar','binary','varbinary','date','time','datetime') THEN COALESCE(mdty.DataTypeName, dty.DataTypeName) + COALESCE('(' + CAST(col.ColumnMaxLength as varchar(25)) + ')', '')
				   ELSE COALESCE(mdty.DataTypeName, dty.DataTypeName)
			  END  AS [text()]
            From ctrl.ETL_Columns_Dim col
			INNER JOIN ctrl.ETL_DataTypes_Dim dty ON col.DataTypeSK = dty.DataTypeSK
			LEFT JOIN ctrl.ETL_DataTypes_Dim mdty ON dty.MasterDataTypeSK = mdty.DataTypeSK
            Where col.TableSK = col2.TableSK
            ORDER BY col.SequenceNumber
            For XML PATH ('')
        ), 2, 20000) [Columns]
  From ctrl.ETL_Columns_Dim col2
  WHERE col2.TableSK = @TableSK
	   )

RETURN (@fldList)
END

GO
