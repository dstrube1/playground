
USE SIProcessing_Attribution

SET NOCOUNT ON

DECLARE @Table sysname = 'TrackedExposure'
DECLARE @PNum INT,
	@d_sql VARCHAR(MAX)


IF OBJECT_ID('tempdb..#Partition') IS NULL
BEGIN
	CREATE TABLE #Partition (
		PNum INT,
		NRows INT,
		RunStatus BIT
	)

	INSERT INTO #Partition( PNum, NRows,RunStatus )
		SELECT p.partition_number,MAX(p.rows),0
		FROM sys.partitions p
		WHERE OBJECT_NAME(p.object_id) = @Table
			AND ROWS > 0
			--AND partition_number NOT IN ()
		GROUP BY p.partition_number
END	

	WHILE EXISTS(SELECT TOP 1 1 FROM #Partition WHERE RunStatus = 0)
	BEGIN
	
		SELECT TOP 1 @PNum = PNum 
		FROM #Partition 
		WHERE RunStatus = 0
		ORDER BY NRows ASC
		
		SET @d_sql = 'ALTER INDEX ALL ON ' +CAST(@Table AS VARCHAR)+' REBUILD PARTITION = '+CAST(@PNum AS VARCHAR)
	
		RAISERROR('%s',0,1,@d_sql) WITH NOWAIT
	
		EXEC (@d_sql)
		
		WAITFOR DELAY'00:00:00.500'
		
		UPDATE #Partition
		SET RunStatus = 1
		WHERE PNum = @PNum
		
	END


