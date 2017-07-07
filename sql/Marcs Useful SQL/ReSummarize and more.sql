SELECT DISTINCT ChannelID--CAST(EasternCreateDate AS DATE),SUM(TransactionAmount) AS reV, SUM(ActionQuantity) AS Act
FROM SIProcessing_CacheHistory..TrackedCache
WHERE EasternCreateDate >= '01/15/2012'
AND EasternCreateDate < '01/16/2012'
AND ClientID = 2537
AND ChannelID = 2
AND TrackedCacheCreateDateUTC > '1/16/2012'
GROUP BY  CAST(EasternCreateDate AS DATE)

SELECT * 
FROM SIProcessing_Attribution..TrackedAction
WHERE ClientID = 2537
AND TrackedActionID IN (
SELECT TrackedActionID
FROM SIProcessing_CacheHistory..TrackedCache
WHERE EasternCreateDate >= '01/15/2012'
AND EasternCreateDate < '01/16/2012'
AND ClientID = 2537
AND ChannelID = 2
AND TrackedCacheCreateDateUTC > '1/16/2012'
)




LocalizedCreateDate >='01/15/2012'
AND LocalizedCreateDate < '01/16/2012'
AND TrackingSourceCreateDateUTC >'1/16/2012'
AND RecordStatus = 'A'


SELECT GENERateDAte, SUM(ViewBaseTransactionAmount+ ClickBaseTransactionAmount) AS REV, SUM(ViewBaseTransactionCount+ ClickBaseTransactionCount) AS Actions
FROM RPT_UM_Summary_Keywords
WHERE ClientID =2537
AND GenerateDate >= '01/01/2012'
AND GenerateDate <  '01/02/2012'
GROUP BY GenerateDate


SELECT* 
FROM dbo.CrawlingTracking_History
WHERE ReportProcessedDate IS NULL
AND NumProcessed = 0


 SELECT ClientID, COUNT(1)
 FROM  CrawlingTracking_History
WHERE  ReportProcessedDate IS NULL
AND NumProcessed = 0
 GROUP BY ClientID
 ORDER BY LastReportDate, InProcess


SELECT LastReportDate, InProcess
 FROM  CrawlingTracking_History
WHERE  ReportProcessedDate IS NULL
AND NumProcessed = 0
AND CLientID = 2537 
AND LastReportDate >= '01/12/2012'


 SELECT LastReportDate, InProcess, COUNT(1)
 FROM  CrawlingTracking_History
WHERE  ReportProcessedDate IS NULL
AND NumProcessed = 0
 GROUP BY LastReportDate, InProcess
 ORDER BY LastReportDate, InProcess
 --LastReportDate	InProcess	(No column name)
--2012-01-10 00:00:00.000	1	830

UPDATE CrawlingTracking_History
SET ReportProcessedDate = NULL,
	NumProcessed = 0
WHERE ClientID = 754
AND LastReportDate >= '01/19/2012'


SELECT * FROM CrawlingTracking_History
WHERE ClientID = 2537
AND LastReportDate >= '01/12/2012'


SELECT * FROM dbo.AT_RPT_NS_SummaryData

UPDATE AT_RPT_NS_SummaryData
SET ReProcessDate = '01/24/2012'
 
 
 SELECT *
 FROM dbo.AT_RPT_PS_SummaryData
 
 UPDATE AT_RPT_PS_SummaryData
 SET ReProcessDate = '01/19/2012'
 
 SELECT ReportDate, Inprocess, COUNT(1)
 FROM dbo.UMTracking_History
 WHERE ReportProcessedDate IS null
 GROUP BY ReportDate, Inprocess
 
		UPDATE dbo.UMTracking_History 
		SET ReportProcessedDate = null, 
		NumProcessed = 0 
		WHERE ReportDate >= '2012/01/21'
		AND ClientID = 2537
		
		SELECT * 
		FROM T 
		
		
		sp_who4 324
		
		
		SELECT* 
		FROM dbo.DFAFileQueue
		WHERE ErrorMessage IS NOT NULL
		AND CreateDateUTC > ='1/20/2012'
		
		
		SELECT * 
		FROM TRackedAction 
		WHERE ClientID = 2537
		AND TrackingSourceID = 3
		AND CreateDateUTC > = '1/20/2012' 
		AND TrackedActionID = 948619054
		
		SELECT* FROM SIProcessing_CacheHistory..TrackedCache
		WHERE TrackedActionID = 948619054
		AND CLientId = 2537
		AND EasternCreateDate
		
		
		SELECT *
		FROM SIProcessing..Clients
		WHERE CLIENTID = 754
		