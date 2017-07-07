USE [SIOLAP]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SI_SP_RPT_PS_Summary_SearchQuery_Read]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SI_SP_RPT_PS_Summary_SearchQuery_Read]
GO

USE [SIOLAP]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SI_SP_RPT_PS_Summary_SearchQuery_Read]
@ClientID int,
@StartDate smalldatetime,
@EndDate smalldatetime,
@CampaignID varchar(5000) = null,
@AdCategoryID varchar(5000) = null,
--@CustomerTransactionTypeID varchar(5000) = null,
@IsContentMatch tinyint = null,
@SEID varchar(5000) = null,
@CurrencyID int = 73,
--@IncludeCustomerTransaction tinyint = null,
@Debug bit = 0,
@ChannelID tinyint = 1  -- 1 means PS, 5 means SocailMedia
as
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Change History
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
--02/18/2009 YZ TransactionCount changed to COALESCE(TTCount, TransactionCount, 0)
--11/08/2010 YZ	Add ChannelID as part of inputs for PS and SocialMedia
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
begin

/*
exec SI_SP_RPT_PS_Summary_SearchQuery_Read 1712, '06-01-2008', '06-02-2008',
'1', 1, '1', 73, 0
*/
	set nocount on

CREATE TABLE #Result1 (
--CSKID int,
CreditedKeyword nvarchar(200),
TypedKeyword nvarchar(1000),
campaignid int,
adcategoryid int,
seid int,
NumClicksTracked int, 
TransactionCount numeric(18,2), 
TransactionAmount money,
TransactionCountWithWeight numeric(18,2)
--,ConversionRate numeric(18,2)
)

	declare @ls_SQL nvarchar(max)

	select @StartDate = convert(datetime, convert(varchar(20), @StartDate, 101)),
			@EndDate = convert(datetime, convert(varchar(20), @EndDate, 101))

select @ls_SQL = 'Select 
ck.Keyword as CreditedKeyword,
ps.TypedKeyword,
ps.CampaignID, 
ck.AdCategoryID,
ps.SEID, 
sum(isnull(NumClicksTracked, 0)) as [NumClicksTracked], 
sum(COALESCE(TTCount, TransactionCount, 0)) as TransactionCount,
sum(isnull(TransactionAmount, 0) * ExchangeRate) as TransactionAmount,
isnull(sum(isnull(TransactionCountWithWeight, 0)), 0) as TransactionCountWithWeight '

select @ls_SQL = @ls_SQL + ' 
From dbo.RPT_PS_Summary_SearchQuery ps 
join dbo.Campaign ca on ps.CampaignID = ca.CampaignID 
join dbo.CSKeywords ck on ps.cskid = ck.cskid
'

select @ls_SQL = @ls_SQL + ' join SearchEngine se on se.SEID = ps.SEID join dbo.CurrencyExchangeData ed on ed.FromCurrencyID = se.CurrencyID and ToCurrencyID = ' + convert(varchar(10), isnull(@CurrencyID, 73))

  + ' where ps.ClientID = ' + convert(varchar(20), @ClientID) 
  + ' and ps.GenerateDate between '''
  + convert(varchar(20), @StartDate)
  +''' and ''' + convert(varchar(20), @EndDate)
  + ''' and ps.IsContentMatch = ' + isnull(convert(varchar(30), @IsContentMatch), 'ps.IsContentMatch')
  + ' '

	if @AdCategoryID is not null and ltrim(rtrim(@AdCategoryID)) <> ''
			select @ls_SQL = @ls_SQL + ' and ck.AdCategoryID in (' + @AdCategoryID + ')'

	if @SEID is not null and ltrim(rtrim(@SEID)) <> ''
		select @ls_SQL = @ls_SQL + ' and ps.SEID in (' + @SEID + ')'

	if @CampaignID is not null and ltrim(rtrim(@CampaignID)) <> '' 
		select @ls_SQL = @ls_SQL + ' and (ps.CampaignID in (' + @CampaignID + '))'
	else
		if @CampaignID is not null and ltrim(rtrim(@CampaignID)) <> ''
			select @ls_SQL = @ls_SQL + ' and ps.CampaignID in (' + @CampaignID + ')'

	select @ls_SQL = @ls_SQL + ' and exists (select 1 from SearchEngine_Parent where ParentSEID = se.ParentSEID and ChannelID = ' + convert(varchar(10), @ChannelID) + ') group by ck.Keyword, ck.adcategoryid, ps.TypedKeyword, ps.campaignid, ps.SEID '

if @Debug = 1
	select @ls_SQL

exec (@ls_SQL)


	end

	Drop table #Result1

GO

GRANT EXECUTE ON [dbo].[SI_SP_RPT_PS_Summary_SearchQuery_Read] TO [SEARCHIGNITE\IONE_Tech_CS_ATL] AS [dbo]
GO

GRANT EXECUTE ON [dbo].[SI_SP_RPT_PS_Summary_SearchQuery_Read] TO [SEARCHIGNITE\SI Tech Services Tier 1] AS [dbo]
GO

GRANT EXECUTE ON [dbo].[SI_SP_RPT_PS_Summary_SearchQuery_Read] TO [webaccess] AS [dbo]
GO


