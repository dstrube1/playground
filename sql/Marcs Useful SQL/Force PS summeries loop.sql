
DECLARE @tmp TABLE (
      RunDate DATETIME,
      Processed BIT
)

INSERT INTO @tmp (RunDate,Processed)
VALUES('06/14/2012',0),
	('06/18/2012',0),
	('06/21/2012',0)

DECLARE @Rundate_Var VARCHAR(30),
      @RunDate DATETIME,
      @StartTime DATETIME,
      @EndTime DATETIME

WHILE EXISTS(SELECT TOP 1 1 FROM @tmp WHERE Processed = 0)
BEGIN

      WHILE EXISTS(SELECT TOP 1 1 FROM SIProcessing.dbo.AT_RPT_PS_SummaryData WHERE ReProcessDate IS NOT NULL)
      BEGIN
            RAISERROR('Waiting for Step 1 to finish',0,1) WITH NOWAIT
            WAITFOR DELAY '00:00:20.000'
      END
            
      SELECT TOP 1 @RunDate = RunDate
      FROM @tmp
      WHERE Processed = 0 
      ORDER BY RunDate DESC
      
      SET @Rundate_Var = CAST(@RunDate AS VARCHAR)
            
      RAISERROR('Currently Processing - %s',0,1,@Rundate_Var) WITH NOWAIT
      
      UPDATE SIProcessing..AT_RPT_PS_SummaryData
      SET ReProcessDate = @RunDate
      WHERE ReProcessDate IS NULL
      

      UPDATE @tmp
      SET Processed = 1
      WHERE RunDate = @RunDate


END

