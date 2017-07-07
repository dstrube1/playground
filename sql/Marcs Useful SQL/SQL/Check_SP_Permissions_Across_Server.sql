DECLARE @object_name VARCHAR(200),
             @name VARCHAR(50),
             @sqltext VARCHAR (200)

CREATE TABLE #SP_Permissions (
      [DBName] VARCHAR(50),
      [Owner] VARCHAR(20),
      [Object] VARCHAR(200),
      [Grantee] VARCHAR(50),
      [Grantor] VARCHAR(50),
      [ProtectType] VARCHAR(50),
      [Action] VARCHAR(50),
      [Column] VARCHAR(50)    
)     
 
DECLARE db_cursor CURSOR FOR  
      SELECT name 
      FROM master.dbo.sysdatabases 
      WHERE name NOT IN ('master','model','msdb','tempdb')  

OPEN db_cursor   
FETCH NEXT FROM db_cursor INTO @name    
 
WHILE @@FETCH_STATUS = 0   
BEGIN   
      SET @sqltext = 'USE ['+@name+']'
      EXEC(@sqltext)
            
      PRINT @sqltext
            
      DECLARE tnames_cursor CURSOR FOR
            SELECT name
            FROM sysobjects
            WHERE type IN ('P')--'U','V',
      OPEN tnames_cursor
      FETCH NEXT FROM tnames_cursor INTO @object_name
         
         WHILE (@@fetch_status =0)
                  BEGIN
                        BEGIN TRY
                              INSERT INTO #SP_Permissions ([Owner],[Object],[Grantee],[Grantor],[ProtectType],[Action],[Column])
                              EXEC ('sp_helprotect ' + @object_name )
                              
                              UPDATE #SP_Permissions
                                    SET [DBName] = @name
                              WHERE [DBName] IS NULL
                              
                        END TRY
                         
                        BEGIN CATCH
                              INSERT INTO #SP_Permissions
                              VALUES(@name,NULL,@object_name,NULL,NULL,NULL,NULL,NULL)
                        END CATCH 
                        PRINT (@name+'..'+ @object_name)
              
            FETCH NEXT FROM tnames_cursor INTO @object_name
         END
         CLOSE tnames_cursor
         DEALLOCATE tnames_cursor
         
       FETCH NEXT FROM db_cursor INTO @name   
END   

CLOSE db_cursor   
DEALLOCATE db_cursor  

      --SP that grant access to user that are not SIADMIN
      SELECT DISTINCT * FROM #SP_Permissions 
      WHERE Grantee not like 'webaccess' 
            and Grantee not like 'siasp'
            and Grantee not like 'public'
            and Grantee not like 'guest'
           -- and Owner not like 'SIAdmin'
      ORDER BY 1,3,4
      
      --SP's that will probably need SIADMIN SP created
      SELECT DBNAME,Object,COUNT(1) FROM #SP_Permissions 
      WHERE Grantee not like 'webaccess' 
            and Grantee not like 'siasp'
            and Grantee not like 'public'
            and Grantee not like 'guest'
            and Owner not like 'SIAdmin'
      GROUP BY DBNAME,Object
      ORDER BY 1

      --SP that dont have any Permissions
      SELECT * FROM #SP_Permissions WHERE Owner Is NULL

  
   --DROP TABLE #SP_Permissions