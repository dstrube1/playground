--TE not in TEM
DECLARE @ClientID INT, 
@num INT 

DECLARE @table TABLE( 
ClientID INT, 
Row_Count INT 
) 

DECLARE client_cursor CURSOR FAST_FORWARD FOR 
SELECT DISTINCT ClientID FROM SIProcessing..External_AdvertiserClient_Mapping WHERE ExternalSourceID = 1 ANd StatusFlag = 1 

OPEN client_cursor 
FETCH NEXT FROM client_cursor INTO @ClientID 

WHILE @@FETCH_STATUS = 0 
BEGIN 

INSERT INTO @table(ClientID,Row_Count) 
SELECT @ClientID,COUNT(1) 
FROM SIProcessing_Attribution..TrackedExposure te 
LEFT JOIN SIProcessing_Attribution..TrackedExposureMaster tem ON te.CreateDateUTC = tem.CreateDateUTC 
AND te.ExposureTypeID = tem.ExposureTypeID 
AND te.ClientID = tem.ClientID 
AND te.UserUniqueGUID = te.UserUniqueGUID 
AND te.TrackedExposureID = tem.TrackedExposureID 
AND tem.TrackingSourceID = 3 
WHERE te.ClientID = @clientID 
AND te.ChannelID = 4 
AND tem.TrackedExposureID Is NULL 

FETCH NEXT FROM client_cursor INTO @ClientID 
PRINT (@clientID); 
RAISERROR ('Batch Complete', 0, 1) WITH NOWAIT	
  
END 

CLOSE client_cursor 
DEALLOCATE client_cursor 

DELETE FROM @table 
WHERE Row_Count = 0 

SELECT * FROM @table 

DECLARE run_cursor CURSOR FAST_FORWARD FOR 
SELECT ClientID,Row_Count FROM @table 

OPEN run_cursor 
FETCH NEXT FROM run_cursor INTO @ClientID, @num 

WHILE @@FETCH_STATUS = 0 
BEGIN 

WHILE (@num>0) 
BEGIN 

PRINT (@clientID); 
PRINT (@num); 

DELETE TOP(5000) FROM te 
FROM SIProcessing_Attribution..TrackedExposure te 
LEFT JOIN SIProcessing_Attribution..TrackedExposureMaster tem ON te.CreateDateUTC = tem.CreateDateUTC 
AND te.ExposureTypeID = tem.ExposureTypeID 
AND te.ClientID = tem.ClientID 
AND te.UserUniqueGUID = te.UserUniqueGUID 
AND te.TrackedExposureID = tem.TrackedExposureID 
AND tem.TrackingSourceID = 3 
WHERE te.ClientID = @clientID 
AND te.ChannelID = 4 
AND tem.TrackedExposureID Is NULL 

SELECT @num-=5000 

RAISERROR ('Batch Complete', 0, 1) WITH NOWAIT 
END	

FETCH NEXT FROM run_cursor INTO @ClientID, @num 

END 
  

CLOSE run_cursor 
DEALLOCATE run_cursor