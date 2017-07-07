USE [Searchignite]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SI_SP_BSR_Download_Keywords_New]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SI_SP_BSR_Download_Keywords_New]
GO

USE [Searchignite]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [dbo].[SI_SP_BSR_Download_Keywords_New]
	@bulksheetqueueID [int]
	,@isDebug TINYINT = 0
AS
/*
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Change History
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--01/26/10	YZ Per Calvin, app is no longer pass @RD, need to use ReportDataStartDate AND ReportDataENDDate FROM BulksheetQueue
--02/08/10	YZ SIP-1894, Per Calvin, [SI_SP_BSR_Download_Keywords_New] need to return bid amount as ManualCPCBid for "Else" condition. Currently it set to null. This is new requirement
--02/10/10	LIR Moved advance filter down and added all the columns needed for filter into the CTE
--02/17/10	YZ Missing 2 columns RuleMinBid and RuleMaxBid
--02/18/10	YZ Missing Transactions column
--02/24/10	LIR added 	,RecommendedBid	,PredictedRank	to result set
--02/28/10	LIR Added StatusFlag check at all levels
--02/28/10	LIR added code to support Advance filter
--03/02/10	WDJ resolved SPOTID error
--03/02/10	LIR Change the data filter to a between on the Engine data cte
--03/04/10	LIR SIP-2580 Added KeywordMatchTypeID for the Advance filter
--03/08/10	LIR removed KeywordmatchID.. 
--03/09/10	LIR Fixed error with firstpageminbid
--03/11/10	LIR Fixed problem with joining to campaignsearchEngine by seid not CampaignID
				also added @clientid to the join for safety
--03/18/10	LIR Added BidRuleID and DailyBudgetConverted to result for advance filter
--04/01/10	LIR JIRA SIP -3063 should not return any records because in ClientSearchEngineMapping, the statusflag = 0 
--05/18/10	LIR JIRA SIP-3384 resolved the currency code
--05/27/10	LIR Added Audit code to resolve performance issues
--06/01/10	LIR	Moved RPT data to temp table and built an index
--06/11/10	YZ	SIP-3674 for currency field, only return 2 decimal
--06/15/10	LIR SIP-3837 Online Bulkrequests > Certain Filter and Request Combos Cause Errors.
--06/18/10	WDJ Changed Advanced filter to NVARCHAR for other character sets and added a VARCHAR(MAX)
				to a conversion to extend the executable code beyond the 4000 character limit.
--06/24/10	YZ	SIP-3667 Replace ''Manual'' with ''''
--07/01/10	LIR	SIP-3777 Please hard code @StartDate & @EndDate to 7 days starting with Day prior to yesterday
--07/02/10	YZ	SIP-4114 BidRule need to include Daypart
--07/14/10	YZ	SIP-4255  If ParentSeId = 82, then 
				   1) If group level EnableContentMatch is false, do not return keywords with MatchTypeId = 4 
				   2) If group level EnableSearchMatch is false, do not return keywords other than MatchTypeId = 4
--07/23/10	YZ	SIP-4309 Duplicate groups
--07/28/10	YZ	SIP-4342 Invalid KeywordStatusID
--08/09/10	YZ	SIP-4456 If RuleOptRank does not exists, it should be null instead of 0
--08/09/10	YZ	SIP-4271 Added CampaignStatusID Column in Keyword_CTE 
--08/09/10	YZ	SIP-4492 Add AdcategoryStatusID column in Keyword_CTE
--09/09/10	LIR	 SIP-5004 add quality score to bulksheet.
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Test Code
SI_SP_BSR_Download_Keywords_new
	@bulksheetqueueID = 17271

	,@isDebug =1
	
	SELECT 
	*	
	FROM BulkSheetQueue bsq
	order by bulksheetqueueid desc
		LEFT JOIN BulkSheetQueueCriteria bsqc ON bsq.BulkSheetQueueID = bsqc.BulkSheetQueueID	
where clientid = 1637
select * from lubulksheetstatus
BulkSheetStatusID	BulkSheetStatusDesc
1	In_Queue
2	Prepare
3	Pending_Approval
4	Approved
5	Rejected
6	Scheduled
7	Pending
8	Cancelled
9	Processing
10	Completed
11	Error
12	Expired

CREATE Table BulkSheetQueueAudit
(BulkSheetQueueAuditID int IDENTITY
,StoredProcedureName varchar(100)
,bulksheetqueueID INT
,SPID int
,StartUTCDateTime datetime
,EndUTCDateTime Datetime
)


SELECT StoredProcedureName
	,bsqa.BulksheetQueueID
	,ClientID
	,Spid
	,dateadd(hour,-4,startUTCDateTime) as StartTime
	,dateadd(hour,-4,EndUTCDateTime) as EndTime
 FROM BulkSheetQueueAudit bsqa
 left join BulkSheetQueue bsq on bsqa.BulksheetQueueID = bsq.BulkSheetQueueID

*/

BEGIN
	SET NOCOUNT ON
--Audit Code 05/27/10	
	DECLARE @BulkSheetQueueAuditID AS INT
	
	INSERT INTO BulkSheetQueueAudit(StoredProcedureName, bulksheetqueueID, spid, StartUTCDateTime)
	VALUES ('SI_SP_BSR_Download_Keywords_New',@bulksheetqueueID,@@spid, GETUTCDATE())

	SET @BulkSheetQueueAuditID = @@IDENTITY
--Audit Code 05/27/10
  	DECLARE 
		@AdvancedFilterXML XML 
		,@StartDate DATETIME
		,@EndDate DATETIME
		,@ClientID INT
		,@CurrencyID INT
		,@BulkSheetTypeID TINYINT
		,@SpotID INT
		,@Keyword_CTE  VARCHAR(MAX)
		,@KeywordRPT_CTE  VARCHAR(MAX)		
		,@SQL NVARCHAR(MAX)		
		,@CurrencySymbol NVARCHAR(10)
		,@SQL_AdvanceFilter NVARCHAR(4000)		
	
	CREATE TABLE #CampaignAdCategory 
	(
		AdCategoryID INT
		,AdCategoryName NVARCHAR(200)
		,CampaignID INT
		,CampaignTitle NVARCHAR(100)
		,SearchEngine NVARCHAR(200)
		,CampaignStatusDesc NVARCHAR(200)
		,AdCategoryStatusDesc VARCHAR(50)
		,AdCategoryBidRule VARCHAR(100)
		,ContentBid MONEY
		,DailyBudgetConverted MONEY
	)
		
--Check to see if there is an Advance filter for this queue
	SELECT 
		@AdvancedFilterXML = bsqc.BulkSheetFilter 	
		,@StartDate = ReportDataStartDate
		,@EndDate = ReportDataENDDate
		,@ClientID = ClientID
		,@CurrencyID = CurrencyID	
		,@BulkSheetTypeID = BulkSheetTypeID	
		,@SpotID = SpotID
	FROM BulkSheetQueue bsq
		LEFT JOIN BulkSheetQueueCriteria bsqc ON bsq.BulkSheetQueueID = bsqc.BulkSheetQueueID
	WHERE bsq.bulksheetqueueid = @bulksheetqueueID
	
	SELECT @CurrencyID = ISNULL(@CurrencyID, 73)
	
	SELECT @CurrencySymbol = CurrencySymbol
	FROM LUCurrency
	WHERE CurrencyID = @CurrencyID
	
	SELECT @CurrencySymbol = ISNULL(@CurrencySymbol, '$')
	
--if either are null then sEND in dates to return 0 report data
	IF @StartDate IS NULL OR @EndDate IS NULL
	BEGIN
		SET @StartDate = DATEADD(DAY,2,GETDATE())
		SET @EndDate = DATEADD(DAY,1,GETDATE())
	END	
	
--Get the list of groups to appy the bulksheet to
	IF EXISTS(	SELECT 1 
				FROM BulkSheetQueueSearchEngineCampaignGroup bq 
				WHERE BulkSheetQueueID = @BulkSheetQueueID
				)
	BEGIN	
		--Group Level
		INSERT INTO #CampaignAdCategory   (AdCategoryID, AdCategoryName, CampaignID, CampaignTitle, Searchengine, CampaignStatusDesc, AdCategoryStatusDesc, AdCategoryBidRule, ContentBid,DailyBudgetConverted)
		SELECT DISTINCT 
			cac.AdCategoryID
			,cac.AdCategoryName
			,cac.CampaignID
			,c.CampaignTitle
			,se.SearchEngine
			,CASE WHEN ucs.CampaignStatusDesc <> 'Active' THEN 'Campaign - ' + ucs.CampaignStatusDesc ELSE ucs.CampaignStatusDesc END AS [CampaignStatusDesc]	
			,lcs.AdCategoryDesc AS AdCategoryStatusDesc
			,BidRuleName AS AdCategoryBidRule		
			,cac.ContentBid	
			,(cse.DailyBudget * ISNULL(ExchangeRate,1.0)) AS DailyBudgetConverted
			
		FROM BulkSheetQueueSearchEngineCampaignGroup bq 
			JOIN CampaignAdCategory cac ON bq.AdCategoryID = cac.AdCategoryID
			JOIN Campaign c ON cac.CampaignID = c.CampaignID
			JOIN CampaignSearchEngine cse ON c.CampaignID = cse.CampaignID
			JOIN SearchEngine se ON cse.SEID = se.SEID	
			JOIN ClientSearchEngineMapping csem ON  se.seid = csem.seid 
				AND csem.clientid = @ClientID
				AND csem.StatusFlag = 1
			JOIN LUCampaignStatus ucs ON ucs.CampaignStatusID = c.CampaignStatusID			
			JOIN LUAdCategoryStatus lcs ON lcs.AdCategoryStatusID = cac.AdCategoryStatusID
			LEFT JOIN CampaignAdCategorySEBidRule sb ON sb.AdCategoryID = cac.AdCategoryID 
				AND sb.SEID = se.SEID
			LEFT JOIN BidRule bi ON bi.BidRuleID = sb.BidRuleID
			LEFT JOIN CurrencyExchangeData ed ON ed.FromCurrencyID = se.CurrencyID 
				AND ToCurrencyID = @CurrencyID				
		WHERE BulkSheetQueueID = @BulkSheetQueueID
			AND bq.AdCategoryID IS NOT NULL
			AND cac.AdCategoryStatusID IN (1,2)
			AND c.CampaignStatusID IN (1,2)-- only return records FROM Active or Paused Campaigns
			AND cac.StatusFlag = 1
			AND c.StatusFlag = 1
			AND cse.StatusFlag = 1
			AND c.ClientID = @ClientID

	--Campaign Level
		INSERT INTO #CampaignAdCategory   (AdCategoryID, AdCategoryName, CampaignID, CampaignTitle, Searchengine, CampaignStatusDesc, AdCategoryStatusDesc, AdCategoryBidRule, ContentBid,DailyBudgetConverted)
		SELECT DISTINCT 
			cac.AdCategoryID
			,cac.AdCategoryName
			,cac.CampaignID
			,c.CampaignTitle
			,se.SearchEngine
			,CASE WHEN ucs.CampaignStatusDesc <> 'Active' THEN 'Campaign - ' + ucs.CampaignStatusDesc ELSE ucs.CampaignStatusDesc END AS [CampaignStatusDesc]	
			,lcs.AdCategoryDesc AS AdCategoryStatusDesc
			,BidRuleName AS dCategoryBidRule	
			,cac.ContentBid	
			,(cse.DailyBudget * ISNULL(ExchangeRate,1.0)) AS DailyBudgetConverted			
			
		FROM BulkSheetQueueSearchEngineCampaignGroup bq 
			JOIN Campaign c ON bq.CampaignID = c.CampaignID	
			JOIN CampaignAdCategory cac ON c.CampaignID = cac.CampaignID
			JOIN CampaignSearchEngine cse ON c.CampaignID = cse.CampaignID
			JOIN SearchEngine se   ON cse.SEID = se.SEID	
			JOIN ClientSearchEngineMapping csem ON  se.seid = csem.seid 
				AND csem.clientid = @ClientID
				AND csem.StatusFlag = 1			
			JOIN LUCampaignStatus ucs   ON ucs.CampaignStatusID = c.CampaignStatusID			
			JOIN LUAdCategoryStatus lcs   ON lcs.AdCategoryStatusID = cac.AdCategoryStatusID
			LEFT JOIN dbo.CampaignAdCategorySEBidRule sb   ON sb.AdCategoryID = cac.AdCategoryID 
				AND sb.SEID = se.SEID
			LEFT JOIN dbo.BidRule bi   ON bi.BidRuleID = sb.BidRuleID
			LEFT JOIN CurrencyExchangeData ed ON ed.FromCurrencyID = se.CurrencyID 
				AND ToCurrencyID = @CurrencyID				
		WHERE BulkSheetQueueID = @BulkSheetQueueID
			AND bq.AdCategoryID IS NULL
			AND bq.CampaignID IS NOT NULL
			AND cac.AdCategoryStatusID IN (1,2)	
			AND c.CampaignStatusID IN (1,2)-- only return records FROM Active or Paused Campaigns
			AND cac.StatusFlag = 1
			AND c.StatusFlag = 1
			AND cse.StatusFlag = 1
			AND c.ClientID = @ClientID	
			and not exists (select 1 from #CampaignAdCategory where AdCategoryID = 	cac.AdCategoryID)

	--SE Level
		INSERT INTO #CampaignAdCategory   (AdCategoryID, AdCategoryName, CampaignID, CampaignTitle, Searchengine, CampaignStatusDesc, AdCategoryStatusDesc, AdCategoryBidRule, ContentBid, DailyBudgetConverted)
		SELECT DISTINCT 
			cac.AdCategoryID
			,cac.AdCategoryName
			,cac.CampaignID
			,c.CampaignTitle
			,se.SearchEngine
			,CASE WHEN ucs.CampaignStatusDesc <> 'Active' THEN 'Campaign - ' + ucs.CampaignStatusDesc ELSE ucs.CampaignStatusDesc END AS [CampaignStatusDesc]	
			,lcs.AdCategoryDesc AS [AdCategoryStatusDesc]
			,BidRuleName AS [AdCategoryBidRule]		
			,cac.ContentBid	
			,(cse.DailyBudget * ISNULL(ExchangeRate,1.0)) AS DailyBudgetConverted			
			
		FROM BulkSheetQueueSearchEngineCampaignGroup bq 
			JOIN CampaignSearchEngine cse ON cse.SEID = bq.SEID 
			JOIN Campaign c ON c.CampaignID = cse.CampaignID 
			JOIN CampaignAdCategory cac ON c.CampaignID = cac.CampaignID 
			JOIN SearchEngine se   ON cse.SEID = se.SEID	
			JOIN ClientSearchEngineMapping csem ON  se.seid = csem.seid 
				AND csem.clientid = @ClientID
				AND csem.StatusFlag = 1			
			JOIN LUCampaignStatus ucs   ON ucs.CampaignStatusID = c.CampaignStatusID			
			JOIN dbo.LUAdCategoryStatus lcs   ON lcs.AdCategoryStatusID = cac.AdCategoryStatusID
			LEFT JOIN dbo.CampaignAdCategorySEBidRule sb   ON sb.AdCategoryID = cac.AdCategoryID 
				AND sb.SEID = se.SEID
			LEFT JOIN dbo.BidRule bi   ON bi.BidRuleID = sb.BidRuleID
			LEFT JOIN CurrencyExchangeData ed ON ed.FromCurrencyID = se.CurrencyID 
				AND ToCurrencyID = @CurrencyID				
		WHERE BulkSheetQueueID = @BulkSheetQueueID
			AND bq.AdCategoryID IS NULL
			AND bq.CampaignID IS NULL
			AND cac.AdCategoryStatusID IN (1,2)	
			AND c.CampaignStatusID IN (1,2)-- only return records FROM Active or Paused Campaigns
			AND cac.StatusFlag = 1
			AND c.StatusFlag = 1
			AND cse.StatusFlag = 1
			AND c.clientid = @clientid		
			and not exists (select 1 from #CampaignAdCategory where AdCategoryID = 	cac.AdCategoryID)
	END
	ELSE
	BEGIN
		INSERT INTO #CampaignAdCategory   (AdCategoryID, AdCategoryName, CampaignID, CampaignTitle, Searchengine, CampaignStatusDesc, AdCategoryStatusDesc, AdCategoryBidRule, ContentBid, DailyBudgetConverted)
		SELECT DISTINCT 
			cac.AdCategoryID
			,cac.AdCategoryName
			,cac.CampaignID
			,c.CampaignTitle
			,se.SearchEngine
			,CASE WHEN ucs.CampaignStatusDesc <> 'Active' THEN 'Campaign - ' + ucs.CampaignStatusDesc ELSE ucs.CampaignStatusDesc END AS [CampaignStatusDesc]	
			,lcs.AdCategoryDesc AS AdCategoryStatusDesc
			,BidRuleName AS AdCategoryBidRule		
			,cac.ContentBid	
			,(cse.DailyBudget * ISNULL(ExchangeRate,1.0)) AS DailyBudgetConverted			
			
		FROM CampaignSearchEngine cse
			JOIN Campaign c ON cse.CampaignID = c.CampaignID 
			JOIN CampaignAdCategory cac ON c.CampaignID = cac.CampaignID 
			JOIN SearchEngine se   ON cse.SEID = se.SEID	
			JOIN ClientSearchEngineMapping csem ON  se.seid = csem.seid 
				AND csem.clientid = @ClientID
				AND csem.StatusFlag = 1			
			JOIN LUCampaignStatus ucs   ON ucs.CampaignStatusID = c.CampaignStatusID			
			JOIN LUAdCategoryStatus lcs   ON lcs.AdCategoryStatusID = cac.AdCategoryStatusID
			LEFT JOIN dbo.CampaignAdCategorySEBidRule sb   ON sb.AdCategoryID = cac.AdCategoryID 
				AND sb.SEID = se.SEID
			LEFT JOIN BidRule bi ON bi.BidRuleID = sb.BidRuleID
			LEFT JOIN CurrencyExchangeData ed ON ed.FromCurrencyID = se.CurrencyID 
				AND ToCurrencyID = @CurrencyID			
		WHERE cac.AdCategoryStatusID IN (1,2)	
			AND cac.AdCategoryStatusID IN (1,2)	
			AND c.CampaignStatusID IN (1,2)-- only return records FROM Active or Paused Campaigns
			AND cac.StatusFlag = 1
			AND c.StatusFlag = 1
			AND cse.StatusFlag = 1	
			AND c.clientid = @clientid				
	END;	
-- get 7 days worth of data if spot	
	IF @BulkSheetTypeID = 4--Spot
	BEGIN
		SET @StartDate = DATEADD(DAY,-8,GETDATE())
		SET @EndDate = DATEADD(DAY,-1,GETDATE())
	end
-- put report data into a temp table
SELECT
	rp.CSKID
	,rp.SEID
	,SUM(Cost * ISNULL(ExchangeRate, 1)) AS Cost
	,SUM(NumClicksReported) AS NumClicksReported
	,SUM(TransactionAmount * ISNULL(ExchangeRate, 1)) AS TransactionAmount
	,SUM(ISNULL(TTCount, TransactionCount)) AS TransactionCount
	,SUM(NumImpressions) AS NumImpressions	
INTO #RPTData	
FROM SIOLAP.dbo.RPT_PS_Summary_CSKLevel rp 
	JOIN SearchEngine se ON rp.SEID = se.SEID
	LEFT JOIN CurrencyExchangeData ed ON ed.FromCurrencyID = se.CurrencyID 
		AND ToCurrencyID = @CurrencyID 	
WHERE ClientID = @ClientID  
	AND rp.GenerateDate BETWEEN @StartDate  AND @EndDate 
GROUP BY rp.CSKID, rp.SEID

CREATE INDEX idx_CSKID ON #RPTData (cskid)	
--	Code to apply the AdvancedFilter
	IF  @AdvancedFilterXML IS NOT NULL
	BEGIN
		SET @SQL_AdvanceFilter = '
	WHERE 1 = 1 ' + [dbo].[fn_CampaignManagementAdvancedFilter](@AdvancedFilterXML,5);
	END
	ELSE
		SET @SQL_AdvanceFilter  = ''	
   
	IF @BulkSheetTypeID = 4--Spot
	BEGIN
		SET @Keyword_CTE = 
'WITH Keyword_CTE AS
(
SELECT 
	ck.Keyword AS Keyword
	,ck.CSKID AS CSKID
	,cc.AdCategoryName AS AdCategoryName
	,cc.AdCategoryID AS AdCategoryID
	,c.CampaignTitle AS CampaignTitle
	,c.CampaignID AS CampaignID
	,se.SearchEngine AS SearchEngine
	,(CASE WHEN acs.AdCategoryDesc = ''Active'' THEN (CASE WHEN ucs.CampaignStatusDesc <> ''Active'' THEN ''Campaign - '' + ucs.CampaignStatusDesc ELSE ucs.CampaignStatusDesc END) ELSE ''Group - '' + acs.AdCategoryDesc END) AS CampaignStatusDesc
	,(CASE WHEN CSKeywordStatusID = 1 AND KeywordSearchEngineDetailStatusID = 5 THEN ''InActive'' ELSE lcs.KeyWordStatusDesc END) AS KeywordStatusDesc
	,lkm.KeywordMatchDesc AS KeywordMatchDesc
	,ir.RecommendedBid AS ManualCPCBid
	,(CASE WHEN IsRedirect = 1 THEN ck.RedirectURL ELSE ck.URL END) AS DestinationURL
	,(CASE WHEN ck.bidruleid IS NULL AND spot.SpotID IS NOT NULL THEN ''Spot:'' + co.[Name]
		 WHEN ck.bidruleid IS NOT NULL AND sb.AdCategoryID IS NOT NULL THEN ''Group:'' + br.BidRuleName
		 WHEN ck.bidruleid IS NOT NULL AND sb.AdCategoryID IS NULL AND GlobalRule <> 1 THEN ''Keyword Bid Rule''
		 WHEN ck.bidruleid IS NOT NULL AND sb.AdCategoryID IS NULL AND GlobalRule = 1 THEN br.BidRuleName
		 ELSE '''' END) AS CurrentBidMethod
	,(CASE WHEN GlobalRule = 1 THEN NULL ELSE br.MinBid END) AS RuleMinBid
	,(CASE WHEN GlobalRule = 1 THEN NULL ELSE br.MaxBid END) AS RuleMaxBid
	,(CASE WHEN GlobalRule = 1 THEN NULL
		 WHEN GlobalRule <> 1 AND brgs.BidRuleID IS NOT NULL THEN brgs.OptimalRank
		 ELSE null END) AS RuleOptRank
	,(CASE WHEN GlobalRule <> 1 AND br.BidRuleTypeID = 1 THEN brp.PerformanceValue ELSE NULL END) AS RuleCPA
	,(CASE WHEN GlobalRule <> 1 AND br.BidRuleTypeID = 3 THEN brp.PerformanceValue ELSE NULL END) AS RuleROAS
	,(CASE WHEN ck.bidruleid IS NULL AND spot.SpotID IS NULL OR GlobalRule = 1 THEN NULL ELSE ck.MainBidAmount END) as RuleStartBid
	,CONVERT(NUMERIC(10, 2), b.finalBid) AS CurrentBid
	,cskri.currentrank AS CurrentRank
	,ir.RecommendedBid
	,ir.PredictedRank
	,(CASE when kr.Rank <= 30 THEN CONVERT(VARCHAR(5), kr.Rank) ELSE ''30+'' END) AS [Rank]
	,ck.MinBid AS FirstPageMinBid
	,ck.KeywordMatchTypeID	
	,ck.BidRuleID
	,cc1.DailyBudgetConverted
	,ck.CSKeywordStatusID as KeywordStatusID
	,c.CampaignStatusID
	,cc.AdcategoryStatusID
	,cskri.QualityScore
FROM #CampaignAdCategory cc1
	JOIN CampaignAdCategory cc ON cc.AdCategoryID = cc1.AdCategoryID --Filter by the bulksheetqueue
	JOIN SpotAdGroups AS spot ON
		spot.ClientID = ' + CAST(@ClientID AS VARCHAR(MAX)) + ' 
		AND spot.SPOTID = ' + CAST(@SpotID AS VARCHAR(MAX)) + '
		AND spot.adcategoryid = cc.adcategoryid 
	JOIN Campaign c ON c.CampaignID = cc.CampaignID 
	JOIN LUCampaignStatus ucs   ON ucs.CampaignStatusID = c.CampaignStatusID
	JOIN LUAdCategoryStatus acs ON acs.AdCategoryStatusID = cc.AdCategoryStatusID
	JOIN CSKeywords ck ON ck.ClientID = ' + CAST(@ClientID AS VARCHAR(MAX)) + ' 
		AND ck.CampaignID = c.CampaignID 
		AND ck.AdCategoryID = cc.AdCategoryID 
		AND ck.SEID = spot.SEID 
		AND ck.CSKeywordStatusID  BETWEEN 1 AND 3 
		AND ck.StatusFlag = 1
	JOIN SearchEngine se ON ck.SEID = se.SEID
	JOIN LUKeyWordStatus lcs   ON lcs.KeyWordStatusID = ck.CSKeywordStatusID
	JOIN lukeywordmatchtype lkm ON ck.KeywordMatchTypeID = lkm.KeywordMatchTypeID 
	LEFT JOIN CampaignAdCategorySEBidRule sb   ON sb.AdCategoryID = cc.AdCategoryID 
		AND sb.SEID = se.SEID 
		AND sb.BidRuleID = ck.BidRuleID
	LEFT JOIN CampaignOptimizerSettings co ON co.SpotID = spot.SpotID
	LEFT JOIN BidRule br   ON br.BidRuleID = ck.BidRuleID
	LEFT JOIN BidRulePerformance brp ON brp.bidruleid = br.bidruleid
	LEFT JOIN BidRuleGapSurfing brgs ON brgs.BidRuleID = br.BidRuleID
	LEFT JOIN Bid b ON b.cskid = ck.cskid
	LEFT JOIN CSKeywordsRankInfo cskri ON cskri.cskid = ck.cskid
	LEFT JOIN Bid bi   ON bi.CSKID = ck.CSKID
	LEFT JOIN SpotBidAndRank ir ON ir.SpotID = ' + CAST(@SpotID AS VARCHAR(MAX)) + ' 
		AND ir.CSKID = ck.CSKID
	LEFT JOIN SEOKeywordRank kr ON kr.clientid = ' + CAST(@ClientID AS VARCHAR(MAX)) + ' 
		AND kr.seid = se.seid 
		AND kr.keyword = ck.keyword 
		AND kr.isActive = 1
	WHERE c.ClientID = ' + CAST(@ClientID AS VARCHAR(MAX)) + '
		AND cc.AdCategoryStatusID IN (1,2)
		AND cc.StatusFlag = 1 	
		AND c.CampaignStatusID IN (1,2)
		AND c.StatusFlag = 1	
		AND lkm.KeywordMatchTypeID <> 10	
		and (Case when ParentSEID = 82 and GroupEnableContentMatch = 0 and GroupEnableSearchMatch = 0 then 0
				when ParentSEID = 82 and GroupEnableContentMatch = 0 and GroupEnableSearchMatch = 1 and ck.KeywordMatchTypeID = 4 then 0
				when ParentSEID = 82 and GroupEnableContentMatch = 1 and GroupEnableSearchMatch = 0 and ck.KeywordMatchTypeID <> 4 then 0
				else 1 end) = 1	
)				
'
	END		
	ELSE
	BEGIN
		SET @Keyword_CTE  = 
'WITH Keyword_CTE AS
(
SELECT 
	ck.Keyword AS Keyword
	,ck.CSKID AS CSKID
	,cc.AdCategoryName AS AdCategoryName
	,cc.AdCategoryID AS AdCategoryID
	,c.CampaignTitle AS CampaignTitle
	,c.CampaignID AS CampaignID
	,se.SearchEngine AS SearchEngine
	,(CASE WHEN acs.AdCategoryDesc = ''Active'' THEN (CASE WHEN ucs.CampaignStatusDesc <> ''Active'' THEN ''Campaign - '' + ucs.CampaignStatusDesc ELSE ucs.CampaignStatusDesc END) ELSE ''Group - '' + acs.AdCategoryDesc END) AS CampaignStatusDesc
	,(CASE WHEN CSKeywordStatusID = 1 AND KeywordSearchEngineDetailStatusID = 5 THEN ''InActive'' ELSE lcs.KeyWordStatusDesc END) AS KeywordStatusDesc
	,lkm.KeywordMatchDesc AS KeywordMatchDesc
	,CONVERT(NUMERIC(10,2), (CASE WHEN ck.bidruleid IS NULL AND spot.SpotID IS NULL THEN ck.MainBidAmount ELSE b.finalBid END)) AS ManualCPCBid
	,(CASE WHEN IsRedirect = 1 THEN ck.RedirectURL ELSE ck.URL END) AS DestinationURL
	,(CASE WHEN ck.bidruleid IS NULL AND spot.SpotID IS NOT NULL THEN ''Spot:'' + co.[Name]
		 WHEN ck.bidruleid IS NOT NULL AND sb.AdCategoryID IS NOT NULL THEN ''Group:'' + br.BidRuleName
		 WHEN ck.bidruleid IS NOT NULL AND sb.AdCategoryID IS NULL AND GlobalRule <> 1 THEN ''Keyword Bid Rule''
		 WHEN ck.bidruleid IS NOT NULL AND sb.AdCategoryID IS NULL AND GlobalRule = 1 THEN br.BidRuleName
		 ELSE '''' END) AS CurrentBidMethod
	,(CASE WHEN GlobalRule = 1 THEN NULL ELSE br.MinBid END) AS RuleMinBid
	,(CASE WHEN GlobalRule = 1 THEN NULL ELSE br.MaxBid END) AS RuleMaxBid
	,(CASE WHEN GlobalRule = 1 THEN NULL
		 WHEN GlobalRule <> 1 AND brgs.BidRuleID IS NOT NULL THEN brgs.OptimalRank
		 ELSE null END) AS RuleOptRank
	,(CASE WHEN GlobalRule <> 1 AND br.BidRuleTypeID = 1 THEN brp.PerformanceValue ELSE NULL END) AS RuleCPA
	,(CASE WHEN GlobalRule <> 1 AND br.BidRuleTypeID = 3 THEN brp.PerformanceValue ELSE NULL END) AS RuleROAS
	,(CASE WHEN
		ck.bidruleid IS NULL
		AND spot.SPOTID IS NULL
		OR GlobalRule = 1 THEN NULL ELSE ck.MainBidAmount END) as RuleStartBid
	,CONVERT(NUMERIC(10, 2), b.finalBid) AS CurrentBid
	,cskri.currentrank AS CurrentRank
	,(CASE when kr.RANK IS NULL OR kr.Rank <= 30  THEN CONVERT(VARCHAR(5), kr.Rank) ELSE ''30+'' END) AS Rank
	,ck.MinBid AS FirstPageMinBid
	,'''' AS RecommendedBid
	,'''' AS PredictedRank
	,ck.KeywordMatchTypeID
	,ck.BidRuleID
	,cc1.DailyBudgetConverted
	,ck.CSKeywordStatusID as KeywordStatusID
	,c.CampaignStatusID
	,cc.AdcategoryStatusID
	,cskri.QualityScore
FROM #CampaignAdCategory cc1 
	JOIN CampaignAdCategory cc ON cc.AdCategoryID = cc1.AdCategoryID 
	JOIN CampaignSearchEngine cse ON cc.CampaignID = cse.CampaignID
	JOIN Campaign c ON c.CampaignID = cse.CampaignID 
	JOIN LUCampaignStatus ucs   ON ucs.CampaignStatusID = c.CampaignStatusID
	JOIN LUAdCategoryStatus acs   ON acs.AdCategoryStatusID = cc.AdCategoryStatusID
	JOIN CSKeywords ck ON ck.ClientID = ' + CAST(@ClientID AS VARCHAR(MAX)) + ' 
		AND ck.CampaignID = c.CampaignID 
		AND ck.AdCategoryID = cc.AdCategoryID 
		AND ck.SEID = cse.SEID 
		AND ck.CSKeywordStatusID  BETWEEN 1 AND 3 
		AND ck.StatusFlag = 1
	JOIN SearchEngine se ON ck.SEID = se.SEID
	JOIN LUKeyWordStatus lcs   ON lcs.KeyWordStatusID = ck.CSKeywordStatusID
	JOIN LUKeywordMatchType lkm ON ck.KeywordMatchTypeID = lkm.KeywordMatchTypeID 
	LEFT JOIN CampaignAdCategorySEBidRule sb ON sb.AdCategoryID = cc.AdCategoryID 
		AND sb.SEID = se.SEID 
		AND sb.BidRuleID = ck.BidRuleID
	LEFT JOIN SpotAdGroups AS spot ON
		spot.ClientID = ' + CAST(@ClientID AS VARCHAR(MAX)) + ' 
		AND spot.AdCategoryID = ck.AdCategoryID 
		AND spot.SEID = ck.SEID
	LEFT JOIN CampaignOptimizerSettings co ON co.SpotID = spot.SpotID
	LEFT JOIN BidRule br ON br.BidRuleID = ck.BidRuleID
	LEFT JOIN BidRulePerformance brp ON brp.BidRuleID = br.BidRuleID
	LEFT JOIN BidRuleGapSurfing brgs ON brgs.BidRuleID = br.BidRuleID
	LEFT JOIN Bid b ON b.cskid = ck.cskid
	LEFT JOIN CSKeywordsRankInfo cskri ON cskri.cskid = ck.cskid
	LEFT JOIN SEOKeywordRank kr ON kr.clientid = ' + CAST(@ClientID AS VARCHAR(MAX)) + '
		AND kr.SEID = se.SEID 
		AND kr.Keyword = ck.Keyword 
		AND kr.isActive = 1
WHERE c.ClientID = ' + CAST(@ClientID AS VARCHAR(MAX)) + '
	AND cc.AdCategoryStatusID IN (1,2)
	AND cc.StatusFlag = 1 	
	AND c.CampaignStatusID IN (1,2)
	AND c.StatusFlag = 1	
	AND lkm.KeywordMatchTypeID <> 10
	and (Case when ParentSEID = 82 and GroupEnableContentMatch = 0 and GroupEnableSearchMatch = 0 then 0
				when ParentSEID = 82 and GroupEnableContentMatch = 0 and GroupEnableSearchMatch = 1 and ck.KeywordMatchTypeID = 4 then 0
				when ParentSEID = 82 and GroupEnableContentMatch = 1 and GroupEnableSearchMatch = 0 and ck.KeywordMatchTypeID <> 4 then 0
				else 1 end) = 1
)'
	END
	
	SET @SQL =  @Keyword_CTE +  
', FinalCTE AS
(
SELECT 
	Keyword
	,Keyword_CTE.CSKID
	,AdCategoryName
	,AdCategoryID
	,CampaignTitle
	,CampaignID
	,SearchEngine
	,CampaignStatusDesc
	,KeywordStatusDesc
	,KeywordMatchDesc
	,ManualCPCBid
	,DestinationURL
	,CurrentBidMethod
	,RuleMinBid
	,RuleMaxBid
	,RuleOptRank
	,RuleCPA
	,RuleROAS
	,RuleStartBid
	,ISNULL(NumClicksReported,0) AS NumClicksReported
	,ISNULL(TransactionCount,0) AS TransactionCount	
	,ISNULL(TransactionCount,0) AS WeightedActions
	,ISNULL(NumImpressions,0) AS NumImpressions	
	,ISNULL(Cost,0) AS Cost
	,ISNULL(TransactionAmount,0.0) AS TransactionAmount
	,CASE WHEN ISNULL(NumImpressions,0) > 0 THEN ISNULL(100.00 * NumClicksReported / NumImpressions,0) ELSE 0 END AS CTR		
    ,CASE WHEN NumClicksReported > 0 THEN ISNULL(Cost/NumClicksReported, 0) ELSE 0 END AS CPC	
    ,CASE WHEN (ISNULL(TransactionCount,0) > 0 AND ISNULL(Cost,0) > 0) THEN ISNULL(Cost/TransactionCount,0) ELSE 0 END AS CPA	
    ,CASE WHEN (ISNULL(TransactionCount,0) > 0 AND ISNULL(NumClicksReported,0) > 0) THEN ISNULL(TransactionCount/NumClicksReported * 100,0) ELSE 0 END AS ConversionRate
    ,CASE WHEN (ISNULL(TransactionAmount,0) > 0 AND ISNULL(Cost,0) > 0) THEN ISNULL(TransactionAmount/Cost,0) ELSE 0 END AS ROAS		
	,CurrentBid
	,CurrentBid AS SearchBidConverted
	,CurrentRank
	,Rank
	,FirstPageMinBid
	,RecommendedBid
	,PredictedRank	
	,KeywordMatchTypeID
	,BidRuleID
	,DailyBudgetConverted
	,KeywordStatusID
	,CampaignStatusID
	,AdcategoryStatusID
	,QualityScore
FROM Keyword_CTE 
	LEFT JOIN #RPTData ON  Keyword_CTE.CSKID = #RPTData.CSKID
)
SELECT 
	Keyword
	,CSKID
	,AdCategoryName
	,AdCategoryID
	,CampaignTitle
	,CampaignID
	,SearchEngine
	,CampaignStatusDesc
	,KeywordStatusDesc
	,KeywordMatchDesc
	,ManualCPCBid
	,DestinationURL
	,CurrentBidMethod
	,RuleMinBid
	,RuleMaxBid
	,RuleOptRank
	,RuleCPA
	,RuleROAS
	,RuleStartBid
	,'''' AS [CheckSum]
	,'''' AS Errors
	,'''+ CAST(@CurrencySymbol AS VARCHAR(MAX)) +''' + CONVERT(VARCHAR(20), convert(decimal(18,2), Cost)) AS MediaCost
	,NumClicksReported AS Clicks
	,'''+ CAST(@CurrencySymbol AS VARCHAR(MAX)) +''' + CONVERT(VARCHAR(20), convert(decimal(18,2), TransactionAmount)) AS Revenue
	,' + CONVERT(VARCHAR(MAX), @CurrencyID) + ' AS CurrencyID
	,TransactionCount as Transactions
	,CurrentBid
	,CurrentRank
	,Rank
	,FirstPageMinBid AS MinBid 
	,RecommendedBid
	,PredictedRank	
	,BidRuleID	
	,DailyBudgetConverted
	,QualityScore
FROM FinalCTE'
	+ @SQL_AdvanceFilter  + '
ORDER BY CampaignTitle, AdCategoryName, SearchEngine, Keyword
'
	IF @isDebug = 1
	BEGIN
		PRINT '/*	Advance Filter '
		PRINT @SQL_AdvanceFilter
		select 
			@CurrencyID as CurrencyID
			,@ClientID as Clientid
			,@StartDate as StartDate
			,@EndDate as Enddate
			,@SQL_AdvanceFilter as Advancefilter
			,@CurrencySymbol as CurrencySymbol
		PRINT '*/
		
GO
IF OBJECT_ID(''tempdb..#CampaignAdCategory'') IS NULL
	CREATE TABLE #CampaignAdCategory 
	(
		AdCategoryID INT
		,AdCategoryName NVARCHAR(200)
		,CampaignID INT
		,CampaignTitle NVARCHAR(100)
		,SearchEngine NVARCHAR(200)
		,CampaignStatusDesc NVARCHAR(200)
		,AdCategoryStatusDesc VARCHAR(50)
		,AdCategoryBidRule VARCHAR(100)
		,ContentBid MONEY
		,DailyBudgetConverted MONEY				
	)
ELSE
	TRUNCATE TABLE 	#CampaignAdCategory 
GO

INSERT INTO #CampaignAdCategory   (AdCategoryID, AdCategoryName, CampaignID, CampaignTitle, Searchengine, CampaignStatusDesc, AdCategoryStatusDesc, AdCategoryBidRule, ContentBid,DailyBudgetConverted)
SELECT TOP 1000 
	cac.AdCategoryID
	,cac.AdCategoryName
	,cac.CampaignID
	,c.CampaignTitle
	,se.SearchEngine
	,CASE WHEN ucs.CampaignStatusDesc <> ''Active'' THEN ''Campaign - '' + ucs.CampaignStatusDesc ELSE ucs.CampaignStatusDesc END AS [CampaignStatusDesc]	
	,lcs.AdCategoryDesc AS AdCategoryStatusDesc
	,BidRuleName AS AdCategoryBidRule		
	,cac.ContentBid	
	,(cse.DailyBudget * ISNULL(ExchangeRate,1.0)) AS DailyBudgetConverted	
FROM CampaignSearchEngine cse
	JOIN Campaign c ON cse.CampaignID = c.CampaignID
	JOIN CampaignAdCategory cac ON c.CampaignID = cac.CampaignID 
	JOIN SearchEngine se   ON cse.SEID = se.SEID	
	JOIN LUCampaignStatus ucs   ON ucs.CampaignStatusID = c.CampaignStatusID			
	JOIN LUAdCategoryStatus lcs   ON lcs.AdCategoryStatusID = cac.AdCategoryStatusID
	LEFT JOIN dbo.CampaignAdCategorySEBidRule sb   ON sb.AdCategoryID = cac.AdCategoryID 
		AND sb.SEID = se.SEID
	LEFT JOIN BidRule bi ON bi.BidRuleID = sb.BidRuleID
	LEFT JOIN CurrencyExchangeData ed ON ed.FromCurrencyID = se.CurrencyID 
		AND ToCurrencyID = ' + CONVERT(VARCHAR(MAX), @CurrencyID) + '		
WHERE cac.AdCategoryStatusID IN (1,2)	
	AND cac.AdCategoryStatusID IN (1,2)	
	AND c.CampaignStatusID IN (1,2)-- only return records FROM Active or Paused Campaigns
	AND cac.StatusFlag = 1
	AND c.StatusFlag = 1
	AND cse.StatusFlag = 1			
	AND c.ClientID = ' + CAST(@ClientID AS VARCHAR(MAX)) + ';
	
'		
			
		PRINT @SQL 
	END
	ELSE
		EXEC(@SQL)
		
--Audit Code 05/27/10		
	UPDATE BulkSheetQueueAudit
	SET EndUTCDateTime = GETUTCDATE()
	WHERE BulkSheetQueueAuditID = @BulkSheetQueueAuditID	
	
	DELETE FROM BulkSheetQueueAudit
	WHERE EndUTCDateTime < DATEADD(DD,-20,GETUTCDATE())
--Audit Code 05/27/10	
END







GO

GRANT EXECUTE ON [dbo].[SI_SP_BSR_Download_Keywords_New] TO [webaccess] AS [dbo]
GO


