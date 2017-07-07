USE [Searchignite]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CampaignAdTitleMappingNew_SearchEngine]') AND parent_object_id = OBJECT_ID(N'[dbo].[CampaignAdTitleMappingNew]'))
ALTER TABLE [dbo].[CampaignAdTitleMappingNew] DROP CONSTRAINT [FK_CampaignAdTitleMappingNew_SearchEngine]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_CampaignAdTitleMappingNew_TitleAsKeyword]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[CampaignAdTitleMappingNew] DROP CONSTRAINT [DF_CampaignAdTitleMappingNew_TitleAsKeyword]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_CampaignAdTitleMappingNew_IsDefault]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[CampaignAdTitleMappingNew] DROP CONSTRAINT [DF_CampaignAdTitleMappingNew_IsDefault]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_CampaignAdTitleMappingNew_IsUpdatedDone]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[CampaignAdTitleMappingNew] DROP CONSTRAINT [DF_CampaignAdTitleMappingNew_IsUpdatedDone]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_CampaignAdTitleMappingNew_StatusFlag]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[CampaignAdTitleMappingNew] DROP CONSTRAINT [DF_CampaignAdTitleMappingNew_StatusFlag]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_CampaignAdTitleMappingNew_QualityScore]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[CampaignAdTitleMappingNew] DROP CONSTRAINT [DF_CampaignAdTitleMappingNew_QualityScore]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_CampaignAdTitleMappingNew_ContentQualityScore]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[CampaignAdTitleMappingNew] DROP CONSTRAINT [DF_CampaignAdTitleMappingNew_ContentQualityScore]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_CampaignAdTitleMappingNew_AdTitleOnOffStatusID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[CampaignAdTitleMappingNew] DROP CONSTRAINT [DF_CampaignAdTitleMappingNew_AdTitleOnOffStatusID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_CampaignAdTitleMappingNew_UpdateDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[CampaignAdTitleMappingNew] DROP CONSTRAINT [DF_CampaignAdTitleMappingNew_UpdateDate]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_CampaignAdTitleMappingNew_CreateDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[CampaignAdTitleMappingNew] DROP CONSTRAINT [DF_CampaignAdTitleMappingNew_CreateDate]
END

GO

USE [Searchignite]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CampaignAdTitleMappingNew]') AND type in (N'U'))
DROP TABLE [dbo].[CampaignAdTitleMappingNew]
GO

USE [Searchignite]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[CampaignAdTitleMappingNew](
	[SEID] [smallint] NOT NULL,
	[SETitleID] [int] NOT NULL,
	[AdTitleMappingID] [int] NOT NULL,
	[CampaignID] [int] NOT NULL,
	[Title] [nvarchar](120) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Description1] [nvarchar](1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Description2] [nvarchar](1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[DisplayUrl] [varchar](2048) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[DefaultUrl] [varchar](2048) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[TitleAsKeyword] [bit] NOT NULL,
	[ExternalID] [varchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IsDefault] [bit] NOT NULL,
	[IsUpdatedDone] [bit] NOT NULL,
	[AdTypeID] [tinyint] NULL,
	[AdStatusID] [tinyint] NULL,
	[StatusFlag] [tinyint] NOT NULL,
	[QualityScore] [real] NOT NULL,
	[ContentQualityScore] [real] NOT NULL,
	[AdTitleOnOffStatusID] [tinyint] NOT NULL,
	[ActivationDatetime] [datetime] NULL,
	[PauseDateTime] [datetime] NULL,
	[UpdateDate] [datetime] NULL,
	[OptimizeLandingPage] [bit] NULL,
	[OptimizeByConversion] [bit] NULL,
	[CreateDate] [smalldatetime] NULL,
	[ImageID] [int] NULL,
 CONSTRAINT [PK_CampaignAdTitleMappingNew] PRIMARY KEY CLUSTERED 
(
	[SEID] ASC,
	[SETitleID] ASC,
	[AdTitleMappingID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PS_CampaignAdTitleMapping]([AdTitleMappingID])
) ON [PS_CampaignAdTitleMapping]([AdTitleMappingID])

GO

SET ANSI_PADDING OFF
GO


USE [Searchignite]
CREATE NONCLUSTERED INDEX [idx_CampaignAdTitleMappingNew] ON [dbo].[CampaignAdTitleMappingNew] 
(
	[SEID] ASC,
	[CampaignID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PS_CampaignAdTitleMapping]([AdTitleMappingID])
GO


USE [Searchignite]
CREATE NONCLUSTERED INDEX [Idx_CampaignAdTitleMappingNew_ActivationDatetime] ON [dbo].[CampaignAdTitleMappingNew] 
(
	[ActivationDatetime] ASC,
	[AdTitleOnOffStatusID] ASC,
	[StatusFlag] ASC,
	[AdStatusID] ASC
)
INCLUDE ( [ExternalID],
[IsUpdatedDone]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PS_CampaignAdTitleMapping]([AdTitleMappingID])
GO


USE [Searchignite]
CREATE NONCLUSTERED INDEX [idx_CampaignAdTitleMappingNew_AdTitleMappingID] ON [dbo].[CampaignAdTitleMappingNew] 
(
	[AdTitleMappingID] ASC,
	[SEID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PS_CampaignAdTitleMapping]([AdTitleMappingID])
GO


USE [Searchignite]
CREATE NONCLUSTERED INDEX [IDX_CampaignAdTitleMappingNew_CampaignID] ON [dbo].[CampaignAdTitleMappingNew] 
(
	[CampaignID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PS_CampaignAdTitleMapping]([AdTitleMappingID])
GO


USE [Searchignite]
CREATE NONCLUSTERED INDEX [Idx_CampaignAdTitleMappingNew_ExternalID] ON [dbo].[CampaignAdTitleMappingNew] 
(
	[ExternalID] ASC,
	[StatusFlag] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PS_CampaignAdTitleMapping]([AdTitleMappingID])
GO


USE [Searchignite]
CREATE NONCLUSTERED INDEX [Idx_CampaignAdTitleMappingNew_PauseDateTime] ON [dbo].[CampaignAdTitleMappingNew] 
(
	[PauseDateTime] ASC,
	[AdTitleOnOffStatusID] ASC,
	[StatusFlag] ASC,
	[AdStatusID] ASC
)
INCLUDE ( [ExternalID],
[IsUpdatedDone]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PS_CampaignAdTitleMapping]([AdTitleMappingID])
GO


USE [Searchignite]
CREATE NONCLUSTERED INDEX [idx_CampaignAdTitleMappingNew_SEID_CampaignID_StatusID] ON [dbo].[CampaignAdTitleMappingNew] 
(
	[SEID] ASC,
	[CampaignID] ASC,
	[StatusFlag] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PS_CampaignAdTitleMapping]([AdTitleMappingID])
GO


USE [Searchignite]
CREATE NONCLUSTERED INDEX [idx_CampaignAdTitleMappingNew_SETitleID] ON [dbo].[CampaignAdTitleMappingNew] 
(
	[SETitleID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [PS_CampaignAdTitleMapping]([AdTitleMappingID])
GO

GRANT SELECT ON [dbo].[CampaignAdTitleMappingNew] TO [siasp] AS [dbo]
GO

GRANT SELECT ON [dbo].[CampaignAdTitleMappingNew] TO [webaccess] AS [dbo]
GO

ALTER TABLE [dbo].[CampaignAdTitleMappingNew]  WITH NOCHECK ADD  CONSTRAINT [FK_CampaignAdTitleMappingNew_SearchEngine] FOREIGN KEY([SEID])
REFERENCES [dbo].[SearchEngine] ([SEID])
GO

ALTER TABLE [dbo].[CampaignAdTitleMappingNew] CHECK CONSTRAINT [FK_CampaignAdTitleMappingNew_SearchEngine]
GO

ALTER TABLE [dbo].[CampaignAdTitleMappingNew] ADD  CONSTRAINT [DF_CampaignAdTitleMappingNew_TitleAsKeyword]  DEFAULT ((0)) FOR [TitleAsKeyword]
GO

ALTER TABLE [dbo].[CampaignAdTitleMappingNew] ADD  CONSTRAINT [DF_CampaignAdTitleMappingNew_IsDefault]  DEFAULT ((1)) FOR [IsDefault]
GO

ALTER TABLE [dbo].[CampaignAdTitleMappingNew] ADD  CONSTRAINT [DF_CampaignAdTitleMappingNew_IsUpdatedDone]  DEFAULT ((1)) FOR [IsUpdatedDone]
GO

ALTER TABLE [dbo].[CampaignAdTitleMappingNew] ADD  CONSTRAINT [DF_CampaignAdTitleMappingNew_StatusFlag]  DEFAULT ((1)) FOR [StatusFlag]
GO

ALTER TABLE [dbo].[CampaignAdTitleMappingNew] ADD  CONSTRAINT [DF_CampaignAdTitleMappingNew_QualityScore]  DEFAULT ((0)) FOR [QualityScore]
GO

ALTER TABLE [dbo].[CampaignAdTitleMappingNew] ADD  CONSTRAINT [DF_CampaignAdTitleMappingNew_ContentQualityScore]  DEFAULT ((0)) FOR [ContentQualityScore]
GO

ALTER TABLE [dbo].[CampaignAdTitleMappingNew] ADD  CONSTRAINT [DF_CampaignAdTitleMappingNew_AdTitleOnOffStatusID]  DEFAULT ((1)) FOR [AdTitleOnOffStatusID]
GO

ALTER TABLE [dbo].[CampaignAdTitleMappingNew] ADD  CONSTRAINT [DF_CampaignAdTitleMappingNew_UpdateDate]  DEFAULT (getutcdate()) FOR [UpdateDate]
GO

ALTER TABLE [dbo].[CampaignAdTitleMappingNew] ADD  CONSTRAINT [DF_CampaignAdTitleMappingNew_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO


