/*
SELECT * FROM SIOLAP..RPT_PS_Summary_AgencyLevel
WHERE GenerateDate < 
*/
DECLARE @ClientID INT,
	@StartDate DATE = '07/01/2012',
	@EndDate DATE = '10/15/2012',
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
	FROM SIOLAP..RPT_PS_Summary_AgencyLevel

	
	SET @RC = @@ROWCOUNT

	WHILE EXISTS(SELECT TOP 1 1 FROM #tmp WHERE isProcessed = 0)
	BEGIN

		SELECT TOP 1 @clientID = ClientID FROM #tmp WHERE isProcessed = 0	

		MERGE INTO SIOLAP..RPT_PS_Summary_AgencyLevel AS Target
		USING (
					SELECT @ClientID AS ClientID, GenerateDate, rpt.SEID,SUM(NumImpressions),SUM(Cost),SUM(NumClicksReported),SUM(NumClicksTracked),SUM(TransactionCount+TTCount), SUM(TransactionAmount), SUM(TotalRank),SUM(TotalRankCount),SUM(TransactionCountWithWeight), CurrencyID
					FROM SIOLAP..RPT_PS_Summary_ClientLevel rpt
					JOIN Searchignite..SearchEngine se ON rpt.SEID = se.SEID
						AND se.StatusFlag = 1
					JOIN Searchignite..SearchEngine_Parent sp ON se.ParentSEID = sp.ParentSEID
						AND sp.ChannelID = 1
					WHERE EXISTS(SELECT 1 FROM Searchignite..tn_ClientHierarchy_Active(@ClientID) WHERE ClientID = rpt.ClientID)
						AND GenerateDate >= @startDate
						AND GenerateDate < @EndDate
					GROUP BY GenerateDate,rpt.SEID,CurrencyID
				)
			   AS Source (ClientID, GenerateDate, SEID,NumImpressions,Cost,NumClicksReported,NumClicksTracked,TransactionCount,TransactionAmount, TotalRank,TotalRankCount,TransactionCountWithWeight,CurrencyID)
		ON Target.GenerateDate = Source.GenerateDate
			AND Target.ClientID = Source.ClientID
			AND Target.SEID = Source.SEID
		WHEN MATCHED THEN
			UPDATE SET NumImpressions = Source.NumImpressions,
				Cost = Source.Cost,
				NumClicksReported = Source.NumClicksReported,
				NumClicksTracked = Source.NumClicksTracked,
				TransactionCount = Source.TransactionCount,
				TransactionAmount = Source.TransactionAmount, 
				TotalRank = Source.TotalRank,
				TotalRankCount = Source.TotalRankCount,
				TransactionCountWithWeight = Source.TransactionCountWithWeight,
				CurrencyID = Source.CurrencyID
		WHEN NOT MATCHED BY TARGET THEN
			INSERT (ClientID, GenerateDate, SEID,NumImpressions,Cost,NumClicksReported,NumClicksTracked,TransactionCount,TransactionAmount, TotalRank,TotalRankCount,TransactionCountWithWeight,CurrencyID) 
			VALUES (Source.ClientID, Source.GenerateDate, Source.SEID,Source.NumImpressions,Source.Cost,Source.NumClicksReported,Source.NumClicksTracked,Source.TransactionCount,Source.TransactionAmount, Source.TotalRank,Source.TotalRankCount,Source.TransactionCountWithWeight,Source.CurrencyID)
		WHEN NOT MATCHED BY SOURCE AND Target.ClientID = @ClientID AND Target.GenerateDate >= @StartDate AND Target.GenerateDate < @EndDate THEN	
			DELETE
		;
		
		SET @RC-=1
		
		RAISERROR('%d Processed, %d left',0,1, @clientID, @RC) WITH NOWAIT
		
		UPDATE #tmp
		SET isProcessed = 1
		WHERE ClientID = @ClientID
	END

