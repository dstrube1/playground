
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'JunkDB..MergedActions20111116') AND type in (N'U'))
DROP TABLE JunkDB..MergedActions20111116
GO

SELECT TrackedActionID_PREV
INTO JunkDB..MergedActions20111116
FROM SIProcessing_Attribution..TrackedAction
WHERE CreateDateUTC >= '10/01/2011'
AND CreateDateUTC < '11/16/2011'
AND TrackedActionID_PREV IS NOT NULL

CREATE CLUSTERED INDEX IDX_MergedActions20111116_TrackedActionID_PREV ON MergedActions20111116(TrackedActionID_PREV)

--SELECT * FROM JunkDB..MergedActions20111116

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'JunkDB..InactiveActions20111116') AND type in (N'U'))
DROP TABLE JunkDB..InactiveActions20111116
GO


SELECT TrackedActionID,CreateDateUTC,UserUniqueGUID,ClientID,CustomerTransactionTypeID,MoreInfo,TrackedActionID_PREV,HashKey,TrackingSourceID
INTO JunkDB..InactiveActions20111116
FROM SIProcessing_Attribution..TrackedAction
WHERE CreateDateUTC >= '10/01/2011'
AND CreateDateUTC < '11/16/2011'
AND RecordStatus = 'I' 


CREATE CLUSTERED INDEX IDX_InactiveActions20111116_TrackedActionID ON InactiveActions20111116(TrackedActionID)


SELECT CAST(CreateDateUTC AS DATE), c.ClientID,c.ClientName,trackingSourceID, COUNT(1) 
FROM JunkDB..InactiveActions20111116	ia 
JOIN SIProcessing..Clients c ON c.ClientID= ia.ClientID
WHERE TrackedActionID NOT IN (SELECT TrackedActionID_PREV FROM JunkDB..MergedActions20111116)
	AND TrackingSourceID = 1
	--AND ClientID = 2537
GROUP BY c.ClientID,c.ClientName,CAST(CreateDateUTC AS DATE), trackingSourceID
ORDER BY c.ClientID,c.ClientName,CAST(CreateDateUTC AS DATE), trackingSourceID

SELECT *  
FROM JunkDB..InactiveActions20111116
WHERE TrackedActionID NOT IN (SELECT TrackedActionID_PREV FROM JunkDB..MergedActions20111116)
AND TrackingSourceID = 1
--AND ClientID = 2537
AND CreateDateUTC >= '10/04/2011'
AND CreateDateUTC < '10/06/2011'

