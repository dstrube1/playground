


DECLARE @PNUM INT,
	@WPNUM INT,
	@D DATE = CAST(GETDATE() AS DATE),
	@WD DATE = CAST(DATEADD(dd,-7,GETDATE()) AS DATE)

SET @PNUM = SIProcessing_Attribution.$PARTITION.PF_SI_TrackedExposureMasterByDay_new(@D)                
SET @WPNUM = SIProcessing_Attribution.$PARTITION.PF_SI_TrackedExposureMasterByDay_new(@WD)

        DECLARE @DATE TABLE(
			RTime TIME,
			PRIMARY KEY CLUSTERED (RTime)
		)
		
		;WITH TIME_CTE AS(
				SELECT CAST('0:00' AS TIME) MinTime
				UNION ALL
				SELECT DATEADD(mi,1,MinTime)
				FROM TIME_CTE
				WHERE MinTime < '23:59'
			)
			INSERT INTO @DATE
			SELECT MinTime
			FROM TIME_CTE OPTION (MAXRECURSION 1440)

		
		RAISERROR('Time Table Built',0,1) WITH NOWAIT

IF OBJECT_ID('tempdb..#Current') IS NULL
BEGIN
--Drop Table #Current
	RAISERROR('Building Current Table',0,1) WITH NOWAIT
	
	CREATE TABLE #Current (
		CDate TIME,
		ClientID INT,
		RCOUNT INT
	)

	INSERT INTO #Current( CDate, ClientID, RCOUNT )
	SELECT CAST(CONVERT(VARCHAR(5), createdateutc, ( 8 ))  AS Time),ClientID, COUNT(1)
	FROM SIProcessing_Attribution..TrackedExposureMaster h
	WHERE SIProcessing_Attribution.$PARTITION.PF_SI_TrackedExposureMasterByDay_new(createdateutc) = @PNUM
	GROUP BY CAST(CONVERT(VARCHAR(5), createdateutc, ( 8 ))  AS Time),ClientID
	
	
	CREATE CLUSTERED INDEX IX_Current_CDate ON #Current (CDate,CLientID)
	
	RAISERROR('Current Table Built',0,1) WITH NOWAIT
	
END

IF OBJECT_ID('tempdb..#Week') IS NULL
BEGIN
--Drop Table #Week
	RAISERROR('Building Week Table',0,1) WITH NOWAIT
	
	CREATE TABLE #Week (
		CDate TIME,
		ClientID INT,
		RCOUNT INT
	)

	INSERT INTO #Week( CDate, ClientID, RCOUNT )
	SELECT CAST(CONVERT(VARCHAR(5), createdateutc, ( 8 ))  AS Time),ClientID, COUNT(1)
	FROM SIProcessing_Attribution..TrackedExposureMaster h
	WHERE SIProcessing_Attribution.$PARTITION.PF_SI_TrackedExposureMasterByDay_new(createdateutc) = @WPNUM
	GROUP BY CAST(CONVERT(VARCHAR(5), createdateutc, ( 8 ))  AS Time),ClientID
	
	CREATE CLUSTERED INDEX IX_Week_CDate ON #Week (CDate,CLientID)
	
	RAISERROR('Week Table Built',0,1) WITH NOWAIT
END


/*
		SELECT d.RTime, c.RCOUNT AS CurrentRecord, w.RCOUNT AS WeekAgoRecord, (ABS(c.RCOUNT-w.RCOUNT)/c.RCOUNT)*100 AS PercentDiff
		FROM @DATE d
		LEFT JOIN (SELECT CDate,CAST(SUM(RCOUNT) AS FLOAT) AS RCount FROM #Current GROUP BY CDate) c ON c.CDate = d.RTime
		LEFT JOIN (SELECT CDate,CAST(SUM(RCOUNT) AS FLOAT) AS RCount FROM #Week GROUP BY CDate) w ON w.CDate = d.RTime
		WHERE (ABS(c.RCOUNT-w.RCOUNT)/c.RCOUNT)*100 > 40
		ORDER BY d.RTime
*/

		SELECT d.RTime,cl.ClientID,cl.ClientName, c.RCOUNT AS CurrentRecord, w.RCOUNT AS WeekAgoRecord, (ABS(c.RCOUNT-w.RCOUNT)/c.RCOUNT)*100 AS PercentDiff
		FROM @DATE d
		CROSS JOIN (SELECT ClientID, ClientName FROM Clients) cl
		LEFT JOIN  #Current c ON c.CDate = d.RTime AND cl.ClientID = c.ClientID
		LEFT JOIN #Week  w ON w.CDate = d.RTime AND cl.ClientID = w.ClientID
		WHERE (ABS(c.RCOUNT-w.RCOUNT)/c.RCOUNT)*100 > 40
			AND c.RCOUNT > 10
		ORDER BY d.RTime
