--select ClientID, ',' from Clients where RootClientID = 1999 AND ClientLevelID = 1
set nocount ON

DECLARE @Left INT

IF OBJECT_ID('tempdb..#CSKID') IS  NULL
BEGIN
	create table #CSKID (CSKID INT, Status tinyint)

	insert into #CSKID(CSKID, Status)
	select CSKID, 1
	from dbo.CSKeywords
	where clientID in (2011,2012,2013,2014,2017,2092,2111,2590,2592,2891,2892,4226,4554,4603,5248,5250,5434,5644,5738,5739,6025,6026,6027,6028,6030,6276,6278,6834,6835,6836,6837,6852,6994,7275) 
	and statusflag = 1 
	
	Create clustered index idx_CSKID_CSKID on #CSKID (Status, CSKID)
END

SELECT COUNT(*) FROM #CSKID

WHILE EXISTS (SELECT TOP 1 1 FROM #CSKID WHERE status = 1)
BEGIN

	SELECT @Left = COUNT(1) 
	FROM #CSKID
	WHERE Status = 1

	UPDATE TOP (1000) #CSKID 
	SET Status = 2
	WHERE status = 1

	RAISERROR ('Batch Starting, %d Left', 0, 1, @Left) WITH Nowait

	UPDATE csk
	SET URL = 'http://dms.netmng.com/si/cm/tracking/clickredirect.aspx',
		UpdateDate = GETUTCDATE()
	FROM dbo.CSKeywords csk
	WHERE EXISTS(SELECT 1 FROM #CSKID WHERE csk.CSKID = CSKID AND Status = 2)

	UPDATE #CSKID SET Status = 3 WHERE Status = 2

	RAISERROR ('BatchComplete', 0, 1) WITH Nowait
	

END