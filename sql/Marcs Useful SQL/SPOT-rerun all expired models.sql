
/*
EXEC dbo.SI_SSIS_Optimization_GetNextSpotID '05/30/2012 00:00:00', 1

SELECT * FROM dbo.LUOptimizationGroupStatus

SELECT CAST(CreateDate AS DATE), COUNT(1)
FROM dbo.CSKFutureBid
GROUP BY CAST(CreateDate AS DATE)
ORDER BY CAST(CreateDate AS DATE)
*/

DECLARE @SpotID INT,
	@date_text VARCHAR(50)

DECLARE @temp TABLE (
	SpotID INT,
	isProcessed BIT
)


INSERT INTO @temp
SELECT SPOTID, 0
SELECT *
FROM DMS_SPOT..CampaignOptimizerSettings
WHERE --OptimizationGroupStatusID =4 AND 
	StatusFlag = 1
	AND ClientID = 5006
ORDER BY SPOTID

/*
UPDATE DMS_SPOT..CampaignOptimizerSettings
SET OptimizationGroupStatusID = 4
WHERE SPOTID = 9804

SELECT * FROM Searchignite..LUOptimizationGroupStatus
*/
SELECT SpotID FROM @temp
	
WHILE EXISTS(SELECT TOP 1 1 FROM @temp WHERE isProcessed = 0)
BEGIN

	SELECT TOP 1 @SpotID = SpotID FROM @temp WHERE isProcessed = 0
	
	SET @date_text = CONVERT(VARCHAR,GETDATE(), 121)
	
	RAISERROR('Starting SpotID (%d) at %s',0,1,@SpotID,@date_text) WITH NOWAIT
	
	EXEC dbo.SI_SP_OptimizationManagement_CallSpot_CreateCache 9804
	
	SELECT 1 FROM DMS_Spot.dbo.SPOTAdgroups WHERE SPOTID = 9804
	
	EXEC SI_SP_OptimizationManagement_Spot_Automation @SpotID
	
	UPDATE @temp
	SET isProcessed = 1
	WHERE SpotID = @SpotID

END
	
