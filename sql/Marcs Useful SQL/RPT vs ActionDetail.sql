

DECLARE @ClientID INT = 7097,
	@startDate DATE = '06/15/2012',
	@endDate DATE = '07/15/2012'

;WITH TC AS (
SELECT CAST(EAsternCreateDate AS DATE) EAstDate, ChannelID,SUM(TransactionAmount) AS REv, SUM(ActionQuantity) AS ACt
FROM SIProcessing_CacheHistory..TrackedCache
WHERE EasternCreateDate >= @startDate
AND EasternCreateDate < @endDate
AND ClientID = @ClientID
GROUP BY CAST(EAsternCreateDate AS DATE),ChannelID
),
TC_Proc AS (
SELECT CAST(EAsternCreateDate AS DATE) EAstDate, ChannelID,SUM(TransactionAmount) AS REv, SUM(ActionQuantity) AS ACt
FROM [209718-SQLPROC\SQLPROC].SIProcessing_CacheHistory.dbo.TrackedCache
WHERE EasternCreateDate >= @startDate
AND EasternCreateDate < @endDate
AND ClientID = @ClientID
GROUP BY CAST(EAsternCreateDate AS DATE),ChannelID
),
PAID AS(
SELECT  GenerateDate, SUM(TransactionAmount) AS REv, SUM(TTCOUNT) AS ACt
FROM SIOLAP..RPT_PS_Summary_ClientLevel
WHERE ClientID = @ClientID
AND GenerateDate >= @startDate
AND GenerateDate < @endDate
GROUP BY GenerateDate
),
NAtural AS(
SELECT  GenerateDate,SUM(TransactionAmount) AS REv, SUM(TTCOUNT) AS ACt
FROM SIOLAP..RPT_NS_Summary_Keywords
WHERE  ClientID = @ClientID
AND GenerateDate >= @startDate
AND GenerateDate < @endDate
GROUP BY GenerateDate
),
PaidInclusion AS(
SELECT  GenerateDate,SUM(TransactionAmount) AS REv, SUM(TTCOUNT) AS ACt
FROM SIOLAP..RPT_PI_Summary_CustomerTT_ClientLevel
WHERE  ClientID = @ClientID
AND GenerateDate >= @startDate
AND GenerateDate < @endDate
GROUP BY GenerateDate
),
DFA AS (
SELECT GENERateDAte, SUM(ViewBaseTransactionAmount+ ClickBaseTransactionAmount) AS REV, SUM(ViewBaseTransactionCount+ ClickBaseTransactionCount) AS Actions
FROM SIOLAP..RPT_UM_Summary_Keywords
WHERE ClientID = @ClientID
AND GenerateDate >= @startDate
AND GenerateDate < @endDate
GROUP BY GenerateDate
)
SELECT TC.EAstDate, 
	TC.ChannelID,
	TC2.REv AS Proc_REvenue,
	TC.REv AS ActionDetail_REvenue, 
	COALESCE(PAID.REv,NAtural.REv, PaidInclusion.REv,DFA.REV,0) AS RPT_Revenue,
	Tc.ACt AS ActionDetail_ActionCount,
	TC2.ACt AS Proc_ActionCount,
	COALESCE(PAID.ACt,NAtural.ACt, PaidInclusion.ACt,DFA.Actions,0) AS RPT_ActionCount,
	CASE WHEN Tc.ACt<>TC2.ACt THEN 'Replication' WHEN TC2.ACt<> COALESCE(PAID.ACt,NAtural.ACt, PaidInclusion.ACt,DFA.Actions,0) THEN 'Summaries' ELSE '' END AS Comment
FROM TC
LEFT JOIN TC_Proc TC2 ON TC.EAstDate = TC2.EAstDate
	AND TC2.ChannelID = TC.ChannelID
LEFT JOIN PAID ON TC.EAstDate = PAID.GenerateDAte 
	AND Tc.ChannelID = 1
LEFT JOIN NAtural ON TC.EAstDate = NAtural.GenerateDAte 
	AND Tc.ChannelID = 2
LEFT JOIN PaidInclusion ON TC.EAstDate = PaidInclusion.GenerateDAte 
	AND Tc.ChannelID = 3
LEFT JOIN DFA ON TC.EAstDate = DFA.GenerateDAte 
	AND Tc.ChannelID = 4
WHERE TC2.ACt <> COALESCE(PAID.ACt,NAtural.ACt, PaidInclusion.ACt,DFA.Actions,0)
	OR TC2.ACt <> TC.ACt
ORDER BY 2,1