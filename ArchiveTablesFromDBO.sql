/*

Cleanup INCH database for rebuild of Step1.  Not driving table
'TablesToArchive' was moved to the notUsed schema after
script ran.

Alter Schema notUsed Transfer dbo.txn_2010_10b-- Doesn't exist wecker does 
Alter Schema notUsed Transfer dbo.txn_2010_11b-- Doesn't exist
Alter Schema notUsed Transfer dbo.txn_2007_01d-- Doesn't exist
Alter Schema notUsed Transfer dbo.txn_2007_02d-- Doesn't exist
Alter Schema notUsed Transfer dbo.txn_2009_08c-- Doesn't exist


*/

Use Step_1
Go

select * from Information_Schema.Tables where Table_Schema = 'dbo'  and table_name not like 'txn%' and table_type = 'BASE TABLE'

Select (table_name) as TableName into #InProcess from Information_Schema.Tables  where Table_Schema = 'archive'  and table_name not like 'txn%' and table_type = 'BASE TABLE' 

Declare @SQL VarChar(Max)
Declare @NewSchemaName VarChar(255)
Declare @TableToChange VarChar(255)

Set @NewSchemaName = 'archive'




While Exists (select top(1) * from #InProcess)
Begin	
    Set @TableToChange = (select top 1 * from #InProcess)

	Set @SQL = 'Select * Into ' + 'dbo.' + @TableToChange + ' from archive.' + @TableToChange 
	Exec (@SQL)
	Print @SQL
	
	Delete top(1) from #InProcess where tableName = @TableToChange	
End

Drop Table #InProcess





