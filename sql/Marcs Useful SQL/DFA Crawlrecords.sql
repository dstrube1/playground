

SELECT * FROM dbo.CSKFutureBid--History

select * from crawlrecord
where seid = 0
and crawltypeid = 39
--AND CrawlRecordStatusID = 0
AND RecordDateTime >= '06/27/2012'
AND RecordDateTime < '06/29/2012'
AND ClientID = 5777


EXEC dbo.SI_SP_CrawlRecord_InsertUpdate_DFA @ReportDate = '2012-06-29 14:29:04', -- datetime
    @ClientID = 0, -- int
    @debug = NULL -- bit


DECLARE @CrawlRecordID INT = 197461295,
	@CrawlGroupID INT,
	@run BIT = 0

IF @run = 1
	EXEC dbo.SI_SP_GenerateCrawlGroup @SEID = 0, @ProcessOdd = 1

select * from crawlrecord WHERE CrawlRecordID = @CrawlRecordID

SELECT @CrawlGroupID = MAX(CrawlGroupID) 
FROM dbo.CrawlRecordGroup
WHERE CrawlRecordID = @CrawlRecordID

IF @run = 1
	UPDATE dbo.CrawlGroup
	SET Priority = 1
	WHERE CrawlGroupID = @CrawlGroupID


SELECT * FROM dbo.CrawlGroup WHERE CrawlGroupID = @CrawlGroupID


SELECT * FROM dbo.CrawlingErrorLog
WHERE CrawlRecordID = @CrawlRecordID
ORDER BY CreateDate DESC


--DFA Files on DART
SELECT * FROM dbo.DFAExternalReportProcess
WHERE CrawlRecordID =@CrawlRecordID


