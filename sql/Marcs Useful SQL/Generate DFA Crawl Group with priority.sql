
USE Searchignite

/*
DECLARE @ClientID INT = 76,
	@Date DATETime = '10/02/2013 10:00:00.00',
	@CR INT,
	@CG INT,
	@OE INT

EXEC SI_SP_CrawlRecord_InsertUpdate_DFA @debug = 0,@clientID = @ClientID,@ReportDate = @Date

SET @OE = @ClientID % 2

exec SI_SP_GenerateCrawlGroup 0, @OE

SELECT TOP 1 @CR = CrawlRecordID
FROM dbo.CrawlRecordDFAHistory
ORDER BY ExecutionDateUTC DESC

SELECT @CG =  MAX(CrawlGroupID)
FROM dbo.CrawlRecordGroup
WHERE CrawlRecordID = @CR

UPDATE dbo.CrawlGroup
SET Priority = 1
WHERE CrawlGroupID = @CG

SELECT @CR AS CrawlRecordID, @CG AS CrawlGroupID

*/

DECLARE @CR INT = 1410590056

SELECT * 
FROM dbo.CrawlRecord
WHERE CrawlTypeID = 39
AND SEID = 0
AND CrawlRecordID = @CR


SELECT * 
FROM dbo.CrawlGroup
WHERE CrawlGroupID IN (
	SELECT CrawlGroupID 
	FROM dbo.CrawlRecordGroup
	WHERE CrawlRecordID = @CR
)

SELECT * FROM dbo.CrawlingErrorLog
WHERE CrawlRecordID = @CR 

