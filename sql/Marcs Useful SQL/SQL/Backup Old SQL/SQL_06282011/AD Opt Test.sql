
WITH CampaignAdTitleMappingID AS(
SELECT cac.AdCategoryName
	,cac.AdCategoryID
	,cac.AdCategoryStatusID
FROM dbo.CampaignAdCategory cac
	left join dbo.CampaignAdcategoryBidRule on cac.AdcategoryID = CampaignAdcategoryBidRule.AdcategoryID
	JOIN Campaign c ON cac.CampaignID = c.CampaignID AND cac.ClientID = c.ClientID
	JOIN CampaignSearchEngine cse ON cse.CampaignID = cac.CampaignID 
	JOIN ClientSearchEngineMapping csem on cac.clientid = csem.ClientId 
		and cse.seid = csem.seid 
WHERE cac.ClientID = 4632
	AND cac.StatusFlag = 1
	AND c.StatusFlag = 1 
	and csem.statusflag =1

)
SELECT
	CampaignAdTitleMapping.SETitleID
	,CampaignAdTitleMapping.Title    
	,CampaignAdTitleMapping.Description1
	,CampaignAdTitleMapping.Description2
	,CampaignAdTitleMapping.DisplayURL 
	,CampaignAdTitleMapping.DefaultURL
	,CampaignAdTitleMapping.AdTitleMappingID
	,CampaignAdTitleMapping.OptimizeLandingPage
	,CampaignAdTitleMapping.Optimizebyconversion
	,CampaignAdTitleMapping.TitleAsKeyword
	,CampaignAdTitleMapping.AdTitleOnOffStatusID
	,CampaignAdCategory.AdCategoryName
	,CampaignAdCategory.AdCategoryID
	,CampaignAdCategory.AdCategoryStatusID
	,CampaignAdTitleMapping.AdStatusID
	,dbo.fn_ConvertTime(CampaignAdTitleMapping.ActivationDateTime, 8,1, 8, 1) as ActivationDateTime
	,dbo.fn_ConvertTime(CampaignAdTitleMapping.PauseDateTime, 8,1, 8, 1) as PauseDateTime
	,CASE
		WHEN CampaignAdCategory.AdCategoryStatusID = 2 THEN 2
		WHEN CampaignAdCategory.AdCategoryStatusID = 4 THEN 4
		WHEN Campaign.CampaignStatusID = 2 THEN 1
		WHEN Campaign.CampaignStatusID = 4 THEN 3
	END AS InheritedStatusID

	-- ARTIFICIAL TEXT AD STATUS
	-- 1 = ACTIVE, 2=PAUSED, 4=DELETED
	,CASE	WHEN CampaignAdTitleMapping.AdStatusID = 3 OR Campaign.CampaignStatusID = 4 OR CampaignAdCategory.AdCategoryStatusID = 4 THEN 4 -- DELETED
			WHEN LUAdTitleOnOffStatus.AdTitleOnOffDescription = 'ON' then 1 -- ACTIVE
			WHEN LUAdTitleOnOffStatus.AdTitleOnOffDescription = 'OFF' then 2 -- PAUSED
	END AS DerivedTextAdStatusID
	,Campaign.CampaignTitle
	,Campaign.CampaignID
	,Campaign.SSRedirect
	,Campaign.CampaignStatusID
	,CampaignAdTitleMapping.SEID
	,LUAdTitleOnOffStatus.AdTitleOnOffDescription
	,(ISNULL(CampaignSearchEngine.DailyBudget,0)) AS DailyBudgetConverted
	,(ISNULL(CampaignAdcategoryBidRule.DisplayCPCBid,0)) AS DisplayCPCBidConverted
	,(ISNULL(CampaignAdcategoryBidRule.PlacementCPCBid,0)) AS PlacementCPCBidConverted
	,(ISNULL(CampaignAdcategoryBidRule.CPMBid,0)) AS CPMBidConverted
	,CampaignAdTitleMapping.ImageID
	,AdCategorySearchEngineDetailStatusID
--INTO #CreativeBaseTables
FROM
	CampaignAdTitleMapping
	JOIN LUAdTitleOnOffStatus ON LUAdTitleOnOffStatus.AdTitleOnOffStatusID = CampaignAdTitleMapping.AdTitleOnOffStatusID
	
	
--Publisher Filter by all Publishers
	JOIN CampaignAdCategory on CampaignAdCategory.ClientID = 4632
		AND CampaignAdCategory.AdTitleMappingID = CampaignAdTitleMapping.AdTitleMappingID  
		AND CampaignAdCategory.CampaignID = CampaignAdTitleMapping.CampaignID 
	left join dbo.CampaignAdcategoryBidRule on CampaignAdCategory.AdcategoryID = CampaignAdcategoryBidRule.AdcategoryID
	JOIN Campaign ON Campaign.ClientID = 4632 AND CampaignAdCategory.CampaignID = Campaign.CampaignID 
	JOIN CampaignSearchEngine ON Campaign.CampaignID = CampaignSearchEngine.CampaignID 
	JOIN ClientSearchEngineMapping on Campaign.clientid = ClientSearchEngineMapping.ClientId and CampaignSearchEngine.seid = ClientSearchEngineMapping.seid and ClientSearchEngineMapping.statusflag =1  

		 
--Publisher Filter by all Publisher
WHERE CampaignAdCategory.ClientID = 4632
	AND CampaignAdTitleMapping.StatusFlag = 1
	AND CampaignAdCategory.StatusFlag = 1
	AND Campaign.StatusFlag = 1 

CREATE CLUSTERED INDEX idx_TT on #CreativeBaseTables (SETitleID, SEID);


SELECT rp.SETitleID
      ,rp.SEID
      ,ISNULL(SUM(NumImpressions),0) AS NumImpressions
      ,ISNULL(SUM(NumClicksReported),0) AS NumClicksReported
      ,ISNULL(SUM(Cost),0) AS Cost
FROM siolap.dbo.RPT_PS_CreativeSUMmary_GroupLevel rp   
JOIN dbo.CampaignAdCategory cac ON rp.AdCategoryID = cac.AdCategoryID 
JOIN CampaignSETitleIDAdIDMapping am  ON am.CampaignID = cac.CampaignID 
      AND rp.SETitleID = am.SETitleID
      AND am.SEID = rp.SEID
      AND am.AdID = rp.ADID
WHERE rp.ClientID = 4632
      AND GenerateDate BETWEEN 'Jun  3 2011 12:00AM' AND 'Jul  3 2011 12:00AM'
      --AND rp.AdCategoryID IN (SELECT DISTINCT AdCategoryID FROM #CreativeBaseTables)
      GROUP BY rp.SETitleID, rp.SEID

SELECT 
	am.SETitleID
	,rt.SEID
	,ISNULL(SUM(ISNULL(TTCount, TransactionCount)),0.0) AS Actions
	,ISNULL(SUM(TransactionAmount),0.0) AS TransactionAmount
	,ISNULL(SUM(ISNULL(TTCount, TransactionCount)* isnull(Weight, 1)),0.0) AS WeightedActions
FROM SIOLAP.dbo.RPT_PS_SUMmary_CustomerTT_CreativeLevel AS rt
	JOIN CampaignSETitleIDAdIDMapping am ON rt.ClientID = 4632
		AND GenerateDate BETWEEN 'Jun  3 2011 12:00AM' AND 'Jul  3 2011 12:00AM'
		AND am.SEID = rt.SEID 
		AND am.CampaignID = rt.CampaignID 
		AND am.ADID = rt.ADID  
	LEFT JOIN ClientCustomerTransactionTypeWeightHistory  tt ON tt.ClientID = 4632
		and tt.StartDate <= rt.GenerateDate
		and tt.EndDate >= rt.GenerateDate
		AND tt.CustomerTransactionTypeID = rt.CustomerTransactionTypeID
GROUP BY am.SETitleID, rt.SEID

