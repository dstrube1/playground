/*
--Pause
IF OBJECT_ID('JunkDB..IHG_Campaign_Pause_SIOPS8905') IS NOT NULL
DROP TABLE JunkDB..IHG_Campaign_Pause_SIOPS8905

CREATE TABLE JunkDB..IHG_Campaign_Pause_SIOPS8905(
ClientID INT,
CampaignID INT,
SEID SMALLINT
)

INSERT INTO JunkDB..IHG_Campaign_Pause_SIOPS8905(ClientID,CampaignID,SEID)
SELECT c.ClientID, C.CampaignID, Cse.SEID
FROM Searchignite.dbo.Campaign c
JOIN Searchignite..CampaignSearchEngine cse ON c.CampaignID = cse.CampaignID
WHERE CampaignStatusID = 1
      AND c.StatusFlag = 1
      AND cse.StatusFlag = 1
      AND ClientID IN (SELECT ClientID FROM SearchIgnite.dbo.tn_ClientHierarchy_Active(1862))

UPDATE Searchignite.dbo.Campaign
SET CampaignStatusID = 2, 
UpdateDate = GETUTCDATE()
WHERE CampaignID IN (SELECT CampaignID FROM JunkDB..IHG_Campaign_Pause_SIOPS8905)

--Generate CrawlRecord
INSERT INTO SearchIgnite.dbo.CrawlRecord ( ItemID , ClientID , SEID , RecordDateTime , ProcessDateTime , CrawlRecordTypeID , CrawlRecordStatusID , CrawlTypeID )
SELECT CampaignID,  ClientID ,  SEID , GETUTCDATE(),  NULL,  1 , 0 , 6 
FROM JunkDB..IHG_Campaign_Pause_SIOPS8905

*/

/*
--Reactivate
UPDATE Searchignite.dbo.Campaign
SET CampaignStatusID = 1, 
UpdateDate = GETUTCDATE()
WHERE CampaignID IN (SELECT CampaignID FROM JunkDB..IHG_Campaign_Pause_SIOPS8905)

--Generate CrawlRecord
INSERT INTO SearchIgnite.dbo.CrawlRecord ( ItemID , ClientID , SEID , RecordDateTime , ProcessDateTime , CrawlRecordTypeID , CrawlRecordStatusID , CrawlTypeID )
SELECT CampaignID,  ClientID ,  SEID , GETUTCDATE(),  NULL,  1 , 0 , 6 
FROM JunkDB..IHG_Campaign_Pause_SIOPS8905

*/


