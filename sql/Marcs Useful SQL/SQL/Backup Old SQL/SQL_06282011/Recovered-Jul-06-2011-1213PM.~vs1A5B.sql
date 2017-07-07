WITH CreativeRPTcte1 AS
(
SELECT
	rp.AdID
	,rp.SEID
	,CampaignID
	,ISNULL(SUM(NumImpressions),0) AS NumImpressions
	,ISNULL(SUM(NumClicksReported),0) AS NumClicksReported
	,ISNULL(SUM(Cost),0) AS Cost
FROM siolap.dbo.RPT_PS_CreativeSUMmary_GroupLevel rp 
	JOIN CampaignAdCategory ad ON rp.ClientID = 4632
	AND GenerateDate BETWEEN 'Jun  3 2011 12:00AM' AND 'Jul  3 2011 12:00AM'
	AND rp.AdCategoryID = ad.AdCategoryID
GROUP BY rp.AdID, rp.SEID, CampaignID
)
SELECT TOP 10
	SETitleID
	,t2.SEID
	,ISNULL(SUM(NumImpressions),0) AS NumImpressions
	,ISNULL(SUM(NumClicksReported),0) AS NumClicksReported
	,ISNULL(SUM(Cost),0) AS Cost
FROM CreativeRPTcte1 t2 
	JOIN CampaignSETitleIDAdIDMapping am ON am.SEID = t2.SEID 
		AND am.CampaignID = t2.CampaignID 
		AND am.ADID = t2.ADID
GROUP BY SETitleID, t2.SEID
ORDER BY ISNULL(SUM(Cost),0) DESC,SETitleID 

SELECT SETitleID
	,ISNULL(SUM(NumImpressions),0) AS NumImpressions
	,ISNULL(SUM(NumClicksReported),0) AS NumClicksReported
	,ISNULL(SUM(Cost),0) AS Cost
FROM siolap.dbo.RPT_PS_CreativeSUMmary_GroupLevel rp 
	JOIN CampaignAdCategory ad ON rp.AdCategoryID = ad.AdCategoryID
WHERE SETitleID IN (66595926,66626773,66595257,66626788,66619955,66626079)
	AND rp.ClientID = 4632
	AND GenerateDate BETWEEN 'Jun  3 2011 12:00AM' AND 'Jul  3 2011 12:00AM'
	GROUP BY SETitleID