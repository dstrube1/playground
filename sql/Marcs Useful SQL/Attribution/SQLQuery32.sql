
DECLARE @BeginDateLocalized DATETIME = '07/24/2013' ,
    @EndDateLocalized DATETIME = '07/25/2013' ,
    @AffiliateID INT = 204,
    @ProfileSequence TINYINT = 1
    
    
    IF OBJECT_ID('tempdb..#ExposureSequence') IS NOT NULL
    DROP TABLE #ExposureSequence

CREATE TABLE #ExposureSequence
    (
      TrackedExposureID [bigint] NOT NULL ,
      TrackedActionID [bigint] NOT NULL ,
      ChannelID [tinyint] NULL ,
      ExposureTypeID [tinyint] NULL ,
      ExposureClientID [int] NOT NULL ,
      ExposureCreateDateUTC [datetime] NULL ,
      PublisherID [int] NULL ,
      ExposureCurrencyID [smallint] NULL ,
      ActionCurrencyID [int] NULL ,
      ActionClientID [int] NULL ,
      ActionLocalizedCreateDate [datetime] NOT NULL ,
      ActionCreateDateUTC [datetime] NULL ,
      UserUniqueGUID [uniqueidentifier] NULL ,
      TransactionAmount [money] NULL ,
      TrackingSourceID [tinyint] NULL ,
      CustomerTransactionTypeID [int] NULL ,
      AffiliateID [int] NULL ,
      CustomAttributionSettingID INT NULL ,
      AttributionModelID INT NULL ,
      ClientAttributionProfileID INT NULL ,
      CustomAttributionFactor NUMERIC(18, 2) ,
      ClientAttributionProfileSettingID INT NULL ,
      ExposureSequenceID BIGINT ,
      ExposureLocalizedCreateDate [datetime] NULL ,
      CSKID BIGINT NULL ,
      AdCategoryID INT ,
      CampaignID INT ,
      KeywordID INT ,
      CreativeID BIGINT ,
      GlobalTrackingTypeID INT ,
      GlobalTrackingID BIGINT ,
      CustomChannelID SMALLINT ,
      Steepness FLOAT ,
      ShiftFactor INT ,
      FirstExposureWeight DECIMAL(15, 8) ,		--06/12/13  ETC
      LastExposureWeight DECIMAL(15, 8)		--06/12/13  ETC
            
    )

CREATE CLUSTERED INDEX idx_ExposureSequence_ExposureClientID_TrackedExposureID ON #ExposureSequence (ExposureClientID, TrackedExposureID) 

INSERT  INTO #ExposureSequence
        ( TrackedExposureID ,
          TrackedActionID ,
          ChannelID ,
          ExposureTypeID ,
          ExposureClientID ,
          ExposureCreateDateUTC ,
          PublisherID ,
          ExposureCurrencyID ,
          ActionCurrencyID ,
          ActionClientID ,
          ActionLocalizedCreateDate ,
          ActionCreateDateUTC ,
          UserUniqueGUID ,
          TransactionAmount ,
          TrackingSourceID ,
          CustomerTransactionTypeID ,
          AffiliateID ,
          CustomAttributionSettingID ,
          AttributionModelID ,
          ClientAttributionProfileID ,
          CustomAttributionFactor ,
          ClientAttributionProfileSettingID ,
          caps.Steepness ,
          caps.ShiftFactor ,
          ExposureSequenceID ,
          ExposureLocalizedCreateDate ,
          CSKID ,
          AdCategoryID ,
          CampaignID ,
          KeywordID ,
          CreativeID ,
          GlobalTrackingTypeID ,
          GlobalTrackingID ,
          CustomChannelID ,
          FirstExposureWeight ,
          LastExposureWeight	
                    
        )
        SELECT  TrackedExposureID ,
                TrackedActionID ,
                ChannelID ,
                ExposureTypeID ,
                ExposureClientID ,
                ExposureCreateDateUTC ,
                PublisherID ,
                ExposureCurrencyID ,
                ActionCurrencyID ,
                ActionClientID ,
                ActionLocalizedCreateDate ,
                ActionCreateDateUTC ,
                UserUniqueGUID ,
                TransactionAmount ,
                TrackingSourceID ,
                CustomerTransactionTypeID ,
                AffiliateID ,
                caps.CustomAttributionSettingID ,
                CASE WHEN caps.AttributionModelID = 4
                          AND CAPS.CustomAttributionFactor = 1 THEN 1
                     WHEN caps.AttributionModelID = 4
                          AND CAPS.CustomAttributionFactor = 16 THEN 3
                     WHEN caps.AttributionModelID = 4
                          AND CAPS.CustomAttributionFactor = 31 THEN 2
                     ELSE caps.AttributionModelID
                END AS AttributionModelID ,
                caps.ClientAttributionProfileID ,
                CASE WHEN caps.AttributionModelID = 4
                          AND caps.[CustomAttributionSettingID] = 2
                     THEN CustomAttributionFactorValue
                     WHEN caps.AttributionModelID = 4
                          AND caps.[CustomAttributionSettingID] = 1
                     THEN [CustomAttributionFactorTimeValue]
                     ELSE 0
                END AS CustomAttributionFactor ,
                CAPS.ClientAttributionProfileSettingID ,
                caps.Steepness ,
                caps.ShiftFactor ,
                es.ExposureSequenceID ,
                es.ExposureLocalizedCreateDate ,
                es.CSKID ,
                es.AdCategoryID ,
                es.CampaignID ,
                es.KeywordID ,
                CAST (es.CreativeID AS BIGINT) AS CreativeID ,
                es.GlobalTrackingTypeID ,
                es.GlobalTrackingID ,
                CASE WHEN useCustomChannel = 1
                     THEN ISNULL(es.CustomChannelID, es.ChannelID)
                     ELSE es.ChannelID
                END ,
                caps.FirstExposureWeight ,
                caps.LastExposureWeight
        FROM    ExposureSequence es
                INNER JOIN dbo.ClientAttributionProfileSetting AS caps ON es.ActionClientID = caps.ClientID
                                                              AND es.ActionCreateDateUTC >= caps.EffectiveBeginDateUTC
                                                              AND es.ActionCreateDateUTC < ISNULL(caps.EffectiveEndDateUTC,
                                                              '9999-12-31')
                LEFT JOIN LUCustomAttributionFactor caf ON caf.CustomAttributionFactorId = CAPS.CustomAttributionFactor
        WHERE   ActionLocalizedCreateDate BETWEEN @BeginDateLocalized
                                          AND     @EndDateLocalized
                AND es.AffiliateID = @AffiliateID
                AND caps.ProfileSequence = @ProfileSequence
                AND es.CustomerTransactionTypeID = 2753
    
  SELECT SUM(TRansactionAmount) AS TransactionAmount,
		COUNT(DISTINCT TrackedActionID)
  FROM     #ExposureSequence  
  WHERE ChannelID = 4    
  
  ;WITH    ClickStreamCTEComplete
          AS ( SELECT   es.ActionClientID AS OrigClientID ,
                        es.TrackedActionID ,
                        es.ActionCreateDateUTC AS CreateDateUTC_TrackedAction ,
                        es.ActionLocalizedCreateDate AS LocalizedCreateDate_TrackedAction ,
                        es.ActionCurrencyID AS CurrencyID ,
                        es.TransactionAmount ,
                        es.CustomerTransactionTypeID ,
                        es.TrackingSourceID ,
                        es.UserUniqueGUID ,
                        es.CustomAttributionFactor ,
                        es.CustomAttributionSettingID ,
                        es.AttributionModelID ,
                        es.ClientAttributionProfileID ,
                        DENSE_RANK() OVER ( PARTITION BY es.TrackedActionID ORDER BY capc.tier ) AS DenseTier ,
                        es.AffiliateID ,
                        es.ExposureClientID AS ClientID ,
                        DENSE_RANK() OVER ( PARTITION BY es.TrackedActionID,
                                            es.ExposureCreateDateUTC ORDER BY capc.Priority ) AS DensePriority ,
                        DATEDIFF(ss, es.ExposureCreateDateUTC,
                                 es.ActionCreateDateUTC) AS LatencyInSeconds ,
                        es.TrackedExposureID ,
                        es.ExposureCreateDateUTC AS CreateDateUTC_TrackedExposure ,
                        es.ExposureLocalizedCreateDate ,
                        es.ChannelID ,
                        es.ExposureCurrencyID AS PublisherCurrencyID ,
                        es.ExposureTypeID ,
                        es.PublisherID ,
                        es.cskid ,
                        es.AdCategoryID ,
                        es.CampaignID ,
                        es.KeywordID ,
                        es.Steepness ,
                        es.ShiftFactor ,
                        capc.ActionWeightPct ,
                        capc.Priority ,
                        capc.tier ,
                        capc.LookbackWindowInDays ,
                        ExposureSequenceID ,
                        es.CreativeID ,
                        es.GlobalTrackingTypeID ,
                        es.GlobalTrackingID ,
                        es.FirstExposureWeight ,
                        es.LastExposureWeight
               FROM     #ExposureSequence es
                        INNER JOIN dbo.ClientAttributionProfileChannel capc ON capc.ClientAttributionProfileSettingID = es.ClientAttributionProfileSettingID
                                                              AND capc.ChannelID = es.CustomChannelID
                                                              AND capc.ExposureTypeID = es.ExposureTypeID
               WHERE    DATEADD(dd, -LookbackWindowInDays, es.ActionCreateDateUTC) < es.ExposureCreateDateUTC
             )
             
             SELECT DensePriority,DenseTier,ChannelID, SUM(TransactionAmount) AS Revenue,COUNT(DISTINCT TrackedActionID) AS Actions
             FROM (
				SELECT DensePriority,DenseTier,ChannelID,TRackedACtionID,TRansactionAMount
                FROM     ClickStreamCTEComplete
               GROUP BY DensePriority,DenseTier,ChannelID,TRackedACtionID,TRansactionAMount
               ) t
               GROUP BY DensePriority,DenseTier,ChannelID
               
        
;WITH    ClickStreamCTEComplete
          AS ( SELECT   es.ActionClientID AS OrigClientID ,
                        es.TrackedActionID ,
                        es.ActionCreateDateUTC AS CreateDateUTC_TrackedAction ,
                        es.ActionLocalizedCreateDate AS LocalizedCreateDate_TrackedAction ,
                        es.ActionCurrencyID AS CurrencyID ,
                        es.TransactionAmount ,
                        es.CustomerTransactionTypeID ,
                        es.TrackingSourceID ,
                        es.UserUniqueGUID ,
                        es.CustomAttributionFactor ,
                        es.CustomAttributionSettingID ,
                        es.AttributionModelID ,
                        es.ClientAttributionProfileID ,
                        DENSE_RANK() OVER ( PARTITION BY es.TrackedActionID ORDER BY capc.tier ) AS DenseTier ,
                        es.AffiliateID ,
                        es.ExposureClientID AS ClientID ,
                        DENSE_RANK() OVER ( PARTITION BY es.TrackedActionID,
                                            es.ExposureCreateDateUTC ORDER BY capc.Priority ) AS DensePriority ,
                        DATEDIFF(ss, es.ExposureCreateDateUTC,
                                 es.ActionCreateDateUTC) AS LatencyInSeconds ,
                        es.TrackedExposureID ,
                        es.ExposureCreateDateUTC AS CreateDateUTC_TrackedExposure ,
                        es.ExposureLocalizedCreateDate ,
                        es.ChannelID ,
                        es.ExposureCurrencyID AS PublisherCurrencyID ,
                        es.ExposureTypeID ,
                        es.PublisherID ,
                        es.cskid ,
                        es.AdCategoryID ,
                        es.CampaignID ,
                        es.KeywordID ,
                        es.Steepness ,
                        es.ShiftFactor ,
                        capc.ActionWeightPct ,
                        capc.Priority ,
                        capc.tier ,
                        capc.LookbackWindowInDays ,
                        ExposureSequenceID ,
                        es.CreativeID ,
                        es.GlobalTrackingTypeID ,
                        es.GlobalTrackingID ,
                        es.FirstExposureWeight ,
                        es.LastExposureWeight
               FROM     #ExposureSequence es
                        INNER JOIN dbo.ClientAttributionProfileChannel capc ON capc.ClientAttributionProfileSettingID = es.ClientAttributionProfileSettingID
                                                              AND capc.ChannelID = es.CustomChannelID
                                                              AND capc.ExposureTypeID = es.ExposureTypeID
               WHERE    DATEADD(dd, -LookbackWindowInDays, es.ActionCreateDateUTC) < es.ExposureCreateDateUTC
             )
               
        ,ClickStreamCTEPriority
          AS (
          
           SELECT   OrigClientID ,
                        TrackingSourceID AS TrackingSourceID_TrackedAction ,
                        TrackedActionID ,
                        CreateDateUTC_TrackedAction ,
                        LocalizedCreateDate_TrackedAction ,
                        PublisherCurrencyID AS CurrencyID ,
                        TransactionAmount ,
                        CustomerTransactionTypeID ,
                        TrackingSourceID ,
                        UserUniqueGUID ,
                        LatencyInSeconds ,
                        AffiliateID ,
                        ClientID ,
                        TrackedExposureID ,
                        CreateDateUTC_TrackedExposure ,
                        ExposureLocalizedCreateDate ,
                        ChannelID ,
                        ExposureTypeID ,
                        PublisherID ,
                        CSKID ,
                        AdCategoryID ,
                        CampaignID ,
                        KeywordID ,
                        Steepness ,
                        ShiftFactor ,
                        CustomAttributionFactor ,
                        CustomAttributionSettingID ,
                        AttributionModelID ,
                        ClientAttributionProfileID ,
                        ActionWeightPct ,
                        ROW_NUMBER() OVER ( PARTITION BY TrackedActionID ORDER BY CreateDateUTC_TrackedExposure ) AS SequenceOrder ,
                        DenseTier ,
                        DensePriority ,
                        CurrencyID AS OrigCurrencyID ,
                        ExposureSequenceID ,
                        CreativeID ,
                        GlobalTrackingTypeID ,
                        GlobalTrackingID ,
                        FirstExposureWeight ,
                        LastExposureWeight
               FROM     ClickStreamCTEComplete
               WHERE    DensePriority = 1
                        AND DenseTier = 1
             ),
        ClickStreamCTE20
          AS ( SELECT   OrigClientID ,
                        TrackingSourceID AS TrackingSourceID_TrackedAction ,
                        TrackedActionID ,
                        CreateDateUTC_TrackedAction ,
                        LocalizedCreateDate_TrackedAction ,
                        CurrencyID ,
                        TransactionAmount ,
                        CustomerTransactionTypeID ,
                        TrackingSourceID ,
                        UserUniqueGUID ,
                        LatencyInSeconds ,
                        AffiliateID ,
                        ClientID ,
                        TrackedExposureID ,
                        CreateDateUTC_TrackedExposure ,
                        ChannelID ,
                        ExposureTypeID ,
                        ExposureLocalizedCreateDate ,
                        PublisherID ,
                        CSKID ,
                        AdCategoryID ,
                        CampaignID ,
                        KeywordID ,
                        Steepness ,
                        ShiftFactor ,
                        CustomAttributionFactor ,
                        CustomAttributionSettingID ,
                        AttributionModelID ,
                        ClientAttributionProfileID ,
                        ActionWeightPct ,
                        SequenceOrder ,
                        COUNT(1) OVER ( PARTITION BY TrackedActionID ) AS ExposureCount ,
                        DenseTier ,
                        DensePriority ,
                        CASE WHEN ( MAX(DATEDIFF(ss,
                                                 CreateDateUTC_TrackedExposure,
                                                 CreateDateUTC_TrackedAction)) OVER ( PARTITION BY TrackedActionID ) ) = 0
                             THEN 1
                             ELSE MAX(DATEDIFF(ss,
                                               CreateDateUTC_TrackedExposure,
                                               CreateDateUTC_TrackedAction)) OVER ( PARTITION BY TrackedActionID )
                        END AS MaxLatency ,
                        OrigCurrencyID ,
                        ExposureSequenceID ,
                        CreativeID ,
                        GlobalTrackingTypeID ,
                        GlobalTrackingID ,
                        FirstExposureWeight ,
                        LastExposureWeight
               FROM     ClickStreamCTEPriority
             ),
        FinalClickStream
          AS ( SELECT   OrigClientID ,
                        TrackingSourceID_TrackedAction ,
                        TrackedActionID ,
                        CreateDateUTC_TrackedAction ,
                        LocalizedCreateDate_TrackedAction ,
                        CurrencyID ,
                        TransactionAmount ,
                        CustomerTransactionTypeID ,
                        TrackingSourceID ,
                        UserUniqueGUID ,
                        LatencyInSeconds ,
                        AffiliateId ,
                        ClientID ,
                        TrackedExposureID ,
                        CreateDateUTC_TrackedExposure ,
                        ChannelID ,
                        ExposureTypeID ,
                        ExposureLocalizedCreateDate ,
                        PublisherID ,
                        CSKID ,
                        AdCategoryID ,
                        CampaignID ,
                        KeywordID ,
                        Steepness ,
                        ShiftFactor ,
                        CustomAttributionFactor ,
                        CustomAttributionSettingID ,
                        AttributionModelID ,
                        ClientAttributionProfileID ,
                        ActionWeightPct ,
                        SequenceOrder ,
                        ExposureCount ,
                        DenseTier ,
                        DensePriority ,
                        MaxLatency ,
                        SUM(CASE WHEN AttributionModelID = 4
                                      AND MaxLatency <> 0
                                      AND CustomAttributionFactor > 1
                                 THEN POWER(1
                                            / CAST(CustomAttributionFactor AS FLOAT),
                                            LOG(LatencyInSeconds))
                                 WHEN AttributionModelID = 4
                                      AND MaxLatency <> 0
                                      AND CustomAttributionFactor < -1
                                 THEN POWER(ABS(CAST(CustomAttributionFactor AS FLOAT)),
                                            LOG(LatencyInSeconds))
                                 ELSE 1
                            END) OVER ( PARTITION BY TrackedActionID ) AS TotalClickStreamWeight ,
                        CASE WHEN CustomAttributionFactor > 1
                             THEN POWER(1
                                        / CAST(CustomAttributionFactor AS FLOAT),
                                        LOG(LatencyInSeconds))
                             WHEN CustomAttributionFactor < -1
                             THEN POWER(ABS(CAST(CustomAttributionFactor AS FLOAT)),
                                        LOG(LatencyInSeconds))
                        END AS TimeWeight ,
                        OrigCurrencyID ,
                        ExposureSequenceID ,
                        CreativeID ,
                        GlobalTrackingTypeID ,
                        GlobalTrackingID ,
                        FirstExposureWeight ,
                        LastExposureWeight
               FROM     ClickStreamCTE20
             ),
        TransactionTrackingCTE
          AS ( SELECT   AffiliateID ,
                        LocalizedCreateDate_TrackedAction AS EasternCreateDate ,
                        TransactionAmount ,
                        ActionWeightPct ,
                        CASE WHEN AttributionModelID IN ( 1, 2 ) THEN 1
                             WHEN AttributionModelID = 5
                             THEN dbo.ufn_UShape(SequenceOrder, ExposureCount,
                                                 Steepness, ShiftFactor)
                             WHEN AttributionModelID = 6
                             THEN dbo.ufn_UShape_Fixed(SequenceOrder,
                                                       ExposureCount,
                                                       FirstExposureWeight,
                                                       LastExposureWeight,
                                                       CONVERT(DECIMAL(15, 8), Steepness))  --06/12/13  ETC
                             WHEN AttributionModelID = 3
                             THEN 1.00 / ExposureCount
                             WHEN AttributionModelID = 4
                             THEN CASE WHEN CustomAttributionSettingID = 1
                                       THEN TimeWeight
                                            / TotalClickStreamWeight
                                       WHEN CustomAttributionSettingID = 2
                                       THEN dbo.fn_AttributionWeightFunnel(CustomAttributionFactor,
                                                              SequenceOrder,
                                                              ExposureCount)
                                  END
                        END AS ActionWeightFactor ,
                        CreateDateUTC_TrackedAction AS Createddate ,
                        CustomerTransactionTypeID ,
                        CreateDateUTC_TrackedExposure ,
                        LatencyInSeconds ,
                        UserUniqueGUID ,
                        ClientID ,
                        OrigClientID ,
                        NULL AS ReferenceID ,
                        TransactionAmount AS origTransactionAmt ,
                        ExposureLocalizedCreateDate ,
                        PublisherID ,
                        CurrencyId ,
                        OrigCurrencyId ,
                        ExposureTypeID ,
                        TrackedActionID ,
                        TrackedExposureID ,
                        TrackingSourceID ,
                        AttributionModelID ,
                        MaxLatency ,
                        SequenceOrder ,
                        ExposureCount ,
                        CustomAttributionFactor ,
                        CustomAttributionSettingID ,
                        TrackingSourceID_TrackedAction ,
                        TransactionAmount AS TransactionAmountUnweighted ,
                        ChannelID ,
                        CASE WHEN channelID = 3 THEN 1
                             ELSE 0
                        END AS PaidInclusion ,
                        CSKID ,
                        AdCategoryID ,
                        ExposureSequenceID ,
                        CampaignID ,
                        KeywordID ,
                        CreativeID ,
                        GlobalTrackingTypeID ,
                        GlobalTrackingID
               FROM     FinalClickStream cs
               WHERE    ( ( AttributionModelID = 1
                            AND SequenceOrder = ExposureCount
                          )
                          OR ( AttributionModelID = 2
                               AND SequenceOrder = 1
                             )
                          OR ( AttributionModelID IN ( 3, 4, 5, 6 ) )
                        )
             )
    SELECT  
		cte.ChannelID,
		COUNT(DISTINCT cte.TRackedActionID),
		SUM(cte.TransactionAmount) AS REvenue,
		SUM(cte.TransactionAmount * ISNULL(ExchangeRate, 1)* ActionWeightFactor * ActionWeightPct) AS TransactionAmount_Conv 
    
    --CASE WHEN cte.AffiliateID IS NULL THEN cte.EasternCreateDate
    --             ELSE DATEADD(hour, ISNULL(UTCHourDiff, 0), CreatedDate)
    --        END AS EasternCreateDate ,
    --        cte.cskid ,
    --        cte.TransactionAmount * ISNULL(ExchangeRate, 1)
    --        * ActionWeightFactor * ActionWeightPct AS TransactionAmount ,
    --        cte.CreatedDate ,
    --        ta.TransactionTypeID ,
    --        ta.MoreInfo ,
    --        [N1] ,
    --        [N2] ,
    --        [N3] ,
    --        [N4] ,
    --        [N5] ,
    --        [N6] ,
    --        [N7] ,
    --        [N8] ,
    --        [N9] ,
    --        [N10] ,
    --        [X1] ,
    --        [X2] ,
    --        [X3] ,
    --        [X4] ,
    --        [X5] ,
    --        [X6] ,
    --        [X7] ,
    --        [X8] ,
    --        [X9] ,
    --        [X10] ,
    --        cte.CustomerTransactionTypeID ,
    --        te.isContentMatch ,
    --        cte.ExposureLocalizedCreateDate AS ClickTime ,
    --        cte.LatencyInSeconds ,
    --        cte.UserUniqueGUID ,
    --        cte.ClientID ,
    --        cte.ReferenceID ,
    --        te.SEID ,
    --        te.NSEID ,
    --        cte.PublisherID ,
    --        te.CampaignKeywordID AS CKeywordID ,
    --        cte.AdCategoryID ,
    --        cte.CampaignID ,
    --        cte.OrigClientID ,
    --        ISNULL(CAST(cte.CreativeID AS NVARCHAR(100)),
    --               CAST(te.extrainfo1 AS NVARCHAR(100))) AS ExtraInfo1 ,
    --        cte.OrigTransactionAmt ,
    --        cte.CurrencyID ,
    --        cte.OrigCurrencyID ,
    --        ta.WebServerID ,
    --        ta.AccessServerID ,
    --        cte.TrackedActionID ,
    --        cte.TrackedExposureID ,
    --        cte.ChannelID ,
    --        cte.ActionWeightPct ,
    --        cte.ActionWeightFactor ,
    --        cte.ExposureCount AS AttributedExposures ,
    --        cte.SequenceOrder AS ExposureSequence ,
    --        cte.ActionWeightFactor * cte.ActionWeightPct AS ActionQuantity ,
    --        cte.KeywordID ,
    --        te.Keyword ,
    --        cte.ExposureTypeID ,
    --        cte.PaidInclusion ,
    --        USDExchangeRate ,
    --        cte.AffiliateID ,
    --        BINARY_CHECKSUM(cte.TrackedActionID, cte.TrackedExposureID,
    --                        cte.EasternCreateDate, cte.TransactionAmount,
    --                        cte.ActionWeightPct, cte.ActionWeightFactor,
    --                        cte.SequenceOrder, cte.ExposureCount) AS BinaryChecksum ,
    --        cte.ExposureSequenceID ,
    --        cte.GlobalTrackingTypeID ,
    --        cte.GlobalTrackingID ,
    --        te.DeviceTypeID ,
    --        te.DeviceModelID ,
    --        te.BrowserVersion AS ExposureBrowserVersion
    
    
    
    FROM    TransactionTrackingCTE AS cte
            LEFT JOIN TrackedExposure te WITH ( FORCESEEK ) ON cte.ClientID = te.ClientID
                                                              AND cte.TrackedExposureID = te.TrackedExposureID
            JOIN TrackedAction ta ON ta.trackedActionID = cte.TrackedActionID
                                     AND ta.CreateDateUTC > DATEADD(dd, -60,
                                                              GETDATE())
                                     AND ta.CreateDateUTC = cte.CreatedDate
            LEFT JOIN SIProcessing.dbo.CurrencyExchangeDataHistory ce ON cte.OrigCurrencyID <> cte.CurrencyID
                                                              AND ce.FromCurrencyID = cte.OrigCurrencyID
                                                              AND ce.ToCurrencyID = cte.CurrencyID
                                                              AND DATEDIFF(d,
                                                              ce.CreateDate,
                                                              cte.CreatedDate) = 0
            LEFT JOIN clients c ON c.clientid = cte.ClientID
            LEFT JOIN LUUTCTimeDiff lutd ON lutd.TimeZoneID = c.TimeZoneID
                                            AND lutd.DaylightSaving = c.DaylightSaving
                                            AND CreatedDate BETWEEN StartDateUTC AND EndDateUTC
                                            AND cte.AffiliateID IS NOT NULL

GROUP BY cte.ChannelID
ORDER BY cte.ChannelID

