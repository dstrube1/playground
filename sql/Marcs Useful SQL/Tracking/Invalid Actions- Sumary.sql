	
	SET NOCOUNT ON
	
	DECLARE @ClientID INT,
	@startDate DATETIME = '06/15/2012',
	@endDate DATETIME =  '06/25/2012'
	
	DECLARE @tmp TABLE(
		ClientID INT,
		isProcessed BIT
	)
		
	IF OBJECT_ID('tempdb..#data') IS NOT NULL
	DROP TABLE #data
	
	CREATE TABLE #data(
		ClientID INT,
		ChannelID INT,
		EasternDate DATE,
		NumActID INT,
		ActionQuantity INT,
		Rev MONEY
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
		
		INSERT INTO #data(ClientID,ChannelID,EasternDate,NumActID,ActionQuantity,Rev)
		SELECT @ClientID, ChannelID,CAST(EasternCreateDate AS DATE) AS EasternDate, COUNT(DISTINCT TrackedActionID) AS NumActID, SUM(ActionQuantity) AS ActionQuantity, SUM(TransactionAmount) AS Rev
		FROM SIProcessing..TrackedCache tc
		WHERE EXISTS (SELECT 1 FROM SIProcessing_Attribution..TrackedAction WHERE ClientID = @ClientID AND EasternCreateDate = LocalizedCreateDate AND TrackedActionID = tc.TrackedActionID AND RecordStatus = 'I')
			AND EasternCreateDate >= @startDate
			AND EasternCreateDate < @endDate
			AND ClientID = @ClientID
			--AND ChannelID = 4
		GROUP BY ChannelID,CAST(EasternCreateDate AS DATE)
				
		
		UPDATE @tmp
		SET isProcessed = 1
		WHERE ClientID = @ClientID 
	
	END
	
	
	SELECT * FROM #data
	
	
	--exec SIProcessing_CacheHistory..SI_SP_ExposureSequence_Delete @InactiveActionDays=  30
	