USE [SIProcessing_Attribution]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TrackedAction_AttributionTesting_Good_RecordStatus]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TrackedAction_AttributionTesting] DROP CONSTRAINT [DF_TrackedAction_AttributionTesting_Good_RecordStatus]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_TrackedAction_Good_EffectiveBeginDateUTC]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TrackedAction_AttributionTesting] DROP CONSTRAINT [DF_TrackedAction_AttributionTesting_Good_EffectiveBeginDateUTC]
END

GO

USE [SIProcessing_Attribution]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TrackedAction_AttributionTesting]') AND type in (N'U'))
DROP TABLE [dbo].[TrackedAction_AttributionTesting]
GO

USE [SIProcessing_Attribution]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[TrackedAction_AttributionTesting](
	[TrackingSourceID] [smallint] NULL,
	[CreateDateUTC] [datetime] NOT NULL,
	[TrackingSourceCreateDateUTC] [datetime] NOT NULL,
	[LocalizedCreateDate] [datetime] NOT NULL,
	[NTID] [int] NULL,
	[TID] [int] NULL,
	[NCTID] [int] NULL,
	[CTID] [int] NULL,
	[CurrencyID] [int] NOT NULL,
	[TransactionAmount] [money] NOT NULL,
	[TransactionTypeID] [tinyint] NOT NULL,
	[CustomerTransactionTypeID] [int] NOT NULL,
	[MoreInfo] [nvarchar](255) COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[loginfo] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ExtraInfo] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
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
	[ClientID] [int] NULL,
	[SessionGUID] [varchar](36) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[UserUniqueGUID] [varchar](36) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CSKID] [int] NULL,
	[RawTrackingActionID] [bigint] NULL,
	[AccessServerID] [int] NULL,
	[WebServerID] [int] NULL,
	[RecordStatus] [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[EffectiveBeginDateUTC] [datetime] NOT NULL,
	[EffectiveEndDateUTC] [datetime] NULL,
	[DAV] [xml] NULL,
	[HashKey] [int] NULL,
	[TrackedActionID_PREV] [int] NULL,
	[USDExchangeRate] [money] NULL,
	[AffiliateID] [int] NULL,
	[TrackedActionID] [bigint] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[TransactionAmountUSD]  AS ([TransactionAmount]*[USDExchangeRate]),
 CONSTRAINT [PK_TrackedAction_AttributionTesting] PRIMARY KEY NONCLUSTERED 
(
	[TrackedActionID] ASC,
	[CreateDateUTC] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PS_SI_TrackedAction]([CreateDateUTC])
) ON [PS_SI_TrackedAction]([CreateDateUTC])

GO

SET ANSI_PADDING OFF
GO


USE [SIProcessing_Attribution]
CREATE CLUSTERED INDEX [IX_TrackedAction_AttributionTesting_ClientID_CreateDateUTC_RecordStatus_ClientID] ON [dbo].[TrackedAction_AttributionTesting] 
(
	[ClientID] ASC,
	[CreateDateUTC] ASC,
	[RecordStatus] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PS_SI_TrackedAction]([CreateDateUTC])
GO


USE [SIProcessing_Attribution]
CREATE NONCLUSTERED INDEX [IX_AttributionTesting_ClientID_RecordStatus_MoreInfo_CreateDateUTC__TrackedActionID] ON [dbo].[TrackedAction_AttributionTesting] 
(
	[ClientID] ASC,
	[RecordStatus] ASC,
	[MoreInfo] ASC,
	[CreateDateUTC] ASC
)
INCLUDE ( [TrackedActionID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PS_SI_TrackedAction]([CreateDateUTC])
GO


USE [SIProcessing_Attribution]
CREATE NONCLUSTERED INDEX [IX_TrackedAction_AttributionTesting_AffiliateID_CreateDateUTC_RecordStatus] ON [dbo].[TrackedAction_AttributionTesting] 
(
	[AffiliateID] ASC,
	[CreateDateUTC] ASC,
	[RecordStatus] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PS_SI_TrackedAction]([CreateDateUTC])
GO


USE [SIProcessing_Attribution]
CREATE NONCLUSTERED INDEX [IX_TrackedAction_AttributionTesting_CustomerTransactionTypeID_ClientID_RecordStatus] ON [dbo].[TrackedAction_AttributionTesting] 
(
	[CustomerTransactionTypeID] ASC,
	[ClientID] ASC,
	[RecordStatus] ASC
)
INCLUDE ( [TrackedActionID],
[TrackingSourceID],
[CreateDateUTC],
[TransactionAmount],
[TransactionTypeID],
[MoreInfo],
[UserUniqueGUID],
[HashKey]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PS_SI_TrackedAction]([CreateDateUTC])
GO


USE [SIProcessing_Attribution]
CREATE NONCLUSTERED INDEX [IX_TrackedAction_AttributionTesting_LocalizedCreateDate] ON [dbo].[TrackedAction_AttributionTesting] 
(
	[LocalizedCreateDate] ASC
)
INCLUDE ( [CreateDateUTC],
[ClientID],
[AffiliateID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PS_SI_TrackedAction]([CreateDateUTC])
GO


USE [SIProcessing_Attribution]
CREATE NONCLUSTERED INDEX [IX_TrackedAction2_SessionGUID__CreateDateUTC_TransactionAmount_TransactionTypeID_CustomerTransactionTypeID_RecordStatus] ON [dbo].[TrackedAction_AttributionTesting] 
(
	[SessionGUID] ASC
)
INCLUDE ( [CreateDateUTC],
[TransactionAmount],
[TransactionTypeID],
[CustomerTransactionTypeID],
[RecordStatus]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PS_SI_TrackedAction]([CreateDateUTC])
GO


USE [SIProcessing_Attribution]
CREATE NONCLUSTERED INDEX [IX_TrackedAction2_UserUniqueGUID__CTTID_TransactionAmount_ClientID_TransactionTypeID_CreateDateUTC_RecordStatus] ON [dbo].[TrackedAction_AttributionTesting] 
(
	[UserUniqueGUID] ASC
)
INCLUDE ( [CustomerTransactionTypeID],
[TransactionAmount],
[ClientID],
[TransactionTypeID],
[CreateDateUTC],
[RecordStatus]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PS_SI_TrackedAction]([CreateDateUTC])
GO


USE [SIProcessing_Attribution]
CREATE NONCLUSTERED INDEX [IX_TrackedAction2_WebServerID_CreateDateUTC] ON [dbo].[TrackedAction_AttributionTesting] 
(
	[WebServerID] ASC
)
INCLUDE ( [LocalizedCreateDate]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PS_SI_TrackedAction]([CreateDateUTC])
GO

ALTER TABLE [dbo].[TrackedAction_AttributionTesting] ADD  CONSTRAINT [DF_TrackedAction_AttributionTesting_Good_RecordStatus]  DEFAULT ('A') FOR [RecordStatus]
GO

ALTER TABLE [dbo].[TrackedAction_AttributionTesting] ADD  CONSTRAINT [DF_TrackedAction_AttributionTesting_Good_EffectiveBeginDateUTC]  DEFAULT (getutcdate()) FOR [EffectiveBeginDateUTC]
GO


