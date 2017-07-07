--176

IF OBJECT_ID('tempdb..#Clients') IS NOT NULL 
	DROP TABLE #Clients
	
DECLARE @RunDate DATE = '04/07/2011',
	@NumWeeks INT = 8,
	@CTE_SQL VARCHAR(MAX),
	@FROM_SQL VARCHAR(MAX),
	@SELECT_SQL VARCHAR(MAX),
	@FINAL_SQL VARCHAR(MAX),
	@clientID_SQL VARCHAR(MAX),
	@HR_SQL VARCHAR(MAX),
	@i int = 0
	
SELECT ParseID AS ClientID 
INTO #Clients
FROM dbo.fn_ParseNumList('3999,1637,3233,4948,4944,3289,2537,1712')

SET @CTE_SQL = 'WITH '

SET @ClientID_SQL = 'Select coalesce(w0.ClientID'
SET @HR_SQL = ',coalesce(w0.HR'
SET @SELECT_SQL = 'w0.COUNT'
SET @FROM_SQL = ' FROM w0'

WHILE (@i < @NumWeeks)
BEGIN

	IF @i <> 0
	BEGIN
		SET @ClientID_SQL = @ClientID_SQL + ',w'+CAST(@i AS VARCHAR)+'.ClientID'
		SET @HR_SQL = @HR_SQL + ',w'+CAST(@i AS VARCHAR)+'.HR'
	END

	SET @CTE_SQL = @CTE_SQL + 'w'+CAST(@i AS VARCHAR)+' AS (
	SELECT tc.ClientID, 
	 DATEPART(hh,EasternCreateDate) AS HR,
	 COUNT(1) AS COUNT
	FROM SIProcessing_CacheHistory..TrackedCache tc
	JOIN #Clients c ON c.ClientID = tc.ClientID
	WHERE EasternCreateDate >= ''' + CONVERT(VARCHAR,DATEADD(dd,-@i * 7,@RunDAte),111) + '''
	AND EasternCreateDate < ''' + CONVERT(VARCHAR,DATEADD(dd,-@i * 7,DATEADD(dd,1,@Rundate)),111) + '''
	GROUP BY tc.ClientID, DATEPART(hh,EasternCreateDate)
	)
	'
	IF @i <> @NumWeeks -1
		SET @CTE_SQL = @CTE_SQL + ','
	
	IF @i > 0 
		SET @FROM_SQL = @FROM_SQL + '
			FULL JOIN w'+CAST(@i AS VARCHAR)+' on w0.ClienTID = w'+CAST(@i AS VARCHAR) +'.ClientID AND w0.HR = w'+CAST(@i AS VARCHAR)+'.HR'
	IF @i > 0 
		SET @SELECT_SQL = @SELECT_SQL + ', w'+CAST(@i AS VARCHAR)+'.COUNT AS w'+CAST(@i AS VARCHAR)+'COUNT'
		
	--SELECT w1.ClientID,	
		
	SET @i = @i +1	
		
END


SET @FROM_SQL = @FROM_SQL

SET @FINAL_SQL = @CTE_SQL+ @ClientID_SQL +') as CLIENTID'+ @HR_SQL +') AS HR,'+ @SELECT_SQL+@FROM_SQL


PRINT (@FINAL_SQL)

DECLARE @Stage TABLE (ClientID INT,HR INT,[COUNT] INT,w1COUNT INT,w2COUNT INT,w3COUNT INT,w4COUNT INT,w5COUNT INT,w6COUNT INT,w7COUNT INT)

INSERT INTO @Stage 
EXEC(@Final_SQL)

SELECT ClientID,HR,SUM([COUNT]), SUM(w1COUNT),SUM(w2COUNT),SUM(w3COUNT),SUM(w4COUNT),SUM(w5COUNT),SUM(w6COUNT),SUM(w7COUNT)
 FROM @STAGE
 GROUP BY ClientID,HR
 ORDER BY ClientID,HR



