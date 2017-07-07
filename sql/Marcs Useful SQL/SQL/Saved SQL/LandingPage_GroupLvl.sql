exec SI_SP_RPT_PS_Summary_LandingPageSummary_Read @currencyid=N'73',@EndDate=N'9/16/2010',@ClientId=N'2575',@StartDate=N'9/10/2010'
exec SI_SP_RPT_PS_Summary_GroupLevel_Read @currencyid=N'73',@EndDate=N'9/16/2010',@ClientId=N'2575',@StartDate=N'9/10/2010'

--Landing Page
Select ps.LandingPageURLsID,
	sum(isnull(NumClicksTracked, 0)) as [NumClicksTracked], 
	sum(COALESCE(TTCount, TransactionCount, 0)) as TransactionCount,
	sum(isnull(TransactionAmount, 0) * ExchangeRate) as TransactionAmount,
	isnull(sum(isnull(TransactionCountWithWeight, 0)), 0) as TransactionCountWithWeight,
CASE WHEN sum(isnull(NumClicksTracked, 0)) = 0 THEN 0 ELSE CAST(1.*sum(COALESCE(TTCount, TransactionCount, 0))/sum(isnull(NumClicksTracked, 0)) AS DECIMAL(12,3)) END AS [Conversion Rate(%)]  
From dbo.RPT_PS_LandingPageSummary_GroupLevel2 ps  
	join SearchEngine se  on ps.ClientID = 2575 and ps.GenerateDate between 'Sep 10 2010 12:00AM' and 'Sep 16 2010 12:00AM' and ps.IsContentMatch = ps.IsContentMatch and se.SEID = ps.SEID  
	join dbo.CurrencyExchangeData ed on ed.FromCurrencyID = se.CurrencyID and ToCurrencyID = 73 
group by ps.LandingPageURLsID


-- Group Level
Select ps.campaignid, 
	ps.adcategoryid, 
	ps.SEID, 
	sum(isnull(convert(bigint, NumImpressions), 0)) as [NumImpressions], 
	sum(isnull(NumClicksReported, 0)) as [NumClicksReported], 
	sum(NumClicksTracked) as NumClicksTracked,
	sum(isnull(Cost, 0) * isnull(ExchangeRate, 1)) as [Cost],
	sum(TotalRank) as TotalRank, sum(TotalRankCount) as TotalRankCount, 
	sum(NumClicksAssisted) as NumClicksAssisted, 
	sum(COALESCE(TTCount, TransactionCount, 0)) as TransactionCount,
	sum(isnull(TransactionAmount, 0) * isnull(ExchangeRate, 1)) as TransactionAmount,
	isnull(sum(isnull(TransactionCountWithWeight, 0)), 0) as TransactionCountWithWeight   
From dbo.RPT_PS_Summary_GroupLevel ps 
	join SearchEngine se on ps.ClientID = 2575 and ps.GenerateDate between 'Sep 6 2010 12:00AM' and 'Sep 12 2010 12:00AM' and ps.IsContentMatch = ps.IsContentMatch and se.SEID = ps.SEID 
	left join dbo.CurrencyExchangeData ed on ed.FromCurrencyID = se.CurrencyID and ToCurrencyID = 73 
group by ps.campaignid, ps.adcategoryid, ps.SEID


;WITH LandingPage AS(
	SELECT CampaignID,AdCategoryID,GenerateDate,SUM(NumClicksTracked) AS Landing_Page_TrackedCLicks
	From dbo.RPT_PS_LandingPageSummary_GroupLevel2 
	WHERE ClientID = 2575 and GenerateDate between 'Sep 6 2010 12:00AM' and 'Sep 12 2010 12:00AM'
	GROUP BY AdCategoryID,GenerateDate,CampaignID
),
GroupLevel AS (
	SELECT AdCategoryID,GenerateDate, SUM(NumClicksTracked)  AS GroupLvl_TrackedCLicks
	From dbo.RPT_PS_Summary_GroupLevel
	WHERE ClientID = 2575 and GenerateDate between 'Sep 6 2010 12:00AM' and 'Sep 12 2010 12:00AM'
	GROUP BY AdCategoryID,GenerateDate
)
SELECT ISNULL(gl.GenerateDate,lp.GenerateDate) AS Date,ISNULL(gl.AdCategoryID,lp.AdcategoryID) AS ADCategoryId,ISNULL(gl.GroupLvl_TrackedCLicks,0) AS GroupLvl_TrackedCLicks, ISNULL(lp.Landing_Page_TrackedCLicks,0)AS Landing_Page_TrackedCLicks, ABS(ISNULL(lp.Landing_Page_TrackedCLicks,0) - ISNULL(gl.GroupLvl_TrackedCLicks,0)) AS DIFF FROM Grouplevel gl
FULL JOIN  LandingPage lp ON lp.AdCategoryID = gl.AdCategoryID AND lp.GenerateDate = gl.GenerateDate AND lp.Landing_Page_TrackedCLicks <> gl.GroupLvl_TrackedCLicks
--WHERE ABS(ISNULL(lp.Landing_Page_TrackedCLicks,0) - ISNULL(gl.GroupLvl_TrackedCLicks,0)) > 0
ORDER BY ISNULL(gl.GenerateDate,lp.GenerateDate)


