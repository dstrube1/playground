USE [Searchignite]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SI_SP_CampaignManagement_Ads_ReadNew]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SI_SP_CampaignManagement_Ads_ReadNew]
GO

USE [Searchignite]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO











CREATE PROCEDURE [dbo].[SI_SP_CampaignManagement_Ads_ReadNew] 
(
	@ClientID INT 	
,	@IncludeContentMatch TINYINT =NULL	
,	@StartDate DATETIME	
,	@EndDate DATETIME	
,	@currencyID INT =NULL	
,	@CONVERT BIT 	=NULL
,	@CustomerTransactionType NVARCHAR(MAX)= NULL
,	@SortDataGridColumnID INT = 1
,	@SortDescending TINYINT  = 0
,	@RowsPerPage INT = 50
,	@RequestPage INT =1
,	@PublisherFilterID INT = -1  --Look in SearchEngine for seid or Campaign for CampaignID
,	@PublisherFilterTypeID SMALLINT = -1 -- 1 is SEID, 2 is Campaign, and -1 is all publishers
,	@isDebug TINYINT = 0
,	@UserID INT 
,	@AdStatusID VARCHAR(1000) = NULL
,	@SearchText NVARCHAR(1000) = NULL
,	@AdvancedFilterXML XML = NULL
,	@AdvancedFilterID INT = NULL
,	@VGID INT = NULL
,   @ExcludedPublishers nvarchar(1000) = NULL
)

AS
/*
--	01/13/10	LIR	Initial version
--	01/13/10	LIR added support for currency conversions
--	01/16/10	LIR Cleanup format and validated sorting by all columns by moving aliasing to the temp table
--	01/19/10	LIR Changed the name of the @AdvanceFilter and added logic to look it up by ID
--	01/19/10	LIR added the SSRedirect AS CampaignSSRedirect
--	01/20/10	LIR Added Group paused and Campaign Paused to the Inhearted Status
--	01/22/10	LIR Modified which status passed into procedure to AdStatusID JIRA SIP-1597
--	01/26/10	LIR Formated and added other columns per JIRA SIP-1582
--	01/26/10	LIR added support for Campaign Deleted and Group Deleted to the InheritedStatus JIRA sip-1666
--	01/26/10	LIR added support for the bulksheets
--	02/01/10	LIR Fixed issues with currency conversion for CPA..etc
--	02/04/10	LIR Added support for the text search feature
--	02/10/10	LIR Moved Advancefilter down one CTE and validated all the advance filter columns and removed 99 publisher
--	02/17/10	LIR Added join to campaignSearchEngine and return dailybudget
--	02/23/10	LIR Fixed the table in the adstatus filter
--	02/24/10	LIR Change Publisher Status to Editorial Status
--	02/25/10	LIR fixed sort by InheritedStatusDesc
--	02/27/10	LIR fixed issue with delete status
--	02/27/10	LIR added dailyconvertedbudget AND contentbidconverted for the advance filter
--	03/01/10	LIR fixed InheritedStatusDesc to InheritedStatus
--	03/09/10	WDJ Performance improvements
--	03/09/10	YZ	SIP-2688 "Search" Box Does Not Return Results for Double Byte Characters
--	03/09/10	LIR Added support for wildcards
--	03/09/10	WDJ LEFT JOIN for Ads which have not been sent to the Publisher.
--	03/12/10	LIR fixed the filter by SEID
--	04/01/10	LIR JIRA sip-3050 Text Ad status remains "Active" after a Campaign is changed to "Deleted"
--	05/24/10	WDJ	Added special handling for single quotes (').
--	08/09/10	LIR	V 4.32	SIP-4457 Campaigns -> Sort by 'Ad Status' only sorts local screen and not whole data set
--	08/09/10	LIR	V 4.4 Patch 1 SIP-4855Compare SI_SP_CampaignManagement_Ads_Read with DEV vs. PP vs. Prod
--	09/07/10	YZ	SIP-4882 Weighted actions show incorrectly
--  10/06/10    JG  SIP-5341 Added ActivationDateTime and PauseDateTime columns from  CampaignAdTitleMapping
--	10/14/10	YZ	SIP-5327 filter by TransactionType does not work
--  10/27/10    JG  Fixed sort Issue with AdStatus column
--	11/01/10	YZ SIP-5643 We will use ClientCustomerTransactionTypeWeightHistory to calculate weights base on date range
--  11/04/10  JC SIP-5699 converted activation and pause dates back to client localized time from stored values in Eastern for display
--	11/16/10	WDJ SIP-5338 Created an artificial filter status for Text Ads (LINES 320-327, 615)
--  02/07/11 JRC  added ImageID to return set
--  02/08/11 JRC  Translation work 
--  02/10/11 JRC   Excluded Publisher parameter added to allow for differing text ad tabs
--  02/24/11 JRC  SIP-6771 moved Editorial Status retrieval further up to remove multiple references to adstatusid in the final select
--  04/19/11 JRC  SIP-6477 fixing adstatus filter to use derived AdStatus

select * from CampaignAdCategory where 1=0

EXEC SI_SP_CampaignManagement_Ads_Read
	 @ClientID =146
	,@StartDate = '09/01/09'
	,@EndDate = '10/01/09'		 
	,@UserID  = 2017
	,@IsDebug=0
	,@PublisherFilterID = 1
	,@PublisherFilterTypeID  = -1 -- 1 is SEID, 2 is Campaign, and -1 is all publishers
	,@ExcludedPublishers = '1,2,3'
	,@RowsPerPage  = 5000
	,@isDebug = 1
	,@IncludeContentMatch = 1
	,@currencyID = 72
	,@CONVERT =1 	
	,@CustomerTransactionType = '674,1,2'
	,@RequestPage =1
	,@SortDescending = 1
	,@SortDataGridColumnID = 53
	,@SearchText = '_'
	,@AdvancedFilterID = null
	,@AdStatusID = 1
	,@AdvancedFilterXML =
	'<si>
  <advancedfilter publisherfiltertypeid="4" publisherfiltertype="textad">
    <filterelement xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" publisherfiltertypeid="4" filterelementid="0" filtertypeid="4" filtertype="EditorialStatus" filteroperatorid="1" filteroperator="-1" datagridcolumnid="60" description="&lt;span fontWeight=''bold''&gt;Text Ad: Publisher Status &lt;/span&gt;is ''&lt;span fontWeight=''bold''&gt;Pending&lt;/span&gt;''">
      <values>
        <value>5</value>
      </values>
      <bidrules />
      <optgroups />
    </filterelement>
  </advancedfilter>
</si>'   

exec SI_SP_CampaignManagement_Ads_ReadNew @ClientID=4632,
--@ExcludedPublishers=N'84',
@PublisherFilterID=-1,
@SortDescending=0,
@StartDate='2011-06-04 00:00:00',
@UserID=4291,
@SortDataGridColumnID=54,
@RowsPerPage=150,
@PublisherFilterTypeID=-1
,@EndDate='2011-07-04 00:00:00',
@RequestPage=1,
@currencyID=73
,@IsDebug=1
    
*/
BEGIN
	SET NOCOUNT ON
	DECLARE 
		@SQL_RPTTablesTT_CTE NVARCHAR(MAX)
		,@SQL_RPTTables_CTE NVARCHAR(MAX)
		,@SQL_BaseTables_CTE NVARCHAR(MAX)
		,@SQL_AdCatoryStatus  VARCHAR(50)
		,@DynamicSQL NVARCHAR(MAX)
		,@StartDateTxt VARCHAR(20)
		,@EndDateTxt VARCHAR(20)
		,@FirstRow INT
		,@LastRow INT
		,@CurrencyIDTxt VARCHAR(10)
		,@SQL_AdvanceFilter NVARCHAR(MAX)
		,@SQL_ContentMatch  NVARCHAR(MAX)	
		,@SQL_Sort NVARCHAR(MAX)		
		,@LanguageID INT
		,@SQL_PublisherFilter NVARCHAR(MAX)
		,@SQL_FinalSelect NVARCHAR(MAX)
		,@SQL_FinalCTE NVARCHAR(MAX)
		,@SQL_BulkSheetFilter NVARCHAR(MAX)			
		,@SQL_Where NVARCHAR(MAX)
		,@SQL_Status VARCHAR(2000)
		,@ClientTimeZoneID smallint
		,@ClientDayLightSavings tinyint
	CREATE TABLE #VirtualGroupDetailCache (SEID SMALLINT, CampaignID INT, AdcategoryID INT)

--SET Varibles		
	SET @StartDateTxt = CONVERT(DATETIME, CONVERT(VARCHAR(20), @StartDate, 101))
	SET @EndDateTxt =	CONVERT(DATETIME, CONVERT(VARCHAR(20), @EndDate, 101))			
	SET @LastRow = @RequestPage * @RowsPerPage 
	SET @FirstRow = @LastRow - @RowsPerPage + 1
	SET @CurrencyIDTxt = CASE WHEN @CurrencyID IS NULL THEN 'NULL' ELSE CAST(@CurrencyID AS VARCHAR(10)) END
	SET @SQL_AdvanceFilter = ''
	SET @SQL_BulkSheetFilter = ''
------------------------------------------------------------------------------------------------------------
------------------------------ Set all the misc parameters for the dynamic SQL -----------------------------	

	SELECT @ClientTimeZoneID = TimeZoneID,
		@ClientDayLightSavings = DaylightSaving
	FROM dbo.Clients
	WHERE ClientID = @ClientID

--CustomerTransactiontype
	IF @CustomerTransactionType IS NOT NULL
		SET @CustomerTransactionType ='
		AND rt.CustomerTransactionTypeID IN ('+@CustomerTransactionType +')'
	ELSE
		SET @CustomerTransactionType = ''
		
--Content Match
	IF @IncludeContentMatch = 1 
		SET @SQL_ContentMatch = '
	AND IsContentMatch = 1'
	ELSE IF @IncludeContentMatch = 0 
		SET @SQL_ContentMatch = '
	AND IsContentMatch = 0'
	ELSE
		SET @SQL_ContentMatch = ''
		
--See if there is an Advance Filter
--Advance Filter
	IF @AdvancedFilterID IS NOT NULL
	BEGIN
		SELECT  @AdvancedFilterXML = AdvancedFilterXML  
		FROM AdvancedFilter
		WHERE @AdvancedFilterID =AdvancedFilterID 
		
		SET @SQL_AdvanceFilter = '
WHERE 1 =1 ' + dbo.fn_CampaignManagementAdvancedFilter(@AdvancedFilterXML,4)
	END	
	ELSE
		SET @SQL_AdvanceFilter = '
WHERE 1 = 1 ' + dbo.fn_CampaignManagementAdvancedFilter(@AdvancedFilterXML,4)

--See if there is a search text
	 IF @SearchText IS NULL
		SET @SearchText = ''
	ELSE
	BEGIN
		SET @SearchText = REPLACE(REPLACE(@SearchText,'_','[_]'),'%','[%]')
		-- 2010-05-24 WDJ Handle Single Quotes (remember to change this SPROC to use sp_executeSQL w/parameters to prevent having to have special cases for special charactrers)
		SET @SearchText = REPLACE(@SearchText,'''','''''');
		SET @SearchText = '	AND (AdCategoryName LIKE N''%'+@SearchText+'%'' 
			OR CampaignTitle LIKE N''%'+@SearchText+'%''
			OR CampaignAdTitleMapping.Title  LIKE N''%'+@SearchText+'%''
			OR CampaignAdTitleMapping.Description1 LIKE N''%'+@SearchText+'%''
			OR CampaignAdTitleMapping.Description2 LIKE N''%'+@SearchText+'%''
			OR CampaignAdTitleMapping.DisplayURL   LIKE N''%'+@SearchText+'%''	
			OR CampaignAdTitleMapping.DefaultURL   LIKE N''%'+@SearchText+'%''	
		)'
	END
	
--Set the Sort column
	SELECT @SQL_Sort = '['+ISNULL(DatabaseColumnName,DataField)+']'  
	FROM [LUDataGridColumn]dgc
		LEFT JOIN LUDATABASECOLUMN  dbc ON dgc.databasecolumnID = dbc.databasecolumnID
	WHERE  DataGridColumnID = @SortDataGridColumnID

	IF @SortDescending = 0
		SET @SQL_Sort = @SQL_Sort + ' ASC'
	ELSE
		SET @SQL_Sort = @SQL_Sort + ' DESC'		
						
--Localization
	SELECT @LanguageID = ISNULL(ID,1) 
	FROM Users u
		LEFT JOIN [LUCulture] c ON u.Cultureid = c.cultureID
		LEFT JOIN [Languages] l ON c.CultureCode = l.culture_name
	WHERE userid = @userID
		AND is_supported = 1

	IF @LanguageID IS NULL
		SET @LanguageID = 1

----------------------------------------------------------------------------------------------------				
--Handle the PublisherFilter
	IF @PublisherFilterID = -1 OR @PublisherFilterTypeID = -1	-- Return all ads
	BEGIN
		SET @SQL_PublisherFilter = 
'--Publisher Filter by all Publishers
	JOIN CampaignAdCategory on CampaignAdCategory.ClientID = ' + CAST(@ClientID AS VARCHAR(10)) + '
		AND CampaignAdCategory.AdTitleMappingID = CampaignAdTitleMapping.AdTitleMappingID  
		AND CampaignAdCategory.CampaignID = CampaignAdTitleMapping.CampaignID 
	left join dbo.CampaignAdcategoryBidRule on CampaignAdCategory.AdcategoryID = CampaignAdcategoryBidRule.AdcategoryID
	JOIN Campaign ON Campaign.ClientID = ' + CAST(@ClientID AS VARCHAR(10)) + ' AND CampaignAdCategory.CampaignID = Campaign.CampaignID 
	JOIN CampaignSearchEngine ON Campaign.CampaignID = CampaignSearchEngine.CampaignID 
	JOIN ClientSearchEngineMapping on Campaign.clientid = ClientSearchEngineMapping.ClientId and CampaignSearchEngine.seid = ClientSearchEngineMapping.seid and ClientSearchEngineMapping.statusflag =1  
'
	
		if  @ExcludedPublishers is not null
			SET @SQL_PublisherFilter = @SQL_PublisherFilter + ' AND CampaignSearchEngine.SEID not in ( + ' + @ExcludedPublishers + ')'

		SET @SQL_PublisherFilter = @SQL_PublisherFilter + '
		 
--Publisher Filter by all Publisher
'
	END
	ELSE IF @PublisherFilterTypeID = 1 AND @PublisherFilterTypeID IS NOT NULL  --SEID
	BEGIN
		SET @SQL_PublisherFilter = 
'--Publisher Filter by SearchEngine			
	JOIN CampaignAdCategory on CampaignAdCategory.ClientID = ' + CAST(@ClientID AS VARCHAR(10)) + '
		AND CampaignAdCategory.AdTitleMappingID = CampaignAdTitleMapping.AdTitleMappingID  
		AND CampaignAdCategory.CampaignID = CampaignAdTitleMapping.CampaignID 
	
	left join dbo.CampaignAdcategoryBidRule on CampaignAdCategory.AdcategoryID = CampaignAdcategoryBidRule.AdcategoryID
	JOIN Campaign ON Campaign.ClientID = ' + CAST(@ClientID AS VARCHAR(10)) + ' AND CampaignAdCategory.CampaignID = Campaign.CampaignID 
	JOIN CampaignSearchEngine ON Campaign.CampaignID = CampaignSearchEngine.CampaignID 
		AND CampaignSearchEngine.SEID = '+CAST(@PublisherFilterID AS VARCHAR(10))
+ ' JOIN ClientSearchEngineMapping on Campaign.clientid = ClientSearchEngineMapping.ClientId and CampaignSearchEngine.seid = ClientSearchEngineMapping.seid and ClientSearchEngineMapping.statusflag =1  '	

	if  @ExcludedPublishers is not null
		SET @SQL_PublisherFilter = @SQL_PublisherFilter + ' AND CampaignSearchEngine.SEID not in ( + ' + @ExcludedPublishers + ')'

SET @SQL_PublisherFilter = @SQL_PublisherFilter + '
		 
--Publisher Filter by SearchEngine	
'
	END
	ELSE IF @PublisherFilterTypeID = 2  --CampaignID
	BEGIN
		SET @SQL_PublisherFilter = 
'--Publisher Filter by Campaign ID		
	JOIN CampaignAdCategory on CampaignAdCategory.ClientID = ' + CAST(@ClientID AS VARCHAR(10)) + '
		AND CampaignAdCategory.AdTitleMappingID = CampaignAdTitleMapping.AdTitleMappingID  
		AND CampaignAdCategory.CampaignID = CampaignAdTitleMapping.CampaignID 	
	left join dbo.CampaignAdcategoryBidRule on CampaignAdCategory.AdcategoryID = CampaignAdcategoryBidRule.AdcategoryID
	JOIN Campaign ON Campaign.ClientID = ' + CAST(@ClientID AS VARCHAR(10)) + ' AND CampaignAdCategory.CampaignID = Campaign.CampaignID 
		AND CampaignAdCategory.CampaignID = '+CAST(@PublisherFilterID AS VARCHAR(10))+' 
	JOIN CampaignSearchEngine ON Campaign.CampaignID = CampaignSearchEngine.CampaignID 
	JOIN ClientSearchEngineMapping on Campaign.clientid = ClientSearchEngineMapping.ClientId and CampaignSearchEngine.seid = ClientSearchEngineMapping.seid and ClientSearchEngineMapping.statusflag =1  
--Publisher Filter by Campaign ID	
'
	END
	ELSE IF @PublisherFilterTypeID = 3  --GroupID
	BEGIN
		SET @SQL_PublisherFilter = 
'--Publisher Filter by group ID		
	JOIN CampaignAdCategory on CampaignAdCategory.ClientID = ' + CAST(@ClientID AS VARCHAR(10)) + '
		AND CampaignAdCategory.AdTitleMappingID = CampaignAdTitleMapping.AdTitleMappingID  
		AND CampaignAdCategory.CampaignID = CampaignAdTitleMapping.CampaignID 
		AND CampaignAdCategory.AdCategoryID = '+CAST(@PublisherFilterID AS VARCHAR(10))+' 	
	left join dbo.CampaignAdcategoryBidRule on CampaignAdCategory.AdcategoryID = CampaignAdcategoryBidRule.AdcategoryID
	JOIN Campaign ON Campaign.ClientID = ' + CAST(@ClientID AS VARCHAR(10)) + ' AND CampaignAdCategory.CampaignID = Campaign.CampaignID 
	JOIN CampaignSearchEngine ON Campaign.CampaignID = CampaignSearchEngine.CampaignID 
	JOIN ClientSearchEngineMapping on Campaign.clientid = ClientSearchEngineMapping.ClientId and CampaignSearchEngine.seid = ClientSearchEngineMapping.seid and ClientSearchEngineMapping.statusflag =1  
--Publisher Filter by group ID	
'
	END
	ELSE
		SET @SQL_PublisherFilter = 
'--Publisher Filter incorrect parameters		
	JOIN CampaignAdCategory on CampaignAdCategory.ClientID = ' + CAST(@ClientID AS VARCHAR(10)) + '
		AND CampaignAdCategory.AdTitleMappingID = CampaignAdTitleMapping.AdTitleMappingID  
		AND CampaignAdCategory.CampaignID = CampaignAdTitleMapping.CampaignID 	
	left join dbo.CampaignAdcategoryBidRule on CampaignAdCategory.AdcategoryID = CampaignAdcategoryBidRule.AdcategoryID
	JOIN Campaign ON Campaign.ClientID = ' + CAST(@ClientID AS VARCHAR(10)) + ' AND CampaignAdCategory.CampaignID = Campaign.CampaignID 
	JOIN CampaignSearchEngine ON Campaign.CampaignID = CampaignSearchEngine.CampaignID 
	JOIN ClientSearchEngineMapping on Campaign.clientid = ClientSearchEngineMapping.ClientId and CampaignSearchEngine.seid = ClientSearchEngineMapping.seid and ClientSearchEngineMapping.statusflag =1  
--Publisher Filter incorrect parameters	
'
----------------------------------------------------------------------------------------------------				
--Select List
	SET @SQL_BaseTables_CTE = '
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
	,'+CASE WHEN @ClientTimeZoneID = 8 AND @ClientDayLightSavings = 1 THEN 'CampaignAdTitleMapping.ActivationDateTime' ELSE 'dbo.fn_ConvertTime(CampaignAdTitleMapping.ActivationDateTime, 8,1, ' + convert(nvarchar(4),@ClientTimeZoneID) + ', ' + convert(nvarchar(4),@ClientDayLightSavings) + ') ' END+' as ActivationDateTime
	,'+CASE WHEN @ClientTimeZoneID = 8 AND @ClientDayLightSavings = 1 THEN 'CampaignAdTitleMapping.PauseDateTime' ELSE 'dbo.fn_ConvertTime(CampaignAdTitleMapping.PauseDateTime, 8,1, ' + convert(nvarchar(4),@ClientTimeZoneID) + ', ' + convert(nvarchar(4),@ClientDayLightSavings) + ') ' END+' as PauseDateTime
	,CASE
		WHEN CampaignAdCategory.AdCategoryStatusID = 2 THEN 2
		WHEN CampaignAdCategory.AdCategoryStatusID = 4 THEN 4
		WHEN Campaign.CampaignStatusID = 2 THEN 1
		WHEN Campaign.CampaignStatusID = 4 THEN 3
	END AS InheritedStatusID

	-- ARTIFICIAL TEXT AD STATUS
	-- 1 = ACTIVE, 2=PAUSED, 4=DELETED
	,CASE	WHEN CampaignAdTitleMapping.AdStatusID = 3 OR Campaign.CampaignStatusID = 4 OR CampaignAdCategory.AdCategoryStatusID = 4 THEN 4 -- DELETED
			WHEN LUAdTitleOnOffStatus.AdTitleOnOffDescription = ''ON'' then 1 -- ACTIVE
			WHEN LUAdTitleOnOffStatus.AdTitleOnOffDescription = ''OFF'' then 2 -- PAUSED
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
INTO #CreativeBaseTables
FROM
	CampaignAdTitleMapping
	JOIN LUAdTitleOnOffStatus ON LUAdTitleOnOffStatus.AdTitleOnOffStatusID = CampaignAdTitleMapping.AdTitleOnOffStatusID
	
	'
---------------------------------------------------------------------------------------------------------------
--Group CTE RPT tables
	SET @SQL_RPTTables_CTE = '
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
	JOIN CampaignAdCategory ad ON rp.ClientID = ' + CAST(@ClientID AS VARCHAR(10)) +'
	AND GenerateDate BETWEEN ''' + @StartDateTxt + ''' AND ''' + @EndDateTxt + '''' + @SQL_ContentMatch + '
	AND rp.AdCategoryID = ad.AdCategoryID
GROUP BY rp.AdID, rp.SEID, CampaignID
),CreativeRPTcte AS
(
SELECT
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
)'

--Handle the RPT Join
	SET @SQL_RPTTablesTT_CTE = ',CreativeTTcte AS
(
SELECT 
	am.SETitleID
	,rt.SEID
	,ISNULL(SUM(ISNULL(TTCount, TransactionCount)),0.0) AS Actions
	,ISNULL(SUM(TransactionAmount),0.0) AS TransactionAmount
	,ISNULL(SUM(ISNULL(TTCount, TransactionCount)* isnull(Weight, 1)),0.0) AS WeightedActions
FROM SIOLAP.dbo.RPT_PS_SUMmary_CustomerTT_CreativeLevel AS rt
	JOIN CampaignSETitleIDAdIDMapping am ON rt.ClientID = ' + CAST(@ClientID AS VARCHAR(10))+'
		AND GenerateDate BETWEEN '''+@StartDateTxt+''' AND '''+@EndDateTxt+''''+@SQL_ContentMatch +'
		AND am.SEID = rt.SEID 
		AND am.CampaignID = rt.CampaignID 
		AND am.ADID = rt.ADID ' + @CustomerTransactionType + ' 
	LEFT JOIN ClientCustomerTransactionTypeWeightHistory  tt ON tt.ClientID = ' + CAST(@ClientID AS VARCHAR(10))+'
		and tt.StartDate <= rt.GenerateDate
		and tt.EndDate >= rt.GenerateDate
		AND tt.CustomerTransactionTypeID = rt.CustomerTransactionTypeID
GROUP BY am.SETitleID, rt.SEID
)'

-----------------------------------------------------------------------------------------------------------------
--Create final select list, this will be different for Bulk sheet
	IF @SQL_FinalSelect IS NULL
		SELECT @SQL_FinalSelect =
'SELECT SETitleID
	,AdCategoryName
	,AdCategoryID
	,CampaignTitle
	,CampaignID
	,fc.SEID
	,se.SearchEngine
	,AdTitleOnOffDescription
	--changed to fix sort
	,fc.AdStatusName AS Status
	,fc.DerivedTextAdStatusID as AdStatusID
	,fc.EditorialStatus
	,Title 
	,Description1
	,Description2
	,DisplayURL
	,DefaultURL 
	,AdTitleMappingID
	,OptimizeLandingPage
	,Optimizebyconversion       
	,TitleAsKeyword
	,AdTitleOnOffStatusID
	,InheritedStatus
	,SSRedirect       
	,CampaignStatusID
	,AdCategoryStatusID
	,ISNULL(NumImpressions,0) AS NumImpressions
	,ISNULL(NumClicksReported,0) AS NumclicksReported
	,ISNULL(Cost,0.0)*ISNULL(ExchangeRate,1) AS Cost
	,ISNULL(Actions,0) AS Actions
	,ISNULL(WeightedActions,0) AS WeightedActions
	,ISNULL(TransactionAmount, 0)*ISNULL(ExchangeRate,1) AS TransactionAmount
	,CTR       
	,CPC *ISNULL(ExchangeRate,1) as CPC
	,CPM *ISNULL(ExchangeRate,1) as CPM
	,CPA *ISNULL(ExchangeRate,1) as CPA
	,[ConversionRate]
	,ROAS
	,DailyBudgetConverted
	,DisplayCPCBidConverted
	,PlacementCPCBidConverted 
	,CPMBidConverted 
	,fc.ActivationDateTime
	,fc.PauseDateTime
	,fc.ImageID
	,fc.AdCategorySearchEngineDetailStatusID
	, ROW_NUMBER() OVER(ORDER BY '+@SQL_Sort +') AS RowNumber 
INTO #TextAd
FROM FinalCTE fc join SearchEngine se on fc.SEID = se.SEID
left JOIN CurrencyExchangeData ed ON ed.FromCurrencyID = se.CurrencyID 
and ToCurrencyID = ' + @CurrencyIDTxt + '

'
+ @SQL_AdvanceFilter + '
  
SELECT COUNT(1) FROM #TextAd

SELECT 
	SETitleID AS [Text Ad ID]
	,AdCategoryName AS [Group Name]
	,AdCategoryID AS [Group ID]
	,CampaignTitle AS [Campaign Name]
	,CampaignID
	,SearchEngine AS Publisher
	,Status	
	,SEID
	,EditorialStatus AS [Editorial Status]
	,AdStatusID
	,InheritedStatus AS [Inherited Status]
	,Title AS Headline   
	,Description1 AS [Description Line 1]
	,Description2 AS [Description Line 2]
	,DisplayURL AS [Display URL]
	,DefaultURL AS [Destination URL]
	,NumImpressions AS Impressions
	,NumClicksReported AS Clicks
	,CTR	
	,Cost
	,CPC
	,CPM	
	,Actions
	,WeightedActions AS [Weighted Actions]
	,ConversionRate AS [Conversion Rate]
	,TransactionAmount AS Revenue
	,CPA
	,ROAS	
	,AdTitleMappingID
	,OptimizeLandingPage
	,Optimizebyconversion	    
	,TitleAsKeyword
	,AdTitleOnOffStatusID
	,SSRedirect as CampaignSSRedirect
	,CampaignStatusID
	,AdCategoryStatusID AS GroupStatusID
	,DailyBudgetConverted
	,DisplayCPCBidConverted
	,PlacementCPCBidConverted
	,CPMBidConverted
	,ActivationDateTime
	,PauseDateTime
	,ImageID
	,AdCategorySearchEngineDetailStatusID as GroupSearchEngineDetailStatusID
FROM #TextAd
WHERE RowNumber BETWEEN '+CAST(@FirstRow AS VARCHAR(10))+' AND '+CAST(@LastRow AS VARCHAR(10)) 



---------------------------------------------------------------------------------------------------------------
	IF CHARINDEX('1', @AdStatusID) > 0 OR CHARINDEX('2', @AdStatusID) > 0 OR CHARINDEX('4', @AdStatusID) > 0
			SELECT @SQL_Status = '	AND CASE	WHEN CampaignAdTitleMapping.AdStatusID = 3 OR Campaign.CampaignStatusID = 4 OR CampaignAdCategory.AdCategoryStatusID = 4 THEN 4 -- DELETED
			WHEN LUAdTitleOnOffStatus.AdTitleOnOffDescription = ''ON'' then 1 -- ACTIVE
			WHEN LUAdTitleOnOffStatus.AdTitleOnOffDescription = ''OFF'' then 2 -- PAUSED
			END in (' + @AdStatusID + ')'
		ELSE
			SELECT @SQL_Status = ''
	

	SET @SQL_Where ='WHERE CampaignAdCategory.ClientID = ' + CAST(@ClientID AS VARCHAR(10))+'
	AND CampaignAdTitleMapping.StatusFlag = 1
	AND CampaignAdCategory.StatusFlag = 1
	AND Campaign.StatusFlag = 1 
'+ @SQL_Status 	+ @SearchText

	IF @VGID >= 0
	BEGIN
		IF @VGID = 0
			INSERT INTO #VirtualGroupDetailCache
				(SEID, CampaignID, AdcategoryID)
			SELECT cs.SEID, ca.CampaignID, ac.AdCategoryID
			FROM Campaign ca JOIN CampaignSearchEngine cs ON ca.ClientID = @ClientID AND ca.CampaignID = cs.CampaignID
			JOIN CampaignadCategory ac ON ac.CampaignID = ca.CampaignID
			WHERE NOT EXISTS (SELECT 1 FROM dbo.VirtualGroupDetailCache WHERE ClientID = @ClientID AND VGID = VGID AND SEID = cs.SEID AND CampaignID = ca.CampaignID AND (AdcategoryID = 0 OR AdcategoryID = ac.AdcategoryID))
		ELSE
			INSERT INTO #VirtualGroupDetailCache
				(SEID, CampaignID, AdcategoryID)
			SELECT cs.SEID, ca.CampaignID, ac.AdCategoryID
			FROM Campaign ca JOIN CampaignSearchEngine cs ON ca.ClientID = @ClientID AND ca.CampaignID = cs.CampaignID
			JOIN CampaignadCategory ac ON ac.CampaignID = ca.CampaignID
			WHERE EXISTS (SELECT 1 FROM dbo.VirtualGroupDetailCache WHERE ClientID = @ClientID AND VGID = @VGID AND SEID = cs.SEID AND CampaignID = ca.CampaignID AND (AdcategoryID = 0 OR AdcategoryID = ac.AdcategoryID))

		CREATE CLUSTERED INDEX idx_VGDC_SEID ON #VirtualGroupDetailCache (SEID, CampaignID, AdcategoryID)

		SELECT @SQL_Where = @SQL_Where + ' and exists (select 1 from #VirtualGroupDetailCache where SEID = CampaignSearchEngine.SEID and CampaignID = CampaignAdcategory.CampaignID and AdcategoryID = CampaignAdcategory.AdcategoryID) '
	END

	SELECT @SQL_Where = @SQL_Where + '
CREATE CLUSTERED INDEX idx_TT on #CreativeBaseTables (SETitleID, SEID);
'

SET @SQL_FinalCTE = ',FinalCTE AS
(
SELECT 
	CreativeBaseTablesCTE.SETitleID
	,AdCategoryName
	,AdCategoryID
	,CampaignTitle
	,CampaignID
	,CreativeBaseTablesCTE.SEID
	,AdTitleOnOffDescription
	,isnull(rv2.resource_key_value,luAdStatusDerived.AdStatusName) as AdStatusName
	,CreativeBaseTablesCTE.AdStatusID
	,Title 
	,Description1
	,Description2
	,DisplayURL
	,DefaultURL 
    ,AdTitleMappingID
	,OptimizeLandingPage
	,Optimizebyconversion	    
	,TitleAsKeyword
	,AdTitleOnOffStatusID
	,isnull(rv3.resource_key_value,luAdStatus.AdStatusName) as EditorialStatus
	,ISNULL(resourcevalues.resource_key_value,lis.InheritedStatusDesc) AS InheritedStatus
	,SSRedirect		
	,CampaignStatusID
	,AdCategoryStatusID
	--Reporting Data
	,ISNULL(NumImpressions,0) AS NumImpressions
	,ISNULL(NumClicksReported,0) AS NumclicksReported
	,ISNULL(Cost,0.0) AS Cost
	,ISNULL(Actions,0) AS Actions
	,ISNULL(WeightedActions,0) AS WeightedActions
	,ISNULL(TransactionAmount, 0) AS TransactionAmount
	,CASE WHEN ISNULL(NumImpressions,0) > 0 THEN ISNULL(100.00 * NumClicksReported / NumImpressions,0) ELSE 0 END AS CTR		
    ,CASE WHEN NumClicksReported > 0 THEN ISNULL(Cost/NumClicksReported, 0) ELSE 0 END AS CPC	
    ,CASE WHEN NumImpressions > 0 THEN ISNULL(Cost/NumImpressions*1000, 0) ELSE 0 END AS CPM	
    ,CASE WHEN (ISNULL(Actions,0) > 0 AND ISNULL(Cost,0) > 0) THEN ISNULL(cost/Actions,0) ELSE 0 END AS CPA
	,CASE WHEN (ISNULL(Actions,0) > 0 AND ISNULL(NumClicksReported,0) > 0) THEN ISNULL(Actions/NumClicksReported * 100,0) ELSE 0 END AS [ConversionRate]
    ,CASE WHEN (ISNULL(TransactionAmount,0) > 0 AND ISNULL(Cost,0) > 0) THEN ISNULL(TransactionAmount/Cost,0) ELSE 0 END AS ROAS
	--Reporting Data
	,DailyBudgetConverted
	,DisplayCPCBidConverted
	,PlacementCPCBidConverted
	,CPMBidConverted
	,CreativeBaseTablesCTE.ActivationDateTime
	,CreativeBaseTablesCTE.PauseDateTime
	,DerivedTextAdStatusID
	,CreativeBaseTablesCTE.ImageID
	,AdCategorySearchEngineDetailStatusID
FROM #CreativeBaseTables AS CreativeBaseTablesCTE 
	LEFT JOIN CreativeRPTcte ON CreativeBaseTablesCTE.SETitleID = CreativeRPTcte.SETitleID and CreativeBaseTablesCTE.SEID = CreativeRPTcte.SEID
	LEFT JOIN CreativeTTcte ON CreativeTTcte.SETitleID = CreativeRPTcte.SETitleID and CreativeBaseTablesCTE.SEID= CreativeTTcte.SEID
	LEFT JOIN dbo.LUInheritedStatus AS lis ON lis.InheritedStatusID = CreativeBaseTablesCTE .InheritedStatusID
	LEFT JOIN ResourceValues ON lis.Resource_Key_ID = ResourceValues.Resource_Key_ID 
		AND ResourceValues.Language_ID = '+ CAST(@LanguageID AS VARCHAR(5)) +'
	JOIN luAdStatus ON luAdStatus.AdStatusID = CreativeBaseTablesCTE.AdStatusID
			left JOIN ResourceValues as rv3 ON luAdStatus.Resource_Key_ID = rv3.Resource_Key_ID 
		AND rv3.Language_ID = '+ CAST(@LanguageID AS VARCHAR(5)) + '	
	JOIN luAdStatusDerived ON luAdStatusDerived.AdStatusDerivedID = DerivedTextAdStatusID
			left JOIN ResourceValues as rv2 ON luAdStatusDerived.Resource_Key_ID = rv2.Resource_Key_ID 
		AND rv2.Language_ID = '+ CAST(@LanguageID AS VARCHAR(5)) + '
)
'




--Build complete DynamicSQL
	SET @DynamicSQL = @SQL_BaseTables_CTE 
	+ @SQL_PublisherFilter
	+ @SQL_Where
	+ @SQL_RPTTables_CTE
	+ @SQL_RPTTablesTT_CTE
	+ @SQL_FinalCTE
	+ @SQL_FinalSelect

	IF @isDebug =1
	BEGIN
		PRINT '/*'
		PRINT 'Advance Filter XML:'
		PRINT CAST(@AdvancedFilterXML AS VARCHAR(4000))
		PRINT ''
		PRINT 'Advance Filter SQL:'
		PRINT @SQL_AdvanceFilter
		PRINT '*/'
		PRINT 'IF OBJECT_ID(''tempdb..#TextAd'') IS NOT NULL
	DROP table #TextAd;
GO
IF OBJECT_ID(''tempdb..#CreativeBaseTables'') IS NOT NULL
	DROP table #CreativeBaseTables;
GO	
' 		
	PRINT @SQL_BaseTables_CTE 
	PRINT  @SQL_PublisherFilter
	PRINT @SQL_Where
	PRINT @SQL_RPTTables_CTE
	PRINT @SQL_RPTTablesTT_CTE
	PRINT @SQL_FinalCTE
	PRINT @SQL_FinalSelect
		--PRINT @DynamicSQL
	END
	ELSE
	BEGIN
		EXECUTE (@DynamicSQL);
	END
END












GO

GRANT EXECUTE ON [dbo].[SI_SP_CampaignManagement_Ads_ReadNew] TO [webaccess] AS [dbo]
GO


