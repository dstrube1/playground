/*
06/16/2010 MRS Initial	

Future modifications:
At this time Microsoft has not made it available to ALTER INDEX REORGANIZE/REBUILD Partitions 
with options such as set fillfactor, online on, SORT USE TEMPDB. If installed in a later 
release of SQL Server, we can set the fill factor on old partitions to 100 so that it is essentially
a READ-ONLY and rebuild partitions with online on.

Reorganize index if fragmentation level is greater than @Reorg_lvl and less than @Rebuild_lvl
Rebuild index if fragmentation level is greater than @Rebuild_lvl

Reindex Flag Lookup:
0	index fragmentation is below @Reorg_lvl, not changed in stored procedure
1	index fragmentation is greater than @Reorg_lvl and less than @Rebuild_lvl
2	index fragmentation is greater than @Rebuild_lvl

*/

IF  EXISTS (SELECT * FROM JunkDB.sys.objects WHERE name = 'index_by_partition' AND type in (N'U'))
DROP TABLE JunkDB..index_by_partition

CREATE TABLE JunkDB..index_by_partition
(
 object_id int,
 partition_number int,
 index_id int,
 index_name varchar(500),
 avg_fragmentation_in_percent float,
 frag_level_processed bit,
 reindex_flag smallint
)

DECLARE @tablename varchar(50) = 'TrackedExposure',
		@Reorg_lvl int = 15,
		-- Unable to rebuild indexes on Partitions while online. Anything gretaer than 100 should be out of range.
		@Rebuild_lvl int = 101,
		@object_id int,
		@partition# int,
		@index_id int,
		@index_name varchar(500), 
		@index_sql varchar(2000),
		@start_time datetime,
		@maximum_runtime_hr smallint = 6,
		@debug bit = 1
		
INSERT INTO JunkDB..index_by_partition (object_id,partition_number, index_id, index_name, frag_level_processed, reindex_flag)
	SELECT t.OBJECT_ID,p.partition_number, i.index_id, i.name, 0 , 0
		FROM  sys.tables t
			INNER JOIN sys.partitions AS p ON p.OBJECT_ID = t.OBJECT_ID
			INNER JOIN sys.indexes AS i ON t.OBJECT_ID = i.OBJECT_ID AND p.index_id = i.index_id
		WHERE t.name = @tablename  
			--AND i.type_desc ='NONCLUSTERED' 
			--AND p.data_compression =0 --NOT Compressed
		ORDER BY p.partition_number
		

WHILE EXISTS(SELECT * FROM JunkDB..index_by_partition WHERE frag_level_processed = 0)
BEGIN

	SELECT TOP 1 @object_id = object_id, @index_id = index_id, @partition# = partition_number  FROM JunkDB..index_by_partition WHERE frag_level_processed = 0

	UPDATE JunkDB..index_by_partition
		SET avg_fragmentation_in_percent  =
			(SELECT TOP 1 avg_fragmentation_in_percent FROM sys.dm_db_index_physical_stats (DB_ID(), @object_id , @index_id, @partition#, NULL) ORDER BY avg_fragmentation_in_percent desc),
			frag_level_processed = (1)
	WHERE  object_id =@object_id AND index_id = @index_id AND partition_number = @partition#
	
END

UPDATE JunkDB..index_by_partition	
	SET  reindex_flag = 1 
	WHERE avg_fragmentation_in_percent >= @Reorg_lvl AND avg_fragmentation_in_percent < @Rebuild_lvl

UPDATE JunkDB..index_by_partition	
	SET  reindex_flag = 2 
	WHERE avg_fragmentation_in_percent >=  @Rebuild_lvl	



IF @debug = 1
BEGIN
	--Reorganize
	SELECT * FROM JunkDB..index_by_partition WHERE reindex_flag = 1
	--Rebuild
	SELECT * FROM JunkDB..index_by_partition WHERE reindex_flag = 2
END

SET @start_time = GETDATE()

--Create script for Reorganize
WHILE (EXISTS(SELECT * FROM JunkDB..index_by_partition WHERE reindex_flag = 1) AND DATEPART(hour,GETDATE()-@start_time) < @maximum_runtime_hr)
BEGIN
	SELECT TOP 1  @object_id = object_id, @index_name = index_name, @index_id = index_id, @partition# = partition_number  from JunkDB..index_by_partition WHERE reindex_flag = 1
	SET @index_sql = 'ALTER INDEX ' + @index_name + ' ON dbo.' + @tablename + ' REORGANIZE PARTITION =' + cast(@partition# as varchar)

	IF @debug = 1
		PRINT (@index_sql)
		
	ELSE
		EXEC (@index_sql)
	
	UPDATE JunkDB..index_by_partition
		SET  reindex_flag = 0 
	WHERE  object_id =@object_id AND index_id = @index_id AND partition_number = @partition#
	
	WAITFOR DELAY '00:00:00.001';
		
END	

--Create script for Rebuild
WHILE EXISTS(SELECT * FROM  JunkDB..index_by_partition WHERE reindex_flag = 2  AND DATEPART(hour,GETDATE()-@start_time) < @maximum_runtime_hr)
BEGIN
	SELECT TOP 1  @object_id = object_id, @index_name = index_name, @index_id = index_id, @partition# = partition_number  from JunkDB..index_by_partition WHERE reindex_flag = 2
	SET @index_sql = 'ALTER INDEX ' + @index_name + ' ON dbo.' + @tablename + ' REBUILD with (online = on)'

	IF @debug = 1
		Print (@index_sql)
		
	ELSE
		--EXEC (@index_sql)
		SELECT 0
	
	UPDATE JunkDB..index_by_partition
		SET  reindex_flag = 0 
	WHERE  object_id =@object_id AND index_id = @index_id AND partition_number = @partition#
	
	WAITFOR DELAY '00:00:00.001';	
		
END	

-- Needed to make sys.dm_db_index_physical_stats run faster
SET @index_sql = 'UPDATE STATISTICS dbo.'+ @tablename

IF @debug = 1
	PRINT (@index_sql)
ELSE
	EXEC (@index_sql)
