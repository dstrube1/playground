
SET NOCOUNT ON

--Local to Server
DECLARE @BackupDirectory VARCHAR(500) = '\\MarcTest\',
	@NumFiles INT = 1,
	@Options VARCHAR(MAX) = 'NOFORMAT, INIT, SKIP, NOREWIND, NOUNLOAD, COMPRESSION,  STATS = 10,BUFFERCOUNT = 70, MAXTRANSFERSIZE=4194304, BLOCKSIZE=65536',
	@DSQL VARCHAR(MAX) = '',
	@DBName sysname,
	@BackupName VARCHAR(200) 

DECLARE @DB TABLE(
	DBName sysname,
	CompleteFlag BIT,
	PRIMARY KEY CLUSTERED (CompleteFlag,DBName)
)

INSERT INTO @DB ( DBName, CompleteFlag )
SELECT name ,0
FROM sys.databases
WHERE name NOT IN ('master','tempdb','model','msdb')


WHILE EXISTS(SELECT TOP 1 1 FROM @DB WHERE CompleteFlag = 0)
BEGIN


	DECLARE @T INT = 0,
		@File_SQL VARCHAR(MAX) ='',
		@FileName VARCHAR(100)

	SELECT TOP 1 @DBName = DBName 
	FROM @DB 
	WHERE CompleteFlag = 0
	
	WHILE @T < @NumFiles
	BEGIN
		
		SET @FileName = @DBName +'_'+RIGHT('00' + CAST(@T+1 AS VARCHAR),2)+'of'+RIGHT('00' + CAST(@NumFiles AS VARCHAR),2)+'.bak'	
	
		SET @File_SQL += 'DISK = N'''+@BackupDirectory+@FileNAme+'''' +CASE WHEN @NumFiles - @T  > 1 THEN ','+CHAR(13) ELSE '' END 
		
		SET @T+=1
	END
	
	SET @BackupName = 'NAME = N''FULL_'+@DBName+'_'+CONVERT(VARCHAR(8),GETDATE(),112)+''','
	
	SET @DSQL = 'BACKUP DATABASE ['+@DBName+'] '+CHAR(13) + 'TO '+@File_SQL+ CHAR(13)+'WITH '+@BackupName+ @Options

	UPDATE @DB
	SET CompleteFlag = 1
	WHERE DBName = @DBName



RAISERROR ('%s',0,1,@DSQL) WITH NOWAIT

END


