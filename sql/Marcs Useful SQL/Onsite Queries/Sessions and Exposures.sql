

SELECT CAST(CreateDateUTC AS DATE) UTCDate,CampaignID, COUNT(1) 
FROM SIProcessing_Attribution..TrackedExposure
WHERE ChannelID = 1
	AND ClientID = 7904
	AND CreateDateUTC >= '01/15/2013'
	AND CreateDateUTC < '01/16/2013'
	AND TypedKeyword IS NOT NULL
GROUP BY CAST(CreateDateUTC AS DATE),CampaignID
ORDER BY CampaignID,CAST(CreateDateUTC AS DATE)


SELECT * 
FROM SIProcessing_Attribution..OnsiteSession
WHERE AdvertiserID = 164
	AND SessionStartTimeUTC >= '01/15/2013'
	AND SessionStartTimeUTC < '01/16/2013'

SELECT UserUniqueGuid,SessionStartTimeUTC
FROM SIProcessing_Attribution..OnsiteSessionHold
WHERE AdvertiserID = 164
	AND SessionStartTimeUTC >= '01/15/2013'
	AND SessionStartTimeUTC < '01/16/2013'
	AND UserUniqueGuid = 'BFEF58AB-0F60-47F2-A16A-744D0F403DFB'
GROUP BY UserUniqueGuid,SessionStartTimeUTC
ORDER BY UserUniqueGuid,SessionStartTimeUTC

SELECT DISTINCT AdvertiserID
FROM SIProcessing_CacheHistory..OnsiteSessionCache
WHERE ExposureClientID = 7904
	AND SessionStartTimeUTC >= '01/15/2013'
	AND SessionStartTimeUTC < '01/16/2013'
	AND LocalizedSessionStartTime >= '01/14/2013'
	AND LocalizedSessionStartTime < '01/17/2013'
GROUP BY ChannelID

SELECT CAST(SessionStartTimeUTC AS DATE) SEssionDate,CampaignID, COUNT(1)
FROM SIProcessing_CacheHistory..OnsiteSessionCache
WHERE ExposureClientID = 7904
	AND SessionStartTimeUTC >= '01/15/2013'
	AND SessionStartTimeUTC < '01/16/2013'
	AND LocalizedSessionStartTime >= '01/14/2013'
	AND LocalizedSessionStartTime < '01/17/2013'
	AND ChannelID = 1
GROUP BY CAST(SessionStartTimeUTC AS DATE),CampaignID
ORDER BY CampaignID,CAST(SessionStartTimeUTC AS DATE)

DECLARE @CampaignID INT = 386722



SELECT * 
FROM SIProcessing_Attribution..TrackedExposure
WHERE ChannelID = 1
	AND ClientID = 7904
	AND CreateDateUTC >= '01/15/2013'
	AND CreateDateUTC < '01/16/2013'
	AND CampaignID = @CampaignID
	
SELECT * 
FROM SIProcessing_Attribution..OnsiteSession os
WHERE ClientID = 7904
	AND SessionStartTimeUTC >= '01/15/2013'
	AND SessionStartTimeUTC < '01/16/2013'
	AND EXISTS(
		SELECT 1
		FROM SIProcessing_Attribution..TrackedExposure
		WHERE ChannelID = 1
			AND ClientID = 7904
			AND CreateDateUTC >= '01/15/2013'
			AND CreateDateUTC < '01/16/2013'
			AND CampaignID = @CampaignID
			AND os.UserUniqueGuid = CAST(UserUniqueGUID AS UNIQUEIDENTIFIER)
	)
	
	
/*	

DROP INDEX TMP_OnsiteSession ON SIProcessing_Attribution..OnsiteSession
 	
CREATE NONCLUSTERED INDEX TMP_OnsiteSession ON SIProcessing_Attribution..OnsiteSession(UserUniqueGuid) WHERE ClientID = 7904 AND SessionStartTimeUTC >= '01/15/2013' AND SessionStartTimeUTC < '01/16/2013'

*/

