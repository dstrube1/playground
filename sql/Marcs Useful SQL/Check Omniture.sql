
DECLARE @ClientID INT = 6650,
	@startDate DATE = '06/20/2012',
	@endDate DATE = '06/30/2012'


SELECT omn.GenerateDate,  SUM(TransactionCount),	SUM(TransactionAmount)
FROM SIProcessing.dbo.TransactionTrackingOmnitureDetail omn
JOIN SIProcessing.dbo.CSKeywords csk ON omn.CSKID = csk.CSKID
WHERE csk.ClientID = @ClientID
	AND omn.GenerateDate >= @startDate
	AND omn.GenerateDate < @endDate
GROUP BY omn.GenerateDate
ORDER BY omn.GenerateDate

SELECT omn.GenerateDate,  SUM(TransactionCount),	SUM(TransactionAmount)
FROM SIProcessing.dbo.TransactionTrackingOmnitureDetail omn
WHERE omn.GenerateDate >= @startDate
	AND omn.GenerateDate < @endDate
GROUP BY omn.GenerateDate
ORDER BY omn.GenerateDate
	