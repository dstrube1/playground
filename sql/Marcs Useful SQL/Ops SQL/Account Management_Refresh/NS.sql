
DECLARE @ClientID INT = 1,
	@StartDate DATE = '07/01/2012',
	@EndDate DATE = '09/01/2012',
	@Merge BIT  = 1,
	@RC INT

IF @Merge = 0
BEGIN

	SELECT @ClientID, GenerateDate, SUM(NumClicksTracked) AS NumClicksTracked, SUM(TransactionAmount) AS TransactionAmount, SUM(TransactionCountWithWeight) AS TransactionCountWithWeight, SUM(TTCount) AS TransactionCount, CurrencyID
	FROM SIOLAP..RPT_NS_Summary_Client rpt
	JOIN Searchignite..NatureSearchEngine ns ON rpt.NSEID = ns.NSEID
	WHERE EXISTS(SELECT 1 FROM Searchignite..tn_ClientHierarchy_Active(@ClientID) WHERE ClientID = rpt.ClientID)
		AND GenerateDate >= @startDate
		AND GenerateDate < @EndDate
	GROUP BY GenerateDate,CurrencyID
		
	SELECT * 
	FROM SIOLAP..RPT_NS_Summary_AgencyLevel
	WHERE ClientID = @ClientID
	AND GenerateDate >= @StartDate
	AND GenerateDate < @EndDate

END

ELSE
BEGIN

	IF OBJECT_ID('tempdb..#tmp') IS NOT NULL
	DROP TABLE #tmp

	CREATE TABLE #tmp(
		ClientID INT,
		isProcessed BIT

	)

	INSERT INTO #tmp (ClientID, isProcessed)
	SELECT DISTINCT ClientID,0
	FROM SIOLAP..RPT_NS_Summary_AgencyLevel
	
	SET @RC = @@ROWCOUNT

	WHILE EXISTS(SELECT TOP 1 1 FROM #tmp WHERE isProcessed = 0)
	BEGIN

		SELECT TOP 1 @clientID = ClientID FROM #tmp WHERE isProcessed = 0	

		MERGE INTO SIOLAP..RPT_NS_Summary_AgencyLevel AS Target
		USING (
					SELECT @ClientID AS ClientID, GenerateDate, SUM(NumClicksTracked) AS NumClicksTracked, SUM(TransactionAmount) AS TransactionAmount, SUM(TransactionCountWithWeight) AS TransactionCountWithWeight, SUM(TTCount) AS TransactionCount, CurrencyID
					FROM SIOLAP..RPT_NS_Summary_Client rpt
					JOIN Searchignite..NatureSearchEngine ns ON rpt.NSEID = ns.NSEID
					WHERE EXISTS(SELECT 1 FROM Searchignite..tn_ClientHierarchy_Active(@ClientID) WHERE ClientID = rpt.ClientID)
						AND GenerateDate >= @startDate
						AND GenerateDate < @EndDate
					GROUP BY GenerateDate,CurrencyID
				)
			   AS Source
		ON Target.GenerateDate = Source.GenerateDate
			AND Target.CurrencyID = Source.CurrencyID
			AND Target.ClientID = Source.ClientID
		WHEN MATCHED THEN
			UPDATE SET NumClicksTracked = Source.NumClicksTracked,
				TransactionAmount = Source.TransactionAmount,
				TransactionCountWithWeight = Source.TransactionCountWithWeight,
				TransactionCount = Source.TransactionCount
		WHEN NOT MATCHED BY TARGET THEN
			INSERT (ClientID,GenerateDate,NumClicksTracked,TransactionAmount,TransactionCountWithWeight,TransactionCount,CurrencyID) 
			VALUES (Source.ClientID,Source.GenerateDate,Source.NumClicksTracked,Source.TransactionAmount,Source.TransactionCountWithWeight,Source.TransactionCount,Source.CurrencyID)
		;
		
		SET @RC-=1
		
		RAISERROR('%d Processed, %d left',0,1, @clientID, @RC) WITH NOWAIT
		
		UPDATE #tmp
		SET isProcessed = 1
		WHERE ClientID = @ClientID
	END

END

