/*
SELECT * FROM SIOLAP..RPT_PS_Summary_AgencyLevel
WHERE GenerateDate < 


exec SI_SP_RPT_UM_AgencySummary_Read
	@ClientID=7490,
	@UserID=4291,
	@StartDate='2013-08-23 00:00:00',
	@EndDate='2013-08-25 00:00:00'	
	
	
*/
DECLARE @ClientID INT,
	@StartDate DATE = '01/01/2013',
	@EndDate DATE = '04/01/2013',
	@Merge BIT  = 1,
	@RC INT


	IF OBJECT_ID('tempdb..#tmp') IS NOT NULL
	DROP TABLE #tmp

	CREATE TABLE #tmp(
		ClientID INT,
		isProcessed BIT

	)

	INSERT INTO #tmp (ClientID, isProcessed)
	SELECT DISTINCT ClientID,0
	FROM SIOLAP..RPT_UM_Summary_AgencyLevel
	WHERE ClientID IN ( 7491,7580)

	
	SET @RC = @@ROWCOUNT

	WHILE EXISTS(SELECT TOP 1 1 FROM #tmp WHERE isProcessed = 0)
	BEGIN

		SELECT TOP 1 @clientID = ClientID FROM #tmp WHERE isProcessed = 0	

		MERGE INTO SIOLAP..RPT_UM_Summary_AgencyLevel AS Target
		USING (
					SELECT @ClientID AS ClientID, GenerateDate,SUM(NumImpressions),SUM(Cost),SUM(NumExposureReported),SUM(ViewBaseTransactionAmount), SUM(ViewBaseTransactionCount), SUM(ClickBaseTransactionAmount),SUM(ClickBaseTransactionCount),SUM(TransactionCountWithWeight), CurrencyID
					FROM SIOLAP..RPT_UM_Summary_CampaignPublisher rpt
					WHERE EXISTS(SELECT 1 FROM Searchignite..tn_ClientHierarchy_Active(@ClientID) WHERE ClientID = rpt.ClientID)
						AND GenerateDate >= @startDate
						AND GenerateDate < @EndDate
					GROUP BY GenerateDate,CurrencyID
				)
			   AS Source (ClientID, GenerateDate, NumImpressions,Cost,NumExposureReported,ViewBaseTransactionAmount,ViewBaseTransactionCount,ClickBaseTransactionAmount,ClickBaseTransactionCount,TransactionCountWithWeight,CurrencyID)
		ON Target.GenerateDate = Source.GenerateDate
			AND Target.ClientID = Source.ClientID
		WHEN MATCHED THEN
			UPDATE SET NumImpressions = Source.NumImpressions,
				Cost = Source.Cost,
				NumExposureReported = Source.NumExposureReported,
				ViewBaseTransactionAmount = Source.ViewBaseTransactionAmount,
				ViewBaseTransactionCount = Source.ViewBaseTransactionCount,
				ClickBaseTransactionAmount = Source.ClickBaseTransactionAmount, 
				ClickBaseTransactionCount = Source.ClickBaseTransactionCount,
				TransactionCountWithWeight = Source.TransactionCountWithWeight,
				CurrencyID = Source.CurrencyID
		WHEN NOT MATCHED BY TARGET THEN
			INSERT (ClientID, GenerateDate,NumImpressions,Cost,NumExposureReported,ViewBaseTransactionAmount,ViewBaseTransactionCount,ClickBaseTransactionAmount, ClickBaseTransactionCount,TransactionCountWithWeight,CurrencyID) 
			VALUES (Source.ClientID, Source.GenerateDate, Source.NumImpressions,Source.Cost,Source.NumExposureReported,Source.ViewBaseTransactionAmount,Source.ViewBaseTransactionCount,Source.ClickBaseTransactionAmount, Source.ClickBaseTransactionCount,Source.TransactionCountWithWeight,Source.CurrencyID)
		WHEN NOT MATCHED BY SOURCE AND Target.ClientID = @ClientID AND Target.GenerateDate >= @StartDate AND Target.GenerateDate < @EndDate THEN	
			DELETE
		;
		
		SET @RC-=1
		
		RAISERROR('%d Processed, %d left',0,1, @clientID, @RC) WITH NOWAIT
		
		UPDATE #tmp
		SET isProcessed = 1
		WHERE ClientID = @ClientID
	END

