
--SI_SP_ImpressionLogRead_Read


DECLARE @D DATETIME = '2012-12-28 00:00:00.000',
	@E DATETIME = '2013-01-08 08:00:00.000',
	@D_Var VARCHAR(30)

IF OBJECT_ID('tempdb..#t') IS NOT NULL
DROP TABLE #t

CREATE TABLE #t (
	UserID UNIQUEIDENTIFIER,
	NMID UNIQUEIDENTIFIER
)

WHILE @D < @E
BEGIN

	TRUNCATE TABLE #t

	INSERT INTO #t(UserID,NMID)
	SELECT cast(nullif(UserUniqueGUID,'') as uniqueidentifier) AS UserUniqueGUID
		  ,cast(nullif(NMImpression_ID,'') as uniqueidentifier) AS NMImpression_ID  
	FROM [SIProcessing].[dbo].[ImpressionLogRead]
	WHERE CreateDateUTC >= @D
		AND CreateDateUTC < DATEADD(hour,1,@D)
	
	SET @D = DATEADD(hour,1,@d)
	SET @D_Var = LEFT(CONVERT(VARCHAR, @D, 120), 30)
	
	RAISERROR('Processed %s',0,1,@D_Var) WITH NOWAIT
		
END

--CREATE CLUSTERED INDEX CX_ImpressionLogRead_CreateDateUTC ON ImpressionLogRead(CreateDateUTC)
--DROP INDEX CX_ImpressionLogRead_CreateDateUTC ON ImpressionLogRead

BEGIN TRAN
	SELECT * FROM [SIProcessing].[dbo].[ImpressionLogRead]
	  	WHERE CreateDateUTC >= '2012-12-28 05:40:54'
		AND CreateDateUTC < '2012-12-28 05:40:55'
		AND NMImpression_ID = '193b3f75-8034-4f4b-b565-eb7ab235d0 c'
COMMIT		


SELECT MIN(CreateDateUTC), MAX(CreateDateUTC)
FROM [SIProcessing].[dbo].[ImpressionLogRead]