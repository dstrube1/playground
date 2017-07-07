
SELECT * 
FROM sys.database_role_members r
							INNER JOIN sysusers su1 ON su1.[uid] = r.member_principal_id
							INNER JOIN sysusers su2 ON su2.[uid] = r.role_principal_id
						WHERE su2.name IN('db_owner') AND su1.name NOT IN('dbo')
						
						SELECT SUSER_NAME()
						sp_who4
						DECLARE @user sysname
SET @user = SUSER_NAME()

EXEC sp_helpuser @user

select dp.NAME AS principal_name,
       dp.type_desc AS principal_type_desc,
       o.NAME AS object_name,
       p.permission_name,
       p.state_desc AS permission_state_desc
from   sys.database_permissions p
left   OUTER JOIN sys.all_objects o
on     p.major_id = o.OBJECT_ID
inner  JOIN sys.database_principals dp
on     p.grantee_principal_id = dp.principal_id