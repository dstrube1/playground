SELECT session_id,percent_complete,DB_NAME(database_id) AS [DB_Name],command,* 
FROM   sys.dm_exec_requests
WHERE percent_complete > 0

GO 

sp_who4