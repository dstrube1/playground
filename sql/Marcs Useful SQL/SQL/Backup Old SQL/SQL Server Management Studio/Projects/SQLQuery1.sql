IF OBJECT_ID('tempdb..#database_permissions') IS NOT NULL DROP table #database_permissions 

DECLARE @Name AS VARCHAR(100) 
DECLARE @usesql AS VARCHAR(2048) 

DECLARE DatabaseList CURSOR FOR
	SELECT name FROM sys.databases ORDER BY name
	
OPEN DatabaseList

FETCH NEXT FROM DatabaseList
INTO @name
CREATE TABLE #database_permissions
(
	[databaseName] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[UserName] [sysname] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[UserType] [nvarchar](60) COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[object_name] [sysname] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[type_desc] [nvarchar](60) COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[permission_name] [nvarchar](128) COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[permission_state_desc] [nvarchar](60) COLLATE Latin1_General_CI_AS_KS_WS NULL
) 

WHILE @@FETCH_STATUS = 0	
BEGIN
	set @usesql = 
	'insert into #database_permissions
	select 
		'''+@name+''',
		dp.NAME AS UserName,
		dp.type_desc AS UserType,
		o.NAME AS object_name,
		o.type_desc ,
		p.permission_name,
		p.state_desc AS permission_state_desc 
	from  ' + @name+'.sys.database_permissions p
	left OUTER JOIN '+@name +'.sys.all_objects o 
		on p.major_id = o.OBJECT_ID
	inner   JOIN '+ @name +'.sys.database_principals dp
		on  p.grantee_principal_id = dp.principal_id
	ORDER BY dp.type_desc'
EXEC(@usesql)
	FETCH NEXT FROM DatabaseList
		INTO @name
END
CLOSE DatabaseList
DEALLOCATE DatabaseList


SELECT * FROM #database_permissions ORDER BY [databaseName]
