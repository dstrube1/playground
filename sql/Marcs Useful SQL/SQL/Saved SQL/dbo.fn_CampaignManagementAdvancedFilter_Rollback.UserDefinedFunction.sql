USE [Searchignite]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fn_CampaignManagementAdvancedFilter]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fn_CampaignManagementAdvancedFilter]
GO

USE [Searchignite]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE FUNCTION

[dbo].[fn_CampaignManagementAdvancedFilter] 
(
	@AdvancedFilterXML XML
,	@PublisherFilterTypeID INT = NULL
)

RETURNS NVARCHAR(MAX)
-----------------------------------------------------------------------------
--Change History
-----------------------------------------------------------------------------
--06/15/2010 YZ SIP-3461 Double-byte character does not filter name and text
--09/13/2010 JRC 4.5 added filters for Language and Location Targeting
--09/13/2010 JRC 4.5 added 1=1 to allow for Language or Location only filter elements
--09/30/2010 WDJ Added Google Quality Score to the advanced filter.
--10/18/2010 MRS SIOPS-1727 Incorrect Advanced filter when doin exact text search
--10/19/2010  JG 4.6 Ad Scheduling added (Future, Not Future, and Between) operators
-----------------------------------------------------------------------------
AS

BEGIN
	-- LOCAL VARIABLES DECLARATION
	DECLARE
		@RTN_AdvancedFilterString NVARCHAR(MAX)

	--,	@AndOrString NVARCHAR(MAX)
	,	@FilterElementIndex INT
	,	@CurrentFilterElementID int
	,	@FilterElementID INT
	,	@FilterType NVARCHAR(32)
	,	@OperatorID NVARCHAR(32)

	,	@FilterTypeID SMALLINT
	,	@FilterTypeID_GLOBAL_BID_RULES SMALLINT
	,	@FilterOperatorID SMALLINT

	,	@DatabaseColumnName NVARCHAR(255)
	,	@FilterValue NVARCHAR(255)
	,	@FilterValue_LBOUND NVARCHAR(255)
	,	@FilterValue_UBOUND NVARCHAR(255)
	,	@FilterString NVARCHAR(255)
	,	@FilterSEID int
	,	@TextAdFilterTypeID INT
	,	@PerformanceFilterTypeID INT
	,	@ExceptionTypeID INT

	-- BID METHOD VARIABLES
	,	@BidMethodFilter NVARCHAR(64)
	,	@IsConcat BIT
	,	@BidRuleTypeID SMALLINT
	;

	DECLARE @AdvFilterTable TABLE
	(
		FilterElementID INT
	,	FilterTypeID SMALLINT
	,	FilterOperatorID SMALLINT
	,	DataField NVARCHAR(255)
	,	FilterValue NVARCHAR(255)
	,	FilterValue_LBOUND NVARCHAR(255)
	,	FilterValue_UBOUND NVARCHAR(255)
	,	FilterString AS QUOTENAME(DataField) + ' <OPERATOR> ' + CASE WHEN FilterOperatorID > 5 THEN QUOTENAME(FilterValue, '''') ELSE FilterValue END
	,   SEID int
	)

	IF @AdvancedFilterXML IS NULL RETURN '';

	-- INITIALIZE LOCAL VARIABLES
	SELECT
		@RTN_AdvancedFilterString = ''
	,	@FilterElementIndex = NULL
	,	@ExceptionTypeID = -99
	,	@FilterTypeID_GLOBAL_BID_RULES = (SELECT FilterTypeID FROM dbo.LUFilterType WHERE FilterTypeName = 'Global Bid Rules')
	,	@BidMethodFilter = ''
	,	@IsConcat = 0
	;

	-- GET TEXT AD PUBLISHER FILTER TYPE ID FOR TEXT AD EXCEPTION
	SELECT @TextAdFilterTypeID = PublisherFilterTypeID
	FROM dbo.LUPublisherFilterType
	WHERE
		PublisherFilterType = 'Text Ad';

	-- GET PERFORMANCE FILTER TYPE ID FOR PERFORMANCE ADVANCED FILTER EXCEPTION
	SELECT @PerformanceFilterTypeID = FilterTypeID
	FROM dbo.LUFilterType
	WHERE
		FilterTypeName = 'Performance';

	-- POPULATE ADVANCED FILTER TABLE
	WITH ADVFILTERLEVEL AS
	(
		SELECT
			ADV.FILTERATTRIB.value('@publisherfiltertypeid', 'INT') AS PublisherFilterTypeID
		,	FILTERELEM.ELEM.value('@filterelementid', 'INT') AS FilterElementID
		FROM
			@AdvancedFilterXML.nodes('//advancedfilter') AS ADV(FILTERATTRIB)
			CROSS APPLY ADV.FILTERATTRIB.nodes('filterelement') AS FILTERELEM(ELEM)
	)
	,
	ADVFILTERCTE AS
	(
		SELECT
			ADV.FILTERATTRIB.value('@filterelementid', 'INT') AS FilterElementID
		,	ADV.FILTERATTRIB.value('@filtertypeid', 'NVARCHAR(MAX)') AS FilterTypeID
		,	ADV.FILTERATTRIB.value('@filteroperatorid', 'NVARCHAR(MAX)') AS FilterOperatorID
		,	ADV.FILTERATTRIB.value('@datagridcolumnid', 'INT') AS DataGridColumnID
		,	FILTER.VAL.value('.', 'NVARCHAR(MAX)') AS FilterValue
		-- NEW FILTER CHANGE FOR BETWEEN (UPPER AND LOWER BOUNDS)
		,	FILTER.VAL.value('(./lbound)[1]', 'NVARCHAR(MAX)') AS FilterValue_LBOUND
		,	FILTER.VAL.value('(./ubound)[1]', 'NVARCHAR(MAX)') AS FilterValue_UBOUND
		,   ADV.FILTERATTRIB.value('@seid', 'INT') as SEID
		FROM
			@AdvancedFilterXML.nodes('//filterelement') AS ADV(FILTERATTRIB)
			CROSS APPLY ADV.FILTERATTRIB.nodes('values/value') AS FILTER(VAL)
	)
	INSERT INTO @AdvFilterTable
	(
		FilterElementID
	,	FilterTypeID
	,	FilterOperatorID
	,	DataField
	,	FilterValue
	,	FilterValue_LBOUND
	,	FilterValue_UBOUND
	,   SEID
	)
	SELECT
		adv.FilterElementID
	,	adv.FilterTypeID
	,	adv.FilterOperatorID
	,	ISNULL(dbc.DatabaseColumnName, dgc.DataField)
	,	adv.FilterValue
	,   adv.FilterValue_LBOUND
	,   adv.FilterValue_UBOUND
	,   adv.SEID
	FROM
		ADVFILTERCTE AS adv
		INNER JOIN ADVFILTERLEVEL AS afl ON afl.FilterElementID = adv.FilterElementID
		INNER JOIN dbo.LUDataGridColumn AS dgc ON dgc.DataGridColumnID = adv.DataGridColumnID
		LEFT JOIN dbo.LUDatabaseColumn AS dbc ON dgc.DatabaseColumnID = dbc.DatabaseColumnID
	WHERE
		afl.PublisherFilterTypeID <= @PublisherFilterTypeID
		AND afl.PublisherFilterTypeID != CASE
											WHEN @PublisherFilterTypeID = @TextAdFilterTypeID THEN @ExceptionTypeID
											ELSE @TextAdFilterTypeID
										END
		AND adv.FilterTypeID IN
			(
				SELECT FilterTypeID
				FROM dbo.LUFilterType
				WHERE
					FilterTypeID != CASE
										WHEN afl.PublisherFilterTypeID = @PublisherFilterTypeID THEN @ExceptionTypeID
										ELSE @PerformanceFilterTypeID
									END
			)
		AND adv.FilterTypeID != @FilterTypeID_GLOBAL_BID_RULES
	ORDER BY
		afl.PublisherFilterTypeID
	,	dgc.Ordinal
	,	adv.FilterElementID;

	-- CURSOR THROUGH RESULT SET TO APPLY FILTER CRUTERIA
	DECLARE CUR_FILTERELEMENTS CURSOR FOR
		SELECT DISTINCT FilterElementID
		FROM @AdvFilterTable
		WHERE
			FilterTypeID != @FilterTypeID_GLOBAL_BID_RULES;

	OPEN CUR_FILTERELEMENTS;
	FETCH NEXT FROM CUR_FILTERELEMENTS INTO @FilterElementID;

	WHILE @@FETCH_STATUS = 0 BEGIN
		SET @RTN_AdvancedFilterString = @RTN_AdvancedFilterString
				+ CASE WHEN @FilterElementIndex IS NULL THEN 'AND ' ELSE '' END
				+ '(' + CHAR(13)

		-- **************************************************************************************************

		DECLARE CUR CURSOR FOR
			SELECT
				FilterElementID
			,	FilterTypeID
			,	FilterOperatorID
			,	DataField
			,	FilterValue
			,	FilterValue_LBOUND
			,	FilterValue_UBOUND
			,	FilterString
			,   SEID
			FROM @AdvFilterTable
			WHERE FilterElementID = @FilterElementID;

		OPEN CUR;

		FETCH NEXT FROM CUR INTO
			@FilterElementID
		,	@FilterTypeID
		,	@FilterOperatorID
		,	@DatabaseColumnName
		,	@FilterValue
		,	@FilterValue_LBOUND
		,	@FilterValue_UBOUND
		,	@FilterString
		,   @FilterSEID
		;

		WHILE @@FETCH_STATUS = 0 BEGIN
			--IF @FilterElementIndex IS NOT NULL
			--	SET @FilterElementIndex = @FilterElementID;

			SET @RTN_AdvancedFilterString = @RTN_AdvancedFilterString
					+	CASE WHEN @FilterElementIndex IS NOT NULL THEN 'OR ' ELSE '' END
					+	CASE @FilterOperatorID
							WHEN 5 /*EQUALS (NUMERIC)*/ THEN REPLACE(@FilterString, '<OPERATOR>', ' = ')
							WHEN 8 /*EQUALS (TEXT)*/ THEN REPLACE(@FilterString, '<OPERATOR> ', ' = N')
							WHEN 6 /*CONTAINS*/ THEN 'CHARINDEX(N''' + @FilterValue + ''', ' + QUOTENAME(@DatabaseColumnName) + ') != 0'
							WHEN 7 /*NOT CONTAINS*/ THEN 'CHARINDEX(N' + QUOTENAME(@FilterValue, '''') + ', ' + QUOTENAME(@DatabaseColumnName) + ') = 0'
							WHEN 1 /*GT*/ THEN REPLACE(@FilterString, '<OPERATOR>', ' > ')
							WHEN 2 /*GTE*/ THEN REPLACE(@FilterString, '<OPERATOR>', ' >= ')
							WHEN 3 /*LT*/ THEN REPLACE(@FilterString, '<OPERATOR>', ' < ')
							WHEN 4 /*LTE*/ THEN REPLACE(@FilterString, '<OPERATOR>', ' <= ')


							WHEN 12/*BETWEEN*/ THEN
													(
														QUOTENAME(@DatabaseColumnName)
														+ ' >= '
														+ @FilterValue_LBOUND
														+ ' AND '
														+ QUOTENAME(@DatabaseColumnName)
														+ ' < '
														+ @FilterValue_UBOUND
													)
							WHEN 13/*FUTURE*/ THEN QUOTENAME(@DatabaseColumnName) + ' > GETUTCDATE()'
							WHEN 14/*NOT FUTURE*/ THEN QUOTENAME(@DatabaseColumnName) + ' IS NULL OR ' + QUOTENAME(@DatabaseColumnName) + ' <= GETUTCDATE()'
							ELSE '1 = 1'
						END
					+ CHAR(13);
			
			--SET @RTN_AdvancedFilterString = ''
			
			-- HANDLE SPECIAL CASE FOR GOOGLE QUALITY SCORE
			IF @DatabaseColumnName = 'QualityScore' BEGIN
				SET @RTN_AdvancedFilterString = REPLACE
												(
													@RTN_AdvancedFilterString
												--,	'[QualityScore]  >  1'
												--,	'1=1'
												,	'[QualityScore]'
												,	'(SEID NOT IN (SELECT SEID FROM SearchEngine WHERE ParentSEID = 1)) OR [QualityScore]'
												);
			END
			;

			SET @FilterElementIndex = @FilterElementID;

			FETCH NEXT FROM CUR INTO
				@FilterElementID
			,	@FilterTypeID
			,	@FilterOperatorID
			,	@DatabaseColumnName
			,	@FilterValue
			,	@FilterValue_LBOUND
			,	@FilterValue_UBOUND
			,	@FilterString
			,   @FilterSEID
			;
		END;

		CLOSE CUR;
		DEALLOCATE CUR;

		SET @FilterElementIndex = NULL;
		SET @RTN_AdvancedFilterString = @RTN_AdvancedFilterString + CHAR(13) + ')' + CHAR(13);
		FETCH NEXT FROM CUR_FILTERELEMENTS INTO @FilterElementID;
	END;

	CLOSE CUR_FILTERELEMENTS;
	DEALLOCATE CUR_FILTERELEMENTS;
	
	-- **************************************************************************************************
	-- Targeting Location ADVANCED FILTER HERE!!!!!!
	-- **************************************************************************************************
	IF (@PublisherFilterTypeID IN
			(
				SELECT PublisherFilterTypeID
				FROM dbo.LUPublisherFilterType
				WHERE PublisherFilterType IN ('Campaign')
			)
		) AND EXISTS
		(
			(
		select 1 from @AdvFilterTable  where DataField  = 'Location' 
		)				
		) BEGIN

		set @CurrentFilterElementID =-1;
	
		
		DECLARE CUR CURSOR FOR
			SELECT * FROM @AdvFilterTable WHERE  DataField = 'Location' order by FilterElementID;;

		OPEN CUR;

		FETCH NEXT FROM CUR INTO
			@FilterElementID
		,	@FilterTypeID
		,	@FilterOperatorID
		,	@DatabaseColumnName
		,	@FilterValue
		,	@FilterString
		,   @FilterSEID
		;

		WHILE @@FETCH_STATUS = 0 
		BEGIN
				if @CurrentFilterElementID <> @FilterElementID
				BEGIN				
							set @CurrentFilterElementID=@FilterElementID
				
								
				DECLARE @LocationList nvarchar(max)
				SET @LocationList = ''
				SELECT @LocationList = @LocationList + Cast(FilterValue As nvarchar(8)) + ','
				FROM @AdvFilterTable WHERE  DataField = 'Location' and FilterElementID = @FilterElementID

				SET @LocationList = '(' + SUBSTRING(@LocationList, 1, Len(@LocationList) - 1) + ')'
				
				-- INITIALIZE NEW SET OF FILTERS
				SET @RTN_AdvancedFilterString = @RTN_AdvancedFilterString + 'AND (' + CHAR(13);
				
				SET @RTN_AdvancedFilterString = @RTN_AdvancedFilterString + 'CampaignID in (' + CHAR(13);
				SET @RTN_AdvancedFilterString = @RTN_AdvancedFilterString + 'select distinct cmp2.campaignid' + CHAR(13) +
						'from 	Campaign cmp2' + CHAR(13) +
								'inner join CampaignSearchEngine cse on cmp2.CampaignID = cse.CampaignID ' + CHAR(13) +
								'inner join SearchEngine se on cse.SEID =se.SEID and se.ParentSEID = '  + cast(@FilterSEID as nvarchar(6))  + CHAR(13) +
				'	left join dbo.Campaign_TargetingLocation ctl on ctl.CampaignID = cmp2.CampaignID ' + CHAR(13) +
								'left join dbo.Campaign_TargetingLocation ctl2 on ctl2.CampaignID = cmp2.CampaignID and ctl2.isexcluded = 0 ' + CHAR(13) +
								'left join TargetingLocation tl  ' + CHAR(13) +
								'on ctl.TargetingLocationId=tl.TargetingLocationId and tl.TargetingLocationTypeID in (1,2,3,4) ' + CHAR(13) +
				',(select AdvancedFilterCode from TargetingLocation where TargetingLocationID in ' + @LocationList + ') tl2' + CHAR(13) +
				'where ' + CHAR(13) +
				'(' + CHAR(13) +
				'	(' + CHAR(13) +
				'	   ((charindex(tl.AdvancedFilterCode,tl2.AdvancedFilterCode) > 0  and ctl.isExcluded=0) or (charindex(tl2.AdvancedFilterCode,tl.AdvancedFilterCode) > 0  and ctl.isExcluded=0))' + CHAR(13) +
				'									  or' + CHAR(13) +
    			'									(ctl2.CampaignID is null)' + CHAR(13) +
				'	)' + CHAR(13) +
				'	AND' + CHAR(13) +
				'	(' + CHAR(13) +
				'		NOT (charindex(tl.AdvancedFilterCode,tl2.AdvancedFilterCode) > 0  and ctl.isExcluded=1)' + CHAR(13) +
				'		or ' + CHAR(13) +
				'		ctl.CampaignID is null' + CHAR(13) +
				'	)' + CHAR(13) +
				'	AND ' + CHAR(13) +
				'		se.ParentSEID is not null ' + CHAR(13) +
				')' + CHAR(13) +
				')';
		SET @RTN_AdvancedFilterString = @RTN_AdvancedFilterString + CHAR(13) + ')' + CHAR(13);					
		END
		
					FETCH NEXT FROM CUR INTO
				@FilterElementID
			,	@FilterTypeID
			,	@FilterOperatorID
			,	@DatabaseColumnName
			,	@FilterValue
			,	@FilterString
				,   @FilterSEID
			;
		END;

		CLOSE CUR;
		DEALLOCATE CUR;
				
				-- CLOSE Targeting Location FILTER
		
		END
		-- **************************************************************************************************
	-- Targeting Language ADVANCED FILTER HERE!!!!!!
	-- **************************************************************************************************
		IF (@PublisherFilterTypeID IN
			(
				SELECT PublisherFilterTypeID
				FROM dbo.LUPublisherFilterType
				WHERE PublisherFilterType IN ('Campaign')
			)
		) AND EXISTS
		(
			(
		select 1 from @AdvFilterTable  where DataField  = 'Language' 
		)				
		) BEGIN
	
		set @CurrentFilterElementID =-1;

						
		DECLARE CUR CURSOR FOR
			SELECT * FROM @AdvFilterTable WHERE  DataField = 'Language' order by FilterElementID;

		OPEN CUR;

		FETCH NEXT FROM CUR INTO
			@FilterElementID
		,	@FilterTypeID
		,	@FilterOperatorID
		,	@DatabaseColumnName
		,	@FilterValue
		,	@FilterString
		,   @FilterSEID
		;

		WHILE @@FETCH_STATUS = 0 
		BEGIN
				if @CurrentFilterElementID <> @FilterElementID
				BEGIN				
							set @CurrentFilterElementID=@FilterElementID
							
							
							declare @TableExistCheck nvarchar(100);
								
							DECLARE @LanguageList nvarchar(max);
							SET @LanguageList = '';
							SELECT @LanguageList = @LanguageList + Cast(FilterValue As nvarchar(8)) + ','
							FROM @AdvFilterTable WHERE  DataField = 'Language' and FilterElementID = @FilterElementID
							
							SET @LanguageList = '(' + SUBSTRING(@LanguageList, 1, Len(@LanguageList) - 1) + ')';
			   					
							
							-- INITIALIZE NEW SET OF FILTERS
							SET @RTN_AdvancedFilterString = @RTN_AdvancedFilterString + 'AND (' + CHAR(13);

								SET @RTN_AdvancedFilterString = @RTN_AdvancedFilterString + 'CampaignID in (' + CHAR(13);
							
							SET @RTN_AdvancedFilterString = @RTN_AdvancedFilterString + 'select distinct cmp2.campaignid ' + CHAR(13) +
							'from ' + CHAR(13) +
							'Campaign cmp2 ' + CHAR(13) +
							'inner join CampaignSearchEngine cse on cmp2.CampaignID = cse.CampaignID ' + CHAR(13) +
							'inner join SearchEngine se on cse.SEID =se.SEID and se.ParentSEID = ' +  cast(@FilterSEID as nvarchar(6))  + CHAR(13) +
							'left join Campaign_LUTargetingLanguage  ctl on ctl.CampaignID = cmp2.CampaignID ' + CHAR(13) +
							'left join LUTargetingLanguage tl  ' + CHAR(13) +
							'on ctl.TargetingLanguageId=tl.TargetingLanguageId ' + CHAR(13) +
							'and tl.ParentSEID = ' + cast(@FilterSEID as nvarchar(6))  + CHAR(13) +
							'where ' + CHAR(13) +
							'(' + CHAR(13) +
							'	(' + CHAR(13) +
							'		(' + CHAR(13) 

							if @FilterOperatorID = '9' --IS 
							SET @RTN_AdvancedFilterString = @RTN_AdvancedFilterString + ' exists (select 1 from Campaign_LUTargetingLanguage ctl2 where ctl.TargetingLanguageID=ctl2.TargetingLanguageID and ctl.CampaignID = ctl2.CampaignID and ctl2.TargetingLanguageID in ' + @LanguageList + ')' + CHAR(13) 
							if @FilterOperatorID = '10' --IS NOT
							--SET @RTN_AdvancedFilterString = @RTN_AdvancedFilterString + ' cmp2.CampaignID NOT IN (select ctl2.campaignid from Campaign_LUTargetingLanguage ctl2 where ctl2.TargetingLanguageID in ' + @LanguageList + ')' + CHAR(13) 
							SET @RTN_AdvancedFilterString = @RTN_AdvancedFilterString + ' not exists (select 1 from Campaign_LUTargetingLanguage ctl2 where ctl.CampaignID = ctl2.CampaignID and ctl2.TargetingLanguageID in ' + @LanguageList + ')' + CHAR(13) 				
							
							SET @RTN_AdvancedFilterString = @RTN_AdvancedFilterString + '		)' + CHAR(13) +
							'' + CHAR(13) +
							'	or' + CHAR(13) +
							'		ctl.CampaignID is null' + CHAR(13) +
							'	)' + CHAR(13) +
							'	AND ' + CHAR(13) +
							'		se.ParentSEID is not null' + CHAR(13) + 
							') )';	
								SET @RTN_AdvancedFilterString = @RTN_AdvancedFilterString + CHAR(13) + ')' + CHAR(13);				
					END
				FETCH NEXT FROM CUR INTO
				@FilterElementID
			,	@FilterTypeID
			,	@FilterOperatorID
			,	@DatabaseColumnName
			,	@FilterValue
			,	@FilterString
			,   @FilterSEID
			;
		END;

		CLOSE CUR;
		DEALLOCATE CUR;
				
				-- CLOSE Targeting Language FILTER
			

		END
	-- **************************************************************************************************
	-- BID RULES ADVANCED FILTER HERE!!!!!!
	-- **************************************************************************************************
	IF (@PublisherFilterTypeID IN
			(
				SELECT PublisherFilterTypeID
				FROM dbo.LUPublisherFilterType
				WHERE PublisherFilterType IN ('Group', 'Keyword')
			)
		) AND EXISTS
		(
			SELECT 1
			FROM @AdvancedFilterXML.nodes('//filterelement') AS ADV(GLOBAL_BID_RULES)
			WHERE
				ADV.GLOBAL_BID_RULES.value('@filtertypeid', 'INT') = @FilterTypeID_GLOBAL_BID_RULES
				AND ADV.GLOBAL_BID_RULES.value('@publisherfiltertypeid', 'INT') <= @PublisherFilterTypeID
				
		) BEGIN

		-- INITIALIZE NEW SET OF FILTERS
		SET @RTN_AdvancedFilterString = @RTN_AdvancedFilterString + 'AND (' + CHAR(13);

		-- DELCARE BID METHOD TEMP TABLE
		DECLARE @tmpBidMethod TABLE (BidMethodFilter NVARCHAR(64));

		-- POPULATE BID/OPT METHOD TABLE VARIABLE
		WITH BidGroupID AS
		(
			SELECT '(BidRuleID = ' + CONVERT(NVARCHAR, ADV.FILTERATTRIB.value('.', 'INT')) + ')' AS BidMethodFilter
			FROM @AdvancedFilterXML.nodes('//bidrules/value') AS ADV(FILTERATTRIB)
		)
		,
		OptGroupID AS
		(
			SELECT '(SPOTID = ' + CONVERT(NVARCHAR, ADV.FILTERATTRIB.value('.', 'INT')) + ')' AS BidMethodFilter
			FROM @AdvancedFilterXML.nodes('//optgroups/value') AS ADV(FILTERATTRIB)
		)
		INSERT INTO @tmpBidMethod (BidMethodFilter)
			SELECT BidMethodFilter FROM BidGroupID
			UNION ALL
			SELECT BidMethodFilter FROM OptGroupID
		;

		-- IF ANY BID/OPT GROUPS HAVE BEEN SELECTED, THEN FILTER THE SPECIFIC METHOD BY ID
		IF @@ROWCOUNT != 0 BEGIN
			DECLARE CUR_BIDRULEGROUPIDS CURSOR FOR
				SELECT BidMethodFilter FROM @tmpBidMethod
			;

			-- OPEN BID METHOD CURSOR		
			OPEN CUR_BIDRULEGROUPIDS;
			FETCH NEXT FROM CUR_BIDRULEGROUPIDS INTO @BidMethodFilter;
			
			WHILE (@@FETCH_STATUS = 0) BEGIN
				SET @RTN_AdvancedFilterString = @RTN_AdvancedFilterString
					+ CASE WHEN ISNULL(@IsConcat, 0) = 0 THEN '' ELSE CHAR(13) + ' OR ' END
					+ @BidMethodFilter
				;
				
				SET @IsConcat = 1;
				FETCH NEXT FROM CUR_BIDRULEGROUPIDS INTO @BidMethodFilter;
			END;

			-- CLEAN UP BID METHOD CURSORR
			CLOSE CUR_BIDRULEGROUPIDS;
			DEALLOCATE CUR_BIDRULEGROUPIDS;
		END;

		ELSE
		
		BEGIN -- FILTER BY BID RULE TYPES
			-- GET BID METHODS

			DECLARE CUR_BIDMETHOD CURSOR FOR
				WITH BidMethod AS
				(
					SELECT
						ADV.FILTERATTRIB.value('@publisherfiltertypeid', 'INT') AS PublisherFilterTypeID
					,	ADV.FILTERATTRIB.value('@filtertypeid', 'INT') AS FilterTypeID
					,	FILTERELEM.ELEM.value('.', 'NVARCHAR(MAX)') AS BidRuleTypeID
					--,	FILTERELEM.ELEM.value('@filterelementid', 'INT') AS FilterElementID
					FROM
						@AdvancedFilterXML.nodes('//advancedfilter/filterelement') AS ADV(FILTERATTRIB)
						CROSS APPLY ADV.FILTERATTRIB.nodes('values/value') AS FILTERELEM(ELEM)
					WHERE
						ADV.FILTERATTRIB.value('@filtertypeid', 'INT') = @FilterTypeID_GLOBAL_BID_RULES
				)
				SELECT
				--	bm.BidRuleTypeID
					CONVERT(INT, brt.BidRuleTypeID) AS BidRuleTypeID
				FROM
					BidMethod AS bm
					LEFT JOIN dbo.LUBidRuleType AS brt ON brt.BidRuleTypeID = bm.BidRuleTypeID
				;
			
			-- OPEN BID RULE TYPE CURSOR
			OPEN CUR_BIDMETHOD;
			FETCH NEXT FROM CUR_BIDMETHOD INTO @BidRuleTypeID;
			
			WHILE @@FETCH_STATUS = 0 BEGIN
				SET @RTN_AdvancedFilterString = @RTN_AdvancedFilterString
					+ CASE WHEN @FilterElementIndex IS NOT NULL THEN ' OR ' ELSE '' END
					+
						CASE
							WHEN @BidRuleTypeID IS NOT NULL THEN '(BidRuleTypeID = ' + CONVERT(VARCHAR, @BidRuleTypeID) + ')'
							ELSE 'IsSPOT = 1'--'(SPOTID IS NOT NULL)'
						END
					+ CHAR(13)
				;
				SET @FilterElementIndex = 999;
			
				FETCH NEXT FROM CUR_BIDMETHOD INTO @BidRuleTypeID;
			END;

			CLOSE CUR_BIDMETHOD;
			DEALLOCATE CUR_BIDMETHOD;
		END;

		-- CLOSE BID METHOD FILTER
		SET @RTN_AdvancedFilterString = @RTN_AdvancedFilterString + CHAR(13) + ')' + CHAR(13);

	END;

	-- **************************************************************************************************

	RETURN @RTN_AdvancedFilterString;
END;







GO

GRANT EXECUTE ON [dbo].[fn_CampaignManagementAdvancedFilter] TO [webaccess] AS [dbo]
GO

