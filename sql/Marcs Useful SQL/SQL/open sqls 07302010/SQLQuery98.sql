SELECT avg_fragmentation_in_percent FROM sys.dm_db_index_physical_stats (DB_ID(), 1639676889, 3, 350, NULL)
SELECT * FROM sys.dm_db_index_physical_stats (DB_ID(), 1639676889, 3, 350, NULL)

SELECT * from sys.tables where name = 'TrackedExposure'

ALTER INDEX ChannelID_LocalizedCreateDate_ClientID_SEID ON dbo.TrackedExposure REBUILD PARTITION = 3
SELECT TOP 1 avg_fragmentation_in_percent FROM sys.dm_db_index_physical_stats (DB_ID(), 1639676889, 3, 350, NULL) ORDER BY avg_fragmentation_in_percent desc