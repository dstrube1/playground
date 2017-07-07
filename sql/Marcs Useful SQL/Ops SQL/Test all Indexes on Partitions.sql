
USE SIProcessing_Attribution

SET NOCOUNT ON

DECLARE @Table sysname = 'TrackedExposure'


DECLARE @PNum INT,
	@Index sysname,
	@d_sql VARCHAR(500),
	@PFunction sysname,
	@pcolumn sysname,
	@Icolumn sysname
	
SELECT DISTINCT @PFunction = pf.name
from sys.indexes i
inner join sys.data_spaces ds on i.data_space_id = ds.data_space_id
inner JOIN sys.partition_schemes ps on ds.data_space_id = ps.data_space_id
inner join sys.partition_functions pf on ps.function_id = pf.function_id
WHERE OBJECT_NAME(i.object_id) = @Table

SELECT DISTINCT @pcolumn = c.name
FROM sys.partitions p
INNER JOIN sys.indexes i ON p.[object_id] = i.[object_id]
	and p.index_id = i.index_id
INNER JOIN sys.index_columns ic ON ic.index_id = i.index_id
	AND i.object_id = ic.object_id
	AND partition_ordinal > 0
INNER JOIN sys.columns c ON c.object_id = ic.object_id 
	and c.column_id = ic.column_id
 WHERE OBJECT_NAME(p.object_id) = @Table


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
	RunStatus BIT
)

INSERT INTO #Partition( PNum, RunStatus )
SELECT distinct p.partition_number,0
	FROM sys.partitions p
	WHERE OBJECT_NAME(p.object_id) = @Table
	AND ROWS > 0
	
DECLARE @Junk TABLE(
	ExecStatus BIT
)


WHILE EXISTS(SELECT TOP 1 1 FROM #Index WHERE RunStatus = 0)
BEGIN

	SELECT TOP 1 @Index = IndexName, @Icolumn = FirstColumn
	FROM #Index 
	WHERE RunStatus = 0

	UPDATE #Partition
	SET RunStatus = 0
	
	WHILE EXISTS(SELECT TOP 1 1 FROM #Partition WHERE RunStatus = 0)
	BEGIN
	
		SELECT TOP 1 @PNum = PNum 
		FROM #Partition 
		WHERE RunStatus = 0
		
		--ASC
		SET @d_sql = 'SELECT TOP 1 1 FROM '+CAST( @Table AS VARCHAR(200))+' WITH(INDEX('+CAST(@Index AS VARCHAR(200))+')) WHERE $PARTITION.'+CAST(@PFunction AS VARCHAR(200))+'('+CAST(@PColumn AS VARCHAR(200))+') = '+CAST(@PNum AS VARCHAR(200)) +' ORDER BY '+CAST(@IColumn AS VARCHAR(200))+' ASC'
	
		RAISERROR('%s',0,1,@d_sql) WITH NOWAIT
	
		INSERT INTO @Junk (ExecStatus)
		EXEC (@d_sql)
		
		--DESC
		SET @d_sql = 'SELECT TOP 1 1 FROM '+CAST( @Table AS VARCHAR(200))+' WITH(INDEX('+CAST(@Index AS VARCHAR(200))+')) WHERE $PARTITION.'+CAST(@PFunction AS VARCHAR(200))+'('+CAST(@PColumn AS VARCHAR(200))+') = '+CAST(@PNum AS VARCHAR(200)) +' ORDER BY '+CAST(@IColumn AS VARCHAR(200))+' DESC'
	
		RAISERROR('%s',0,1,@d_sql) WITH NOWAIT
	
		INSERT INTO @Junk (ExecStatus)
		EXEC (@d_sql)
		
		UPDATE #Partition
		SET RunStatus = 1
		WHERE PNum = @PNum
		
	END
	
	UPDATE #Index
	SET RunStatus = 1
	WHERE IndexName = @Index

END


