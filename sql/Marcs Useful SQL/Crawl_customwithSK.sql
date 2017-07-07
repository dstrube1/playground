

IF OBJECT_ID('SearchIgnite.._Crawling_ImportKeywordbyAdcategoryID') IS NOT NULL
DROP TABLE _Crawling_ImportKeywordbyAdcategoryID

CREATE TABLE _Crawling_ImportKeywordbyAdcategoryID (
	ClientID INT,
	SEID INT,
	CampaignID INt,
	Campaign_External [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS,
	AdCategoryID INT,
	AdCategory_External [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS,
	isProcessed BIT,
	ErrorMessage VARCHAR(1000)
)

INSERT INTO _Crawling_ImportKeywordbyAdcategoryID
SELECT cac.ClientID, cse.SEID,cac.CampaignID,se2.SEExternalID, cac.AdCategoryID, se1.SEExternalID,0, ''
FROM dbo.CampaignAdCategory cac
JOIN dbo.CampaignSearchEngine cse ON cac.CampaignID = cse.CampaignID
JOIN dbo.SEExternalIDInfo se1 ON cse.SEID = se1.SEID
	AND se1.CCKTypeID = 2
	AND se1.CCKValue = cac.AdCategoryID
JOIN dbo.SEExternalIDInfo se2 ON cse.SEID = se2.SEID
	AND se2.CCKTypeID = 1
	AND se2.CCKValue = cac.CampaignID
WHERE Cac.AdCategoryID IN ()



SELECT * 
FROM _Crawling_ImportKeywordbyAdcategoryID  WITH (NOLOCK)
WHERE isProcessed = 0

SELECT DISTINCT ClientID 
FROM dbo.CSKeywords  WITH (NOLOCK)
WHERE CampaignID IN (347160,347158,347159,347157,347161)

SELECT COUNT(1)
FROM dbo.CSKeywords  WITH (NOLOCK)
WHERE ClientID = 7493
AND StatusFlag = 1



