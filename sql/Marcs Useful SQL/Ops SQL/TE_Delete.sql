  
  SELECT partition_number
		,MAX(ROWS)
		, partition_number % 30 AS ModGroup
	FROM sys.partitions p 
	WHERE OBJECT_NAME(p.object_id) = 'TrackedExposure'
	AND ROWS > 0
	GROUP BY partition_number
	ORDER BY 2
	
SELECT TOP 1 1 FROM SIProcessing_Attribution..TrackedExposure WITH(INDEX(IX_ChannelID_LocalizedCreateDate_ClientID_NSEID))--_CorruptPartition
WHERE LocalizedCreateDate < '07/01/2012' 
AND SIProcessing_Attribution.$PARTITION.PF_SI_ExposureClientID(ClientID) = 570
AND ChannelID >0 


SELECT TOP 1 1 FROM SIProcessing_Attribution..TrackedExposure -- WITH(INDEX(IX_ChannelID_LocalizedCreateDate_ClientID_NSEID))--_CorruptPartition
WHERE LocalizedCreateDate < '07/01/2012' 
AND SIProcessing_Attribution.$PARTITION.PF_SI_ExposureClientID(ClientID) = 570
  
  
  SELECT SUM(DeletedRows) + 5248475
  FROM DBA..TrackedExposure_DeleteParallel_Log
  
  SELECT SUM(DeletedRows)
  FROM DBA..TrackedExposure_DeleteParallel_Log
  WHERE StartDate >= '2012-10-29'
  
  SELECT TOP 50 * 
  FROM DBA..TrackedExposure_DeleteParallel_Log
  WHERE StartDate >= '2012-10-29'
  ORDER BY EndDate DESC
 
  SELECT ExecutionNum, SUM(DeletedRows), COUNT(DISTINCT PartitionNumber)
  FROM DBA..TrackedExposure_DeleteParallel_Log
  WHERE StartDate >= '2012-10-29'
  GROUP BY ExecutionNum
  
  SELECT PartitionNumber, SUM(DeletedRows)
  FROM DBA..TrackedExposure_DeleteParallel_Log
  WHERE StartDate >= '2012-10-29'
  GROUP BY PartitionNumber
  ORDER BY PartitionNumber
  
  --MOD GROUP - 2,14
  --PartitionID - 104,332
  
 SELECT * FROM SIProcessing..Clients
 WHERE SIProcessing_Attribution.$PARTITION.PF_SI_ExposureClientID(ClientID) = 38  
  

exec DBA..SI_SP_TrackedExposureDelete @Mod = 30, @ExecNum = 1

UPDATE DBA..DataRetention
SET RetentionDays = 400
WHERE DataRetentionID = 4

  sp_who4 373
  
  sp_who2 20
  
  KILL 94
  
  
  DBCC INPUTBUFFER (21)
  
  EXEC sp_readerrorlog
SELECT * FROM SIProcessing_Attribution.dbo.sysarticles

Select @@version


sp_spaceused 'TrackedExposure'

sp_spaceused 'TrackedExposure_CorruptPartition'
  
  
  UPDATE dr
  SET RetentionDays = 120
  FROM DBA..DataRetention dr
  WHERE DataRetentionID IN (8,10,11,12,18)
  