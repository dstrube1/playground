
USE Searchignite

IF OBJECT_ID('tempdb..#cr') IS NOT NULL
DROP TABLE  #cr

CREATE TABLE #cr (
	CrawlRecordID INt
)
/*
--Group Sync
insert into dbo.crawlrecord (itemid, clientid, seid, recorddatetime, crawlrecordtypeid, crawlrecordstatusid, crawltypeid)
OUTPUT inserted.CrawlRecordID INTO #cr( CrawlRecordID )
SELECT DISTINCT cac.AdCategoryID, cac.ClientID, cse.SEID, getutcdate(), 2, 0,  3 
FROM dbo.CampaignAdCategory cac
JOIN dbo.CampaignSearchEngine cse ON cac.CampaignID = cse.CampaignID
WHERE AdCategoryID = 10759176

--Sync Campaign
insert into dbo.crawlrecord (itemid, clientid, seid, recorddatetime, crawlrecordtypeid, crawlrecordstatusid, crawltypeid)
OUTPUT inserted.CrawlRecordID INTO #cr( CrawlRecordID )
SELECT DISTINCT c.CampaignID, c.ClientID, cse.SEID, getutcdate(), 1, 0,  2 
FROM dbo.Campaign c
JOIN dbo.CampaignSearchEngine cse ON c.CampaignID = cse.CampaignID
WHERE c.CampaignID IN (347159,347157,347161,347160,347158)

--Update Redirect
insert into dbo.crawlrecord (itemid, clientid, seid, recorddatetime, crawlrecordtypeid, crawlrecordstatusid, crawltypeid)
OUTPUT inserted.CrawlRecordID INTO #cr( CrawlRecordID )
SELECT      CKeywordID, ClientID, SEID, getutcdate(), 3, 0,  19
FROM dbo.CSKeywords
WHERE CSKID IN (453807358,453807360,453807366,453824671)

--SiteLinks Update
insert into dbo.crawlrecord (itemid, clientid, seid, recorddatetime, crawlrecordtypeid, crawlrecordstatusid, crawltypeid)
OUTPUT inserted.CrawlRecordID INTO #cr( CrawlRecordID )
SELECT DISTINCT CampaignID,ClientID, SEID, getutcdate(), 1, 0, 51 
FROM dbo.SiteLink
WHERE StatusFlag = 1
AND ClientID IN (7521,7492)
AND SEID = 59

--Facebook Action Measurement pull
insert into dbo.crawlrecord (itemid, clientid, seid, recorddatetime, crawlrecordtypeid, crawlrecordstatusid, crawltypeid)
OUTPUT inserted.CrawlRecordID INTO #cr( CrawlRecordID )
VALUES (15289,15289,84,DATEADD(dd,2,'08/01/2012'),0,0,22),
(15289,15289,84,DATEADD(dd,2,'08/02/2012'),0,0,22),
(15289,15289,84,DATEADD(dd,2,'08/03/2012'),0,0,22),
(15289,15289,84,DATEADD(dd,2,'08/04/2012'),0,0,22),
(15289,15289,84,DATEADD(dd,2,'08/05/2012'),0,0,22),
(15289,15289,84,DATEADD(dd,2,'08/06/2012'),0,0,22),
(15289,15289,84,DATEADD(dd,2,'08/07/2012'),0,0,22),
(15289,15289,84,DATEADD(dd,2,'08/08/2012'),0,0,22),
(15289,15289,84,DATEADD(dd,2,'08/09/2012'),0,0,22),
(15289,15289,84,DATEADD(dd,2,'08/10/2012'),0,0,22),
(15289,15289,84,DATEADD(dd,2,'08/11/2012'),0,0,22),
(15289,15289,84,DATEADD(dd,2,'08/12/2012'),0,0,22),
(15289,15289,84,DATEADD(dd,2,'08/13/2012'),0,0,22),
(15289,15289,84,DATEADD(dd,2,'08/14/2012'),0,0,22),
(15289,15289,84,DATEADD(dd,2,'08/15/2012'),0,0,22),
(15289,15289,84,DATEADD(dd,2,'08/16/2012'),0,0,22),
(15289,15289,84,DATEADD(dd,2,'08/17/2012'),0,0,22),
(15289,15289,84,DATEADD(dd,2,'08/18/2012'),0,0,22),
(15289,15289,84,DATEADD(dd,2,'08/19/2012'),0,0,22),
(15289,15289,84,DATEADD(dd,2,'08/20/2012'),0,0,22),
(15289,15289,84,DATEADD(dd,2,'08/21/2012'),0,0,22),
(15289,15289,84,DATEADD(dd,2,'08/22/2012'),0,0,22),
(15289,15289,84,DATEADD(dd,2,'08/23/2012'),0,0,22),
(15289,15289,84,DATEADD(dd,2,'08/24/2012'),0,0,22),
(15289,15289,84,DATEADD(dd,2,'08/25/2012'),0,0,22),
(15289,15289,84,DATEADD(dd,2,'08/26/2012'),0,0,22),
(15289,15289,84,DATEADD(dd,2,'08/27/2012'),0,0,22),
(15289,15289,84,DATEADD(dd,2,'08/28/2012'),0,0,22)
*/

--Yahoo Bing
insert into dbo.crawlrecord (itemid, clientid, seid, recorddatetime, crawlrecordtypeid, crawlrecordstatusid, crawltypeid)
OUTPUT inserted.CrawlRecordID INTO #cr( CrawlRecordID )
VALUES (2169,2169,82,'08/02/2012',0,0,22),
(2169,2169,82,'08/04/2012'),0,0,22),
(2169,2169,82,'08/06/2012'),0,0,22),
(2169,2169,82,'08/08/2012'),0,0,22),
(2169,2169,82,'08/10/2012'),0,0,22),
(2169,2169,82,'08/12/2012'),0,0,22),
(2169,2169,82,'08/14/2012'),0,0,22),
(2169,2169,82,'08/16/2012'),0,0,22),
(2169,2169,82,'08/18/2012'),0,0,22),
(2169,2169,82,'08/20/2012'),0,0,22),
(2169,2169,82,'08/22/2012'),0,0,22),
(2169,2169,82,'08/24/2012'),0,0,22),
(2169,2169,82,'08/26/2012'),0,0,22),
(2169,2169,82,'08/28/2012'),0,0,22),
(2169,2169,82,'08/30/2012'),0,0,22),
(2169,2169,82,'09/01/2012'),0,0,22),
(2169,2169,82,'09/03/2012'),0,0,22),
(2169,2169,82,'09/05/2012'),0,0,22),
(2169,2169,82,'09/07/2012'),0,0,22),
(2169,2169,82,'09/09/2012'),0,0,22)

DECLARE @text VARCHAR(MAX)= ''

SELECT @text += CAST(CrawlRecordID AS VARCHAR(30)) + ',' FROM #cr

SELECT @text
