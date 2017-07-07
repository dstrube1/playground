
SET NOCOUNT ON

DECLARE @ManThreshold INT= 250000,
	@AvgThreshold INT,
	@NumPartitions INT = 500


DECLARE @PNUM INT,
	@ClientID INT,
	@Rcount INT
/**/
IF OBJECT_ID('tempdb..#Clients') IS NOT NULL
DROP TABLE #Clients

CREATE TABLE #Clients (
	ClientID INt,
	PNum INt,
	RCount INT,
	StatusFlag BIT,
	Recommended_PNum INT
)

INSERT INTO #Clients( ClientID, PNum, RCount, StatusFlag,Recommended_PNum )
SELECT ClientID,SIProcessing_Attribution.$PARTITION.PF_SI_ExposureClientID(ClientID),0,0,0
FROM SIProcessing..Clients

WHILE EXISTS(SELECT TOP 1 1 FROM #Clients WHERE StatusFlag = 0)
BEGIN

	SELECT TOP 1 @ClientID = ClientID, @PNUM  = PNum
	FROM #Clients
	WHERE StatusFlag = 0
	
	RAISERROR('Partition %d Client %d starting',0,1, @Pnum, @ClientID) WITH NOWAIT

	SELECT @RCount = COUNT(1)
	FROM SIProcessing_Attribution..TrackedExposure WITH (NOLOCK)
	WHERE SIProcessing_Attribution.$PARTITION.PF_SI_ExposureClientID(ClientID) = @Pnum
		AND ClientID = @ClientID
		
	WAITFOR DELAY'00:00:00.500'	

	UPDATE #Clients
	SET StatusFlag = 1,
		RCount = @Rcount
	WHERE ClientID = @ClientID

END

IF @ManThreshold IS NULL
	SELECT @AvgThreshold = SUM(RCount)/@NumPartitions
	FROM #Clients
ELSE 
	SET @AvgThreshold = @ManThreshold

--Reset Locals
UPDATE #Clients
SET StatusFlag = 0

SET @PNUM = 1
SET	@RCount =0

WHILE EXISTS(SELECT TOP 1 1 FROM #Clients WHERE StatusFlag = 0)
BEGIN

	SELECT TOP 1 @ClientID =ClientID
	FROM #Clients
	WHERE StatusFlag = 0
	ORDER BY ClientID
	
	SELECT @Rcount+= RCount
	FROM #Clients
	WHERE ClientID = @ClientID
	
	UPDATE #Clients
	SET StatusFlag = 1,
		Recommended_PNum = @PNUM
	WHERE ClientID = @ClientID
	
	IF @Rcount > @AvgThreshold
	BEGIN
		SET @PNUM += 1
		SET @Rcount = 0
	END
	
END

SELECT * 
FROM #Clients
WHERE RCount > 0

SELECT PNum, SUM(RCount) 
FROM #Clients
GROUP BY PNum
ORDER BY PNum

SELECT Recommended_PNum, SUM(RCount) 
FROM #Clients
GROUP BY Recommended_PNum
ORDER BY Recommended_PNum

