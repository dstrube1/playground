/*
ALTER DATABASE SIOLAP MODIFY FILE
   (NAME = 'SIOLAP_log', SIZE = 163840)
   
  dbcc shrinkfile (2, 0)
*/
DECLARE @database_id int 
DECLARE @database_name sysname 
DECLARE @sql_string nvarchar(2000) 
DECLARE @file_size TABLE 
    ( 
    [database_name] [sysname] NULL, 
    [groupid] [smallint] NULL, 
    [groupname] sysname NULL, 
    [fileid] [smallint] NULL, 
    [file_size] [decimal](12, 2) NULL, 
    [space_used] [decimal](12, 2) NULL, 
    [free_space] [decimal](12, 2) NULL, 
    [name] [sysname] NOT NULL, 
    [filename] [nvarchar](260) NOT NULL 
    )

SELECT TOP 1 @database_id = database_id 
    ,@database_name = name 
FROM sys.databases 
WHERE database_id > 0 
	AND is_read_only = 0
ORDER BY database_id
 

WHILE @database_name IS NOT NULL 
BEGIN

    SET @sql_string = 'USE ' + QUOTENAME(@database_name) + CHAR(10) 
    SET @sql_string = @sql_string + 'SELECT 
                                        DB_NAME() 
                                        ,sysfilegroups.groupid 
                                        ,sysfilegroups.groupname 
                                        ,fileid 
                                        ,convert(decimal(12,2),round(sysfiles.size/128.000,2)) as file_size 
                                        ,convert(decimal(12,2),round(fileproperty(sysfiles.name,''SpaceUsed'')/128.000,2)) as space_used 
                                        ,convert(decimal(12,2),round((sysfiles.size-fileproperty(sysfiles.name,''SpaceUsed''))/128.000,2)) as free_space 
                                        ,sysfiles.name 
                                        ,sysfiles.filename 
                                    FROM sys.sysfiles 
                                    LEFT OUTER JOIN sys.sysfilegroups 
                                        ON sysfiles.groupid = sysfilegroups.groupid
                                    WHERE sysfiles.growth > 0/*Uncapped*/'

    INSERT INTO @file_size 
        EXEC sp_executesql @sql_string   

    --Grab next database 
    SET @database_name = NULL 
    SELECT TOP 1 @database_id = database_id 
        ,@database_name = name 
    FROM sys.databases 
    WHERE database_id > @database_id 
		AND is_read_only = 0
    ORDER BY database_id 
END

--File Sizes 
SELECT database_name, groupid, ISNULL(groupname,'TLOG') groupname, fileid, name, file_size, space_used, free_space,(free_space/file_size)*100 AS [%FREE], filename 
FROM @file_size
--WHERE CHARINDEX('H:\',filename) > 0
ORDER BY 9 ASC

--File Group Sizes 
SELECT database_name, groupid, ISNULL(groupname,'TLOG') groupname, SUM(file_size) as file_size, SUM(space_used) as space_used, SUM(free_space) as free_space ,SUM(free_space)/SUM(file_size)*100 AS [%FREE]

FROM @file_size 
GROUP BY database_name, groupid, groupname
ORDER BY 7 ASC