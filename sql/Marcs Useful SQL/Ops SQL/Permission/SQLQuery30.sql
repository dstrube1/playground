
DECLARE @t TABLE(
	ID INT IDENTITY(1,1),
	hostname NCHAR(128),
	loginame NCHAR(128),
	program_name NCHAR(128),
	SPID SMALLINT,
	EventInfo NVARCHAR(MAX),
	ProcessedBit BIT DEFAULT(0),
	PRIMARY KEY CLUSTERED(ProcessedBit,ID)
)

INSERT INTO @t (hostname,loginame,spid,program_name)
select hostname,loginame,spid,program_name
from sys.sysprocesses with (nolock)
WHERE loginame = 'siasp'
	AND CHARINDEX('BULK',hostname) = 0
	AND CHARINDEX('ADMIN',hostname) = 0
	AND CHARINDEX('CRAWL',hostname) = 0
	AND CHARINDEX('APP',hostname) = 0
	AND CHARINDEX('CACHE',hostname) = 0
	AND CHARINDEX('DASHBOARD',hostname) = 0
	AND CHARINDEX('RDS',hostname) = 0

DECLARE @SPID SMALLINT,
	@ID INT,
	@dsql VARCHAR(100)

WHILE EXISTS(SELECT TOP 1 1 FROM @t WHERE ProcessedBit = 0	)
BEGIN

	SELECT TOP 1 @ID = ID,@SPID = SPID
	FROM @t 
	WHERE ProcessedBit = 0
	
	IF OBJECT_ID('tempdb..#Inputbuffer')IS NOT NULL
	DROP TABLE 	#Inputbuffer
		
	CREATE TABLE #Inputbuffer(
		EventType NVARCHAR(30) NULL,
		Parameters INT NULL,
		EventInfo NVARCHAR(MAX) NULL
	)
	
	SET @dsql = 'DBCC INPUTBUFFER('+CAST(@SPID AS VARCHAR(10))+') WITH NO_INFOMSGS'

	INSERT #Inputbuffer
	EXEC (@dsql)
	
	UPDATE @t
	SET ProcessedBit = 1,
		EventInfo = ib.EventInfo
	FROM #Inputbuffer ib
	WHERE ID = @ID
		AND ProcessedBit = 0
		
END

IF EXISTS(SELECT TOP 1 1 FROM @t)
BEGIN
	DECLARE @profile sysname,
		@body NVARCHAR(MAX)

	SELECT @body =  COALESCE(@body+ char(10)+ char(10),'')+ 'User logged into SIASP from '+hostname+ char(10)+ 'SPID: '+CAST(SPID AS VARCHAR(10))+ char(10)+'Program: '+CAST(program_name AS VARCHAR(10))+ char(10)+'Inputbuffer: {' + char(10) ++EventInfo + char(10) + '}'
	FROM @t

	SELECT TOP 1 @profile=  name
	FROM msdb..sysmail_profile
	WHERE name LIKE ('%DB%')
	ORDER BY profile_id DESC

	EXEC msdb.dbo.sp_send_dbmail 
		@profile_name = @profile,
		@recipients = 'msmith@ignitionone.com;Karthik.Sathya@ignitionone.com;yong.zou@ignitionone.com; lee.rogers@ignitionone.com',
		@subject = 'SIASP login detected',
		@body = @body
END	
	

