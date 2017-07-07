	
	SET NOCOUNT ON
	
	DECLARE @ClientID INT,
		@startDate DATETIME = '06/20/2012',
		@endDate DATETIME =  '06/28/2012',
		@runDate DATETIME,
		@runDate_var VARCHAR(30),
		@IgnoreMoreInfo_Paid BIT,
		@DuplicateTransSeconds_Paid INT
		
	DECLARE @tmp TABLE(
		ClientID INT,
		isProcessed BIT
	)
		
		
		IF OBJECT_ID('tempdb..#affect_ac') IS NOT NULL
			DROP TABLE #affect_ac
		
		CREATE TABLE #affect_ac (
			TrackedActionID BIGINT,
			ClientID INT,
			CreateDateUTC DATETIME,
			Moreinfo NVARCHAR(255) COLLATE Latin1_General_CI_AS_KS_WS NULL,
			CustomerTransactionTypeID INt,
			TransactionAmount MONEY,
			RNum INT
		)
	
	INSERT INTO @tmp( ClientID, isProcessed )
	SELECT DISTINCT MasterClientID, 0
	FROM SIProcessing..External_AdvertiserClient_Mapping eam
	WHERE ExternalSourceID = 1
		AND StatusFlag = 1
		AND EXISTS(SELECT 1 FROM SIProcessing..CLientMailoption WHERE IgnoreMoreInfo_Paid = 0 AND ClientID = eam.MasterClientID)
		--AND ClientID = 2537
	
	WHILE EXISTS(SELECT TOP 1 1 FROM @tmp WHERE isProcessed = 0)
	BEGIN
	
	IF OBJECT_ID('tempdb..#dfa') IS NOT NULL
			DROP TABLE #dfa
			
			CREATE TABLE #dfa (
				trackedactionid BIGINT , 
				UserUniqueGUID VARCHAR(36), 
				ClientID INt,
				AffiliateID INT,
				CreateDateUTC DATETIME, 
				CustomerTransactionTypeID INt,
				TransactionAmount MONEY,
				[MoreInfo] [nvarchar] (255) COLLATE Latin1_General_CI_AS_KS_WS NULL,
				HashKey INT,
				TransactionDatetime_LBOUND DATETIME,
				TransactionDatetime_UBOUND DATETIME
			)


	
		SELECT TOP 1 @ClientID = ClientID FROM @tmp WHERE isProcessed = 0 ORDER BY ClientID
			SELECT @IgnoreMoreInfo_Paid = IgnoreMoreInfo_Paid,@DuplicateTransSeconds_Paid =DuplicateTransSeconds_Paid FROM SIProcessing..ClientMailOption WHERE ClientID = @ClientID
			
			
		
		RAISERROR('Client %d Starting',0,1,@ClientID) WITH NOWAIT
		
		SET @Rundate = @startDate
		
		WHILE (@runDate < @endDate)
		BEGIN
		
			SET @runDate_var = CAST(@runDate AS VARCHAR)
		
			RAISERROR('		Running %s',0,1,@runDate_var) WITH NOWAIT
		
			INSERT INTO #dfa (trackedactionid, UserUniqueGUID, ClientID,AffiliateID,CreateDateUTC, CustomerTransactionTypeID,TransactionAmount,MoreInfo,HashKey,TransactionDatetime_LBOUND,TransactionDatetime_UBOUND)
			   SELECT   trackedactionid, UserUniqueGUID, ClientID,AffiliateID,CreateDateUTC, CustomerTransactionTypeID,TransactionAmount,MoreInfo,HashKey,DATEADD(SECOND, -@DuplicateTransSeconds_Paid,  CreateDateUTC),DATEADD(SECOND, @DuplicateTransSeconds_Paid,  CreateDateUTC)
			   FROM     SIProcessing_Attribution..TrackedAction
			   WHERE    CreateDateUTC >= @runDate
                    AND CreateDateUTC < DATEADD(dd,1,@runDate)
                    AND ClientID = @ClientID
                    AND RecordStatus = 'A'
                    AND (TrackingSourceID = 3 OR TrackedActionID_PREV IS NOT NULL)
                    AND ISNULL(MoreInfo,'') NOT IN ('','1')
            
            SET @runDate = DATEADD(dd,1,@runDate)

		END
			RAISERROR('Detecting dups',0,1) WITH NOWAIT
			
						
			IF EXISTS(SELECT 1 FROM dbo.AffiliateGroupClients WHERE ClientID = @ClientID AND StatusFlag = 1)
			BEGIN
			
				RAISERROR('		Affiliate Index Building',0,1) WITH NOWAIT
				CREATE CLUSTERED INDEX CX_dfa_temp ON #dfa (MoreInfo,CustomerTransactionTypeID,AffiliateID, TransactionAmount,trackedactionid,CreateDateUTC)
				
				RAISERROR('		Inserting Actions that match from TrackedAction',0,1) WITH NOWAIT
				INSERT #affect_ac( TrackedActionID, clientID, CreateDateUTC,Moreinfo,CustomerTransactionTypeID,TransactionAmount )
				SELECT d1.trackedactionid,d1.clientID, d1.CreateDateUTC,NULL,NULL,NULL
				FROM SIProcessing_Attribution..TrackedAction d1 WITH (INDEX(IX_MoreInfo_RecordStatus__TrackedActionID__CreateDateUTC_LocalizedCreateDate_ClientID_TrackedActionID))
				JOIN #dfa d2 ON d1.CLientID IN (SELECT ClientID FROM dbo.AffiliateGroupClients WHERE AffiliateID = d2.AffiliateID AND StatusFlag = 1)
					 AND d1.CustomerTransactionTypeID = d2.CustomerTransactionTypeID
					 AND d1.TransactionAmount = d2.TransactionAmount
					 AND d1.trackedactionid <> d2.trackedactionid
					 AND d1.CreateDateUTC >= d2.TransactionDatetime_LBOUND
					 AND d1.CreateDateUTC <= d2.TransactionDatetime_UBOUND
					 AND d1.MoreInfo = d2.MoreInfo
					 AND d1.RecordStatus = 'A'

			END
			ELSE 
				BEGIN
				
				RAISERROR('		NonAffiliate Index Building',0,1) WITH NOWAIT
				CREATE CLUSTERED INDEX CX_dfa_temp ON #dfa (MoreInfo,CustomerTransactionTypeID,ClientID, TransactionAmount,trackedactionid,CreateDateUTC)
					
								
				RAISERROR('		Inserting Actions that match from TrackedAction',0,1) WITH NOWAIT
				INSERT #affect_ac( TrackedActionID, clientID, CreateDateUTC,Moreinfo,CustomerTransactionTypeID,TransactionAmount )
				SELECT d1.trackedactionid,d1.clientID, d1.CreateDateUTC,NULL,NULL,NULL
				FROM SIProcessing_Attribution..TrackedAction d1 WITH (INDEX(IX_MoreInfo_RecordStatus__TrackedActionID__CreateDateUTC_LocalizedCreateDate_ClientID_TrackedActionID))
				JOIN #dfa d2 ON d1.ClientID = d2.ClientID
					 AND d1.CustomerTransactionTypeID = d2.CustomerTransactionTypeID
					 AND d1.TransactionAmount = d2.TransactionAmount
					 AND d1.trackedactionid <> d2.trackedactionid
					 AND d1.CreateDateUTC >= d2.TransactionDatetime_LBOUND
					 AND d1.CreateDateUTC <= d2.TransactionDatetime_UBOUND
					 AND d1.MoreInfo = d2.MoreInfo
					 AND d1.RecordStatus = 'A'

			END
			
								 
		RAISERROR('		Update @affect_ac',0,1) WITH NOWAIT
		UPDATE ac
		SET Moreinfo = ta.MoreInfo,
			CustomerTransactionTypeID = ta.CustomerTransactionTypeID,
			TransactionAmount = ta.TransactionAmount
		FROM #affect_ac ac
		JOIN SIProcessing_Attribution..TrackedAction ta ON ta.TrackedActionID = ac.TrackedActionID
			AND ta.CreateDateUTC = ac.CreateDateUTC
			AND ta.ClientID = ac.ClientID
			AND RecordStatus = 'A'
		WHERE ac.ClientID = @ClientID
		
		RAISERROR('		Insert Actions that had match',0,1) WITH NOWAIT
		INSERT #affect_ac( TrackedActionID, clientID, CreateDateUTC,Moreinfo,CustomerTransactionTypeID,TransactionAmount )
		SELECT d1.trackedactionid,d1.clientID, d1.CreateDateUTC,d1.Moreinfo,d1.CustomerTransactionTypeID,d1.TransactionAmount
		FROM #dfa d1
		JOIN #affect_ac d2 ON d1.ClientID = d2.ClientID
			 AND d1.CustomerTransactionTypeID = d2.CustomerTransactionTypeID
			 AND d1.TransactionAmount = d2.TransactionAmount
			 AND d1.MoreInfo = d2.MoreInfo
		WHERE d1.ClientID = @ClientID
		
		UPDATE @tmp
		SET isProcessed = 1
		WHERE ClientID = @ClientID 
	
	END

SET NOCOUNT OFF	
	
	SELECT * FROM #affect_ac
	
SELECT  ROW_NUMBER() OVER (PARTITION BY MoreInfo ORDER BY TrackingSourceID DESC,CreateDateUTC) RNUM,*
FROM SIProcessing_attribution..TrackedAction ta
WHERE EXISTS(SELECT 1 FROM #affect_ac WHERE ta.TrackedActionID = TrackedActionID AND CreateDateUTC = ta.CreateDateUTC)
AND ClientID = 2537

/*

BEGIN TRAN
	UPDATE ta
	SET RecordStatus = 'I',
		EffectiveEndDateUTC = GETUTCDATE()
	FROM  SIProcessing_Attribution.dbo.TrackedAction ta
	WHERE TRackedActionID IN (
		SELECT TrackedActionID FROM (
		SELECT  ROW_NUMBER() OVER (PARTITION BY MoreInfo ORDER BY TrackingSourceID DESC,CreateDateUTC) RNUM,ta.TrackedActionID
		FROM SIProcessing_attribution..TrackedAction ta
		WHERE EXISTS(SELECT 1 FROM #affect_ac WHERE ta.TrackedActionID = TrackedActionID AND CreateDateUTC = ta.CreateDateUTC)
		) r
		WHERE rnum  = 1 AND TrackingSourceID = 3
	)
--3390
--commit
*/

--exec SI_SP_ExposureSequence_Delete @InactiveActionDays=  30


SET NOCOUNT OFF
		
/*	
			SELECT ROW_NUMBER() OVER (PARTITION BY MoreInfo ORDER BY CreateDateUTC),*
			FROM #affect_ac
	
			SELECT ta.ClientID,  CAST(ta.CreateDateUTC AS DATE) , COUNT(1)
			FROM SIProcessing_attribution..TrackedAction ta
			JOIN #affect_ac ac ON ta.TrackedActionID = ac.TrackedActionID
				AND ta.CreateDateUTC = ac.CreateDateUTC
				AND ta.ClientID = ac.ClientID
			GROUP BY ta.ClientID,  CAST(ta.CreateDateUTC AS DATE )
			ORDER BY ta.ClientID,  CAST(ta.CreateDateUTC AS DATE )
	
			CREATE CLUSTERED INDEX CX_tmp_affect_ac ON #affect_ac (TrackedActionID, CreateDateUTC,clientID)
			
			tempdb..sp_spaceused '#affect_ac'
			
			SET ROWCOUNT 0
			
			DECLARE @rcount INT  = 2
			
			WHILE @rcount > 0
			BEGIN
				DELETE ac
				FROM (
					SELECT ROW_NUMBER() OVER (PARTITION BY TrackedActionID ORDER BY CreateDateUTC) RNum 
					FROM #affect_ac
				) ac
				WHERE RNum>2
				
				SET @rcount = @@ROWCOUNT
				
				RAISERROR('Batch Complete',0,1) WITH NOWAIT
			END
			
			SET NOCOUNT OFF
			
			SELECT  ROW_NUMBER() OVER (PARTITION BY ta.Moreinfo ORDER BY ta.TrackedActionID) RNum,ta.*
			FROM SIProcessing_attribution..TrackedAction ta
			WHERE EXISTS(SELECT 1 FROM #affect_ac ac WHERE ta.TrackedActionID = ac.TrackedActionID
					AND ta.CreateDateUTC = ac.CreateDateUTC
					AND ta.ClientID = ac.ClientID
					--AND ac.ClientID = 1637
					--AND ac.CreateDateUTC >= '06/24/2012'
					--AND ac.CreateDateUTC < '06/25/2012'
					)
					
					SELECT* 
					FROM SIProcessing_Attribution..TrackedAction 
					WHERE TrackedActionID IN( 1191013199,1191013216)
					
					SELECT * FROM dbo.ClientMailOption WHERE ClientID = 1637
	

	
	--exec SIProcessing_CacheHistory..SI_SP_ExposureSequence_Delete @InactiveActionDays=  30
	
		*/	