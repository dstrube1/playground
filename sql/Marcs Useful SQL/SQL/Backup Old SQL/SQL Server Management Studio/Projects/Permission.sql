--Artim
USE Artim

select 

    'Artim'  AS DatabaseName,
	dp.NAME AS UserName,
	dp.type_desc AS UserType,
	o.NAME AS object_name,
	o.type_desc ,
	p.permission_name,
	p.state_desc AS permission_state_desc 
	
from  sys.database_permissions p
left OUTER JOIN sys.all_objects o 
	on p.major_id = o.OBJECT_ID
inner   JOIN sys.database_principals dp
	on  p.grantee_principal_id = dp.principal_id
	
	ORDER BY dp.type_desc
	
--distribution
USE distribution

select 
    'distribution'  AS DatabaseName,
	dp.NAME AS UserName,
	dp.type_desc AS UserType,
	o.NAME AS object_name,
	o.type_desc ,
	p.permission_name,
	p.state_desc AS permission_state_desc 
	
from  sys.database_permissions p
left OUTER JOIN sys.all_objects o 
	on p.major_id = o.OBJECT_ID
inner   JOIN sys.database_principals dp
	on  p.grantee_principal_id = dp.principal_id
	
ORDER BY dp.type_desc

--Gauntlet
USE Gauntlet

select 
    'Gauntlet'  AS DatabaseName,
	dp.NAME AS UserName,
	dp.type_desc AS UserType,
	o.NAME AS object_name,
	o.type_desc ,
	p.permission_name,
	p.state_desc AS permission_state_desc 
	
from  sys.database_permissions p
left OUTER JOIN sys.all_objects o 
	on p.major_id = o.OBJECT_ID
inner   JOIN sys.database_principals dp
	on  p.grantee_principal_id = dp.principal_id
	
ORDER BY dp.type_desc

--JunkDB
USE JunkDB

select 
    'JunkDB'  AS DatabaseName,
	dp.NAME AS UserName,
	dp.type_desc AS UserType,
	o.NAME AS object_name,
	o.type_desc ,
	p.permission_name,
	p.state_desc AS permission_state_desc 
	
from  sys.database_permissions p
left OUTER JOIN sys.all_objects o 
	on p.major_id = o.OBJECT_ID
inner   JOIN sys.database_principals dp
	on  p.grantee_principal_id = dp.principal_id
	
ORDER BY dp.type_desc

--master
USE master

select 
    'master'  AS DatabaseName,
	dp.NAME AS UserName,
	dp.type_desc AS UserType,
	o.NAME AS object_name,
	o.type_desc ,
	p.permission_name,
	p.state_desc AS permission_state_desc 
	
from  sys.database_permissions p
left OUTER JOIN sys.all_objects o 
	on p.major_id = o.OBJECT_ID
inner   JOIN sys.database_principals dp
	on  p.grantee_principal_id = dp.principal_id
	
ORDER BY dp.type_desc

--model
USE model

select 
    'model'  AS DatabaseName,
	dp.NAME AS UserName,
	dp.type_desc AS UserType,
	o.NAME AS object_name,
	o.type_desc ,
	p.permission_name,
	p.state_desc AS permission_state_desc 
	
from  sys.database_permissions p
left OUTER JOIN sys.all_objects o 
	on p.major_id = o.OBJECT_ID
inner   JOIN sys.database_principals dp
	on  p.grantee_principal_id = dp.principal_id
	
ORDER BY dp.type_desc

--msdb
USE msdb

select 
    'msdb'  AS DatabaseName,
	dp.NAME AS UserName,
	dp.type_desc AS UserType,
	o.NAME AS object_name,
	o.type_desc ,
	p.permission_name,
	p.state_desc AS permission_state_desc 
	
from  sys.database_permissions p
left OUTER JOIN sys.all_objects o 
	on p.major_id = o.OBJECT_ID
inner   JOIN sys.database_principals dp
	on  p.grantee_principal_id = dp.principal_id
	
ORDER BY dp.type_desc

--Rauche
USE Gauntlet

select 
    'master'  AS DatabaseName,
	dp.NAME AS UserName,
	dp.type_desc AS UserType,
	o.NAME AS object_name,
	o.type_desc ,
	p.permission_name,
	p.state_desc AS permission_state_desc 
	
from  sys.database_permissions p
left OUTER JOIN sys.all_objects o 
	on p.major_id = o.OBJECT_ID
inner   JOIN sys.database_principals dp
	on  p.grantee_principal_id = dp.principal_id
	
ORDER BY dp.type_desc

--Gauntlet
USE Gauntlet

select 
	dp.NAME AS UserName,
	dp.type_desc AS UserType,
	o.NAME AS object_name,
	o.type_desc ,
	p.permission_name,
	p.state_desc AS permission_state_desc 
	
from  sys.database_permissions p
left OUTER JOIN sys.all_objects o 
	on p.major_id = o.OBJECT_ID
inner   JOIN sys.database_principals dp
	on  p.grantee_principal_id = dp.principal_id
	
ORDER BY dp.type_desc

--Gauntlet
USE Gauntlet

select 
	dp.NAME AS UserName,
	dp.type_desc AS UserType,
	o.NAME AS object_name,
	o.type_desc ,
	p.permission_name,
	p.state_desc AS permission_state_desc 
	
from  sys.database_permissions p
left OUTER JOIN sys.all_objects o 
	on p.major_id = o.OBJECT_ID
inner   JOIN sys.database_principals dp
	on  p.grantee_principal_id = dp.principal_id
	
ORDER BY dp.type_desc

--Gauntlet
USE Gauntlet

select 
	dp.NAME AS UserName,
	dp.type_desc AS UserType,
	o.NAME AS object_name,
	o.type_desc ,
	p.permission_name,
	p.state_desc AS permission_state_desc 
	
from  sys.database_permissions p
left OUTER JOIN sys.all_objects o 
	on p.major_id = o.OBJECT_ID
inner   JOIN sys.database_principals dp
	on  p.grantee_principal_id = dp.principal_id
	
ORDER BY dp.type_desc

--Gauntlet
USE Gauntlet

select 
	dp.NAME AS UserName,
	dp.type_desc AS UserType,
	o.NAME AS object_name,
	o.type_desc ,
	p.permission_name,
	p.state_desc AS permission_state_desc 
	
from  sys.database_permissions p
left OUTER JOIN sys.all_objects o 
	on p.major_id = o.OBJECT_ID
inner   JOIN sys.database_principals dp
	on  p.grantee_principal_id = dp.principal_id
	
ORDER BY dp.type_desc

--Gauntlet
USE Gauntlet

select 
	dp.NAME AS UserName,
	dp.type_desc AS UserType,
	o.NAME AS object_name,
	o.type_desc ,
	p.permission_name,
	p.state_desc AS permission_state_desc 
	
from  sys.database_permissions p
left OUTER JOIN sys.all_objects o 
	on p.major_id = o.OBJECT_ID
inner   JOIN sys.database_principals dp
	on  p.grantee_principal_id = dp.principal_id
	
ORDER BY dp.type_desc

--Gauntlet
USE Gauntlet

select 
	dp.NAME AS UserName,
	dp.type_desc AS UserType,
	o.NAME AS object_name,
	o.type_desc ,
	p.permission_name,
	p.state_desc AS permission_state_desc 
	
from  sys.database_permissions p
left OUTER JOIN sys.all_objects o 
	on p.major_id = o.OBJECT_ID
inner   JOIN sys.database_principals dp
	on  p.grantee_principal_id = dp.principal_id
	
ORDER BY dp.type_desc