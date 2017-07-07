
/*
--CrawlTypeID 40 - Pageviews


	INSERT INTO Searchignite..CrawlRecord(ItemId, ClientID, Seid, RecordDateTime, CrawlRecordTypeId, CrawlRecordStatusID, CrawlTypeID)
	SELECT 3767, 3767, 0, '2013-06-23' , 0, 0, 40
	
	SELECT SCOPE_IDENTITY()


EXEC Searchignite..SI_SP_GenerateCrawlGroup @SEID = 0, -- smallint
    @ProcessOdd = 1 -- bit
    
    

UPDATE Searchignite..CrawlRecord
SET CrawlRecordStatusID = 0
WHERE CrawlRecordID IN (1181042326,1181042327,1181042328)
    

*/


DECLARE @CrawlRecordID INT = 1183465781

SELECT *
FROM Searchignite..CrawlRecord
WHERE ClientID = 3767
AND CrawlTypeID = 40
ORDER BY CreateDateUTC

SELECT * 
FROM Searchignite..CrawlGroup cg
WHERE EXISTS (

SELECT * FROM Searchignite..CrawlRecordGroup
WHERE CrawlRecordID = @CrawlRecordID
	AND cg.CrawlGroupID = CrawlGroupID
)


SELECT * FROM Searchignite..CrawlingErrorLog
WHERE CrawlRecordID = @CrawlRecordID

