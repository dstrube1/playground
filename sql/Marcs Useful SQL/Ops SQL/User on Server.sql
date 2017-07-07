
SELECT
spid,status,sid,hostname,program_name,cmd,cpu,physical_io,blocked,dbid,
convert(sysname, rtrim(loginame)) as loginname,spid as 'spid_sort', 
substring( convert(varchar,last_batch,111) ,6 ,5 ) + ' ' + substring( convert(varchar,last_batch,113) ,13 ,8 ) as 'last_batch_char',last_batch, DB_NAME(dbid)
from master.dbo.sysprocesses (nolock)
order by loginname
/*
DBCC FREESYSTEMCACHE ('ALL');
DBCC FREESESSIONCACHE
DBCC FREEPROCCACHE
DBCC DROPCLEANBUFFERS
*/