
USE DBA

DECLARE @Date DATE = '10/25/2012'

exec SI_SP_TrackedActionCountsForWebserverID @Date = @Date--, @Read = 1

EXEC dbo.SI_SP_TrackingActionCounts_byWebserverRefresh @Date = @Date 


SELECT WebServerName, COUNT(1)
FROM SIProcessing_Staging..TransactionTrackingRaw
GROUP BY WebServerName

DECLARE @Date DATE = '10/24/2012'

SELECT ChannelID,CAST(ActionLocalizedCreateDate AS DATE) ,COUNT(1), COUNT(DISTINCT TrackedActionID), COUNT(DISTINCT TrackedExposureID)
FROM SIProcessing_CacheHistory..ExposureSequence
WHERE ActionClientID = 7293
AND ActionLocalizedCreateDate >= '10/20/2012'
AND ActionLocalizedCreateDate < '10/30/2012'
GROUP BY ChannelID,CAST(ActionLocalizedCreateDate AS DATE)
ORDER BY ChannelID,CAST(ActionLocalizedCreateDate AS DATE)



DECLARE @Date DATE = '10/23/2012'

SELECT CAST(ExposureCreateDateUTC AS DATE), COUNT(1) 
FROM SIProcessing_CacheHistory..ExposureSequence
WHERE ActionClientID = 7293
AND ActionLocalizedCreateDate >= @Date
AND ActionLocalizedCreateDate < DATEADD(dd,1,@Date)
GROUP BY CAST(ExposureCreateDateUTC AS DATE)
ORDER BY CAST(ExposureCreateDateUTC AS DATE)

