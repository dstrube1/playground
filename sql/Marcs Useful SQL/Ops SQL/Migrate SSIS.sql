

SELECT * 
FROM msdb..sysjobsteps sjs
WHERE subsystem = 'SSIS'
AND EXISTS (SELECT 1 FROM msdb..sysjobs WHERE enabled = 1 AND job_id = sjs.job_id)

SELECT TOP 10 * FROM msdb..sysdtspackages

SELECT * 
FROM msdb..sysssispackages ssis
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



SELECT * 
FROM msdb..sysssispackages ssis
WHERE
EXISTS (
	SELECT * 
	FROM msdb..sysjobsteps sjs
	WHERE subsystem = 'SSIS'
	AND EXISTS (SELECT 1 FROM msdb..sysjobs WHERE enabled = 1 AND job_id = sjs.job_id)
	AND CHARINDEX(ssis.name, command) > 0
	-- incase of version
	--AND (CASE WHEN PATINDEX('%V[0-9]%',ssis.name) > 0 THEN PATINDEX('%V[0-9]%',command)  ELSE 1 END) >0
)



SELECT * 
FROM msdb..sysjobsteps sjs
WHERE subsystem = 'SSIS'
AND EXISTS (SELECT 1 FROM msdb..sysjobs WHERE enabled = 1 AND job_id = sjs.job_id)


SELECT name,* 
FROM msdb..sysjobs 
ORDER BY 1


DECLARE @SourceServer VARCHAR(50),
      @DestServer VARCHAR(50) = 'ATL02SQLQA01\ATL_SQLMAIN_QA'

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





