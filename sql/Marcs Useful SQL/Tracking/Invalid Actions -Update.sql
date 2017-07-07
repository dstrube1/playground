	
	SET NOCOUNT ON
	
	DECLARE @ClientID INT,
	@startDate DATETIME = '06/15/2012',
	@endDate DATETIME =  '06/25/2012'
	
	DECLARE @tmp TABLE(
		ClientID INT,
		isProcessed BIT
	)
	
	IF OBJECT_ID('tempdb..#ta') IS NOT NULL
	DROP TABLE #ta
	
	CREATE TABLE #ta(
		TrackedActionID INT,
		CreateDateUTC DATETIME
	)
	
	
	INSERT INTO @tmp( ClientID, isProcessed )
	SELECT DISTINCT MasterClientID, 0
	FROM SIProcessing..External_AdvertiserClient_Mapping
	WHERE ExternalSourceID = 1
		AND StatusFlag = 1	
	
	WHILE EXISTS(SELECT TOP 1 1 FROM @tmp WHERE isProcessed = 0)
	BEGIN
	
		SELECT TOP 1 @ClientID = ClientID FROM @tmp WHERE isProcessed = 0 ORDER BY ClientID
		
		RAISERROR('Client %d Complete',0,1,@ClientID) WITH NOWAIT
		
		INSERT INTO #ta(TrackedActionID,CreateDateUTC)
		SELECT DISTINCT TrackedActionID, CreatedDate
		FROM SIProcessing..TrackedCache tc
		WHERE EXISTS (SELECT 1 FROM SIProcessing_Attribution..TrackedAction WHERE ClientID = @ClientID AND EasternCreateDate = LocalizedCreateDate AND TrackedActionID = tc.TrackedActionID AND RecordStatus = 'I')
			AND EasternCreateDate >= @startDate
			AND EasternCreateDate < @endDate
			AND ClientID = @ClientID
			--AND ChannelID = 4
				
		
		UPDATE @tmp
		SET isProcessed = 1
		WHERE ClientID = @ClientID 
	
	END
	
	
	SELECT * 
	FROM SIProcessing_Attribution..TrackedAction ta
	JOIN #ta tta ON tta.CreateDateUTC = ta.CreateDateUTC
		AND tta.TrackedActionID = ta.TrackedActionID
		
	/*
	
	--35593
	BEGIN TRAN
	UPDATE ta
	SET EffectiveEndDateUTC = GETUTCDATE()
	FROM SIProcessing_Attribution..TrackedAction ta
	JOIN #ta tta ON tta.CreateDateUTC = ta.CreateDateUTC
		AND tta.TrackedActionID = ta.TrackedActionID
	--Commit	
		
	
	SELECT * 
	FROM SIProcessing_CacheHistory..TrackedCache tc
	JOIN #ta ta ON tc.TrackedActionID = ta.TrackedActionID
	*/
		