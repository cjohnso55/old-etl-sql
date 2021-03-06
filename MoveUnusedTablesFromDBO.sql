/*

Cleanup INCH database for rebuild of Step1.  Not driving table
'TablesChangeSchemaNotUsed' was moved to the notUsed schema after
script ran.

Alter Schema notUsed Transfer dbo.txn_2010_10b-- Doesn't exist wecker does 
Alter Schema notUsed Transfer dbo.txn_2010_11b-- Doesn't exist
Alter Schema notUsed Transfer dbo.txn_2007_01d-- Doesn't exist
Alter Schema notUsed Transfer dbo.txn_2007_02d-- Doesn't exist
Alter Schema notUsed Transfer dbo.txn_2009_08c-- Doesn't exist


*/

Use INCH
Go


Declare @SQL VarChar(Max)
Declare @NewSchemaName VarChar(255)
Declare @TableToChange VarChar(255)

Set @NewSchemaName = 'notUsed'
Select * into #InProcess from INCH.dbo.TablesChangeSchemaNotUsed 



While Exists (select top(1) * from #InProcess)
Begin	
    Set @TableToChange = (select top 1 * from #InProcess)

	Set @SQL = 'Alter Schema ' + @NewSchemaName + ' Transfer ' + @TableToChange
	Exec (@SQL)
	Print @SQL
	
	Delete top(1) from #InProcess where tableName = @TableToChange	
End

Drop Table #InProcess





