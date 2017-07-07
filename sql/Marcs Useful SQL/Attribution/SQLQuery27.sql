

SELECT CAST(LocalizedCreateDate AS DATE) AS EDate, 
	COUNT(1) AS Actions, 
	SUM(CASE WHEN es.TrackedActionID IS NOT NULL THEN 1 ELSE 0 END) AS ES_Actions,
	SUM(CASE WHEN tc.TrackedActionID IS NOT NULL THEN 1 ELSE 0 END) AS Attributed_Actions,
	--SUM(CASE WHEN es.TrackedActionID IS NOT NULL AND es.ChannelID = 4 THEN 1 ELSE 0 END) AS ES_Actions_4,
	--SUM(CASE WHEN tc.TrackedActionID IS NOT NULL AND tc.ChannelID = 4 THEN 1 ELSE 0 END) AS Attributed_Actions_4,
	SUM(ta.TransactionAmount) AS Revenue,
	SUM(es.TransactionAmount) AS ES_Revenue,
	SUM(tc.TransactionAmount) AS Attributed_Revenue
	--SUM(CASE WHEN es.ChannelID = 4 THEN es.TransactionAmount ELSE 0 END) AS ES_Revenue_4,
	--SUM(CASE WHEN tc.ChannelID = 4 THEN tc.TransactionAmount ELSE 0 END) AS Attributed_Revenue_4
FROM SIProcessing_Attribution..TrackedAction ta
LEFT JOIN SIProcessing_CacheHistory..TrackedCache tc ON tc.TrackedActionID = ta.TrackedActionID
	AND ta.LocalizedCreateDate = tc.EasternCreateDate
LEFT JOIN SIProcessing_CacheHistory..ExposureSequence es ON es.TrackedActionID = ta.TrackedActionID
	AND ta.LocalizedCreateDate = es.ActionLocalizedCreateDate
WHERE ta.ClientID = 9327
	AND RecordStatus = 'A'
	--AND (ta.TrackingSourceID = 3 OR (ta.TrackingSourceID = 1 AND ta.TrackedActionID_PREV IS NOT NULL))
	AND LocalizedCreateDate >= '08/15/2013'
	AND LocalizedCreateDate < '08/30/2013'
GROUP BY CAST(LocalizedCreateDate AS DATE)
ORDER BY CAST(LocalizedCreateDate AS DATE)

SELECT DISTINCT ta.*
FROM SIProcessing_Attribution..TrackedAction ta
LEFT JOIN SIProcessing_CacheHistory..TrackedCache tc ON tc.TrackedActionID = ta.TrackedActionID
	AND ta.LocalizedCreateDate = tc.EasternCreateDate
	AND tc.ChannelID = 4
WHERE ta.ClientID = 3829
	AND RecordStatus = 'A'
	AND (TrackingSourceID = 3 OR (TrackingSourceID = 1 AND TrackedActionID_PREV IS NOT NULL))
	AND LocalizedCreateDate >= '06/10/2013'
	AND LocalizedCreateDate < '06/20/2013'
	AND tc.TransactionAmount <> ta.TransactionAmount
GROUP BY 

SELECT CAST(EasternCreateDate AS DATE) AS EDAte, COUNT(DISTINCT TrackedActionID) AS NumActions, SUM(TransactionAmount) AS REvenue
FROM SIProcessing_CacheHistory..TrackedCache tc
WHERE ClientID = 3829
	AND EasternCreateDate >= '06/10/2013'
	AND EasternCreateDate < '06/20/2013'
	AND ChannelID = 4
	AND EXISTS( 
		SELECT 1
		FROM SIProcessing_Attribution..TrackedAction
		WHERE ClientID = 3829
			AND RecordStatus = 'A'
			AND (TrackingSourceID = 3 OR (TrackingSourceID = 1 AND TrackedActionID_PREV IS NOT NULL))
			AND TrackedActionID = tc.TrackedActionID
	)
GROUP BY CAST(EasternCreateDate AS DATE)
ORDER BY CAST(EasternCreateDate AS DATE)



SELECT CAST(EasternCreateDate AS DATE) AS EDAte, COUNT(DISTINCT TrackedActionID) AS NumActions, SUM(TransactionAmount) AS REvenue
FROM SIProcessing_CacheHistory..TrackedCache tc
WHERE ClientID = 3829
	AND EasternCreateDate >= '06/10/2013'
	AND EasternCreateDate < '06/20/2013'
	AND ChannelID = 1
GROUP BY CAST(EasternCreateDate AS DATE)
ORDER BY CAST(EasternCreateDate AS DATE)
