
SET NOCOUNT ON

DECLARE @ClientID INT,
	@startDate DATE = '06/20/2012',
	@endDate DATE = '07/01/2012',
	@NumClients Int

IF OBJECT_ID('tempdb..#results') IS NOT NULL
DROP TABLE #results
	
CREATE TABLE #results(
	ClientID INT,
	EAstDate DATE, 
	ChannelID INT,
	Proc_REvenue MONEY,
	ActionDetail_REvenue MONEY, 
	RPT_Revenue MONEY,
	ActionDetail_ActionCount INT,
	Proc_ActionCount INT,
	RPT_ActionCount INT,
	Comment VARCHAR(255)
)

IF OBJECT_ID('tempdb..#Clients') IS NOT NULL
DROP TABLE #Clients

CREATE TABLE #Clients (
	ClientId INT,
	isProcessed BIT
)

INSERT INTO #Clients( ClientId, isProcessed )
SELECT DISTINCT ClientID,0 
FROM Searchignite..External_AdvertiserClient_Mapping
WHERE ExternalSourceID = 1
	AND StatusFlag = 1

SELECT @NumClients = @@ROWCOUNT

WHILE EXISTS(SELECT TOP 1 1 FROM #Clients WHERE isProcessed = 0)
BEGIN

	SELECT TOP 1 @ClientID = ClientID FROM #Clients WHERE isProcessed = 0
	
	RAISERROR('Currently Processing Client %d (%d left)',0,1,@ClientID, @NumClients) WITH NOWAIT
	
	;WITH TC AS (
	SELECT CAST(EAsternCreateDate AS DATE) EAstDate, ChannelID,SUM(TransactionAmount) AS REv, SUM(ActionQuantity) AS ACt
	FROM SIProcessing_CacheHistory..TrackedCache
	WHERE EasternCreateDate >= @startDate
	AND EasternCreateDate < @endDate
	AND ClientID = @ClientID
	AND ChannelID = 4
	--AND PublisherID = 128
	GROUP BY CAST(EAsternCreateDate AS DATE),ChannelID
	),
	TC_Proc AS (
	SELECT CAST(EAsternCreateDate AS DATE) EAstDate, ChannelID,SUM(TransactionAmount) AS REv, SUM(ActionQuantity) AS ACt
	FROM [209718-SQLPROC\SQLPROC].SIProcessing_CacheHistory.dbo.TrackedCache
	WHERE EasternCreateDate >= @startDate
	AND EasternCreateDate < @endDate
	AND ClientID = @ClientID
	AND ChannelID = 4
	--AND PublisherID = 128
	GROUP BY CAST(EAsternCreateDate AS DATE),ChannelID
	),
	DFA AS (
	SELECT GENERateDAte, SUM(ViewBaseTransactionAmount+ ClickBaseTransactionAmount) AS REV, SUM(ViewBaseTransactionCount+ ClickBaseTransactionCount) AS Actions
	FROM SIOLAP..RPT_UM_Summary_Keywords
	WHERE ClientID = @ClientID
	AND GenerateDate >= @startDate
	AND GenerateDate < @endDate
	GROUP BY GenerateDate
	)
	INSERT INTO #results( ClientID ,EAstDate ,ChannelID ,Proc_REvenue ,ActionDetail_REvenue ,RPT_Revenue , ActionDetail_ActionCount ,Proc_ActionCount ,RPT_ActionCount ,Comment)
	SELECT @ClientID,
		TC.EAstDate, 
		TC.ChannelID,
		TC2.REv AS Proc_REvenue,
		TC.REv AS ActionDetail_REvenue, 
		ISNULL(DFA.REV,0) AS RPT_Revenue,
		Tc.ACt AS ActionDetail_ActionCount,
		TC2.ACt AS Proc_ActionCount,
		ISNULL(DFA.Actions,0) AS RPT_ActionCount,
		CASE WHEN Tc.ACt<>TC2.ACt THEN 'Replication' WHEN TC2.ACt<> ISNULL(DFA.Actions,0) THEN 'Summaries' ELSE '' END AS Comment
	FROM TC
	LEFT JOIN TC_Proc TC2 ON TC.EAstDate = TC2.EAstDate
		AND TC2.ChannelID = TC.ChannelID
	LEFT JOIN DFA ON TC.EAstDate = DFA.GenerateDAte 
		AND Tc.ChannelID = 4
	WHERE TC2.ACt <> ISNULL(DFA.Actions,0)
		OR TC2.ACt <> TC.ACt
	ORDER BY 2,1
		
	SET @NumClients = @NumClients - 1	
		
	UPDATE #Clients
	SET isProcessed = 1
	WHERE ClientId = @ClientID	
		
END

SELECT * FROM #results
