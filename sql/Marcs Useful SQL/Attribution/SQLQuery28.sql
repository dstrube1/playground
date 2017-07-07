
SELECT CAST(LocalizedCreateDate AS DATE) AS EDate, 
	COUNT(1) AS Actions, 
	SUM(CASE WHEN es.TrackedActionID IS NOT NULL THEN 1 ELSE 0 END) AS ES_Actions,
	SUM(CASE WHEN tc.TrackedActionID IS NOT NULL THEN 1 ELSE 0 END) AS Attributed_Actions,
	SUM(CASE WHEN es4.TrackedActionID IS NOT NULL THEN 1 ELSE 0 END) AS ES_Actions_4,
	SUM(CASE WHEN tc4.TrackedActionID IS NOT NULL THEN 1 ELSE 0 END) AS Attributed_Actions_4,
	SUM(ta.TransactionAmount) AS Revenue,
	SUM(es.TransactionAmount) AS ES_Revenue,
	SUM(tc.OrigTransactionAmt) AS Attributed_OrigRevenue,
	SUM(tc.TransactionAmount) AS Attributed_Revenue,
	SUM(es4.TransactionAmount) AS ES_Revenue_4,
	SUM(tc4.OrigTransactionAmt) AS Attributed_OrigRevenue_4,
	SUM(tc4.TransactionAmount) AS Attributed_Revenue_4
FROM SIProcessing_Attribution..TrackedAction ta
LEFT JOIN (SELECT DISTINCT TrackedActionID, TRansactionAmount, EasternCreateDate,OrigTransactionAmt FROM SIProcessing_CacheHistory..TrackedCache) tc ON tc.TrackedActionID = ta.TrackedActionID
	AND ta.LocalizedCreateDate = tc.EasternCreateDate
LEFT JOIN (SELECT DISTINCT TrackedActionID,TransactionAmount,ActionLocalizedCreateDate FROM SIProcessing_CacheHistory..ExposureSequence) es ON es.TrackedActionID = ta.TrackedActionID
	AND ta.LocalizedCreateDate = es.ActionLocalizedCreateDate
LEFT JOIN (SELECT DISTINCT TrackedActionID, TRansactionAmount, EasternCreateDate,OrigTransactionAmt FROM SIProcessing_CacheHistory..TrackedCache WHERE ChannelID = 4) tc4 ON tc4.TrackedActionID = ta.TrackedActionID
	AND ta.LocalizedCreateDate = tc4.EasternCreateDate
LEFT JOIN (SELECT DISTINCT TrackedActionID,TransactionAmount,ActionLocalizedCreateDate FROM SIProcessing_CacheHistory..ExposureSequence WHERE ChannelID = 4) es4 ON es4.TrackedActionID = ta.TrackedActionID
	AND ta.LocalizedCreateDate = es4.ActionLocalizedCreateDate
WHERE ta.ClientID = 3829
	AND RecordStatus = 'A'
	AND (ta.TrackingSourceID = 3 OR (ta.TrackingSourceID = 1 AND ta.TrackedActionID_PREV IS NOT NULL))
	AND LocalizedCreateDate >= '06/10/2013'
	AND LocalizedCreateDate < '06/20/2013'
GROUP BY CAST(LocalizedCreateDate AS DATE)
ORDER BY CAST(LocalizedCreateDate AS DATE)


SELECT CAST(ActionLocalizedCreateDate AS DATE) EDate,ChannelID,COUNT(DISTINCT TrackedExposureID)
FROM SIProcessing_CacheHistory..ExposureSequence es
WHERE EXISTS (
SELECT 1
FROM SIProcessing_Attribution..TrackedAction
WHERE ClientID = 3829
	AND RecordStatus = 'A'
	AND (TrackingSourceID = 3 OR (TrackingSourceID = 1 AND TrackedActionID_PREV IS NOT NULL))
	AND LocalizedCreateDate >= '06/10/2013'
	AND LocalizedCreateDate < '06/20/2013'
	AND es.TrackedActionID = TrackedActionID
	AND es.ActionLocalizedCreateDate = LocalizedCreateDate
)
GROUP BY ChannelID,CAST(ActionLocalizedCreateDate AS DATE)
ORDER BY ChannelID,CAST(ActionLocalizedCreateDate AS DATE)

SELECT ChannelID, CAST(LocalizedCreateDate AS DATE) EDate, COUNT(1)
FROM SIProcessing_Attribution..TrackedExposure
WHERE ClienTID = 3829
	AND LocalizedCreateDate >= '06/10/2013'
	AND LocalizedCreateDate < '06/20/2013'
GROUP BY ChannelID, CAST(LocalizedCreateDate AS DATE)
ORDER BY ChannelID, CAST(LocalizedCreateDate AS DATE)

SELECT  EDate ,
        [1] ,
        [2] ,
        [3] ,
        [4] ,
        [5] ,
        [6]
FROM    ( SELECT    ChannelID ,
                    CAST(LocalizedCreateDate AS DATE) EDate ,
                    COUNT(1) TE_Exposures
          FROM      SIProcessing_Attribution..TrackedExposure
          JOIN 
          WHERE     ClienTID = 3829
                    AND LocalizedCreateDate >= '06/10/2013'
                    AND LocalizedCreateDate < '06/20/2013'
           GROUP BY ChannelID,CAST(LocalizedCreateDate AS DATE)
        ) AS te PIVOT
( SUM(TE_Exposures) FOR ChannelID IN ( [1], [2], [3], [4], [5], [6] ) ) AS PivotTable
ORDER BY EDate;
