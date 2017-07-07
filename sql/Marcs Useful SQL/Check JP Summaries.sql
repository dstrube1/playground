

/*
SELECT ClientID,ClientName 
FROM SIProcessing..CLients
WHERE ParentClientID = 1
AND StatusFlag = 1

ClientID	ClientName
2902	Europe
5689	Africa
5803	Asia
5804	Japan
5805	US
5806	Test
5807	Global
6300	France
7559	Latin America

US, Global, Latin America (5805,5807,7559)
Europe, France, Africa (2902, 6300, 5689)
Japan, Asia (5804, 5803)


*/

IF OBJECT_ID('tempdb..#Clients') IS NULL
BEGIN
	CREATE  TABLE  #Clients(
		ClientID INt,
		ParentCLientID INT,
		PRIMARY KEY(ParentClientID, ClientID)
	)

	INSERT INTO #Clients ( ClientID, ParentCLientID )
	SELECT ClientID, ParentClientID 
	FROM SIProcessing..Clients 
	WHERE StatusFlag = 1
		AND ParentClientID IS NOT NULL
END
 ;WITH ClientsTree
 AS
 (
   SELECT c.ClientID,c.ParentClientID,
       0 AS Level
   FROM  #Clients AS c
   WHERE ClientID IN (5805,5807,7559)
   UNION ALL
 -- Recursive
    SELECT c.ClientID,c.ParentClientID,
       LEVEL + 1
   FROM  #Clients AS c
   INNER JOIN ClientsTree AS d
       ON c.ParentClientID = d.clientID
 )
SELECT LastReportDate,Inprocess, COUNT(DISTINCT ClientID) AS [Count]
FROM SIProcessing..CrawlingTracking_History cth
WHERE ReportProcessedDate IS NULL
AND EXISTS(SELECT 1 FROM ClientsTree WHERE ClientID = cth.ClientID)
GROUP BY LastReportDate,Inprocess
ORDER BY LastReportDate,Inprocess

