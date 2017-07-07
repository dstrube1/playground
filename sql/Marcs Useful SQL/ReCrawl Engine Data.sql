SELECT * 
FROM dbo.CrawlRecord
WHERE ClientID = 5988
AND ItemID = 5988
AND CrawlTypeID = 22
AND RecordDateTime >= '12/01/2011'
AND SEID = 1
ORDER BY RecordDateTime DESC


SELECT TOP 10* 
FROM dbo.CrawlRecord
WHERE CrawlTypeID = 22
AND CrawlRecordStatusID = 2
ORDER BY RecordDateTime DESC


SELECT * 
FROM dbo.LUCrawlType

SELECT *
FROM dbo.LUCrawlRecordType

SELECT*
FROM dbo.LUCrawlRecordStatus


SELECT *
FROM dbo.Clients
WHERE CLientID = 5988

--Mark a client to have there data repulled
EXEC [dbo].[SI_SP_AdminTools_CreateCrawlRecords] 
@ClientID = 5988, 
@SEID = 1, 
@ItemID = 5988, 
@RecordDateTime = N'2011-12-07 12:50:01.053', 
@InsertReportGeneralCrawlRecord = 1

--Check on records to see if they have been crawled
SELECT * 
FROM dbo.CrawlRecord
WHERE ClientID = 5988
AND ItemID = 5988
AND CrawlTypeID = 22
AND RecordDateTime >= '12/01/2011'
AND SEID = 1
ORDER BY RecordDateTime DESC