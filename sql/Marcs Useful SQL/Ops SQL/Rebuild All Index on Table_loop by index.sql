
USE SIProcessing_Attribution

SET NOCOUNT ON

DECLARE @Table sysname = 'TrackedExposure'


DECLARE @PNum INT,
	@Index sysname,
	@d_sql VARCHAR(500)
	
IF OBJECT_ID('tempdb..#Index') IS NOT NULL
DROP TABLE #Index

CREATE TABLE #Index (
	IndexName sysname,
	FirstColumn sysname,
	RunStatus BIT
)

INSERT INTO #Index( IndexName, FirstColumn,RunStatus )
SELECT DISTINCT i.name, c.name,0
FROM sys.indexes i 
join sys.index_columns ic on ic.object_id = i.object_id
	AND i.index_id = ic.index_id
join sys.columns c on c.object_id = i.object_id
	AND ic.column_id = c.column_id
WHERE OBJECT_NAME(i.object_id) = @Table
AND IC.key_ordinal > 0
AND IC.is_included_column = 0
AND IC.index_column_id = 1

IF OBJECT_ID('tempdb..#Partition') IS NOT NULL
DROP TABLE #Partition

CREATE TABLE #Partition (
	PNum INT,
	NRows INT,
	RunStatus BIT
)

INSERT INTO #Partition( PNum,NRows, RunStatus )
SELECT distinct p.partition_number,p.rows,0
	FROM sys.partitions p
	WHERE OBJECT_NAME(p.object_id) = @Table
	AND ROWS > 0
	
DECLARE @Junk TABLE(
	ExecStatus BIT
)


WHILE EXISTS(SELECT TOP 1 1 FROM #Index WHERE RunStatus = 0)
BEGIN

	SELECT TOP 1 @Index = IndexName
	FROM #Index 
	WHERE RunStatus = 0

	UPDATE #Partition
	SET RunStatus = 0
	
	WHILE EXISTS(SELECT TOP 1 1 FROM #Partition WHERE RunStatus = 0)
	BEGIN
	
		SELECT TOP 1 @PNum = PNum 
		FROM #Partition 
		WHERE RunStatus = 0
		ORDER BY NRows ASC
		
		SET @d_sql = 'ALTER INDEX '+CAST(@Index AS VARCHAR(200))+' ON ' +CAST(@Table AS VARCHAR(200))+' REBUILD PARTITION = '+CAST(@PNum AS VARCHAR(200))
	
		RAISERROR('%s',0,1,@d_sql) WITH NOWAIT
	
		--EXEC (@d_sql)
		
		WAITFOR DELAY '00:00:00.005'
		
		UPDATE #Partition
		SET RunStatus = 1
		WHERE PNum = @PNum
		
	END
	
	UPDATE #Index
	SET RunStatus = 1
	WHERE IndexName = @Index

END


