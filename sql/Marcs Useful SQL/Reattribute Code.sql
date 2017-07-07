/*
UPDATE dbo.AttributionReprocessQueue
SET isActive = 0
*/
USE SIProcessing_CacheHistory

DECLARE @tmp TABLE(
	ClientID INT,
	AffiliateID INT NULL,
	isProcessed BIT
)

INSERT INTO @tmp( ClientID,AffiliateID, isProcessed )
SELECT ParseID AS ClientID,agc.AffiliateID, 0 
FROM SIProcessing.dbo.fn_ParseNumList('2537') fn
LEFT JOIN SIProcessing..AffiliateGroupClients agc ON fn.ParseID = agc.ClientID
	AND agc.StatusFlag = 1

DECLARE @ClientID INT,
	@AffiliateID INT,
	@Start DATETIME = '05/30/2012',
	@End	DATETIME = '06/01/2012',
	@Comment VARCHAR(100) = 'Reattribute 2537 Client Services Error',
	@WithCounts BIT = 1

IF @WithCounts = 1
BEGIN	

	RAISERROR('Running Counts',0,1) WITH NOWAIT

	IF OBJECT_ID('tempdb..#counts') IS NOT NULL	
		DROP TABLE #counts

	CREATE TABLE #counts(
		ClientID INT,
		EDate DATE,
		ChannelID INT,
		ExposureCount INT,
		ActionCount INT,
		PrePost BIT
	)

	INSERT INTO #counts( ClientID ,EDate ,ChannelID ,ExposureCount ,ActionCount,PrePost)
	SELECT ClientID , CAST(EasternCreateDate AS DATE), ChannelID, COUNT(DISTINCT TrackedExposureID), COUNT(DISTINCT TrackedActionID),0
	FROM dbo.TrackedCache tc
	WHERE EasternCreateDate >=DATEADD(dd,-2,@Start)
		AND EasternCreateDate < DATEADD(dd,2,@End)
		AND EXISTS (SELECT 1 FROM @tmp WHERE ClientID = tc.ClientID)
	GROUP BY ClientID , CAST(EasternCreateDate AS DATE), ChannelID
	ORDER BY ClientID , CAST(EasternCreateDate AS DATE), ChannelID
END
	
WHILE EXISTS(SELECT TOP 1 1 FROM @tmp WHERE isProcessed = 0 AND AffiliateID IS NULL)
BEGIN
	
	SELECT TOP 1 @ClientID = ClientID FROM @tmp WHERE isProcessed = 0
	
	RAISERROR('Processing ClientID: %d',0,1,@ClientId) WITH NOWAIT
	
	EXEC SI_SP_AttributionReprocessQueue_InsertUpdate
		@affiliateID =NULL
		,@ClientID = @ClientID
		,@LocalizedBeginDate = @start
		,@LocalizedEndDate = @End
		,@Notes = @Comment
		,@isAttributionOnly = 0

	UPDATE @tmp
	SET isProcessed = 1
	WHERE ClientID = @ClientID

END

	
WHILE EXISTS(SELECT TOP 1 1 FROM @tmp WHERE isProcessed = 0 AND AffiliateID IS NOT NULL)
BEGIN
	
	SELECT TOP 1 @AffiliateID=AffiliateID,
		@ClientID = MIN(ClientID)
	FROM @tmp WHERE isProcessed = 0
		AND AffiliateID IS NOT NULL
	GROUP BY AffiliateID
	
	RAISERROR('Processing AffiliateID: %d',0,1,@AffiliateID) WITH NOWAIT
	
	EXEC SI_SP_AttributionReprocessQueue_InsertUpdate
		@affiliateID =@AffiliateID
		,@ClientID = @ClientID
		,@LocalizedBeginDate = @start
		,@LocalizedEndDate = @End
		,@Notes = @Comment
		,@isAttributionOnly = 0

	UPDATE @tmp
	SET isProcessed = 1
	WHERE affiliateID =@AffiliateID

END
	
RAISERROR('Starting Attribution',0,1) WITH NOWAIT
EXEC SI_SP_AttributionReprocess @debug = 0, @RunTimeHrs = 5

IF @WithCounts = 1
BEGIN	

	INSERT INTO #counts( ClientID ,EDate ,ChannelID ,ExposureCount ,ActionCount, PrePost)
	SELECT ClientID , CAST(EasternCreateDate AS DATE), ChannelID, COUNT(DISTINCT TrackedExposureID), COUNT(DISTINCT TrackedActionID),1
	FROM dbo.TrackedCache tc
	WHERE EasternCreateDate >=DATEADD(dd,-2,@Start)
		AND EasternCreateDate < DATEADD(dd,2,@End)
		AND EXISTS (SELECT 1 FROM @tmp WHERE ClientID = tc.ClientID)
	GROUP BY ClientID , CAST(EasternCreateDate AS DATE), ChannelID
	ORDER BY ClientID , CAST(EasternCreateDate AS DATE), ChannelID


	SELECT  c1.ClientID ,
			c1.EDate ,
			c1.ChannelID ,
			c1.ExposureCount AS Prev_ExposureCount,
			c2.ExposureCount ,
			c1.ActionCount AS Prev_ActionCount,
			c2.ActionCount 
	FROM #counts c1
	FULL JOIN #counts c2 ON c1.EDate = c2.EDate
		AND c1.ClientID = c2.ClientID
		AND c1.ChannelID = c2.ChannelID
		AND (c1.ExposureCount <> c2.ExposureCount
			OR c1.ActionCount <> c2.ActionCount)
	WHERE c2.PrePost = 1
		AND c1.PrePost = 0 
	ORDER BY ClientID, ChannelID, Edate
	
END