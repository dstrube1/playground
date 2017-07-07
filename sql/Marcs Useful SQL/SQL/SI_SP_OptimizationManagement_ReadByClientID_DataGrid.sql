 exec SI_SP_OptimizationManagement_ReadByClientID_DataGrid 
@CurrencyID=N'-1', 
@ClientID=N'2919', 
@spotid=N'-1', 
@ConversionCurrencyID=N'5', 
@startdate=N'4/20/2010 10:52:32 AM', 
@enddate=N'5/19/2010 10:52:32 AM'



USE [Searchignite]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER PROCEDURE [dbo].[SI_SP_OptimizationManagement_ReadByClientID_DataGrid]
(
	@ClientID INT
,	@StartDate DATE = NULL
,	@EndDate DATE = NULL
,	@StartDate_PREV DATE = NULL
,	@EndDate_PREV DATE = NULL
,	@CurrencyID INT = NULL
,	@ConversionCurrencyID INT = NULL
,	@ShowAll BIT = 0
,	@SPOTID INT = NULL
)

AS

/*
-----------------------------------------------------------------------------------------
	Change History
-----------------------------------------------------------------------------------------
	01/28/2010 WDJ Initial.
	02/22/2010 WDJ Added "MODEL EXPIRED" Handling.
	02/25/2010 WDJ Pulling Refresh Cache hours from table "SISystemConstant"
	03/09/2010 WDJ Retrieving the correct Target Type based on the Objective.
	03/24/2010 WDJ Updated calculated rates and values (ROAS, CTR, CPA, and COnversion Rate).
	5/24/2010  MRS Added the use of temp tables to increase performance
-----------------------------------------------------------------------------------------


EXEC [dbo].[SI_SP_OptimizationManagement_ReadByClientID_DataGrid]
	@ClientID = 2858
--,	@SPOTID = 4525
--	@ClientID = 146
--,	@ShowAll = 1
,	@StartDate = '2010-02-18'
,	@EndDate = '2010-02-24'
,	@StartDate_PREV = '2010-02-11'
,	@EndDate_PREV = '2010-02-17'
;
*/

BEGIN
	-- LOCAL VARIABLES DECLARATION
	DECLARE
		@OptimizationRefreshCacheHours TINYINT

	SELECT
		@StartDate = ISNULL(@StartDate, DATEADD(DAY, -30, GETUTCDATE()))
	,	@EndDate = ISNULL(@EndDate, GETUTCDATE())
	--,	@StartDate_PREV = ISNULL(@StartDate_PREV, DATEADD(DAY, -30, @StartDate))
	--,	@EndDate_PREV = ISNULL(@EndDate_PREV, DATEADD(DAY, -30, @EndDate))
	;

	-- GET REFRESH CACHE HOURS
	SELECT TOP 1
		@OptimizationRefreshCacheHours = ISNULL(OptimizationRefreshCacheHours, 30)
	FROM
		dbo.SISystemConstant;
	
	-- CHECK FOR, AND UPDATE, EXPIRED OPTIMIZATION GROUPS
	UPDATE dbo.CampaignOptimizerSettings SET
		RefreshCache = 1
	,	OptimizationGroupStatusID = 4
	WHERE
		ClientID = @ClientID
		AND CacheDateUTC IS NOT NULL
		AND OptimizationGroupStatusID = 5
		AND DATEDIFF(HOUR, CacheDateUTC, GETUTCDATE()) > @OptimizationRefreshCacheHours
	;
-- Temp Table used to manage and manipulate data	
	CREATE TABLE #DataGrid(
	[ClientID] [int] NOT NULL,
	[GenerateDate] [smalldatetime] NOT NULL,
	[SEID] [smallint] NOT NULL,
	[AdCategoryID] [int] NOT NULL,
	[NumImpressions] [int] NOT NULL,
	[Cost] [money] NOT NULL,
	[NumClicksReported] [int] NOT NULL,
	[TransactionCount] [int] NOT NULL,
	[TransactionAmount] [money] NOT NULL,
	[TTCount] [numeric](18, 2) NULL, 
	[CurrencyID] [int], 
	[SPOTID] [int],
	[ExchangeRate] [float] --was [money] but had rounding error
	)
	
	INSERT INTO  #DataGrid ([ClientID],[GenerateDate],[SEID],[AdCategoryID],[NumImpressions],[Cost],[NumClicksReported],[TransactionCount],[TransactionAmount],[TTCount])
		SELECT [ClientID],[GenerateDate],[SEID],[AdCategoryID],[NumImpressions],[Cost],[NumClicksReported],[TransactionCount],[TransactionAmount],[TTCount] 
		FROM SIOLAP.dbo.RPT_PS_Summary_GroupLevel 
		WHERE ClientID = @ClientID AND GenerateDate BETWEEN @StartDate AND @EndDate
		
	UPDATE #DataGrid
		SET CurrencyID = (
			SELECT CurrencyId 
			FROM SearchEngine 
			WHERE SearchEngine.SEID =  #DataGrid.SEID
		)
	
	UPDATE #DataGrid
		SET SPOTID = (
			SELECT SPOTID 
			FROM SPOTAdGroups 
			WHERE SPOTAdGroups.ClientID =  #DataGrid.ClientID 
				AND SPOTAdGroups.AdCategoryID = #DataGrid.AdCategoryID
		)	
	
	IF @SPOTID > -1
	BEGIN
		DELETE FROM #DataGrid
		WHERE SPOTID != @SPOTID
	END
	 
	DELETE FROM #DataGrid
	WHERE SPOTID IS NULL  
	
	UPDATE #DataGrid
		SET ExchangeRate =(
			SELECT ExchangeRate 
			FROM CurrencyExchangeData 
			WHERE FromCurrencyID = #DataGrid.CurrencyID 
				AND ToCurrencyID = ISNULL(@ConversionCurrencyID, CurrencyExchangeData.FromCurrencyID)
		)
		;
WITH RPT AS
	(	
		SELECT 
			rpt.ClientID
		,	rpt.SPOTID
		,	SUM(ISNULL(rpt.NumImpressions, 0)) AS [Impressions]
		,	SUM(ISNULL(rpt.NumClicksReported, 0)) AS [Clicks]
		,	SUM((rpt.Cost * ISNULL(rpt.ExchangeRate, 1.0))) AS Cost
		,	SUM(rpt.TTCount) AS Actions
		,	SUM((rpt.TransactionAmount * ISNULL(rpt.ExchangeRate, 1.0))) AS Revenue
		FROM
			#DataGrid AS rpt
		GROUP BY
			rpt.ClientID
		,	rpt.SPOTID
		
		)
		
SELECT cs.SPOTID
	,	cs.Name AS [Opt Group]
	,	cs.CurrencyID AS [Currency]
	,	cs.OptimizationGroupStatusID -- Model Current
	,	ogs.OptimizationGroupStatus AS [Status]
	,	IsActive AS IsAutomated
	--,	CASE WHEN EXISTS (SELECT 1 FROM dbo.SPOTScheduling WHERE SPOTID = cs.SPOTID) THEN 1 ELSE 0 END AS IsAutomated
	,	dbo.fn_OptimizationManagement_ConvertScheduleToString(cs.SPOTID) AS SCHEDULE
	,	oo.OptimizationObjective AS Objective
	,	lu.ObjectiveTargetTypeID
	,	ott.OptimizationTargetType AS [Target Type]
	,	CASE WHEN cs.IsMetric = 1 THEN cs.MetricAmount ELSE cs.Budget END AS [Target]
	,	ISNULL(RPT.Impressions, 0) AS Impressions
	,	ISNULL(RPT.Clicks, 0) AS Clicks
	,	ISNULL((RPT.Clicks * 1.0)/NULLIF((RPT.Impressions * 1.0), 0), 0) * 100.0 AS CTR
	,	ISNULL(RPT.Cost, 0.0) AS Cost
	,	ISNULL(RPT.Actions, 0) AS Actions
	,	ISNULL(RPT.Revenue, 0.0) AS Revenue
	,	ISNULL(RPT.Cost/NULLIF(RPT.Actions, 0), 0.0) AS CPA
	,	ISNULL((RPT.Revenue/NULLIF(RPT.Cost, 0)), 0.0) AS [ROAS%]
	,	ISNULL(RPT.Actions/NULLIF(RPT.Clicks, 0), 0.0) * 100 AS [Conversion Rate]
	,	dbo.fn_ConvertTime
		(
			cs.UpdateDateUTC
		,	13
		,	0
		,	c.TimeZoneID
		,	c.DayLightSaving
		) AS [Last Update]
	,	dbo.fn_ConvertTime
		(
			cs.CacheDateUTC
		,	13
		,	0
		,	c.TimeZoneID
		,	c.DayLightSaving
		) AS [Last Optimized]
	--,	*
	FROM
		dbo.CampaignOptimizerSettings AS cs
		INNER JOIN dbo.Clients AS c ON c.ClientID = cs.ClientID
		LEFT JOIN dbo.LUOptimizationObjective_LUOptimizationTargetType AS lu ON
			lu.OptimizationObjectiveID = cs.OptimizationObjectiveID
			AND lu.IsMetric = cs.IsMetric
		LEFT JOIN dbo.LUOptimizationGroupStatus AS ogs ON ogs.OptimizationGroupStatusID = cs.OptimizationGroupStatusID
		LEFT JOIN dbo.LUOptimizationTargetType AS ott ON ott.OptimizationTargetTypeID = lu.OptimizationTargetTypeID
		LEFT JOIN dbo.LUOptimizationObjective AS oo ON oo.OptimizationObjectiveID = cs.OptimizationObjectiveID
		LEFT JOIN RPT ON
			RPT.ClientID = cs.ClientID
			AND RPT.SPOTID = cs.SPOTID
	WHERE
		cs.ClientID = @ClientID
		AND cs.CurrencyID = ISNULL(NULLIF(@CurrencyID, -1), cs.CurrencyID)
		AND cs.StatusFlag = CASE WHEN @ShowAll = 1 THEN cs.StatusFlag ELSE 1 END
		AND cs.SPOTID = ISNULL(NULLIF(@SPOTID, -1), cs.SPOTID)
	ORDER BY
		cs.Name;
		
	DROP TABLE #DataGrid
END;

GO
GRANT EXECUTE ON [dbo].[SI_SP_OptimizationManagement_ReadByClientID_DataGrid] TO [siasp] AS [dbo]
GO
GRANT EXECUTE ON [dbo].[SI_SP_OptimizationManagement_ReadByClientID_DataGrid] TO [webaccess] AS [dbo]