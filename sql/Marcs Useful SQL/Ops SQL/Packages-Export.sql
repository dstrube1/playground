
DECLARE @SourceServer VARCHAR(50),
	@DestServer VARCHAR(50) = 'ATL02SQLDEV03.searchignite.local\ATL_SQLDW_DEV'

SET @SourceServer = @@SERVERNAME

SELECT 'dtutil /SQL "'+CASE WHEN ssis.folderid = '00000000-0000-0000-0000-000000000000' THEN '' ELSE ssisf.foldername + '\' END + ssis.name+'" /SourceServer ' + @SourceServer+ ' /Quiet /Copy SQL;"'+CASE WHEN ssis.folderid = '00000000-0000-0000-0000-000000000000' THEN '' ELSE ssisf.foldername + '\' END + ssis.name+'" /DestServer ' + @DestServer
FROM msdb..sysssispackages ssis
LEFT JOIN msdb..sysssispackagefolders ssisf ON ssis.folderid = ssisf.folderid
WHERE
EXISTS (
	SELECT * 
	FROM msdb..sysjobsteps sjs
	WHERE subsystem = 'SSIS'
	AND EXISTS (SELECT 1 FROM msdb..sysjobs WHERE enabled = 1 AND job_id = sjs.job_id)
	AND CHARINDEX(ssis.name, command) > 0
	-- incase of version
	AND (CASE WHEN PATINDEX('%V[0-9]%',command) > 0 THEN PATINDEX('%V[0-9]%',ssis.name)   ELSE 1 END) >0
)


