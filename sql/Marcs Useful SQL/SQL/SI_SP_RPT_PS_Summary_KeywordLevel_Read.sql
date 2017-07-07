USE [SIOLAP]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SI_SP_RPT_PS_Summary_KeywordLevel_Read]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SI_SP_RPT_PS_Summary_KeywordLevel_Read]
GO

USE [SIOLAP]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[SI_SP_RPT_PS_Summary_KeywordLevel_Read]
	@ClientID INT,
	@StartDate SMALLDATETIME,
	@EndDate SMALLDATETIME,
	@CampaignID VARCHAR(5000) = NULL,
	@AdCategoryID VARCHAR(5000) = NULL,
	@CustomerTransactionTypeID VARCHAR(5000) = NULL,
	@IsContentMatch TINYINT = NULL,
	@SEID VARCHAR(5000) = NULL,
	@SpotID INT = NULL,
	@CurrencyID INT = 73,
	@IncludeCustomerTransaction TINYINT = NULL,
	@Debug BIT = 0,
	@ChannelID tinyint = 1  -- 1 means PS, 5 means SocailMedia
AS
BEGIN
/*
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Change History
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
07/31/2008 YZ Initial
10/21/2008 DA Using v_ClientCustomerTransactionType
01/09/2009 YZ JIRA 236. Due to changes on affiliate, need to change ClientCustomerTransactionTypeWithWeight to left join instead of full join 
01/14/2009 YZ JIRA 894. Need to add SEORank
02/18/2009 YZ Per Calvin, if SEORank > 30, then return 30+
02/18/2009 YZ TransactionCount changed to COALESCE(TTCount, TransactionCount, 0) 
04/08/2009 YZ Jira 2020, need add  isActive = 1 on the SEOKeywordRank table
07/13/2009 YZ Bug fix. Missing ")" if both CampaignID and AdCategoryID passed
05/06/2010 YZ JIRA SIP-3400 Convert all impressions to BidInt
05/28/2010 YZ JIRA SIP-3682 Performance tuning if user pass campaignID or ADcategoryID
06/21/2010 YZ JIRA SICS-1286 Performance tuning
07/15/2010 YZ JIRA SIP-4294 Filtered Actions do not Return Unless "Breakout" is selected
08/11/2010 JRC JIRA SIP-4581 Swapped Assisted and Tracked Clicks in results insert at the end of proc
08/26/2010 YZ SIOPS-1387 When join with ClientCustomerTransactionTypeWeight, it needs to check ClientID due to affiliates
09/22/2010 YZ SIP-4213 If user select 1 campaign and group, it should be "OR" condition instead of "AND" condition
09/28/2010 LIR Added Google QualityScore to result set
11/01/2010 YZ SIP-5643 We will use ClientCustomerTransactionTypeWeightHistory to calculate weights base on date range
11/08/2010 YZ	Add ChannelID as part of field for PS and SocialMedia
01/24/2011 YZ SIP-5416 @CustomerTransactionTypeID will only filter values in transaction type and transaction amount
02/01/2011 YZ SIOPS-2596 If @IncludeCustomerTransaction = 1, the currency exchange rate should be base on CurrencyID in SearchEngine table instead if CurrencyID in ClientCustomerTransactionType table
02/14/2011 WDJ SIP-6448 Created an artificial filter for DISPLAY using a CASE IsContentMatch = 0 if match type is PLACEMENT. This needs to be re-addressed!
04/04/2011 MRS 5.1 SIP-6448 Removed Unused Join And Placement had wrong ContentMatch Flag

--Test code:
SI_SP_RPT_PS_Summary_KeywordLevel_Read
	@ClientID = 1873,
	@StartDate= '01/01/2010',
	@EndDate= '01/01/2010',
	@IncludeCustomerTransaction = 1,
	@CustomerTransactionTypeID = '5',
	@Debug = 1
	
	select top 1000 * from RPT_PS_Summary_CustomerTT
*/
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SET nocount ON
	CREATE TABLE #TTDetail (CSKID INT, CustomerTransactionTypeID INT, TransactionCount NUMERIC(18,2), TransactionAmount MONEY, NumClicksAssisted INT, TransactionCountwithWeight NUMERIC(18,2))
	CREATE TABLE #TT (CSKID INT, TransactionCount NUMERIC(18,2), TransactionCountwithWeight NUMERIC(18,2), TransactionAmount MONEY, NumClicksAssisted INT)
	CREATE TABLE #Result1 (QualityScore TINYINT, campaignid INT, adcategoryid INT, cskid INT, Keyword NVARCHAR(200) COLLATE Latin1_General_CI_AS_KS_WS, SEID SMALLINT, NumImpressions BIGINT, NumClicksReported INT, NumClicksTracked INT, NumClicksAssisted INT, Cost MONEY, TotalRank NUMERIC(18,2), TotalRankCount INT, KeywordMatchTypeID TINYINT, [OrganicRank] VARCHAR(5), TransactionCount NUMERIC(18,2), TransactionAmount MONEY, TransactionCountWithWeight NUMERIC(18,2))
	CREATE TABLE #T (CustomerTransactionTypeID INT)

	DECLARE @ls_SQL NVARCHAR(MAX), @ls_TT NVARCHAR(MAX), @ls_CustomerTransactionName NVARCHAR(MAX), @CTTypeID INT,
			@ls_Where VARCHAR(MAX)

	SELECT @StartDate = CONVERT(DATETIME, CONVERT(VARCHAR(20), @StartDate, 101)),
			@EndDate = CONVERT(DATETIME, CONVERT(VARCHAR(20), @EndDate, 101))

	SELECT @ls_SQL = 'Select MIN(ckri.QualityScore) AS QualityScore, ck.campaignid, ck.adcategoryid, ps.cskid, ck.Keyword, ps.SEID, sum(isnull(convert(bigint, NumImpressions), 0)) as [NumImpressions], sum(isnull(NumClicksReported, 0)) as [NumClicksReported], sum(NumClicksTracked) as NumClicksTracked,
			sum(isnull(ps.Cost, 0) * isnull(ExchangeRate, 1)) as [Cost],
			sum(TotalRank) as TotalRank, sum(TotalRankCount) as TotalRankCount, ck.KeywordMatchTypeID, (case when [Rank] is null or [Rank] <= 30 then convert(varchar(5), [Rank]) else ''30+'' end) as Rank, '

	IF @CustomerTransactionTypeID IS NOT NULL AND LTRIM(RTRIM(@CustomerTransactionTypeID)) <> '' OR @IncludeCustomerTransaction = 1
	BEGIN
		SELECT @ls_TT = 'select CSKID, ps.CustomerTransactionTypeID, sum(COALESCE(TTCount, TransactionCount, 0)) as TransactionCount, sum(TransactionAmount * isnull(ExchangeRate, 1)), sum(NumClicksAssisted), sum(COALESCE(TTCount, TransactionCount, 0) * isnull(Weight, 1)) as TransactionCountwithWeight
						from dbo.RPT_PS_Summary_CustomerTT ps join dbo.v_ClientCustomerTransactionType ct on ps.ClientID = ' + CONVERT(VARCHAR(20), @ClientID)
						+ ' and GenerateDate between ''' + CONVERT(VARCHAR(20), @StartDate) + ''' and ''' + CONVERT(VARCHAR(20), @EndDate)
						+ ''' and IsContentMatch = ' + ISNULL(CONVERT(VARCHAR(50), @IsContentMatch), 'IsContentMatch')

		IF @CustomerTransactionTypeID IS NOT NULL AND LTRIM(RTRIM(@CustomerTransactionTypeID)) <> ''
			SELECT @ls_TT = @ls_TT + ' and ps.CustomerTransactionTypeID in (' + @CustomerTransactionTypeID + ')'

		IF @CampaignID IS NOT NULL AND LTRIM(RTRIM(@CampaignID)) <> '' AND @AdCategoryID IS NOT NULL AND LTRIM(RTRIM(@AdCategoryID)) <> ''
			SELECT @ls_TT = @ls_TT + ' and (CampaignID in (' + @CampaignID + ') or AdCategoryID in (' + @AdCategoryID + '))'
		ELSE
			IF @CampaignID IS NOT NULL AND LTRIM(RTRIM(@CampaignID)) <> ''
				SELECT @ls_TT = @ls_TT + ' and CampaignID in (' + @CampaignID + ')'
			ELSE
			IF @AdCategoryID IS NOT NULL AND LTRIM(RTRIM(@AdCategoryID)) <> ''
				SELECT @ls_TT = @ls_TT + ' and AdCategoryID in (' + @AdCategoryID + ')'

		IF @SEID IS NOT NULL AND LTRIM(RTRIM(@SEID)) <> ''
			SELECT @ls_TT = @ls_TT + ' and ps.SEID in (' + @SEID + ')'

		IF @SpotID > 0
			SELECT @ls_SQL = @ls_SQL + ' and exists (select 1 from dbo.SpotAdgroups where SpotID = ' + CONVERT(VARCHAR(20), @SpotID) + ' and ClientID = ps.ClientID and AdCategoryID = ps.AdCategoryID and SEID = tt.SEID)'

		SELECT @ls_TT = @ls_TT + ' and ct.ClientID = ps.ClientID and ct.CustomerTransactionTypeID = ps.CustomerTransactionTypeID'
						+ ' join SearchEngine se on se.SEID = ps.SEID '
						+ ' left join dbo.CurrencyExchangeData ed on ed.FromCurrencyID = se.CurrencyID and ToCurrencyID = ' + CONVERT(VARCHAR(10), @CurrencyID)
						+ ' left join ClientCustomerTransactionTypeWeightHistory tw on ps.ClientID = tw.ClientID and ps.GenerateDate >= tw.StartDate and ps.GenerateDate <= tw.EndDate and ps.CustomerTransactionTypeID = tw.CustomerTransactionTypeID
						    group by CSKID, ps.CustomerTransactionTypeID'

		IF @Debug = 1
			PRINT @ls_TT
		
		INSERT INTO #TTDetail
			(CSKID, CustomerTransactionTypeID, TransactionCount, TransactionAmount, NumClicksAssisted, TransactionCountwithWeight)
		EXEC (@ls_TT)

		CREATE INDEX idx_TTDetail ON #TTDetail (CustomerTransactionTypeID, CSKID)
	END

	IF @CustomerTransactionTypeID IS NULL OR LTRIM(RTRIM(@CustomerTransactionTypeID)) = ''
           SELECT @ls_SQL = @ls_SQL + ' sum(NumClicksAssisted) as NumClicksAssisted, sum(COALESCE(TTCount, TransactionCount, 0)) as TransactionCount,
           sum(isnull(TransactionAmount, 0) * isnull(ExchangeRate, 1)) as TransactionAmount,
           isnull(sum(isnull(TransactionCountWithWeight, 0)), 0) as TransactionCountWithWeight  '
	ELSE
	BEGIN
		INSERT INTO #TT
			(CSKID, TransactionCount, TransactionCountwithweight, TransactionAmount, NumClicksAssisted)
		SELECT CSKID, SUM(TransactionCount), SUM(TransactionCountwithWeight), SUM(TransactionAmount), SUM(NumClicksAssisted)
		FROM #TTDetail tt
		GROUP BY CSKID
		
		CREATE CLUSTERED INDEX idx_TT_CSKID ON #TT (CSKID)

		--select @ls_SQL = @ls_SQL + ' isnull(tt.NumClicksAssisted, 0) as NumClicksAssisted, isnull(tt.TransactionCount, 0) as TransactionCount,
		--		isnull(tt.TransactionAmount, 0) as TransactionAmount,
		--		isnull(tt.TransactionCountWithWeight, 0) as TransactionCountWithWeight  '
		
		SELECT @ls_SQL = @ls_SQL + ' 0 as NumClicksAssisted, 0 as TransactionCount,
		0 as TransactionAmount,
		0 as TransactionCountWithWeight  '

	END  --Filter by CustomerTransactionTypeID


	SELECT @ls_SQL = @ls_SQL + ' From dbo.RPT_PS_Summary_CSKLevel ps LEFT JOIN SearchIgnite..CSKeywordsRankInfo ckri on ps.cskid = ckri.cskid
		join CSkeywords ck on ps.ClientID = ' + CONVERT(VARCHAR(20), @ClientID) + ' and ps.GenerateDate between '''
						+ CONVERT(VARCHAR(20), @StartDate)
						+''' and ''' + CONVERT(VARCHAR(20), @EndDate)

						-- (WDJ SIP-6448) CHECK FOR "PLACEMENT MATCH TYPE WHICH "INFERS" SEARCH
						+ ''' and (CASE WHEN ck.KeywordMatchTypeID = 7 THEN 1 ELSE ps.IsContentMatch END) = ' + 
							ISNULL(CONVERT(VARCHAR(128), @IsContentMatch), '(CASE WHEN ck.KeywordMatchTypeID = 7 THEN 1 ELSE ps.IsContentMatch END)')
						--+ ''' and ps.IsContentMatch = ' + ISNULL(CONVERT(VARCHAR(30), @IsContentMatch), 'ps.IsContentMatch')
						+ ' and ps.CSKID = ck.CSKID'

	IF @SEID IS NOT NULL AND LTRIM(RTRIM(@SEID)) <> ''
		SELECT @ls_SQL = @ls_SQL + ' and ps.SEID in (' + @SEID + ')'

	IF @CampaignID IS NOT NULL AND LTRIM(RTRIM(@CampaignID)) <> '' AND @AdCategoryID IS NOT NULL AND LTRIM(RTRIM(@AdCategoryID)) <> ''
		--select @ls_SQL = @ls_SQL + ' and (CampaignID in (' + @CampaignID + ') or AdCategoryID in (' + @AdCategoryID + '))'
		SELECT @ls_where = ' where exists (select 1 from Cskeywords where CSKID = ps.CSKID and (CampaignID in ('+ @CampaignID + ') or AdCategoryID in (' + @AdCategoryID + ')))'
	ELSE
		IF @CampaignID IS NOT NULL AND LTRIM(RTRIM(@CampaignID)) <> ''
			--select @ls_SQL = @ls_SQL + ' and CampaignID in (' + @CampaignID + ')'
			SELECT @ls_where = ' where exists (select 1 from Cskeywords where CSKID = ps.CSKID and CampaignID in ('+ @CampaignID + '))'
		ELSE
			IF @AdCategoryID IS NOT NULL AND LTRIM(RTRIM(@AdCategoryID)) <> ''
				--select @ls_SQL = @ls_SQL + ' and AdCategoryID in (' + @AdCategoryID + ')'
				SELECT @ls_where = ' where exists (select 1 from CSkeywords where CSKID = ps.CSKID and AdCategoryID in (' + @AdCategoryID + '))'


	SELECT @ls_SQL = @ls_SQL + ' join SearchEngine se on se.SEID = ps.SEID left join dbo.CurrencyExchangeData ed on ed.FromCurrencyID = se.CurrencyID and ToCurrencyID = ' + CONVERT(VARCHAR(10), ISNULL(@CurrencyID, 73))
	select @ls_SQL = @ls_SQL + ' join SearchEngine_Parent sp on sp.ParentSEID = se.ParentSEID and sp.ChannelID = ' + convert(varchar(10), @ChannelID)
	SELECT @ls_SQL = @ls_SQL + ' left join dbo.SEOKeywordRank kr on kr.ClientID = ck.ClientID and kr.SEID = ck.SEID and kr.Keyword = ck.Keyword and kr.isActive = 1 '

	IF @SpotID > 0
		SELECT @ls_SQL = @ls_SQL + ' join dbo.SpotAdgroups sa on sa.SpotID = ' + CONVERT(VARCHAR(20), @SpotID) + ' and sa.ClientID = ps.ClientID and sa.AdCategoryID = ps.AdCategoryID and sa.SEID = ps.SEID'


	if @CustomerTransactionTypeID is not null and ltrim(rtrim(@CustomerTransactionTypeID)) <> ''
		select @ls_SQL = @ls_SQL + ' left join #TT tt on ps.CSKID = tt.CSKID'

	IF @ls_where IS NOT NULL
		SELECT @ls_SQL = @ls_SQL + @ls_Where
		
	SELECT @ls_SQL = @ls_SQL + ' group by ck.campaignid, ck.adcategoryid, ps.cskid, ck.KeywordID, ck.Keyword, ps.SEID, ck.KeywordMatchTypeID, (case when [Rank] is null or [Rank] <= 30 then convert(varchar(5), [Rank]) else ''30+'' end)'
	if @CustomerTransactionTypeID is not null and ltrim(rtrim(@CustomerTransactionTypeID)) <> ''
		select @ls_SQL = @ls_SQL + ', tt.NumClicksAssisted, tt.TransactionCount, tt.TransactionAmount, tt.TransactionCountWithWeight'

	IF ISNULL(@IncludeCustomerTransaction, 0) <> 1 OR NOT EXISTS (SELECT 1 FROM v_ClientCustomerTransactionType WHERE ClientID = @ClientID AND CustomerTransactionTypeID > 3)
	BEGIN
		IF @Debug = 1
			PRINT @ls_SQL
		
		INSERT INTO #Result1
		(QualityScore, campaignid, adcategoryid, cskid, Keyword, SEID, NumImpressions, NumClicksReported, NumClicksTracked, Cost, TotalRank, TotalRankCount, KeywordMatchTypeID, [OrganicRank], NumClicksAssisted, TransactionCount, TransactionAmount, TransactionCountWithWeight)
		EXEC (@ls_SQL)
		
		IF @CustomerTransactionTypeID IS NOT NULL
		BEGIN
			CREATE CLUSTERED INDEX idx_Result1_CSKID ON #Result1 (CSKID)
			
			UPDATE #Result1
			SET NumClicksAssisted = ISNULL(tt.NumClicksAssisted, 0),
				TransactionCount = ISNULL(tt.TransactionCount, 0),
				TransactionAmount = ISNULL(tt.TransactionAmount, 0),
				TransactionCountWithWeight = ISNULL(tt.TransactionCountWithWeight, 0)
			FROM #Result1 re JOIN #TT tt ON re.CSKID = tt.CSKID
		END
		
		SELECT * FROM #Result1
	END
	ELSE
	BEGIN
		--Include CustomerTransactionType
		IF @Debug = 1
			PRINT @ls_SQL
		
		INSERT INTO #Result1
			(QualityScore, campaignid, adcategoryid, cskid, Keyword, SEID, NumImpressions, NumClicksReported, NumClicksTracked, Cost, TotalRank, TotalRankCount, KeywordMatchTypeID, [OrganicRank], NumClicksAssisted, TransactionCount, TransactionAmount, TransactionCountWithWeight)
		
		EXEC (@ls_SQL)
		
		CREATE CLUSTERED INDEX idx_Result1_CSKID ON #Result1 (CSKID)
		
		UPDATE #Result1
		SET NumClicksAssisted = ISNULL(tt.NumClicksAssisted, 0),
			TransactionCount = ISNULL(tt.TransactionCount, 0),
			TransactionAmount = ISNULL(tt.TransactionAmount, 0),
			TransactionCountWithWeight = ISNULL(tt.TransactionCountWithWeight, 0)
		FROM #Result1 re JOIN #TT tt ON re.CSKID = tt.CSKID

		SELECT @ls_SQL = 'select re.* '

		SELECT @CTTypeID = MIN(CustomerTransactionTypeID)
		FROM #TTDetail

		WHILE @CTTypeID > 0
		BEGIN
			SELECT @ls_SQL = @ls_SQL + ', (select TransactionAmount from #TTDetail where CustomerTransactionTypeID = ' + CONVERT(VARCHAR(10), @CTTypeID) + ' and CSKID = re.CSKID) as [' + LTRIM(RTRIM(CustomerTransactionName)) + ' Revenue]'
							+ ', (select TransactionCount from #TTDetail where CustomerTransactionTypeID = ' + CONVERT(VARCHAR(10), @CTTypeID) + ' and CSKID = re.CSKID) as [' + LTRIM(RTRIM(CustomerTransactionName)) + ' Actions]'
			FROM  dbo.v_ClientCustomerTransactionType
			WHERE ClientID = @ClientID
			AND CustomerTransactionTypeID = @CTTypeID

			SELECT @CTTypeID = MIN(CustomerTransactionTypeID)
			FROM #TTDetail
			WHERE CustomerTransactionTypeID > @CTTypeID
		END

		SELECT @ls_SQL = @ls_SQL + ' from #Result1 re'
		
		IF @Debug = 1
			PRINT @ls_SQL
		
		EXEC (@ls_SQL)
	END


	DROP TABLE #TTDetail
	DROP TABLE #TT
	DROP TABLE #Result1
	DROP TABLE #T
END






GO

GRANT EXECUTE ON [dbo].[SI_SP_RPT_PS_Summary_KeywordLevel_Read] TO [SEARCHIGNITE\IONE_Tech_CS_ATL] AS [dbo]
GO

GRANT EXECUTE ON [dbo].[SI_SP_RPT_PS_Summary_KeywordLevel_Read] TO [SEARCHIGNITE\SI Tech Services Tier 1] AS [dbo]
GO

GRANT EXECUTE ON [dbo].[SI_SP_RPT_PS_Summary_KeywordLevel_Read] TO [webaccess] AS [dbo]
GO


