USE [SIProcessing_CacheHistory]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SI_SP_TransactionAffiliate_TE3_MarcTest]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SI_SP_TransactionAffiliate_TE3_MarcTest]
GO

USE [SIProcessing_CacheHistory]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO






CREATE PROC [dbo].[SI_SP_TransactionAffiliate_TE3_MarcTest]
(	@ClientID INT,
	@BeginDate DATETIME,
	@EndDate DATETIME,
	@UTCTime BIT,
	@Debug TINYINT = 0
)
/*
01/31/11	LIR Initial version
	
SI_SP_TransactionAffiliate_TE3_MarcTest
	@clientid = 1637,
	@BeginDate = '05/01/11',
	@EndDate = '05/15/11' ,
	@UTCTime =0,
	@Debug = 0


SELECT * FROm 
	
	SELECT affiliateID,MIN(ClientID), COUNT(1) FROM dbo.TrackedExposure
	--WHERE CreateDateUTC BETWEEN '01/30/11' AND '01/31/11'
	GROUP BY AffiliateID
	ORDER BY COUNT(1) desc
	
SELECT MIN(LocalizedCreateDate) FROm TrackedAction Where ClientID = 1637
	
SET @ModGroupID = NULL              
SET @BeginDate ='12/30/2010'             
SET @EndDate ='01/01/2011'            
SET @ProcessAffiliate = NULL              
SET @ClientID = 115  
SET @AffiliateID  =  252  


IF OBJECT_ID('tempdb..#TrackedExposure') IS NOT NULL
DROP TABLE #TrackedExposure

IF OBJECT_ID('tempdb..#TrackedAction') IS NOT NULL
DROP TABLE #TrackedAction

DECLARE
	@ClientID INT = 1637,
	@BeginDate DATETIME ='01/08/11',
	@EndDate DATETIME = '01/09/11',
	@UTCTime BIT = 0,
	@Debug TINYINT = 0
*/	
AS 
BEGIN
	-- Test to see if this is not an affiliate client, if so end
	IF NOT EXISTS (	SELECT 1 
				FROM AffiliateGroupClients agc
				WHERE agc.StatusFlag = 1
					AND ClientID = @ClientID
				)
	RETURN
		
	DECLARE	@COUNT INT,
		@TimeZoneID SMALLINT,
		@DaylightSaving TINYINT,
		@BeginDateHistory DATETIME,
		@EndDateHistory DATETIME,
		@DataType VARCHAR(10),
		@AffiliateID  INT

	IF @BeginDate IS NULL
	BEGIN
		SET @ENDdATE = DATEADD(d,1,GETUTCDATE())
		SET @BeginDATE = DATEADD(d,-1,GETUTCDATE())
	END

	SELECT @AffiliateID = AffiliateID FROM dbo.AffiliateGroupClients
	WHERE clientid = @ClientID

	DECLARE @Clients TABLE
	(	ClientID INT PRIMARY KEY CLUSTERED
		,TimeZoneID SMALLINT
		,DaylightSaving TINYINT
	)

	DECLARE @UUTCTimeDiff TABLE
	(
		[TimeZoneID] [smallint] NOT NULL ,
		[DaylightSaving] [tinyint] NOT NULL ,
		[StartDate] [datetime] NOT NULL,
		[EndDate] [datetime] NOT NULL,
		[UTCHourDiff] [smallint] NOT NULL,
		PRIMARY KEY NONCLUSTERED([TimeZoneID],	[DaylightSaving],	[StartDate], [EndDate])
	)
	INSERT INTO @UUTCTimeDiff (TimeZoneID, DaylightSaving, StartDate, EndDate, UTCHourDiff)
	SELECT 	TimeZoneID, DaylightSaving, StartDate, EndDate, UTCHourDiff
	FROM LUUTCTimeDiff 
								
	--Affilations   (IF THEN FOR AFFILIATIONS)
	INSERT  INTO @Clients ( ClientID, TimeZoneID, DaylightSaving )
	SELECT  
		c.clientid
		,c.TimeZoneID
		,c.DaylightSaving
	FROM    clients c 
		JOIN dbo.AffiliateGroupClients agc
		ON c.clientid = agc.clientid 
	WHERE   AffiliateID = @AffiliateID
			
	IF @UTCTime = 0 
	BEGIN
		SELECT  @TimeZoneID = TimeZoneID,
				@DaylightSaving = DaylightSaving
		FROM    Clients
		WHERE   ClientID = @ClientID

		SELECT  @BeginDate = dbo.fn_ConvertTime(@BeginDate, @TimeZoneID, @DaylightSaving, 13, 0)
		SELECT  @EndDate = dbo.fn_ConvertTime(@EndDate, @TimeZoneID, @DaylightSaving, 13, 0)
	END

	
--This is what the Dynamic code uses	
	DECLARE @Dates TABLE
	(	BeginDate DATETIME NOT NULL,
		EndDate DATETIME NOT NULL
	)

	INSERT INTO @Dates ([BeginDate], [EndDate])
		VALUES  ( @BeginDate, @EndDate ) 
					
	CREATE TABLE #TrackedExposure 
	(	
	--From NonCluster Include
		ChannelID INT NULL	
		,PublisherCurrencyID [int] NULL	
		,TrackedExposureID BIGINT NOT NULL	
		,LocalizedCreateDate DATETIME
	--From ClusterIndex Lookup
		,CreateDateUTC DATETIME NOT NULL
		,ClientID INT NOT NULL	
		,UserUniqueGUID VARCHAR(36) NOT NULL
		,ExposureTypeID INT NULL
	--Join
		,TimeZoneID SMALLINT NULL
		,DaylightSaving TINYINT NULL
	)

	CREATE TABLE #TrackedAction
	(	
		[TrackedActionID] [bigint] NOT NULL,
		[TrackingSourceID] [smallint] NULL,
		[CreateDateUTC] [datetime] NOT NULL,
		[TrackingSourceCreateDateUTC] [datetime] NOT NULL,
		[LocalizedCreateDate] [datetime] NOT NULL,
		[NTID] [int] NULL,
		[TID] [int] NULL,
		[NCTID] [BIGint] NULL,
		[CTID] [BIGint] NULL,
		[CurrencyID] [int] NULL,
		[TransactionAmount] [money] NULL,
		[USDExchangeRate] [money] NULL,
		[TransactionTypeID] [tinyint] NULL,
		[CustomerTransactionTypeID] [int] NULL,
		[MoreInfo] [nvarchar](255) NULL,
		[loginfo] [nvarchar](MAX) NULL,
		[N1] [nvarchar](100) NULL,
		[N2] [nvarchar](100) NULL,
		[N3] [nvarchar](100) NULL,
		[N4] [nvarchar](100) NULL,
		[N5] [nvarchar](100) NULL,
		[N6] [nvarchar](100) NULL,
		[N7] [nvarchar](100) NULL,
		[N8] [nvarchar](100) NULL,
		[N9] [nvarchar](100) NULL,
		[N10] [nvarchar](100) NULL,
		[X1] [nvarchar](100) NULL,
		[X2] [nvarchar](100) NULL,
		[X3] [nvarchar](100) NULL,
		[X4] [nvarchar](100) NULL,
		[X5] [nvarchar](100) NULL,
		[X6] [nvarchar](100) NULL,
		[X7] [nvarchar](100) NULL,
		[X8] [nvarchar](100) NULL,
		[X9] [nvarchar](100) NULL,
		[X10] [nvarchar](100) NULL,
		[ClientID] [int] NOT NULL,
		AffiliateID INT NULL,
		[SessionGUID] [varchar](36) NULL,
		[UserUniqueGUID] [varchar](36) NOT NULL,
		[CSKID] [int] NULL,
		[RawTrackingActionID] [bigint] NULL,
		[AccessServerID] [int] NULL,
		[WebServerID] [int] NULL,
		[RecordStatus] [char](1) NOT NULL,
		[EffectiveBeginDateUTC] [datetime] NOT NULL,
		[EffectiveEndDateUTC] [datetime] NULL,
		[CustomAttributionSettingID] INT NULL,
		AttributionModelID INT NULL,
		ClientAttributionProfileID INT NULL,
		CustomAttributionFactor NUMERIC(18, 2),
		ClientAttributionProfileSettingID INT NULL,
		PRIMARY KEY CLUSTERED ( UserUniqueGUID, CreateDateUTC, TrackedActionID )
	)
	INSERT  INTO #TrackedAction
	SELECT  [TrackedActionID],
		[TrackingSourceID],
		ta.CreateDateUTC,
		[TrackingSourceCreateDateUTC],
		[LocalizedCreateDate],
		[NTID],
		[TID],
		[NCTID],
		[CTID],
		[CurrencyID],
		[TransactionAmount],
		[USDExchangeRate],
		[TransactionTypeID],
		[CustomerTransactionTypeID],
		[MoreInfo],
		[loginfo],
		[N1], [N2], [N3], [N4], [N5], [N6], [N7], [N8], [N9], [N10],
		[X1], [X2], [X3], [X4], [X5], [X6], [X7], [X8], [X9], [X10],
		ta.[ClientID],
		ta.AffiliateID,
		[SessionGUID],
		ISNULL(UserUniqueGUID,0),
		[CSKID],
		[RawTrackingActionID],
		[AccessServerID],
		[WebServerID],
		ta.RecordStatus,
		ta.EffectiveBeginDateUTC,
		ta.EffectiveEndDateUTC,
		caps.[CustomAttributionSettingID],
		CASE WHEN caps.AttributionModelID = 4 AND CAPS.CustomAttributionFactor =1 THEN 1  --First
			 WHEN caps.AttributionModelID = 4 AND CAPS.CustomAttributionFactor =16 THEN 3 --Even
			 WHEN caps.AttributionModelID = 4 AND CAPS.CustomAttributionFactor =32 THEN 2 --Last
			ELSE caps.AttributionModelID
			END AS AttributionModelID,
		caps.ClientAttributionProfileID,
		CASE WHEN caps.AttributionModelID = 4 AND caps.[CustomAttributionSettingID] = 2 THEN CustomAttributionFactorValue
			WHEN caps.AttributionModelID = 4 AND caps.[CustomAttributionSettingID] = 1 THEN [CustomAttributionFactorTimeValue]
			ELSE 0 END AS  CustomAttributionFactor,  --CAPS.CustomAttributionFactor,  --Need to finish this code to case based on type of sliding window
		CAPS.ClientAttributionProfileSettingID
	FROM	SIProcessing_Attribution..TrackedAction_AttributionTesting ta
		JOIN @Dates d
			ON	CreateDateUTC >= d.BeginDate
				AND CreateDateUTC < d.EndDate
				AND ta.RecordStatus IN('A','U','R')
				AND ta.AffiliateID = @AffiliateID 					
		INNER JOIN dbo.ClientAttributionProfileSetting AS caps
			ON ta.ClientID = caps.ClientID  
				AND ta.CreateDateUTC >= caps.EffectiveBeginDateUTC
				AND ta.CreateDateUTC < ISNULL(caps.EffectiveEndDateUTC, '9999-12-31')
		LEFT JOIN LUCustomAttributionFactor caf ON caf.CustomAttributionFactorId = CAPS.CustomAttributionFactor

	IF @Debug =1
	BEGIN
		SELECT 'Actions',COUNT(1) FROM #trackedAction
		SELECT * FROM #trackedAction
	END

	INSERT  INTO #TrackedExposure
	(	CreateDateUTC
		,UserUniqueGUID
		,TrackedExposureID
		,ChannelID
		,ExposureTypeID
		,PublisherCurrencyID
		,LocalizedCreateDate
		,TimeZoneID
		,DaylightSaving	
		,ClientID
	)
		SELECT	
		CreateDateUTC
		,UserUniqueGUID
		,TrackedExposureID	
		,ChannelID
		,ExposureTypeID
		,PublisherCurrencyID
		,LocalizedCreateDate
		,TimeZoneID
		,DaylightSaving	
		,te.ClientID
	FROM    SIProcessing_Attribution..TrackedExposure_AttributionTesting te
		JOIN @Clients C
			ON te.clientid = C.clientid
	WHERE
		 EXISTS
			(	SELECT	1
				FROM   #TrackedAction ta
				WHERE 
					te.AffiliateID = ta.AffiliateID
					AND te.useruniqueguid = ta.UserUniqueGUID
			)
			
	CREATE NONCLUSTERED INDEX IDX_TrackedExposure	ON #TrackedExposure ( UserUniqueGUID, CreateDateUTC)
		
	IF @Debug =1
		SELECT 'Exposures',COUNT(1) FROM [#TrackedExposure];

	WITH ClickStreamCTEComplete AS
	(	SELECT
		--Action columns
			ta.ClientID AS OrigClientID, 
			ta.[TrackedActionID],
			ta.CreateDateUTC AS CreateDateUTC_TrackedAction,
			ta.LocalizedCreateDate AS LocalizedCreateDate_TrackedAction,
			ta.CurrencyID,
			ta.TransactionAmount,
			ta.USDExchangeRate,
			ta.TransactionTypeID,
			ta.CustomerTransactionTypeID,
			ta.TrackingSourceID,
			ta.TID,
			ta.NTID,
			ta.[SessionGUID],
			ta.[MoreInfo],
			ta.[N1], ta.[N2], ta.[N3], ta.[N4], ta.[N5], ta.[N6], ta.[N7], ta.[N8], ta.[N9], ta.[N10],
			ta.[X1], ta.[X2], ta.[X3], ta.[X4], ta.[X5], ta.[X6], ta.[X7], ta.[X8], ta.[X9], ta.[X10],
			ta.[loginfo],
			ta.[UserUniqueGUID],
			ta.[WebServerID],
			ta.[AccessServerID],
			ta.CustomAttributionFactor,
			ta.CustomAttributionSettingID,
			ta.AttributionModelID,
			ta.ClientAttributionProfileID
			,DENSE_RANK() OVER ( PARTITION BY ta.TrackedActionID ORDER BY capc.tier ) AS DenseTier
		----Exposure columns
			,te.ClientID
			,DENSE_RANK() OVER ( PARTITION BY ta.TrackedActionID, te.CreateDateUTC ORDER BY capc.Priority ) AS DensePriority
			,DATEDIFF(ss, te.CreateDateUTC, ta.CreateDateUTC) AS LatencyInSeconds
			,te.TrackedExposureID
			,te.CreateDateUTC AS CreateDateUTC_TrackedExposure
			,te.LocalizedCreateDate AS LocalizedCreateDate_TrackedExposure
			,te.ChannelID
			,te.PublisherCurrencyID
			,te.TimeZoneID
			,te.DaylightSaving
			,te.exposureTypeID
		--ClientAttributionProfileChannel columns
			,capc.ActionWeightPct
			,capc.Priority
			,capc.tier
			,capc.LookbackWindowInDays
		FROM	#TrackedAction ta
			INNER JOIN #TrackedExposure AS te
				ON (te.UserUniqueGUID = ta.UserUniqueGUID AND DATEADD(ms,900,te.CreateDateUTC) < ta.CreateDateUTC)  --Or add clientid to the mix
			INNER JOIN dbo.ClientAttributionProfileChannel capc
				ON capc.ClientAttributionProfileSettingID = ta.ClientAttributionProfileSettingID
					AND capc.ChannelID = te.ChannelID
					AND capc.ExposureTypeID = te.ExposureTypeID
		WHERE	ta.RecordStatus IN('A','U','R')
			AND DATEADD(dd, -LookbackWindowInDays, ta.CreateDateUTC) < te.CreateDateUTC
	),
	ClickStreamCTEPriority AS --This holds the complete clicksteam used to calculate tier and priority
	(SELECT
		--Action columns
		OrigClientID,
		TrackingSourceID AS TrackingSourceID_TrackedAction,
		[TrackedActionID],
		CreateDateUTC_TrackedAction,
		LocalizedCreateDate_TrackedAction,
		PublisherCurrencyID AS CurrencyID,
		TransactionAmount,
		USDExchangeRate,
		TransactionTypeID,
		CustomerTransactionTypeID,
		TrackingSourceID ,
		ISNULL(tid,TrackedActionID) AS tid,	
		ISNULL(NTID,TrackedActionID) AS NTID,	
		[SessionGUID],
		[MoreInfo],
		[N1], [N2], [N3], [N4], [N5], [N6], [N7], [N8], [N9], [N10],
		[X1], [X2], [X3], [X4], [X5], [X6], [X7], [X8], [X9], [X10],
		[loginfo],
		[UserUniqueGUID]
		,WebServerID
		,AccessServerID
		,LatencyInSeconds
	--Exposure columns
		,ClientID
		,TrackedExposureID
		,CreateDateUTC_TrackedExposure
		,LocalizedCreateDate_TrackedExposure
		,ChannelID
		,TimeZoneID
		,DaylightSaving	
		,ExposureTypeID		
	--Profile columns
		,CustomAttributionFactor
		,CustomAttributionSettingID
		,AttributionModelID
		,ClientAttributionProfileID
		,ActionWeightPct
		,ROW_NUMBER() OVER ( PARTITION BY TrackedActionID ORDER BY CreateDateUTC_TrackedExposure ) AS SequenceOrder
		,DenseTier
		,DensePriority
		,CurrencyID AS OrigCurrencyID
	FROM	ClickStreamCTEComplete
	WHERE	DensePriority = 1
		AND DenseTier = 1
	)
	,ClickStreamCTE20 AS --This holds the complete clicksteam used to calculate tier and priority
	(SELECT
	--Action columns
		OrigClientID,
		TrackingSourceID AS TrackingSourceID_TrackedAction,
		[TrackedActionID],
		CreateDateUTC_TrackedAction,
		LocalizedCreateDate_TrackedAction,
		CurrencyID,
		TransactionAmount,
		USDExchangeRate,
		TransactionTypeID,
		CustomerTransactionTypeID,
		TrackingSourceID,
		TID,
		NTID,
		[SessionGUID],
		[MoreInfo],
		[N1], [N2], [N3], [N4], [N5], [N6], [N7], [N8], [N9], [N10],
		[X1], [X2], [X3], [X4], [X5], [X6], [X7], [X8], [X9], [X10],
		[loginfo]
		,[UserUniqueGUID]
		,LatencyInSeconds
	--Exposure columns
		,ClientID
		,TrackedExposureID
		,CreateDateUTC_TrackedExposure
		,LocalizedCreateDate_TrackedExposure
		,ChannelID
		,TimeZoneID
		,DaylightSaving	
		,ExposureTypeID	
		,WebServerID
		,AccessServerID			
	--Profile columns
		,CustomAttributionFactor,
		CustomAttributionSettingID,
		AttributionModelID,
		ClientAttributionProfileID,
		ActionWeightPct,
		SequenceOrder,
		COUNT(1) OVER ( PARTITION BY TrackedActionID ) AS ExposureCount,
		DenseTier,
		DensePriority,
		CASE WHEN ( MAX(DATEDIFF(ss, CreateDateUTC_TrackedExposure,
		CreateDateUTC_TrackedAction)) OVER ( PARTITION BY TrackedActionID ) ) = 0
		THEN 1
		ELSE MAX(DATEDIFF(ss, CreateDateUTC_TrackedExposure,
		CreateDateUTC_TrackedAction)) OVER ( PARTITION BY TrackedActionID )
		END AS MaxLatency,
		OrigCurrencyID
	FROM	ClickStreamCTEPriority
	),
	FinalClickStream AS --This holds the complete clicksteam used to calculate tier and priority
	(SELECT
		--Action columns
		OrigClientID,
		TrackingSourceID_TrackedAction,
		[TrackedActionID],
		CreateDateUTC_TrackedAction,
		LocalizedCreateDate_TrackedAction,
		CurrencyID,
		TransactionAmount,
		USDExchangeRate,
		TransactionTypeID,
		CustomerTransactionTypeID,
		TrackingSourceID,
		TID,
		NTID,
		[SessionGUID],
		[MoreInfo],
		[N1], [N2], [N3], [N4], [N5], [N6], [N7], [N8], [N9], [N10],
		[X1], [X2], [X3], [X4], [X5], [X6], [X7], [X8], [X9], [X10],
		[loginfo],
		[UserUniqueGUID]
		,LatencyInSeconds
	--Exposure columns
		,ClientID
		,TrackedExposureID
		,LocalizedCreateDate_TrackedExposure
		,CreateDateUTC_TrackedExposure
		,ChannelID
		,TimeZoneID
		,DaylightSaving
		,ExposureTypeID	
		,WebServerID	
		,AccessServerID			
	--Profile columns
		,CustomAttributionFactor,
		CustomAttributionSettingID,
		AttributionModelID,
		ClientAttributionProfileID,
		ActionWeightPct,
		SequenceOrder,
		ExposureCount,
		DenseTier,
		DensePriority,
		MaxLatency
		 ,SUM(CASE WHEN AttributionModelID = 4 AND MaxLatency <> 0 AND CustomAttributionFactor > 1
				THEN POWER(1/CAST(CustomAttributionFactor AS FLOAT), LOG(LatencyInSeconds))
			WHEN AttributionModelID = 4 AND MaxLatency <> 0 AND CustomAttributionFactor < -1
				THEN POWER(ABS(CAST(CustomAttributionFactor AS FLOAT)), LOG(LatencyInSeconds))
			ELSE 1 END )  OVER ( PARTITION BY TrackedActionID ) 
		AS TotalClickStreamWeight,
		CASE WHEN CustomAttributionFactor > 1 
				THEN POWER(1/CAST(CustomAttributionFactor AS FLOAT), LOG(LatencyInSeconds))
			 WHEN CustomAttributionFactor < -1 
				THEN POWER(ABS(CAST(CustomAttributionFactor AS FLOAT)), LOG(LatencyInSeconds)) 
			END  
		AS TimeWeight
		,OrigCurrencyID
	FROM	ClickStreamCTE20
	)
	,TransactionTrackingCTE AS
	(SELECT	LocalizedCreateDate_TrackedAction AS EasternCreateDate,
		TID
		,NTID
		,TransactionAmount
		,[ActionWeightPct]
		,CASE	WHEN AttributionModelID IN ( 1, 2 ) THEN 1
			WHEN AttributionModelID = 3 THEN 1.00 / ExposureCount
			WHEN AttributionModelID = 4 THEN
				CASE	WHEN CustomAttributionSettingID = 1
						THEN TimeWeight/TotalClickStreamWeight
					WHEN CustomAttributionSettingID = 2
						THEN dbo.fn_AttributionWeightFunnel(CustomAttributionFactor, SequenceOrder, ExposureCount)
				END
		END AS ActionWeightFactor
		,[CreateDateUTC_TrackedAction] AS Createddate
		,SessionGUID
		,[TransactionTypeID]
		,MoreInfo
		,[N1], [N2], [N3], [N4], [N5], [N6], [N7], [N8], [N9], [N10]
		,[X1], [X2], [X3], [X4], [X5], [X6], [X7], [X8], [X9], [X10]
		,CustomerTransactionTypeID
		,[loginfo]
		,LocalizedCreateDate_TrackedExposure AS ClickTime
		,CreateDateUTC_TrackedExposure
		,LatencyInSeconds
		,[UserUniqueGUID]
		,ClientID
		,OrigClientID
		,NULL AS ReferenceID
		,TransactionAmount AS origTransactionAmt
		,CurrencyId
		,OrigCurrencyId
		,TimeZoneID
		,DaylightSaving		
		,ExposureTypeID			
	--New columns
		,TrackedActionID
		,TrackedExposureID
		,TrackingSourceID
		,AttributionModelID
		,MaxLatency
		,SequenceOrder
		,ExposureCount
		,CustomAttributionFactor
		,CustomAttributionSettingID
		,TrackingSourceID_TrackedAction
		,TransactionAmount AS TransactionAmountUnweighted
		,[TransactionAmount] * [USDExchangeRate] * [ActionWeightPct] AS TransactionAmountUSD
		,[TransactionAmount] * USDExchangeRate AS TransactionAmountUnweightedUSD
		,ChannelID
		,USDExchangeRate
		,WebServerID
		,AccessServerID
		,CASE WHEN channelID =3 THEN 1 ELSE 0 END AS PaidInclusion
	FROM	FinalClickStream cs
	WHERE	(	( AttributionModelID = 1 AND SequenceOrder = ExposureCount)
		 OR	( AttributionModelID = 2 AND SequenceOrder = 1)
		 OR	( AttributionModelID IN ( 3, 4 ) )
		)
)
	SELECT	
		EasternCreateDate
		,TID
		,NTID
		,cskid
		,TransactionAmount * ISNULL(ExchangeRate, 1) * ActionWeightFactor * ActionWeightPct AS TransactionAmount
		,CreatedDate
		,cte.SessionGUID
		,TransactionTypeID
		,MoreInfo
		,[N1], [N2], [N3], [N4], [N5], [N6], [N7], [N8], [N9], [N10]
		,[X1], [X2], [X3], [X4], [X5], [X6], [X7], [X8], [X9], [X10]
		,CustomerTransactionTypeID
		,loginfo
		,isContentMatch
		,cte.TrackedExposureID AS CTID
		,cte.TrackedExposureID AS NCTID
		,te.localizedCreateDate as ClickTime	
		,LatencyInSeconds			
		,cte.UserUniqueGUID	
		,cte.ClientID	
		,ReferenceID	
		,te.SEID
		,te.NSEID	
		,te.PublisherID	
		,te.CampaignKeywordID AS CKeywordID
		,te.AdCategoryID
		,te.CampaignID		
		,OrigClientID	
		,te.ExtraInfo1		
		,OrigTransactionAmt
		,CurrencyID
		,OrigCurrencyID
		,cte.WebServerID
		,cte.AccessServerID
		,TrackedActionID
		,cte.TrackedExposureID
		,cte.ChannelID									
		,ActionWeightPct
		,ActionWeightFactor		
		,ExposureCount AS AttributedExposures
		,SequenceOrder AS ExposureSequence
		,ActionWeightFactor * ActionWeightPct AS ActionQuantity
		,te.KeywordID
		,te.Keyword
		,te.ExposureTypeID
		,PaidInclusion						
		,USDExchangeRate
		,BINARY_CHECKSUM(EasternCreateDate,
				TID
				,NTID
				,CSKID
				,TransactionAmount
				,[ActionWeightPct]
				,ActionWeightFactor
				,Createddate
				,cte.SessionGUID
				,[TransactionTypeID]
				,MoreInfo
				,[N1], [N2], [N3], [N4], [N5], [N6], [N7], [N8], [N9], [N10]
				,[X1], [X2], [X3], [X4], [X5], [X6], [X7], [X8], [X9], [X10]
				,CustomerTransactionTypeID
				,[loginfo]
				,ISContentMatch
				,cte.TrackedExposureID 
				,cte.trackedExposureID 
				,ClickTime
				,LatencyInSeconds
				,cte.[UserUniqueGUID]
				,cte.ClientID
				,OrigClientID
				,KeywordID
				,Keyword
				,ReferenceID
				,SEID
				,NSEID
				,CampaignKeywordID
				,AdCategoryID
				,CampaignID
				,ExtraInfo1
				,origTransactionAmt
				,CurrencyID
				,OrigCurrencyID
				,cte.WebServerID
				,cte.AccessServerID
				,cte.TimeZoneID
				,cte.DaylightSaving
				,TrackedActionID
				,cte.TrackedExposureID
				,cte.TrackingSourceID
				,AttributionModelID
				,MaxLatency
				,SequenceOrder
				,ExposureCount
				,CustomAttributionFactor
				,CustomAttributionSettingID
				,TrackingSourceID_TrackedAction
				,TransactionAmountUnweighted
				,TransactionAmountUSD
				,TransactionAmountUnweightedUSD
				,cte.ChannelID
				,PublisherID
				,cte.ExposureTypeID
				,USDExchangeRate
				,PaidInclusion
				,ExchangeHistoryID
				,FromCurrencyID
				,ToCurrencyID
				,ExchangeRate
				,CreateDate
				,lutd.TimeZoneID
				,lutd.DaylightSaving
				,StartDate
				,EndDate
				,UTCHourDiff
			) AS BinaryChecksum
	FROM    TransactionTrackingCTE AS cte
		JOIN SIProcessing_Attribution..TrackedExposure_AttributionTesting te ON cte.ClientID = te.ClientID 
			AND cte.CreateDateUTC_TrackedExposure = te.CreateDateUTC
			AND cte.exposureTypeID = te.ExposureTypeID
			AND cte.useruniqueGUID = te.UserUniqueGUID
		LEFT JOIN SIProcessing.dbo.CurrencyExchangeDataHistory ce ON cte.OrigCurrencyID <> cte.CurrencyID
			AND ce.FromCurrencyID = cte.OrigCurrencyID
			AND ce.ToCurrencyID = cte.CurrencyID
			AND  DATEDIFF(d,ce.CreateDate, ClickTime ) = 0
		LEFT JOIN  @UUTCTimeDiff lutd ON lutd.TimeZoneID = cte.TimeZoneID
			AND lutd.DaylightSaving = cte.DaylightSaving
			AND CreatedDate BETWEEN StartDate AND EndDate

END




GO


