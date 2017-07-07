DECLARE @SwapSQL VARCHAR(1000),
	@FunctionSQL VARCHAR(1000),
	@SQLCOMMAND VARCHAR(200),
	@Current_partition INT,
	@debug BIT = 1
/*		
LURepartition Status
 0 Not Processed
 1 Swapped out of TrackedExposure
 2 Altering TrackedExposure Partition Function
 3 ReInsert Recording into TrackedExposure
 4 Altering TrackedExposure_swap Partition Function
 5 Complete
 99 Count on TrackedExposure did not match
	
JUNKDB..RePartition
Partition_Number INT
RowCount INT
ClientID INT
Client
Client_Row_Count INT
Is_Merge BIT
Is_Split BIT
SQLCOMMAND VARCHAR(200)
RePartition_Status TINYINT
LastUpdateDate DATETIME
*/	
CREATE TABLE JunkDB..RePartition(	

-- Split 
WHILE EXISTS (SELECT * FROM JUNKDB..RePartition WHERE Is_Split = 1 ANd RePartition_Status <> 5) OR EXISTS (SELECT * FROM JUNKDB..RePartition WHERE Is_Split = 1 ANd RePartition_Status <> 99)
BEGIN
	  	
	SELECT TOP 1 @Current_partition = Partition_Number FROM JUNKDB..RePartition WHERE Is_Split = 1 ANd RePartition_Status <> 5 order by Partition_Number Desc
	
	--Swap out of Tracked Exposure
	WHILE EXISTS(SELECT * FROM JUNKDB..RePartition WHERE Partition_Number = @Current_partition AND RePartition_Status = 0)
	BEGIN
		SET @SwapSQL = 'ALTER TABLE SIProcessing_Attribution..TrackedExposure SWITCH PARTITION ' + CONVERT(varchar(4),@Current_Partition) +' TO SIProcessing_Attribution..TrackedExposure_swap' + CONVERT(varchar(4),@Current_Partition)
		
		IF @debug = 1
			PRINT (@SwapSQl)
		ELSE 
			EXEC (@SwapSQL)
		
		UPDATE 	JUNKDB..RePartition
			SET RePartition_Status = 1,
				LastUpdateDate	= GETDATE()
		WHERE 	Partition_Number = @Current_partition
		
	END 	
	--Fix Partition in TrackedExposure
	WHILE EXISTS(SELECT * FROM JUNKDB..RePartition WHERE Partition_Number = @Current_partition AND RePartition_Status = 1) 
	BEGIN
		SELECT TOP 1 @SQLCOMMAND = SQLCOMMAND FROM JUNKDB..RePartition WHERE Partition_Number = @Current_partition AND RePartition_Status = 1
		
		SET @FunctionSQL = 'ALTER PARTITION FUNCTION PF_SI_ExposureClientID ()' + @SQLCOMMAND + '
		ALTER PARTITION SCHEME PS_SI_ExposureClientID NEXT USED [PRIMARY]' --Different on Prod
		
		IF @debug = 1
			PRINT (@FunctionSQL)
		ELSE 
			EXEC (@FunctionSQL)
			
		UPDATE 	JUNKDB..RePartition
			SET RePartition_Status = 2,
				LastUpdateDate	= GETDATE()
		WHERE 	Partition_Number = @Current_partition 
			AND SQLCOMMAND = @SQLCOMMAND 
		
	END
	
	--Insert records back in were date < 120 days 
	WHILE EXISTS(SELECT * FROM JUNKDB..RePartition WHERE RePartition_Status = 2)
	BEGIN
		IF @debug = 1
		PRINT ( 'INSERT INTO SIProcessing_Attribution..TrackedExposure
			SELECT * FROM SIProcessing_Attribution..TrackedExposure_swap
			WHERE  DATEDIFF(dd,CreateDateUTC,GETDATE()) < 120')
		ELSE 
			INSERT INTO SIProcessing_Attribution..TrackedExposure
			SELECT * FROM SIProcessing_Attribution..TrackedExposure_swap
			WHERE  DATEDIFF(dd,CreateDateUTC,GETDATE()) < 120	
		
		UPDATE 	JUNKDB..RePartition
			SET RePartition_Status = 3,
				LastUpdateDate	= GETDATE()
		WHERE 	RePartition_Status = 2	
			
	END
	
	--Truncate Swap table
	WHILE EXISTS(SELECT * FROM JUNKDB..RePartition WHERE RePartition_Status = 3)
	BEGIN
		IF @debug = 1
			PRINT('TRUNCATE TABLE SIProcessing_Attribution..TrackedExposure_swap')
		ELSE	
			TRUNCATE TABLE SIProcessing_Attribution..TrackedExposure_swap
			
		UPDATE 	JUNKDB..RePartition
			SET RePartition_Status = 4,
				LastUpdateDate	= GETDATE()
		WHERE 	RePartition_Status = 3		
	END

	--Fix Partition in Swap
	WHILE EXISTS(SELECT * FROM JUNKDB..RePartition WHERE Partition_Number = @Current_partition AND RePartition_Status = 4) 
	BEGIN
		SELECT TOP 1 @SQLCOMMAND = SQLCOMMAND FROM JUNKDB..RePartition WHERE Partition_Number = @Current_partition AND RePartition_Status = 4
		
		SET @FunctionSQL = 'ALTER PARTITION FUNCTION PF_SI_ExposureClientID_SWAP ()' + @SQLCOMMAND + '
		ALTER PARTITION SCHEME PS_SI_ExposureClientID_SWAP NEXT USED [PRIMARY]' --Different on Prod
		
		IF @debug = 1
			PRINT (@FunctionSQL)
		ELSE 
			EXEC (@FunctionSQL)
			
		UPDATE 	JUNKDB..RePartition
			SET RePartition_Status = 5,
				LastUpdateDate	= GETDATE()
		WHERE 	Partition_Number = @Current_partition 
			AND SQLCOMMAND = @SQLCOMMAND 
		
	END
	
END