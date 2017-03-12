SET IDENTITY_INSERT [ctrl].[ETL_DataTypes_Dim] ON 
  INSERT INTO [ctrl].[ETL_DataTypes_Dim]
  (
  [DataTypeSK]
 ,[DataTypeName]
 ,[DataTypeMaxLength]
 ,[DataSourceTypeSK]
 ,[MasterDataTypeSK]
 ,[DefaultValue]
  )
  VALUES
  (
   0
  ,'Undefined'
  ,NULL
  ,NULL
  ,NULL
  ,NULL
  )
  SET IDENTITY_INSERT [ctrl].[ETL_DataTypes_Dim] OFF