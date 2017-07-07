
DECLARE @Clients TABLE(
	ClientID INT PRIMARY KEY CLUSTERED
)

 ;WITH ClientsTree
 AS
 (
   SELECT c.ClientID,c.ParentClientID,
       0 AS Level
   FROM  SIProcessing..Clients AS c
   WHERE ClientID IN (2825)
	AND StatusFlag = 1
   UNION ALL
 -- Recursive
    SELECT c.ClientID,c.ParentClientID,
       LEVEL + 1
   FROM  SIProcessing..Clients AS c
   INNER JOIN ClientsTree AS d
       ON c.ParentClientID = d.clientID
       AND c.StatusFlag = 1
 )
INSERT INTO @Clients( ClientID )
SELECT ClientID
FROM ClientsTree 


DECLARE @SDate DATETIME = '05/24/2013 12:30:00.000',
	@EDate DATETIME = '05/24/2013 17:41:00.000',
	@compare INT = -7
	
SELECT @SDate AS StartDate,DATEADD(dd,@compare,@SDate) AS CompareTime_start,@EDate AS EndDate,DATEADD(dd,@compare,@EDate) AS CompareTime_End

DECLARE @t1 TABLE (
	UTCTime TIME,
	ClientID INT,
	Actions INT,
	PRIMARY KEY CLUSTERED (UTCTime,ClientID)
)

DECLARE @t2 TABLE (
	UTCTime TIME,
	ClientID INT,
	Actions INT,
	PRIMARY KEY CLUSTERED (UTCTime,ClientID)
)

INSERT INTO @t1 (UTCTime,ClientID,Actions)
SELECT CAST(CONVERT(VARCHAR(5),CreateDateUTC,108) AS TIME),ClientID, COUNT(1)
FROM SIProcessing_Attribution..TrackedAction ta
WHERE RecordStatus = 'A'
	AND CreateDateUTC >= @SDate
	AND CreateDateUTC < @EDate
	AND EXISTS (SELECT 1 FROM @Clients WHERE ClientID = ta.ClientID)
GROUP BY CAST(CONVERT(VARCHAR(5),CreateDateUTC,108) AS TIME),ClientID
	
INSERT INTO @t2 (UTCTime,ClientID,Actions)
SELECT CAST(CONVERT(VARCHAR(5),CreateDateUTC,108) AS TIME),ClientID, COUNT(1) AS Actions
FROM SIProcessing_Attribution..TrackedAction ta
WHERE RecordStatus = 'A'
	AND CreateDateUTC >= DATEADD(dd,@compare,@SDate)
	AND CreateDateUTC < DATEADD(dd,@compare,@EDate)
	AND EXISTS (SELECT 1 FROM @Clients WHERE ClientID = ta.ClientID)
GROUP BY CAST(CONVERT(VARCHAR(5),CreateDateUTC,108) AS TIME),ClientID
	
SELECT ISNULL(t1.UTCTime,t2.UTCTime) AS LocalTime,
	ISNULL(t1.ClientID,t2.ClientID) AS CLientID, 
	t1.Actions, 
	t2.Actions AS ActionCompare, 
	CASE WHEN t1.Actions IS NULL THEN 0 ELSE CAST((ABS(t1.Actions-ISNULL(t2.Actions*1.00,0))/t1.Actions)*100 AS FLOAT) END AS [%Diff]
FROM @t1 t1
FULL JOIN @t2 t2 ON t1.ClientID = t2.ClientID
	AND t1.UTCTime = t2.UTCTime
	AND t1.UTCTime < CAST(GETUTCDATE() AS TIME)
--WHERE CAST((ABS(t1.Actions-ISNULL(t2.Actions*1.00,0))/t1.Actions)*100 AS FLOAT) > 100
--	AND t2.ACtions > 0
ORDER BY ISNULL(t1.ClientID,t2.ClientID), ISNULL(t1.UTCTime,t2.UTCTime)

SELECT ISNULL(t1.UTCTime,t2.UTCTime) AS LocalTime,
	SUM(t1.Actions) AS Actions, 
	SUM(t2.Actions) AS ActionCompare
FROM @t1 t1
FULL JOIN @t2 t2 ON t1.ClientID = t2.ClientID
	AND t1.UTCTime = t2.UTCTime
GROUP BY ISNULL(t1.UTCTime,t2.UTCTime)

