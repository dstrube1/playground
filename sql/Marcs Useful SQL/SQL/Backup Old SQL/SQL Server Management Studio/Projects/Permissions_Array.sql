

DECLARE @Name AS VARCHAR(100)
DECLARE @usesql AS VARCHAR(2048)
DECLARE DatabaseList CURSOR FOR
	SELECT name FROM sys.databases ORDER BY name
	
OPEN DatabaseList

FETCH NEXT FROM DatabaseList
INTO @name

WHILE @@FETCH_STATUS = 0	
BEGIN
	set @usesql = 
	'select
		'''+@name+''' AS DatabaseName,
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
