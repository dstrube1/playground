/*
SELECT TOP 10 * FROM SIOLAP..RPT_Social_Summary_AgencyLevel
WHERE GenerateDate < 
*/
SET NOCOUNT ON

DECLARE @ClientID INT,
	@StartDate DATE = '07/01/2012',
	@EndDate DATE = '11/7/2012',
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
	FROM Searchignite..Clients
	WHERE ClientLevelID = 7
	AND StatusFlag = 1

	
	SET @RC = @@ROWCOUNT

	WHILE EXISTS(SELECT TOP 1 1 FROM #tmp WHERE isProcessed = 0)
	BEGIN

		SELECT TOP 1 @clientID = ClientID FROM #tmp WHERE isProcessed = 0	

		MERGE INTO SIOLAP..RPT_Social_Summary_AgencyLevel AS Target
		USING (
					SELECT @ClientID,rpt.GenerateDate, rpt.SEID,SUM(NumImpressions),SUM(Cost),SUM(NumClicksReported),SUM(NumClicksTracked),SUM(TransactionCount), SUM(TransactionAmount), SUM(TransactionCountWithWeight), SUM(SocialImpressions), SUM(SocialClicks), SUM(SocialCost), SUM(Reach), SUM(SocialReach), SUM(UniqueClicks), SUM(Conversions), SUM(FBActions),CurrencyID
					FROM SIOLAP..RPT_Social_Summary_ClientLevel rpt
					JOIN Searchignite..SearchEngine se ON rpt.SEID = se.SEID
						AND se.StatusFlag = 1
					JOIN Searchignite..SearchEngine_Parent sp ON se.ParentSEID = sp.ParentSEID
						AND sp.ChannelID = 5
					LEFT JOIN ( SELECT GenerateDate,SEID,SUM(Clicks_1day+Clicks_7day+Clicks_28day+Impressions_1day) AS FBActions 
						FROM SIOLAP..RPT_Social_Summary_GroupActions sga
						WHERE EXISTS(SELECT 1 FROM Searchignite..tn_ClientHierarchy_Active(@ClientID) WHERE ClientID = sga.ClientID)
							AND GenerateDate >= @startDate
							AND GenerateDate < @EndDate
						GROUP BY GenerateDate,SEID
						) sg
						ON rpt.SEID = sg.SEID
							AND rpt.GenerateDate = sg.GenerateDate
					WHERE EXISTS(SELECT 1 FROM Searchignite..tn_ClientHierarchy_Active(@ClientID) WHERE ClientID = rpt.ClientID)
						AND rpt.GenerateDate >= @startDate
						AND rpt.GenerateDate < @EndDate
					GROUP BY rpt.GenerateDate,rpt.SEID,CurrencyID
				)
			   AS Source (ClientID,GenerateDate, SEID,NumImpressions,Cost,NumClicksReported,NumClicksTracked,TransactionCount, TransactionAmount, TransactionCountWithWeight, SocialImpressions, SocialClicks, SocialCost, Reach, SocialReach, UniqueClicks, Conversions, FBActions,CurrencyID)
		ON Target.GenerateDate = Source.GenerateDate
			AND Target.ClientID = Source.ClientID
			AND Target.SEID = Source.SEID
		WHEN MATCHED THEN
			UPDATE SET NumImpressions = ISNULL(Source.NumImpressions,0),
				Cost = ISNULL(Source.Cost,0),
				NumClicksReported = ISNULL(Source.NumClicksReported,0),
				NumClicksTracked = ISNULL(Source.NumClicksTracked,0),
				TransactionCount = ISNULL(Source.TransactionCount,0),
				TransactionAmount = ISNULL(Source.TransactionAmount,0), 
				TransactionCountWithWeight = ISNULL(Source.TransactionCountWithWeight,0),
				SocialImpressions = ISNULL(Source.SocialImpressions,0), 
				SocialClicks = ISNULL(Source.SocialClicks,0), 
				SocialCost = ISNULL(Source.SocialCost,0), 
				Reach = ISNULL(Source.Reach,0), 
				SocialReach = ISNULL(Source.SocialReach,0), 
				UniqueClicks = ISNULL(Source.UniqueClicks,0), 
				Conversions = ISNULL(Source.Conversions,0), 
				FBActions = ISNULL(Source.FBActions,0),
				CurrencyID = Source.CurrencyID
		WHEN NOT MATCHED BY TARGET THEN
			INSERT (ClientID,GenerateDate, SEID,NumImpressions,Cost,NumClicksReported,NumClicksTracked,TransactionCount, TransactionAmount, TransactionCountWithWeight, SocialImpressions, SocialClicks, SocialCost, Reach, SocialReach, UniqueClicks, Conversions, FBActions,CurrencyID) 
			VALUES (Source.ClientID,Source.GenerateDate, Source.SEID,ISNULL(Source.NumImpressions,0),ISNULL(Source.Cost,0),ISNULL(Source.NumClicksReported,0),ISNULL(Source.NumClicksTracked,0),ISNULL(Source.TransactionCount,0), ISNULL(Source.TransactionAmount,0), ISNULL(Source.TransactionCountWithWeight,0), ISNULL(Source.SocialImpressions,0), ISNULL(Source.SocialClicks,0), ISNULL(Source.SocialCost,0), ISNULL(Source.Reach,0), ISNULL(Source.SocialReach,0), ISNULL(Source.UniqueClicks,0), ISNULL(Source.Conversions,0), ISNULL(Source.FBActions,0),Source.CurrencyID)
		--WHEN NOT MATCHED BY SOURCE AND Target.ClientID = @ClientID AND Target.GenerateDate >= @StartDate AND Target.GenerateDate < @EndDate THEN	
		--	DELETE
		;
		
		SET @RC-=1
		
		RAISERROR('%d Processed, %d left',0,1, @clientID, @RC) WITH NOWAIT
		
		UPDATE #tmp
		SET isProcessed = 1
		WHERE ClientID = @ClientID
	END

