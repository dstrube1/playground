DECLARE @BeginDatelocalized DATETIME = '05/24/2012'  
     ,@EndDatelocalized DATETIME= '05/25/2012'  
     ,@AffiliateID INT = 10
     ,@ProfileSequence INT = 2  
/*
EXEC SI_SP_Transaction_TE4_FromExposureSEQ  
     @BeginDatelocalized = '05/24/2012'   
     ,@EndDatelocalized = '05/25/2012'   
     ,@AffiliateID  = 10 
     ,@ProfileSequence=2  
     ,@debug = 1
*/     

     
SELECT
    TrackedExposureID
    ,TrackedActionID
    ,ChannelID
    ,ExposureTypeID
    ,ExposureClientID
    ,ExposureCreateDateUTC
    ,PublisherID
    ,ExposureCurrencyID
    ,ActionCurrencyID
    ,ActionClientID
    ,ActionLocalizedCreateDate
    ,ActionCreateDateUTC
    ,UserUniqueGUID
    ,TransactionAmount
    ,TrackingSourceID
    ,CustomerTransactionTypeID
    ,AffiliateID
    ,caps.CustomAttributionSettingID
    ,CASE WHEN caps.AttributionModelID = 4 AND CAPS.CustomAttributionFactor =1 THEN 1 --First
       WHEN caps.AttributionModelID = 4 AND CAPS.CustomAttributionFactor =16 THEN 3 --Even
       WHEN caps.AttributionModelID = 4 AND CAPS.CustomAttributionFactor =31 THEN 2 --Last
      ELSE caps.AttributionModelID
      END AS AttributionModelID
    ,caps.ClientAttributionProfileID
    ,CASE WHEN caps.AttributionModelID = 4 AND caps.[CustomAttributionSettingID] = 2 THEN CustomAttributionFactorValue
      WHEN caps.AttributionModelID = 4 AND caps.[CustomAttributionSettingID] = 1 THEN [CustomAttributionFactorTimeValue]
      ELSE 0 END AS CustomAttributionFactor --CAPS.CustomAttributionFactor, --Need to finish this code to case based on type of sliding window
    ,CAPS.ClientAttributionProfileSettingID
    ,es.ExposureSequenceID
    ,es.ExposureLocalizedCreateDate
    ,es.CSKID
    ,es.AdCategoryID
    ,es.CampaignID
    ,es.KeywordID
    ,CAST (es.CreativeID AS BIGINT) AS CreativeID
    ,es.GlobalTrackingTypeID
    ,es.GlobalTrackingID
   FROM ExposureSequence es
    JOIN dbo.ClientAttributionProfileSetting AS caps
     ON es.ActionClientID = caps.ClientID
      AND es.ActionCreateDateUTC >= caps.EffectiveBeginDateUTC
      AND es.ActionCreateDateUTC < ISNULL(caps.EffectiveEndDateUTC, '9999-12-31')
    LEFT JOIN LUCustomAttributionFactor caf ON caf.CustomAttributionFactorId = CAPS.CustomAttributionFactor
   WHERE ActionLocalizedCreateDate BETWEEN @BeginDateLocalized AND @EndDateLocalized
    AND es.AffiliateID = @AffiliateID AND caps.ProfileSequence = @ProfileSequence
    
    
    