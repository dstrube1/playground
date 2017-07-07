--EXEC [SysAdmin].[SI_SP_TrackingReport_Client_Hourly]

	DECLARE	@startdate DATE,
			@enddate DATE,
			@StartTime DATETIME,
			@EndTime DATETIME,
			@ClientID INT
		
	
	SET @startdate = '09/09/2010'
	SET @enddate = '09/13/2010'		
	SET @ClientID = 2825
				
	SET @StartTime = @startdate
	SET @EndTime = DATEADD(hh,1,@StartTime)
				
	WHILE(@StartTime < @enddate)
	BEGIN			
				
	;WITH 
		Clients AS(
			SELECT ClientID FROM SIAnalysis.dbo.v_AgencyClient WHERE Agency = @ClientID
		),	
		Actions AS(	
			SELECT	@StartTime AS TIME,
				Count(*) as Actions
			FROM	SIProcessing_Attribution.dbo.TrackedAction ta
				INNER JOIN Clients c ON c.ClientID = ta.ClientID
			WHERE	LocalizedCreateDate >= @StartTime
					AND	LocalizedCreateDate < @EndTime
		),
		
		
		Exposures AS(			
			SELECT @StartTime AS TIME,
					SUM(CASE ChannelID when 1 then 1 ELSE 0 END)  as Clicks,
					SUM(CASE ChannelID WHEN 2 THEN 1 ELSE 0 END) AS NatClicks,
					SUM(CASE ChannelID WHEN 3 THEN 1 ELSE 0 END) AS PIClicks
			from	SIProcessing_Attribution.dbo.TrackedExposure te
				INNER JOIN Clients c ON c.ClientID = te.ClientID
			WHERE	LocalizedCreateDate >= @StartTime
					AND	LocalizedCreateDate < @EndTime
					AND ExposureTypeID < 4		
		),
		ActionsLW AS(	
			SELECT DATEADD(day, -7, @StartTime) AS TIME,
				Count(*) as ActionsLW
			from	SIProcessing_Attribution.dbo.TrackedAction ta
				INNER JOIN Clients c ON c.ClientID = ta.ClientID
			WHERE	LocalizedCreateDate >= DATEADD(day, -7, @StartTime)
					AND LocalizedCreateDate < DATEADD(day, -7, @EndTime)
		),
		ExposuresLW AS(	
			SELECT DATEADD(day, -7, @StartTime) AS TIME,
					SUM(CASE ChannelID when 1 then 1 ELSE 0 END)  as ClicksLW,
					SUM(CASE ChannelID WHEN 2 THEN 1 ELSE 0 END) AS NatClicksLW,
					SUM(CASE ChannelID WHEN 3 THEN 1 ELSE 0 END) AS PIClicksLW
			from	SIProcessing_Attribution.dbo.TrackedExposure te
				INNER JOIN Clients c ON c.ClientID = te.ClientID
			WHERE	LocalizedCreateDate >=DATEADD(day, -7, @StartTime)
					AND LocalizedCreateDate < DATEADD(day, -7, @EndTime)
					AND ExposureTypeID < 4
		),
		ActionsLW2 AS(	
			SELECT DATEADD(day, -14, @StartTime) AS TIME,
				Count(*) as ActionsLW2
			from	SIProcessing_Attribution.dbo.TrackedAction ta
				INNER JOIN Clients c ON c.ClientID = ta.ClientID
			WHERE	LocalizedCreateDate >= DATEADD(day, -14, @StartTime)
					AND LocalizedCreateDate < DATEADD(day, -14, @EndTime)
		),
		ExposuresLW2 AS(	
			SELECT DATEADD(day, -14, @StartTime) AS TIME,
					SUM(CASE ChannelID when 1 then 1 ELSE 0 END)  as ClicksLW2,
					SUM(CASE ChannelID WHEN 2 THEN 1 ELSE 0 END) AS NatClicksLW2,
					SUM(CASE ChannelID WHEN 3 THEN 1 ELSE 0 END) AS PIClicksLW2
			from	SIProcessing_Attribution.dbo.TrackedExposure te
				INNER JOIN Clients c ON c.ClientID = te.ClientID
			WHERE	LocalizedCreateDate >=DATEADD(day, -14, @StartTime)
					AND LocalizedCreateDate < DATEADD(day, -14, @EndTime)
					AND ExposureTypeID < 4
		),
		ActionsLW3 AS(	
			SELECT DATEADD(day, -21, @StartTime) AS TIME,
				Count(*) as ActionsLW3
			from	SIProcessing_Attribution.dbo.TrackedAction ta 
				INNER JOIN Clients c ON c.ClientID = ta.ClientID
			WHERE	LocalizedCreateDate >= DATEADD(day, -21, @StartTime)
					AND LocalizedCreateDate < DATEADD(day, -21, @EndTime)
		),
		ExposuresLW3 AS(	
			SELECT DATEADD(day, -21, @StartTime) AS TIME,
					SUM(CASE ChannelID when 1 then 1 ELSE 0 END)  as ClicksLW3,
					SUM(CASE ChannelID WHEN 2 THEN 1 ELSE 0 END) AS NatClicksLW3,
					SUM(CASE ChannelID WHEN 3 THEN 1 ELSE 0 END) AS PIClicksLW3
			from	SIProcessing_Attribution.dbo.TrackedExposure te
				INNER JOIN Clients c ON c.ClientID = te.ClientID
			WHERE	LocalizedCreateDate >=DATEADD(day, -21, @StartTime)
					AND LocalizedCreateDate < DATEADD(day, -21, @EndTime)
					AND ExposureTypeID < 4
		)
			SELECT	Actions.[TIME],
					ISNULL(Actions,0) AS Actions, 
					ISNULL(ActionsLW,0)AS ActionsLW,
					ISNULL(ActionsLW2,0)AS ActionsLW2,
					ISNULL(ActionsLW3,0)AS ActionsLW3,
					ISNULL(ActionsLW+ActionsLW2+ActionsLW3,0)/3 AS ActionsAVG,
					CASE WHEN ISNULL(ActionsLW+ActionsLW2+ActionsLW3,0) = 0 THEN 0 ELSE (((ActionsLW+ActionsLW2+ActionsLW3)/3) - Actions)/((ActionsLW+ActionsLW2+ActionsLW3)/3)/**100 */END AS ActionsPercentDiff,
					ISNULL(Clicks, 0) AS Clicks, 
					ISNULL(ClicksLW,0) AS ClicksLW,
					ISNULL(ClicksLW2,0) AS ClicksLW2,
					ISNULL(ClicksLW3,0)AS ClicksLW3,
					ISNULL(ClicksLW+ClicksLW2+ClicksLW3,0)/3 AS ClicksAVG,
					CASE WHEN ISNULL(ClicksLW+ClicksLW2+ClicksLW3,0) = 0 THEN 0 ELSE ABS(ISNULL(Clicks,0)-ISNULL(ClicksLW+ClicksLW2+ClicksLW3,0)/3)/(ISNULL(ClicksLW+ClicksLW2+ClicksLW3,0)/3)*100 END AS ClicksPercentDiff,
					ISNULL(NatClicks,0) AS NatClicks,
					ISNULL(NatClicksLW,0)AS NatClicksLW,
					ISNULL(NatClicksLW2,0) AS NatClicksLW2,
					ISNULL(NatClicksLW3,0) AS NatClicksLW3,
					ISNULL(NatClicksLW+NatClicksLW2+NatClicksLW3,0)/3 AS NatClicksAVG,
					CASE WHEN ISNULL(NatClicksLW+NatClicksLW2+NatClicksLW3,0) = 0 THEN 0 ELSE ABS(ISNULL(NatClicks,0)-ISNULL(NatClicksLW+NatClicksLW2+NatClicksLW3,0)/3)/(ISNULL(NatClicksLW+NatClicksLW2+NatClicksLW3,0)/3)*100 END AS NatClicksPercentDiff,
					ISNULL(PICLicks,0) AS PICLicks, 
					ISNULL(PICLicksLW,0) AS PICLicksLW,
					ISNULL(PIClicksLW2,0) AS PICLicksLW2,
					ISNULL(PIClicksLW3,0) AS PICLicksLW3,
					ISNULL(PICLicksLW+PIClicksLW2+PIClicksLW3,0)/3 AS PICLicksAVG,
					CASE WHEN ISNULL(PICLicksLW+PIClicksLW2+PIClicksLW3,0) = 0 THEN 0 ELSE ABS(ISNULL(PICLicks,0)-ISNULL(PICLicksLW+PIClicksLW2+PIClicksLW3,0)/3)/(ISNULL(PICLicksLW+PIClicksLW2+PIClicksLW3,0)/3)*100 END AS PIClicksPercentDiff
			FROM	Actions 
				LEFT JOIN Exposures ON Exposures.[TIME] = Actions.[TIME]
				LEFT JOIN ActionsLW ON DATEADD(DAY,7,ActionsLW.[TIME]) = Actions.[TIME]
				LEFT JOIN ExposuresLW ON DATEADD(DAY,7,ExposuresLW.[TIME]) =  Actions.[TIME]
				LEFT JOIN ActionsLW2 ON DATEADD(DAY,14,ActionsLW2.[TIME]) = Actions.[TIME]
				LEFT JOIN ExposuresLW2 ON DATEADD(DAY,14,ExposuresLW2.[TIME])  = Actions.[TIME]
				LEFT JOIN ActionsLW3 ON DATEADD(DAY,21,ActionsLW3.[TIME]) = Actions.[TIME]
				LEFT JOIN ExposuresLW3 ON DATEADD(DAY,21,ExposuresLW3.[TIME]) = Actions.[TIME]
			ORDER BY Actions.[TIME]
			
			SET @StartTime = @EndTime
			SET @EndTime = DATEADD(hh,1,@StartTime)
	END