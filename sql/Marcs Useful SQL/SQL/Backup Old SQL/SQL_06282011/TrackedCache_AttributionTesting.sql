USE [SIProcessing_CacheHistory]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[TrackedCache_AttributionTesting](
	[EasternCreateDate] [datetime] NOT NULL,
	[TID] [int] NULL,
	[NTID] [int] NULL,
	[CSKID] [int] NULL,
	[TransactionAmount] [money] NULL,
	[CreatedDate] [datetime] NULL,
	[SessionGUID] [varchar](36) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[TransactionTypeID] [tinyint] NULL,
	[MoreInfo] [nvarchar](255) COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[N1] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[N2] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[N3] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[N4] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[N5] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[N6] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[N7] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[N8] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[N9] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[N10] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[X1] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[X2] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[X3] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[X4] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[X5] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[X6] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[X7] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[X8] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[X9] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[X10] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CustomerTransactionTypeID] [int] NULL,
	[loginfo] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ISContentMatch] [tinyint] NULL,
	[CTID] [int] NULL,
	[NCTID] [int] NULL,
	[ClickTime] [datetime] NULL,
	[LatencyInSeconds] [int] NULL,
	[UserUniqueGuid] [varchar](36) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ClientID] [int] NULL,
	[KeywordID] [int] NULL,
	[ReferenceID] [int] NULL,
	[SEID] [smallint] NULL,
	[NSEID] [smallint] NULL,
	[PublisherID] [int] NULL,
	[CKeywordID] [int] NULL,
	[AdCategoryID] [int] NULL,
	[CampaignID] [int] NULL,
	[OrigClientID] [int] NULL,
	[ExtraInfo1] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[OrigTransactionAmt] [money] NULL,
	[CurrencyID] [int] NULL,
	[OrigCurrencyID] [int] NULL,
	[WebServerID] [int] NULL,
	[RawTRHID] [bigint] NULL,
	[AccessServerID] [int] NULL,
	[TrackedActionID] [bigint] NOT NULL,
	[TrackedExposureID] [bigint] NOT NULL,
	[ChannelID] [int] NULL,
	[ActionWeightPct] [decimal](3, 2) NULL,
	[ActionWeightFactor] [decimal](5, 4) NULL,
	[AttributedExposures] [int] NULL,
	[ExposureSequence] [int] NULL,
	[ActionQuantity] [decimal](18, 2) NULL,
	[Keyword] [nvarchar](200) COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[ExposureTypeID] [int] NULL,
	[PaidInclusion] [bit] NULL,
	[USDExchangeRate] [money] NULL,
	[transactionamountusd]  AS ([transactionamount]*[usdexchangerate]),
	[AffiliateID] [int] NULL,
	[BinaryCheckSum] [int] NULL,
	[InsertDateUTC] [datetime] NULL,
	[TrackingSourceID] [smallint] NOT NULL,
 CONSTRAINT [PK_TrackedHistory_AttributionTesting_New] PRIMARY KEY NONCLUSTERED 
(
	[TrackedActionID] ASC,
	[TrackedExposureID] ASC,
	[EasternCreateDate] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PS_SI_TrackedHistory]([EasternCreateDate])
) ON [PS_SI_TrackedHistory]([EasternCreateDate])

GO

SET ANSI_PADDING OFF
GO


USE [SIProcessing_CacheHistory]
CREATE CLUSTERED INDEX [AttributionTesting_EasternCreateDate_CSKID_New] ON [dbo].[TrackedCache_AttributionTesting] 
(
	[ChannelID] ASC,
	[EasternCreateDate] ASC,
	[CSKID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PS_SI_TrackedHistory]([EasternCreateDate])
GO


USE [SIProcessing_CacheHistory]
CREATE NONCLUSTERED INDEX [AttributionTesting_ClientID_EasternCreateDate_New] ON [dbo].[TrackedCache_AttributionTesting] 
(
	[ChannelID] ASC,
	[ClientID] ASC,
	[EasternCreateDate] ASC
)
INCLUDE ( [ActionQuantity],
[AffiliateID],
[CustomerTransactionTypeID],
[ISContentMatch],
[PaidInclusion],
[TransactionAmount]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PS_SI_TrackedHistory]([EasternCreateDate])
GO


USE [SIProcessing_CacheHistory]
CREATE NONCLUSTERED INDEX [AttributionTesting_CreatedDate] ON [dbo].[TrackedCache_AttributionTesting] 
(
	[CreatedDate] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PS_SI_TrackedHistory]([EasternCreateDate])
GO


USE [SIProcessing_CacheHistory]
CREATE NONCLUSTERED INDEX [TrackedActionID_AttributionTesting_TrackedExposureID_EasternCreateDate_AffiliateID_BindaryChecksum_New] ON [dbo].[TrackedCache_AttributionTesting] 
(
	[TrackedActionID] ASC,
	[TrackedExposureID] ASC,
	[EasternCreateDate] ASC,
	[AffiliateID] ASC,
	[BinaryCheckSum] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PS_SI_TrackedHistory]([EasternCreateDate])
GO


USE [SIProcessing_CacheHistory]
CREATE NONCLUSTERED INDEX [AttributionTesting_TrackedActionID_TrackedExposureID_EasternCreateDate_ClientID_BindaryChecksum_New] ON [dbo].[TrackedCache_AttributionTesting] 
(
	[TrackedActionID] ASC,
	[TrackedExposureID] ASC,
	[EasternCreateDate] ASC,
	[ClientID] ASC,
	[BinaryCheckSum] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PS_SI_TrackedHistory]([EasternCreateDate])
GO

ALTER TABLE [dbo].[TrackedCache_AttributionTesting] ADD  DEFAULT (getutcdate()) FOR [InsertDateUTC]
GO

ALTER TABLE [dbo].[TrackedCache_AttributionTesting] ADD  DEFAULT ((1)) FOR [TrackingSourceID]
GO


