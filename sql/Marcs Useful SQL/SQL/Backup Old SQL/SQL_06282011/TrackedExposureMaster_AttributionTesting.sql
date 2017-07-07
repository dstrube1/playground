USE [SIProcessing_Attribution]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TrackedExposureMaster_AttributionTesting]') AND type in (N'U'))
DROP TABLE [dbo].[TrackedExposureMaster_AttributionTesting]
GO

USE [SIProcessing_Attribution]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[TrackedExposureMaster_AttributionTesting](
	[TrackedExposureID] [bigint] IDENTITY(1,1) NOT NULL,
	[ExposureTypeID] [int] NOT NULL,
	[ChannelID] [int] NOT NULL,
	[CreateDateUTC] [datetime] NOT NULL,
	[TrackingSourceID] [smallint] NULL,
	[AffiliateID] [int] NULL,
	[ClientID] [int] NOT NULL,
	[PublisherCurrencyID] [int] NULL,
	[UserUniqueGUID] [uniqueidentifier] NULL,
	[RawID] [int] NOT NULL,
 CONSTRAINT [PK_TrackedExposureMaster_AttributionTesting] PRIMARY KEY NONCLUSTERED 
(
	[TrackedExposureID] ASC,
	[CreateDateUTC] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PS_SI_TrackedExposureMaster]([CreateDateUTC])
) ON [PS_SI_TrackedExposureMaster]([CreateDateUTC])

GO


USE [SIProcessing_Attribution]
CREATE CLUSTERED INDEX [idx_AffiliateID_ClientID] ON [dbo].[TrackedExposureMaster_AttributionTesting] 
(
	[AffiliateID] ASC,
	[ClientID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 75) ON [PS_SI_TrackedExposureMaster]([CreateDateUTC])
GO

ALTER TABLE [dbo].[TrackedExposureMaster_AttributionTesting] SET (LOCK_ESCALATION = AUTO)
GO


