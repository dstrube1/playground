
SELECT LastReportDate, Inprocess, COUNT(1)
FROM dbo.CrawlingTracking_History
WHERE ReportProcessedDate IS NULL
	AND ClientID = 754
GROUP BY LastReportDate, Inprocess
ORDER BY LastReportDate, Inprocess


SELECT * FROM dbo.AT_RPT_PS_SummaryData

SELECT * FROM dbo.RPT_PS_GenerateList

UPDATE dbo.AT_RPT_PS_SummaryData
SET ReProcessDate = '2012-09-18 00:00:00.000'

