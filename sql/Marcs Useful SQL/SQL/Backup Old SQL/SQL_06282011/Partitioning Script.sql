IF OBJECT_ID('tempdb..#Partition_Admin') IS NOT NULL
DROP TABLe #Partition_Admin

IF OBJECT_ID('tempdb..#PartitionCampaignAdTitleMapping') IS NOT NULL
DROP TABLe #PartitionCampaignAdTitleMapping

CREATE TABLE #PartitionCampaignAdTitleMapping(
	BeginID INT, 
	EndID INT, 
	RecordCount INT
)

DECLARE @RecordCount INT 
,@AdTitleMappingID INT 
,@BeginID INT = 1
,@EndID INT  = 0
,@PartitionCount INT = 0 
,@AvgPartSize INT
,@NumPartitions INT = 501--How many partitions wanted + 1
,@SchemeSQL VARCHAR(MAX)
,@FunctionSQL VARCHAR (MAX)

SELECT AdTitleMappingID
	, COUNT(1) AS RecordCount 
INTO #Partition_Admin 
FROM dbo.CampaignAdTitleMapping 
GROUP BY AdTitleMappingID
ORDER BY AdTitleMappingID

-- Calculate # of rows should be in each Partition
SELECT @AvgPartSize=COUNT(1)/@NumPartitions FROm CampaignAdTitleMapping

DECLARE AdTitleMappingID_cursor CURSOR FORWARD_ONLY FOR 
SELECT AdTitleMappingID,
	RecordCount 
FROM #Partition_Admin 
ORDER BY AdTitleMappingID 

OPEN AdTitleMappingID_cursor; 

FETCH NEXT FROM AdTitleMappingID_cursor 
INTO @AdTitleMappingID, @RecordCount; 

WHILE @@FETCH_STATUS = 0 
BEGIN 
--IF @BeginID = 0 
--	SET @BeginID = 1 


SET @PartitionCount= @PartitionCount + @RecordCount 

SET @EndID = @AdTitleMappingID +1 

IF @PartitionCount > @AvgPartSize 
BEGIN 
INSERT INTO #PartitionCampaignAdTitleMapping (BeginID, EndID, RecordCount) 
VALUES (@BeginID, @EndID,@PartitionCount) 

--SET @EndID = 0 
SET @BeginID = @EndID +1 

SET @PartitionCount = 0 
END 


FETCH NEXT FROM AdTitleMappingID_cursor 
INTO @AdTitleMappingID, @RecordCount; 


END 
CLOSE AdTitleMappingID_cursor 
DEALLOCATE AdTitleMappingID_cursor 


SELECT * 
FROM #PartitionCampaignAdTitleMapping

SET @SchemeSQL = '

CREATE PARTITION SCHEME [PS_CampaignAdTitleMapping] AS PARTITION [PF_CampaignAdTitleMapping] TO ('

SET @FunctionSQL = '

IF  EXISTS (SELECT * FROM sys.partition_schemes WHERE name = N''PS_CampaignAdTitleMapping'')
DROP PARTITION SCHEME [PS_CampaignAdTitleMapping]

IF  EXISTS (SELECT * FROM sys.partition_functions WHERE name = N''PF_CampaignAdTitleMapping'')
DROP PARTITION FUNCTION [PF_CampaignAdTitleMapping]

CREATE PARTITION FUNCTION [PF_CampaignAdTitleMapping](int) AS RANGE RIGHT FOR VALUES ('

DECLARE CreatePart_Cursor CURSOR FORWARD_ONLY FOR 
SELECT EndID 
FROM #PartitionCampaignAdTitleMapping 

OPEN CreatePart_Cursor; 

FETCH NEXT FROM CreatePart_Cursor 
INTO @ENDID; 

WHILE @@FETCH_STATUS = 0 
BEGIN 

SET @BeginID = @BeginID + 1
SET @SchemeSQL = @SchemeSQL +'[PRIMARY],'
SET @FunctionSQL = @FunctionSQL +CAST(@EndID AS VARCHAR)+','

FETCH NEXT FROM CreatePart_Cursor 
INTO @EndID; 


END 
CLOSE CreatePart_Cursor 
DEALLOCATE CreatePart_Cursor


SET @SchemeSQL = @SchemeSQL+ '[PRIMARY])'

SET @FunctionSQL = SUBSTRING(@FunctionSQL,1,LEN(@FunctionSQL)-1) + ')'

PRINT @FunctionSQL
PRINT @SchemeSQL
