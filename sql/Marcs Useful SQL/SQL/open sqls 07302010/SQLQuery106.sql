/*
Procedure compares SIOLAP..RPT Tables and TrackedCache, and returns the date, clientid, channel, and counts where data doesn't match.
Loops through all active clients and Channels. To see code bein ran, set @debug = 1.

07/14/2010 - MRS Initial

SELECT * FROM JunkDB..RPT_Cache_Comparision
*/
Declare @StartDate DATETIME = '2010-01-01',
		@EndDate DATETIME = '2010-07-27',
		@ClientID INT = NULL,
		@PickupWhereLeftOff BIT = 0,
		@RunStart DATETIME,
		@RunEnd DATETIME,
		@ChannelID TINYINT,
		@sqltext varchar(MAX),
		@ClientsLeft INT,
		@debug BIT=0

IF (@PickupWhereLeftOff IS NULL OR @PickupWhereLeftOff = 0) AND @debug = 0
BEGIN		
	IF EXISTS (SELECT * FROM JunkDB.sys.objects WHERE object_id = OBJECT_ID(N'JunkDB..RPT_Cache_Comparision') AND type in (N'U'))
		DROP TABLE JunkDB..RPT_Cache_Comparision
		
	CREATE TABLE JunkDB..RPT_Cache_Comparision (
		ClientID INT,
		ChannelID TINYINT,
		GenerateDate DATETIME,
		RPT_COUNT INT,
		Cache_Count INT,
		Percent_Error FLOAT 
)		
END

IF @ClientID IS NULL OR ( @ClientID IS NOT NULL AND @PickupWhereLeftOff = 1)
BEGIN	
	DECLARE client_cursor CURSOR FOR  
		SELECT ClientID FROM SearchIgnite..Clients 
		WHERE StatusFlag = 1 AND ClientID >= ISNULL(@ClientID,0)
		ORDER BY ClientID

	OPEN client_cursor   
	FETCH NEXT FROM client_cursor INTO @ClientID   

	WHILE @@FETCH_STATUS = 0   
	BEGIN   		
		
		SET @RunStart = @StartDate
		SET @RunEnd = DATEADD(dd,1,@StartDate)
		WHILE (@RunStart < @EndDate)
		BEGIN
					
		SET @ChannelID = 1	
			
			WHILE(@ChannelID <= 4)	
			BEGIN
				SET @sqltext = '
				WITH RPT AS(
					SELECT GenerateDate
					, SUM('
					+(CASE WHEN @ChannelID = 4 THEN 'TransactionCount' ELSE 'TTCount' END)
					+') AS Count
					FROM '
					+ CASE WHEN @ChannelID = 1 THEN 'SIOLAP..RPT_PS_Summary_CustomerTT'
					WHEN @ChannelID = 2 THEN 'SIOLAP..RPT_NS_Summary_CustomerTT'
					WHEN @ChannelID = 3 THEN 'SIOLAP..RPT_PI_Summary_CustomerTT'
					ELSE 'SIOLAP..RPT_UM_Summary_CustomerTT_ClientLevel'
					 END +
					
					' WITH (NOLOCK) 
					WHERE ClientID = '+CAST(@ClientID AS VARCHAR)+' 
					AND GenerateDate >=  '''+CONVERT(VARCHAR,@RunStart,120)+'''
					AND GenerateDate <  '''+CONVERT(VARCHAR,@RunEnd,120)+'''
					GROUP BY GenerateDate
				), Cache AS(
					SELECT 
					CAST(EasternCreateDate As Date) As EasternDate 
					, ROUND(SUM(ActionWeightFactor * ActionWeightPct),2) AS Count
					FROM SIProcessing_CacheHistory..TrackedCache WITH (NOLOCK)
					WHERE ClientID = '+CAST(@ClientID AS VARCHAR)+'
					AND ChannelID = '+CAST(@ChannelID AS VARCHAR)+' 
					AND EasternCreateDate >= '''+CONVERT(VARCHAR,@RunStart,120)+'''
					AND EasternCreateDate < '''+CONVERT(VARCHAR,@RunEnd,120)+'''
					GROUP BY CAST(EasternCreateDate As Date) 
				)

				Select '+CAST(@ClientID AS Varchar)+' AS ClientID, '+CAST(@ChannelID AS Varchar)+' AS ChannelID,r.GenerateDate,ISNULL(r.Count,0) AS RPT_Count,ISNULL(c.Count,0) AS Cache_Count,(CASE WHEN (ISNULL(r.Count,0) = 0 AND ISNULL(c.Count,0) = 0) THEN 0 WHEN (ISNULL(r.Count,0) = 0 AND ISNULL(c.Count,0) > 0) THEN 100 ELSE (100*ABS(r.Count-ISNULL(c.Count,0))/r.Count) END) AS ''%error''from RPT r
					left join Cache c ON c.EasternDate = r.GenerateDate
				WHERE (CASE WHEN (ISNULL(r.Count,0) = 0 AND ISNULL(c.Count,0) = 0) THEN 0 WHEN (ISNULL(r.Count,0) = 0 AND ISNULL(c.Count,0) > 0) THEN 100 ELSE (100*ABS(r.Count-ISNULL(c.Count,0))/r.Count) END) > 0 AND ABS(ISNULL(r.Count,0) - ISNULL(c.Count,0)) > 1
				ORDER BY 1,2,3'

				IF @debug = 1
					Print (@sqltext)
				ELSE	
				BEGIN
					SET @ClientsLeft = (SELECT COUNT(1) FROM SearchIgnite..Clients WITH (NOLOCK) WHERE StatusFlag = 1 AND ClientID > @ClientID)
					PRINT(CAST(@ClientID AS Varchar)+ ', ' + CAST(@ChannelID AS Varchar) + ', '+CONVERT(VARCHAR,@RunStart,102)+ ', '+CONVERT(VARCHAR,@RunEnd,102)+ ', '+ CAST(@ClientsLeft AS Varchar))
					INSERT INTO JunkDB..RPT_Cache_Comparision
						EXEC(@sqltext)	
				END
					
				SET @ChannelID = @ChannelID +1	
			END
			SET @RunStart = @RunEnd
			SET @RunEnd = DATEADD(dd,1,@RunStart)
		END
			
		FETCH NEXT FROM client_cursor INTO @ClientID   
	END   

	CLOSE client_cursor   
	DEALLOCATE client_cursor
END	

ELSE 
BEGIN

	SET @RunStart = @StartDate
	SET @RunEnd = DATEADD(dd,1,@RunStart)
		
	WHILE (@RunStart < @EndDate)
	BEGIN

	SET @ChannelID = 1	
			
	WHILE(@ChannelID <= 4)	
	BEGIN
		SET @sqltext = '
		WITH RPT AS(
			SELECT GenerateDate
			, SUM('
			+CASE WHEN @ChannelID = 4 THEN 'TransactionCount' ELSE 'TTCount' END
			+') AS Count
			FROM '
			+ CASE WHEN @ChannelID = 1 THEN 'SIOLAP..RPT_PS_Summary_CustomerTT'
			WHEN @ChannelID = 2 THEN 'SIOLAP..RPT_NS_Summary_CustomerTT'
			WHEN @ChannelID = 3 THEN 'SIOLAP..RPT_PI_Summary_CustomerTT'
			ELSE 'SIOLAP..RPT_UM_Summary_CustomerTT_ClientLevel'
			 END +
			
			' WITH (NOLOCK) 
			WHERE ClientID = '+CAST(@ClientID AS VARCHAR)+' 
			AND GenerateDate >=  '''+CONVERT(VARCHAR,@RunStart,120)+'''
			AND GenerateDate <  '''+CONVERT(VARCHAR,@RunEnd,120)+'''
			GROUP BY GenerateDate
		), Cache AS(
			SELECT 
			CAST(EasternCreateDate As Date) As EasternDate 
			, ROUND(SUM(ActionWeightFactor * ActionWeightPct),2) AS Count
			FROM SIProcessing_CacheHistory..TrackedCache WITH (NOLOCK)
			WHERE ClientID = '+CAST(@ClientID AS VARCHAR)+'
			AND ChannelID = '+CAST(@ChannelID AS VARCHAR)+' 
			AND EasternCreateDate >= '''+CONVERT(VARCHAR,@RunStart,120)+'''
			AND EasternCreateDate < '''+CONVERT(VARCHAR,@RunEnd,120)+'''
			GROUP BY CAST(EasternCreateDate As Date) 
		)

		Select '+CAST(@ClientID AS Varchar)+' AS ClientID, '+CAST(@ChannelID AS Varchar)+' AS ChannelID,r.GenerateDate,ISNULL(r.Count,0) AS RPT_Count,ISNULL(c.Count,0) AS Cache_Count,(CASE WHEN (ISNULL(r.Count,0) = 0 AND ISNULL(c.Count,0) = 0) THEN 0 WHEN (ISNULL(r.Count,0) = 0 AND ISNULL(c.Count,0) > 0) THEN 100 ELSE (100*ABS(r.Count-ISNULL(c.Count,0))/r.Count) END) AS ''%error''from RPT r
			left join Cache c ON c.EasternDate = r.GenerateDate
		WHERE (CASE WHEN (ISNULL(r.Count,0) = 0 AND ISNULL(c.Count,0) = 0) THEN 0 WHEN (ISNULL(r.Count,0) = 0 AND ISNULL(c.Count,0) > 0) THEN 100 ELSE (100*ABS(r.Count-ISNULL(c.Count,0))/r.Count) END) > 0 AND ABS(ISNULL(r.Count,0) - ISNULL(c.Count,0)) > 1
		ORDER BY 1,2,3'

		IF @debug = 1
			Print (@sqltext)
		ELSE
		BEGIN
			SET @ClientsLeft = (SELECT COUNT(1) FROM SearchIgnite..Clients WITH (NOLOCK) WHERE StatusFlag = 1 AND ClientID > @ClientID)
			PRINT(CAST(@ClientID AS Varchar)+ ', ' + CAST(@ChannelID AS Varchar) + ', '+CONVERT(VARCHAR,@RunStart,102)+ ', '+CONVERT(VARCHAR,@RunEnd,102)+ ', '+ CAST(@ClientsLeft AS Varchar))
			INSERT INTO JunkDB..RPT_Cache_Comparision
				EXEC(@sqltext)	
		END
			
		SET @ChannelID = @ChannelID +1	
	END
	
	SET @RunStart = @RunEnd
	SET @RunEnd = DATEADD(dd,1,@RunStart)
	END
	
END

IF @debug = 0	
	SELECT * from JunkDB..RPT_Cache_Comparision