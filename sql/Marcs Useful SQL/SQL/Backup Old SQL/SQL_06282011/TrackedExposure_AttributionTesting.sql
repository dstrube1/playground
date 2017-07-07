USE [SIProcessing_Attribution]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TrackedExposure_AttributionTesting]') AND type in (N'U'))
DROP TABLE [dbo].[TrackedExposure_AttributionTesting]
GO

USE [SIProcessing_Attribution]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[TrackedExposure_AttributionTesting](
	[TrackedExposureID] [bigint] IDENTITY(1,1) NOT NULL,
	[ExposureTypeID] [int] NOT NULL,
	[ChannelID] [int] NOT NULL,
	[CTID] [int] NULL,
	[NCTID] [int] NULL,
	[CreateDateUTC] [datetime] NOT NULL,
	[LocalizedCreateDate] [datetime] NOT NULL,
	[TrackingSourceID] [smallint] NULL,
	[TrackingSourceCreateDateUTC] [datetime] NOT NULL,
	[URL] [nvarchar](2048) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CSKID] [int] NULL,
	[SessionGUID] [varchar](36) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[LongTermGUID] [varchar](36) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IPAddress] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[OSVersion] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[BrowserVersion] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ReferralURL] [nvarchar](2048) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ReferralPage] [nvarchar](2048) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CurrentRank] [numeric](18, 2) NULL,
	[ISContentMatch] [bit] NOT NULL,
	[ExtraInfo1] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ExtraInfo2] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[UserUniqueGUID] [varchar](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[AffiliateID] [int] NULL,
	[ClientID] [int] NOT NULL,
	[SEID] [smallint] NULL,
	[NSEID] [smallint] NULL,
	[PublisherID] [int] NOT NULL,
	[PublisherCurrencyID] [int] NULL,
	[CampaignKeywordID] [int] NULL,
	[KeywordID] [int] NULL,
	[Keyword] [nvarchar](200) COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[AdCategoryID] [int] NULL,
	[CampaignID] [int] NULL,
	[PlacementID] [int] NULL,
	[WebServerID] [int] NULL,
	[AccessServerID] [int] NULL,
	[Domain] [nvarchar](2048) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[TypedKeyword] [nvarchar](200) COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[ProductText] [nvarchar](1000) COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[QueriedPage] [smallint] NULL,
	[URLID] [bigint] NULL,
	[URLTypeID] [int] NULL,
	[ExceptionId] [int] NULL,
 CONSTRAINT [PK_TrackedExposure_AttributionTesting_NEW] PRIMARY KEY CLUSTERED 
(
	[ClientID] ASC,
	[CreateDateUTC] ASC,
	[ExposureTypeID] ASC,
	[UserUniqueGUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


USE [SIProcessing_Attribution]
CREATE NONCLUSTERED INDEX [IX_ChannelID_ClientID_SEID_LocalizedCreateDate] ON [dbo].[TrackedExposure_AttributionTesting] 
(
	[ChannelID] ASC,
	[ClientID] ASC,
	[SEID] ASC,
	[LocalizedCreateDate] ASC
)
INCLUDE ( [AdCategoryID],
[CampaignID],
[CSKID],
[ISContentMatch],
[TrackedExposureID],
[URLID],
[URLTypeID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


USE [SIProcessing_Attribution]
CREATE NONCLUSTERED INDEX [IX_ChannelID_LocalizedCreateDate_ClientID_NSEID] ON [dbo].[TrackedExposure_AttributionTesting] 
(
	[ChannelID] ASC,
	[LocalizedCreateDate] ASC,
	[ClientID] ASC,
	[NSEID] ASC
)
INCLUDE ( [Keyword],
[KeywordID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


USE [SIProcessing_Attribution]
CREATE NONCLUSTERED INDEX [IX_TrackedExposure_LocalizedCreateDate] ON [dbo].[TrackedExposure_AttributionTesting] 
(
	[LocalizedCreateDate] ASC
)
INCLUDE ( [ChannelID],
[ClientID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


USE [SIProcessing_Attribution]
CREATE NONCLUSTERED INDEX [IX_TrackedExposure_UserUniqueGUID_ClientID_CreatedateUTC] ON [dbo].[TrackedExposure_AttributionTesting] 
(
	[UserUniqueGUID] ASC,
	[ClientID] ASC,
	[CreateDateUTC] ASC
)
INCLUDE ( [ChannelID],
[ExposureTypeID],
[PublisherCurrencyID],
[TrackedExposureID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


USE [SIProcessing_Attribution]
CREATE UNIQUE NONCLUSTERED INDEX [IX_TrackedExpsoureID_ClientID] ON [dbo].[TrackedExposure_AttributionTesting] 
(
	[TrackedExposureID] ASC,
	[ClientID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


