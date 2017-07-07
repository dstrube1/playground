USE [SIProcessing]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SI_SSIS_DFADataLoad_SetAttributionReprocess]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SI_SSIS_DFADataLoad_SetAttributionReprocess]
GO

USE [SIProcessing]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [dbo].[SI_SSIS_DFADataLoad_SetAttributionReprocess]

AS
/*
------------------------------------------------------------
Change History
------------------------------------------------------------
05/16/11  JRC - Inital  
05/15/11  JRC - Added Notes value for Reprocess
10/18/2011	MRS	Changed MAX(TransactionDatetime) to DATEADD(dd,1,MAX(TransactionDatetime))
11/03/2011	MRS If date range in Reprocessing table is greater than new range dont update 

*/
BEGIN



	-- LOCAL VARIABLES DECLARATION
	DECLARE
		@ClientID INT
	,	@AffiliateID INT
	,	@BeginDate DATE
	,	@EndDate DATE
	;

	DECLARE CUR CURSOR FOR
		SELECT
			ta.ClientID
		,	agc.AffiliateID
		,	CASE WHEN tr.BeginDate < MIN(TransactionDatetime) THEN tr.BeginDate ELSE MIN(TransactionDatetime)END AS BeginDate
		,	CASE WHEN tr.EndDate > DATEADD(dd,1,MAX(TransactionDatetime)) THEN tr.EndDate ELSE DATEADD(dd,1,MAX(TransactionDatetime)) END AS EndDate
		FROM
			dbo.TrackedAction_STAGE_DFA AS ta
			LEFT JOIN dbo.AffiliateGroupClients AS agc ON agc.ClientID = ta.ClientID
			LEFT JOIN SIProcessing_CacheHistory.dbo.TrackedReprocess tr ON (tr.ClientID = ta.ClientID OR agc.AffiliateID = tr.AffiliateID)
				AND isActive = 1
		GROUP BY
			ta.ClientID
		,	agc.AffiliateID
		,	tr.BeginDate
		,	tr.EndDate
	;

	OPEN CUR;
	FETCH NEXT FROM CUR INTO
		@ClientID
	,	@AffiliateID
	,	@BeginDate
	,	@EndDate
	;

	WHILE @@FETCH_STATUS = 0 BEGIN
		IF @AffiliateID IS NOT NULL
			BEGIN
				UPDATE SIProcessing_CacheHistory.dbo.TrackedReprocess SET
					BeginDate = @BeginDate
				,	EndDate = @EndDate
				,	isActive = 1
				WHERE
					AffiliateID = @AffiliateID
					AND isRepeat = 0
				;
				
				IF @@ROWCOUNT = 0
					INSERT INTO SIProcessing_CacheHistory.dbo.TrackedReprocess
					(
						AffiliateID
					,	BeginDate
					,	EndDate
					,	isActive
					,	isRepeat
					,   Notes
					)
					SELECT
						@AffiliateID
					,	@BeginDate
					,	@EndDate
					,	1 AS IsActive
					,	0 AS IsRepeat
					,  'From DFA Data Load'
					;
			END;
		ELSE
			BEGIN
				UPDATE SIProcessing_CacheHistory.dbo.TrackedReprocess SET
					BeginDate = @BeginDate
				,	EndDate = @EndDate
				,	isActive = 1
				WHERE
					ClientID = @ClientID
					AND isRepeat = 0
				;
				
				IF @@ROWCOUNT = 0
					INSERT INTO SIProcessing_CacheHistory.dbo.TrackedReprocess
					(
						ClientID
					,	BeginDate
					,	EndDate
					,	isActive
					,	isRepeat
					,   Notes
					)
					SELECT
						@ClientID
					,	@BeginDate
					,	@EndDate
					,	1 AS IsActive
					,	0 AS IsRepeat
					,  'From DFA Data Load'
					;
			END;

		FETCH NEXT FROM CUR INTO
			@ClientID
		,	@AffiliateID
		,	@BeginDate
		,	@EndDate
		;
	END;

	CLOSE CUR;
	DEALLOCATE CUR;
END;




GO

GRANT EXECUTE ON [dbo].[SI_SSIS_DFADataLoad_SetAttributionReprocess] TO [webaccess] AS [dbo]
GO


