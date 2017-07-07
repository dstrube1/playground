SELECT DISTINCT catm.CampaignID,
	cac.AdCategoryID,
	catm.SEID,
	catm.AdTitleMappingID,
	catm.SETitleID
FROM dbo.CampaignAdTitleMapping catm
	JOIN dbo.CampaignAdCategory cac ON cac.CampaignID = catm.CampaignID
	--JOIN dbo.CampaignSETitleIDAdIDMapping csam ON csam.CampaignID = cac.CampaignID
	--	AND csam.SETitleID = catm.SETitleID
	--	AND csam.SEID = catm.SEID
WHERE cac.StatusFlag = 1
	AND catm.StatusFlag = 1
GROUP BY --csam.ADID,
	cac.AdCategoryID,
	CATM.SEID
HAVING COUNT(catm.SETitleID) > 1


SELECT TOP 10 * FROM CampaignADCategory


SELECT COUNT(1) FROM dbo.CampaignSETitleIDAdIDMapping
--53,622,543
SELECT c.StatusFlag,COUNT(1) 
FROM dbo.CampaignSETitleIDAdIDMapping csam
	JOIN dbo.Campaign c ON c.CampaignID = csam.CampaignID 
		AND c.StatusFlag = 1
--34,793,227


SELECT catm.SETitleID,SEID,catm.CampaignID,catm.AdTitleMappingID,cac.AdCategoryID
INTO #CampaignAdTitleMapping_Marc07112011
FROM CampaignAdTitleMapping catm
JOIN CampaignAdCategory cac ON catm.AdTitleMappingID = cac.AdTitleMappingID
	AND cac.CampaignID = catm.CampaignID
JOIN Campaign c ON c.CampaignID =  catm.CampaignID 
WHERE cac.StatusFlag = 1
	AND C.StatusFlag = 1
	
CREATE CLUSTERED INDEX IDX_CampaignAdTitleMapping_Marc07112011 ON #CampaignAdTitleMapping_Marc07112011(SETitleID,SEID,CampaignID)
	
	
SELECT  * FROM #CampaignAdTitleMapping_Marc07112011
	
SELECT  * 
FROM dbo.CampaignSETitleIDAdIDMapping csam
JOIN #CampaignAdTitleMapping_Marc07112011 c ON csam.CampaignID =  c.CampaignID 
	AND csam.SEID = c.SEID
WHERE csam.SETitleID <> c.SETitleID


WHERE


SELECT c.StatusFlag AS ClientStatus,
	ca.StatusFlag AS CampaignStatus,
	cac.StatusFlag AS AdCategoryStatus,
	COUNT(1) 
FROM Clients c
JOIN Campaign ca ON c.ClientID = ca.ClientID
JOIN dbo.CampaignAdCategory cac ON  cac.CampaignID = ca.CampaignID
GROUP BY ROLLUP(c.StatusFlag,ca.StatusFlag,cac.StatusFlag)
ORDER BY c.StatusFlag,ca.StatusFlag,cac.StatusFlag

SELECT COUNT(1) FROM dbo.CampaignAdCategory


SELECT  * FROM dbo.CampaignSETitleIDAdIDMapping
WHERE ISNULL(ADID,'') = '' 
	OR ISNULL(SETitleID,'') = ''
--1,800,644


SELECT  csam.SETitleID, csam.CampaignID,csam.SEID,csam.ADID
FROM  CampaignSETitleIDAdIDMapping csam
JOIN dbo.Campaign c ON c.CampaignID = csam.CampaignID AND c.StatusFlag = 1
WHERE ISNULL(csam.ADID,'') <> ''
 
SELECT TOP 10 * FROM  CampaignAdTitleMapping
SELECT TOP 10 * FROM  CampaignSETitleIDAdIDMapping


