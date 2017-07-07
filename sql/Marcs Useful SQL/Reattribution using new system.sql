
SELECT *
FROM dbo.AffiliateGroupClients
WHERE CLientID = 2537

--Add Record to be reattributed and resummarized:
EXEC SIProcessing_CacheHistory..SI_SP_AttributionReprocessQueue_InsertUpdate
                @affiliateID = 211
                ,@ClientID = 4712
                ,@LocalizedBeginDate = '11/10/2011'
                ,@LocalizedEndDate = '11/16/2011'
                ,@Notes ='Reattribute Cap One'
                ,@isAttributionOnly = 0
  
UPDATE dbo.AttributionReprocessQueue
SET         isActive = 1,
                LocalizedBeginDate = '11/01/2011',
                LocalizedEndDate = '11/19/2011',
                Notes = 'Resummarize DFA'
WHERE ClientID = 2537


--Check whats in the queue:
select * from AttributionReprocessQueue
WHERE IsActive  = 1 
ORDER BY CLientID


--SP for Reattribution
EXEC SI_SP_AttributionReprocess @debug = 1, @RunTimeHrs = 3



                        EXEC SI_SP_Transaction_TE4_FromExposureSEQ_load 
                            @AffiliateID = 204,
                            @BeginDateLocalized = '10/31/2011',
                            @EndDateLocalized = '11/10/2011'
/*

	
	WITH PAID AS(
	SELECT ChannelID,CAST(EasternCreateDate AS DATE) AS DATE,SUM(ActionQuantity) AS TTCOUNT,COUNT(1) AS rec
		FROM SIProcessing_CacheHistory.. TrackedCache
		WHERE ClientID = 2537
		AND EasternCreateDate >= '10/01/2011'
		AND EasternCreateDate < '11/01/2011'
		AND ChannelID  = 1
		GROUP BY ChannelID,CAST(EasternCreateDate AS DATE)
),  DFA AS(
	SELECT ChannelID,CAST(EasternCreateDate AS DATE) AS DATE,SUM(ActionQuantity) AS TTCOUNT,COUNT(1) AS rec
		FROM SIProcessing_CacheHistory.. TrackedCache
		WHERE ClientID = 2537
		AND EasternCreateDate >= '10/01/2011'
		AND EasternCreateDate < '11/01/2011'
		AND ChannelID  = 4
		GROUP BY ChannelID,CAST(EasternCreateDate AS DATE)
)
SELECT p.DATE, p.TTCOUNT AS Paid, d.TTCOUNT AS DFA, p.TTCOUNT-d.TTCOUNT AS DIFF--, p.rec,d.rec, p.rec-d.rec
FROM PAID p
JOIN DFA d ON d.DATE = p.DATE
ORDER BY p.DATE


*/
