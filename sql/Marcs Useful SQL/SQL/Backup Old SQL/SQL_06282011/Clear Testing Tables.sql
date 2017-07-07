TRUNCATE TABLE SIProcessing_Attribution..TrackedExposure_AttributionTesting

TRUNCATE TABLE SIProcessing_Attribution..TrackedExposureMaster_AttributionTesting

TRUNCATE TABLE SIProcessing_Attribution..TrackedAction_AttributionTesting

TRUNCATE TABLE SIProcessing_CacheHistory..TrackedCache_AttributionTesting

--Query for TA
SELECT * FROm SIProcessing_Attribution..TrackedAction_AttributionTesting


SELECT TrackedExposureID FROm SIProcessing_CacheHistory..TrackedCache
WHERE TrackedActionID IN (
SELECT TrackedActionID FROM TRackedAction with (nolock)
WHERE ClientID = 1637
AND CreateDateUTC >= ''
AND CreateDateUTC < '10/20/2011'
AND RecordStatus = 'A'
)