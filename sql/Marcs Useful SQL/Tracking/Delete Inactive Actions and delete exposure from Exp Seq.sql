	
	--DECLARE @BeginActionCreateDateUTC DATETIME
	
	--SELECT @BeginActionCreateDateUTC = MAX(EndActionCreateDateUTC)
	--FROM ExposureSequenceDeleteHeader
	--WHERE ProcessEndUTC IS NOT NULL 
	--	AND ErrorMessage IS null
	
	DECLARE @DATE DATETIME
	SET @DATE = '10/01/2011'--CAST(DATEADD(dd,-60, GETUTCDATE()) AS DATE)
	
	WHILE @DATE < '11/25/2011'--GETDATE()
	BEGIN

			UPDATE dbo.TrackedAction
			SET EffectiveEndDateUTC = GETUTCDATE()
			WHERE TrackedActionID IN (
			SELECT DISTINCT TrackedActionID
			FROM SIProcessing_CacheHistory..ExposureSequence
			WHERE ActionClientID IN(SELECT ClientID FROM SIProcessing..AffiliateGroupClients WHERE AffiliateID = 260 AND StatusFlag = 1)
			AND ActionLocalizedCreateDate >= @DATE
			AND ActionLocalizedCreateDate < DATEADD(dd,1, @DAte)
			)
			AND RecordStatus <> 'A'
			
			
		--EXEC SI_SP_ExposureSequence_Delete @InactiveActionDays= 60
			
		DELETE es
		FROM dbo.ExposureSequence es
		WHERE ActionClientID IN(SELECT ClientID FROM SIProcessing..AffiliateGroupClients WHERE AffiliateID = 260 AND StatusFlag = 1)
		AND ActionLocalizedCreateDate >= @DAte
		AND ActionLocalizedCreateDate < DATEADD(dd,1,@Date)
		AND NOT EXISTS (SELECT 1 FROM dbo.TrackedExposure WHERE ClientID = es.ExposureClientID AND TrackedExposureID = es.TrackedExposureID)

			
	PRINT (@Date)
					RAISERROR('',0,1) WITH NOWAIT
	SET @DATE = DATEADD(dd,1,@DATE)
	END