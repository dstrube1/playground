
USE msdb
GO
SELECT s.Name AS DatabaseName,TYPE as [D=Full,I=Differential],
MAX(bus.backup_finish_date) as lastbackup
FROM sys.sysdatabases s
LEFT OUTER JOIN msdb.dbo.backupset bus ON bus.database_name = s.name
where type in ('D','I')
GROUP BY s.Name,type
HAVING MAX(bus.backup_finish_date) < DATEADD(dd,-2,GETDATE())


SELECT s.Name AS DatabaseName,
MAX(bus.backup_finish_date) as lastbackup
FROM sys.sysdatabases s
LEFT OUTER JOIN msdb.dbo.backupset bus ON bus.database_name = s.name
where type in ('D','I')
GROUP BY s.Name
HAVING MAX(bus.backup_finish_date) < DATEADD(hh,-48,GETDATE())