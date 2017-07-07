
SELECT * 
FROM dbo.ClientCrawlingDataFeedProcess

EXEC dbo.SI_SP_ClientCrawlingDataFeedProcess_Read @ClientId = 0 -- int



UPDATE ClientCrawlingDataFeedProcess
SET Parameters = 'ftp.ignitionone.com|omniture|F3AsteKu|21|/*/omniture/pageviews/'
WHERE ClientId = 76


UPDATE ClientCrawlingDataFeedProcess
SET Parameters = 'ftp.ignitionone.com|SEOReport360i|chUfEy79|22|/jailhome/home/SEOReport360i/|\\ATL_DFS_PR.searchignite.local\Data\datafiles\SEODashboard|http://reporting.searchignite.com/360iseo/|\\ATL_DFS_PR.searchignite.local\Data\datafiles\SEODashboard\assets\logos\'
WHERE ClientId = 1637


UPDATE ClientCrawlingDataFeedProcess
SET Parameters = 'ftp.searchignite.com|omniture|F3AsteKu|21|/*/omniture/pageviews/'
WHERE ClientId = 76
			
UPDATE ClientCrawlingDataFeedProcess
SET Parameters = 'ftp.searchignite.local|SEOReport360i|chUfEy79|22|/jailhome/home/SEOReport360i/|\\209718-SQLPROC\datafiles\SEODashboard\|http://reporting.searchignite.com/360iseo/|\\209718-SQLPROC\datafiles\SEODashboard\assets\logos\'
WHERE ClientId = 1637


			
			SELECT * 
			FROM dbo.CrawlRecord
			WHERE CrawlTypeID = 40
				AND SEID = 0
			ORDER BY CreateDateUTC DESC
			
			
			
			SELECT * FROM dbo.LUCrawlType
			WHERE CrawlTypeID = 40
			
	/*		
	INSERT INTO Searchignite..CrawlRecord(ItemId, ClientID, Seid, RecordDateTime, CrawlRecordTypeId, CrawlRecordStatusID, CrawlTypeID)
	SELECT 1637, 3767, 0, GETUTCDATE(), 0, 0, 40
	
	INSERT INTO Searchignite..CrawlRecord(ItemId, ClientID, Seid, RecordDateTime, CrawlRecordTypeId, CrawlRecordStatusID, CrawlTypeID)
	SELECT 76, 76, 0, GETUTCDATE(), 0, 0, 40
	
	
	EXEC dbo.SI_SP_GenerateCrawlGroup @SEID = 0, -- smallint
	    @ProcessOdd = 0-- bit
	
	EXEC dbo.SI_SP_GenerateCrawlGroup @SEID = 0, -- smallint
	    @ProcessOdd = 1-- bit
	
	*/
			
			
			SELECT * FROM dbo.CrawlRecordGroup
			WHERE CrawlRecordID IN (1381739246)
			
			SELECT *
			FROM dbo.CrawlGroup cg
			WHERE EXISTS (
				SELECT 1 
				FROM dbo.CrawlRecordGroup
				WHERE CrawlRecordID IN (1386510661)
					AND cg.CrawlGroupID = CrawlGroupID
			)
			
			SELECT * FROM dbo.CrawlingErrorLog
			WHERE CrawlRecordID IN (1386241250)
			
			   SELECT * FROM dbo.CrawlingErrorLog
   WHERE CrawlRecordID IN (1386510661)
			
			/*
			UPDATE cg
			SET Priority = 1
			FROM dbo.CrawlGroup cg
			WHERE EXISTS (
				SELECT 1 
				FROM dbo.CrawlRecordGroup
				WHERE CrawlRecordID IN (1386510661)
					AND cg.CrawlGroupID = CrawlGroupID
			)
			*/
			
	
	
			
			