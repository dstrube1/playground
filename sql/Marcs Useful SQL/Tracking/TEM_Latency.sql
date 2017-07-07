
USE SIProcessing_Attribution

DECLARE @LatencySec INT,
	@PNUM INT


	SELECT @PNum = MAX(Partition_number )
	FROM sys.partitions p JOIN sys.indexes i
		  ON p.object_id = i.object_id and p.index_id = i.index_id
		   JOIN sys.partition_schemes ps
					ON ps.data_space_id = i.data_space_id
		   JOIN sys.partition_functions f
					   ON f.function_id = ps.function_id
		   LEFT JOIN sys.partition_range_values rv
	ON f.function_id = rv.function_id AND p.partition_number = rv.boundary_id
	WHERE OBJECT_NAME(i.object_id) = 'TrackedExposureMaster'
	AND ROWS > 0
	
	
SELECT @LatencySec = DATEDIFF(S,MAX(CreateDateUTC),GETUTCDATE())
FROM TrackedExposureMaster WITH (NOLOCK)
WHERE $Partition.PF_SI_TrackedExposureMasterByDay(CreateDateUTC) = @PNUM
	AND TrackingSourceID = 1

SELECT CAST( 
		CAST(@LatencySec/3600 % 60 AS VARCHAR(30)) +
		':' + CAST(@LatencySec/60 % 60 AS VARCHAR(30)) +
		':' + CAST(@LatencySec % 60 AS VARCHAR(30))
	 AS TIME(0))
	 