

	SELECT * FROM dbo.Clients WHERE CLientNAme LIKE '%IHG%' AND StatusFlag = 1
	
	
	SELECT * FROM dbo.Clients WHERE ClientID = 1862

SELECT * 
FROM dbo.tn_ClientHierarchy_Active(1862) f
JOIN Clients c ON f.ClientID = c.ClientID

select * from LUUTCTimeDiff



SELECT c.CampaignID,c.ClientID,cse.SEID
--INTO JunkDB..IHG_CampaignPause_05172013
FROM dbo.Campaign c
JOIN dbo.CampaignSearchEngine cse ON cse.CampaignID = c.campaignID
WHERE CampaignStatusID = 1
	AND c.StatusFlag = 1
	AND cse.StatusFlag = 1
	AND ClientID IN (SELECT ClientID FROM dbo.tn_ClientHierarchy_Active(1862))
	/*
-- Update Campaign Table
UPDATE Campaign
SET CampaignStatusID = 2, --CHANGE TO 1 WHEN ACTIVATING CAMPAIGNS
UpdateDate = GETUTCDATE()
WHERE CampaignID IN (SELECT CampaignID FROM JunkDB..IHG_CampaignPause_05172013)

--Crawl out Campaign Changes
INSERT INTO dbo.CrawlRecord(ItemID,ClientID,SEID,RecordDateTime,ProcessDateTime,CrawlRecordTypeID,CrawlRecordStatusID,CrawlTypeID)
SELECT CampaignID,ClientID,SEID ,GETUTCDATE(),NULL,1,0,6
FROM JunkDB..IHG_CampaignPause_05172013
*/
	
