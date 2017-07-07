
USE Searchignite

DECLARE @StartDate DATE = '09/01/2012',
	@EndDate DATE = '09/07/2012',
	@CurrentDate DATE,
	@ClientID INT,
	@SEID SMALLINT


IF OBJECT_ID('tempdb..#cr') IS NOT NULL
DROP TABLE  #cr

CREATE TABLE #cr (
	CrawlRecordID INt
)

IF OBJECT_ID('tempdb..#work') IS NOT NULL
DROP TABLE  #work

CREATE TABLE #work(
	ClientID INT,
	SEID SMALLINT,
	ProcessDate DATE
)

IF OBJECT_ID('tempdb..#clients') IS NOT NULL
DROP TABLE  #clients

CREATE TABLE #clients(
	ClientID INT,
	SEID SMALLINT,
	ISProcessed BIT
) 
/*
SELECT '('+CAST(clientID AS VARCHAR(30))+',' +CAST(SEID AS VARCHAR(30)) +',0),'
FROM dbo.SocialCreativeAdCategoryImpressionClicksCost icc
JOIN dbo.CampaignAdCategory cac ON icc.AdCategoryID = cac.AdCategoryID
WHERE ReportDate >= '08/01/2012'
AND ReportDate < '09/01/2012'
GROUP BY clientID,SEID
ORDER BY ClientID

*/
INSERT INTO #clients( ClientID, SEID, ISProcessed )
VALUES  (76,84,0),
(146,84,0),
(2036,84,0),
(3289,85,0),
(3780,84,0),
(3998,85,0),
(3999,85,0),
(4468,84,0),
(4712,84,0),
(4714,84,0),
(4885,87,0),
(5006,84,0),
(5014,85,0),
(5067,84,0),
(5296,84,0),
(5322,87,0),
(5720,85,0),
(5777,84,0),
(5796,84,0),
(6146,84,0),
(6147,84,0),
(6148,84,0),
(6310,88,0),
(6328,85,0),
(6341,84,0),
(6363,84,0),
(6365,84,0),
(6367,84,0),
(6380,87,0),
(6394,87,0),
(6420,87,0),
(6427,87,0),
(6464,87,0),
(6466,87,0),
(6556,85,0),
(6582,85,0),
(6620,87,0),
(6676,87,0),
(6817,87,0),
(7013,87,0),
(7039,84,0),
(7138,87,0),
(7143,87,0),
(7145,87,0),
(7147,87,0),
(7149,87,0),
(7157,87,0),
(7194,84,0),
(7244,87,0),
(7246,87,0),
(7256,87,0),
(7264,87,0),
(7286,87,0),
(7287,87,0),
(7289,87,0),
(7291,87,0),
(7296,87,0),
(7360,87,0),
(7373,87,0),
(7574,88,0),
(7612,85,0)

--Facebook Action Measurement pull
WHILE EXISTS (SELECT TOP 1 1 FROM #clients WHERE ISProcessed = 0)
BEGIN

	SELECT TOP 1 @ClientID = ClientID, @SEID = SEID FROM #clients WHERE ISProcessed = 0

	SET @CurrentDate = @StartDate
	
	WHILE @CurrentDate < @EndDate
	BEGIN
	
		INSERT INTO #work( ClientID, SEID, ProcessDate )
		SELECT @ClientID, @SEID, @CurrentDate
		
		SET @CurrentDate = DATEADD(dd,1,@CurrentDate)
		
	END
	
	UPDATE #clients
	SET ISProcessed = 1
	WHERE ClientID = @ClientID
		AND SEID = @SEID

END

	insert into dbo.crawlrecord (itemid, clientid, seid, recorddatetime, crawlrecordtypeid, crawlrecordstatusid, crawltypeid)
		OUTPUT inserted.CrawlRecordID INTO #cr( CrawlRecordID )
	SELECT ClientID,ClientID,SEID,DATEADD(dd,2,ProcessDate),0,0,22 FROM #work

DECLARE @text VARCHAR(MAX)= ''

SELECT @text += CAST(CrawlRecordID AS VARCHAR(30)) + ',' FROM #cr

SELECT @text
