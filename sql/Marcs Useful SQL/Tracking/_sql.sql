
DECLARE @WSID INT = 3,
	@WSID_Compare INT = 4,
	@StartDateUTC DATETIME = '2013-04-18 16:17:00.000',
	@EndDateUTC DATETIME = '2013-04-19'
/*

SELECT * 
FROM SIProcessing..LUServer
ORDER BY 2

SELECT GETUTCDATE()

*/

IF OBJECT_ID('tempdb..#t') IS NOT NULL
DROP TABLe #t

CREATE TABLE #t (
	D DATE,
	T TIME,
	COUNTS INT

)
INSERT INTO #t(D,T,Counts)
SELECT CAST(CreateDateUTC AS DATE),CAST(CONVERT(VARCHAR(5), createdateutc, ( 8 ))AS TIME), COUNT(1)
FROM SIProcessing_Attribution..TrackedExposurePaid
WHERE LocalizedCreateDate >= DATEADD(dd,-1,@StartDateUTC)
	AND LocalizedCreateDate < DATEADD(dd,1,@EndDateUTC)
	AND CreateDateUTC >= @StartDateUTC
	AND CreateDateUTC < @EndDateUTC
	AND WebServerID = @WSID
GROUP BY CAST(CreateDateUTC AS DATE),CAST(CONVERT(VARCHAR(5), createdateutc, ( 8 ))AS TIME)	


SELECT *
FROM SIProcessing_Attribution..TrackedExposurePaid
WHERE LocalizedCreateDate >= DATEADD(dd,-1,@StartDateUTC)
	AND LocalizedCreateDate < DATEADD(dd,1,@EndDateUTC)
	AND CreateDateUTC >= @StartDateUTC
	AND CreateDateUTC < @EndDateUTC
	AND WebServerID = @WSID
/**/

IF OBJECT_ID('tempdb..#t_compare') IS NOT NULL
DROP TABLe #t_compare

CREATE TABLE #t_compare (
	D DATE,
	T TIME,
	COUNTS INT

)
INSERT INTO #t_compare(D,T,Counts)
SELECT CAST(CreateDateUTC AS DATE),CAST(CONVERT(VARCHAR(5), createdateutc, ( 8 ))AS TIME), COUNT(1)
FROM SIProcessing_Attribution..TrackedExposurePaid
WHERE LocalizedCreateDate >= DATEADD(dd,-1,@StartDateUTC)
	AND LocalizedCreateDate < DATEADD(dd,1,@EndDateUTC)
	AND CreateDateUTC >= @StartDateUTC
	AND CreateDateUTC < @EndDateUTC
	AND WebServerID = @WSID_Compare
GROUP BY CAST(CreateDateUTC AS DATE),CAST(CONVERT(VARCHAR(5), createdateutc, ( 8 ))AS TIME)
	
SELECT t.D,t.T,t.COUNTS AS Compare,t2.COUNTS,(ABS(t.Counts - ISNULL(t2.COUNTS,0))/CAST(t.COUNTS AS FLOAT)) *100 AS PercentDifference
FROM #t_compare t
LEFT JOIN #t t2 ON t.D = t2.D
	AND t.T = t2.T
--WHERE (ABS(t.Counts - ISNULL(t2.COUNTS,0))/t.COUNTS) *100 > 10
ORDER BY t.D, t.T
	