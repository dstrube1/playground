
SET NOCOUNT on
DECLARE @ServerName SYSNAME, @DBName SYSNAME
SELECT @ServerName = @@SERVERNAME

SELECT @ServerName = SUBSTRING(@ServerName, CHARINDEX ('_', @ServerName) + 1, DATALENGTH(@Servername))


DECLARE get_record CURSOR for
SELECT name FROM master..sysdatabases WHERE name NOT IN ('master', 'tempdb', 'model', 'msdb')

OPEN get_record
FETCH NEXT FROM get_record INTO @DBName
WHILE @@FETCH_STATUS = 0
begin
	PRINT '
DBCC SHRINKDATABASE('+ @DBName + ') 
GO
BACKUP DATABASE ['+ @DBName + '] TO  DISK = N''F:\Backups\SQLMain\'+ @DBName + '.bak'' WITH NOFORMAT, INIT,  NAME = N'''+ @DBName + '-Full Database Backup'', SKIP, NOREWIND, NOUNLOAD, COMPRESSION,  STATS = 10
GO
RAISERROR('''+ @DBName + ' Complete'',0,1) WITH NOWAIT
'

	FETCH NEXT FROM get_record INTO @DBName
END
CLOSE get_record
DEALLOCATE get_record