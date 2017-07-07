
USE Searchignite

SET NOCOUNT ON

DECLARE @ClientId INT = 7904,
	@SEID SMallINT = 1,
	@CrawlGroupId INT
	

IF OBJECT_ID('tempdb..#cr') IS NULL
CREATE TABLE #cr (
	CrawlRecordID INt
)
	
IF OBJECT_ID('tempdb..#temp') IS NULL
BEGIN

	CREATE TABLE #temp (
		CSKID INT,
		CKeywordID INT,
		ProcessStatus TINYINT
	)

	INSERT INTO #temp ( CSKID,CKeywordID, ProcessStatus )
	SELECT CSKID,CKeywordID, 0 
	FROM Searchignite..CSKeywords
	WHERE SEID = @SEID
		AND ClientID = @ClientId
		
END

WHILE EXISTS(SELECT TOP 1 1 FROM #temp WHERE ProcessStatus = 0)
BEGIN

	RAISERROR('Batch Starting',0,1) WITH NOWAIT
	
	UPDATE TOP (50000) #temp 
	SET ProcessStatus = 1
	WHERE ProcessStatus = 0
	
	TRUNCATE TABLE #cr
	
	insert into SearchIgnite..crawlrecord (itemid, clientid, seid, recorddatetime, crawlrecordtypeid, crawlrecordstatusid, crawltypeid)
	OUTPUT inserted.CrawlRecordID INTO #cr( CrawlRecordID )
	SELECT CKeywordID, @ClientID, @SEID, getutcdate(), 3, 5,  19 
	FROM #temp
	WHERE ProcessStatus = 1
	

    INSERT  INTO SearchIgnite..CrawlGroup( ClientId ,SEID ,StatusFlag ,Priority)
    VALUES  ( @ClientId ,@SEID ,0 ,1 )
      
    SELECT  @CrawlGroupId = SCOPE_IDENTITY()  

    INSERT  SearchIgnite..CrawlRecordGroup( CrawlRecordId ,CrawlGroupId )
        SELECT  CrawlRecordId ,@CrawlGroupId
        FROM    #cr t

	UPDATE #temp
	SET ProcessStatus = 2
	WHERE ProcessStatus = 1
	
	RAISERROR('Batch Complete, CrawlGroupID %d',0,1,@CrawlGroupId) WITH NOWAIT

END
/*
SELECT * FROM #temp

sp_who4

SELECT  cr.*
FROM    CrawlRecord cr WITH (NOLOCK)
WHERE EXISTS (
	SELECT 1 
	FROM CrawlRecordGroup WITH (NOLOCK)
	WHERE  cr.CrawlRecordID =CrawlRecordId
		AND CrawlGroupID IN (47504427,47504428,47504429,47504430,47504431,47504432,47504433)
)    
 
SELECT  *
FROM    CrawlGroup cg WITH (NOLOCK)
WHERE CrawlGroupID IN (47504427,47504428,47504429,47504430,47504431,47504432,47504433)

          
SELECT * 
FROM dbo.CrawlingErrorLog cel WITH (NOLOCK)
WHERE CrawlGroupID IN (47504427,47504428,47504429,47504430,47504431,47504432,47504433)  

*/
