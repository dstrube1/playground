
USE SIProcessing_Attribution

SET NOCOUNT ON 

DECLARE @MaxPartition INT,
	@MinRecords INT = 200

IF OBJECT_ID('tempdb..#Merge') IS NOT NULL
DROP TABLE #Merge

CREATE TABLE #Merge (
	Merge_value INT,
	ProcessFlag BIT
)

SELECT @MaxPartition = MAX(partition_number)
FROM sys.partitions
WHERE OBJECT_NAME(object_id) = 'TrackedExposure'
	AND rows > 0

INSERT INTO #Merge ( Merge_value,ProcessFlag )
SELECT CAST(rv.value AS INT),0
	FROM sys.partitions p JOIN sys.indexes i
		  ON p.object_id = i.object_id and p.index_id = i.index_id
		   JOIN sys.partition_schemes ps
					ON ps.data_space_id = i.data_space_id
		   JOIN sys.partition_functions f
					   ON f.function_id = ps.function_id
		   LEFT JOIN sys.partition_range_values rv
	ON f.function_id = rv.function_id AND p.partition_number = rv.boundary_id
	WHERE OBJECT_NAME(i.object_id) = 'TrackedExposure'
		AND partition_number < @MaxPartition
	GROUP BY partition_number,rv.value
	HAVING MAX(ROWS) < @MinRecords
	order by 1
	
DECLARE @v INT,
	@d_sql VARCHAR(MAX)
	
WHILE EXISTS (SELECT TOP 1 1 FROM #Merge WHERE ProcessFlag = 0)
BEGIN

	SELECT TOP 1 @v = Merge_value 
	FROM #Merge 
	WHERE ProcessFlag = 0
	
	SET @d_sql = 'ALTER PARTITION FUNCTION PF_SI_ExposureClientID () MERGE RANGE (' +CAST( @v AS VARCHAR)+')'
	
	RAISERROR('%s',0,1,@d_sql) WITH NOWAIT
	
	EXEC (@d_sql)
	
	WAITFOR DELAY'00:00:00.500'
	
	UPDATE #Merge
	SET ProcessFlag = 1
	WHERE Merge_value = @v

END
	