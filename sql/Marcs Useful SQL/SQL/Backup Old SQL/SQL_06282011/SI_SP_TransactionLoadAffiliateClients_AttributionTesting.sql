USE [SIProcessing_CacheHistory]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SI_SP_TransactionLoadAffiliateClients_AttributionTesting]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SI_SP_TransactionLoadAffiliateClients_AttributionTesting]
GO

USE [SIProcessing_CacheHistory]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

      
               
CREATE PROC [dbo].[SI_SP_TransactionLoadAffiliateClients_AttributionTesting]    
    (    
      @ModGroup INT = NULL,    
      @AffiliateID INT = NULL,    
      @BeginDate DATETIME = NULL,    
      @EndDate DATETIME = NULL,    
      @Debug TINYINT = 0,    
      @TrackedQueueHeaderID INT = NULL,    
      @isWebService BIT = 0                   
    )    
AS     
/*                     
05/11/09 Version 1.00 Initial version                      
05/11/09	LIR Change the retrys to 10                      
05/12/09	LIR Changed to EasternCreatedate on  EXEC SI_SP_TransactionAffiliate @ClientID, @BeginDate, @EndDate,1                      
				Also changed	SET @EndDate = DATEADD(dd,1,GETDATE())                      
								set @BeginDate =DATEADD(dd,-1,GETDATE())                      
05/12/90	LIR added code to handle a singe Affiliate group                      
07/21/09	LIR modified code to look back 48 hours                      
04/20/10	LIR Added code to not delete pageview records based on checksum = null          
01/01/11	LIR TrackedExposureID is larger than an INT, modified the code to set the temp table to bigint        
					and to not load the NTID and CTID columns in the TrackedCache table                    
01/26/11	LIR Added TrackedActionID < 0 to better use indexes             
02/25/11	LIR Added logic to only process affialategroups that do not  have clients in different timezones                        
03/22/11	LIR Added code to call the new TE3 storedprocedures
     
SI_SP_TransactionLoadAffiliateClients_AttributionTesting                        
	@AffiliateID = null                      
	,@Debug =1                      
	,@BeginDate = NULL                      
	,@EndDate = NULL            
         
              
--TEST OUTSIDE OF PROC                      
DECLARE         
	@ModGroupID INT                       
	,@BeginDate DATETIME                       
	,@EndDate DATETIME                       
	,@ProcessAffiliate TINYINT                      
	,@ClientID INT = NULL         
	,@Debug TINYINT = 1        
	,@AffiliateID TINYINT           
	,@ModGroup TINYINT             
	,@TrackedQueueHeaderID INT  = NULL            
                         
SET @ModGroupID = NULL                      
SET @BeginDate ='12/30/2010'                     
SET @EndDate ='01/01/2011'                    
SET @ProcessAffiliate = NULL                      
SET @ClientID = 115          
SET @AffiliateID  =  252          
        
IF OBJECT_ID('TEMPDB..#TEMP') IS NOT NULL         
	DROP TABLE #TEMP        
--TEST OUTSIDE OF PROC          
 */                    
BEGIN                      
    DECLARE 
		@SQLString AS VARCHAR(200),    
        @cnt INT,    
        @TrackedQueueId INT,    
        @retry INT,    
        @err INT,    
        @ProcessStart DATETIME,    
        @ClientID INT,    
        @ReprocessAllID INT,    
        @isRepeat TINYINT,    
        @TotalCount INT                       
                     
    SET @TotalCount = 0                         
                     
    DECLARE @Clients TABLE    
        (    
          ClientID INT,    
          AffiliateID INT    
        )                      
        
    DECLARE @AffiliateGroup TABLE    
        (    
          AffiliateID INT    
        )                   
    CREATE TABLE #Temp    
        (    
          [EasternCreateDate] [datetime] NOT NULL,    
          [TID] [bigint] NOT NULL,    
          [NTID] [bigint] NOT NULL,    
          [CSKID] [int] NULL,    
          [TransactionAmount] [float] NULL,    
          [CreatedDate] [datetime] NOT NULL,    
          [SessionGUID] [varchar](36) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL,    
          [TransactionTypeID] [tinyint] NULL,    
          [MoreInfo] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,    
          [N1] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,    
          [N2] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,    
          [N3] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,    
          [N4] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,    
          [N5] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,    
          [N6] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,    
          [N7] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,    
          [N8] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,    
          [N9] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,    
          [N10] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,    
          [X1] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,    
          [X2] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,    
          [X3] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,    
          [X4] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,    
          [X5] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,    
          [X6] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,    
          [X7] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,    
          [X8] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,    
          [X9] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,    
          [X10] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,    
          [CustomerTransactionTypeID] [int] NULL,    
          [loginfo] [nvarchar](MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,    
          [iscontentmatch] [bit] NULL,    
          [CTID] [BIGint] NOT NULL,    
          [NCTID] [BIGint] NOT NULL,    
          [ClickTime] [datetime] NULL,    
          [LatencyInSeconds] [int] NULL,    
          [UserUniqueGUID] [varchar](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,    
          [ClientID] [int] NOT NULL,    
          [ReferenceID] [int] NULL,    
          [SEID] [int] NULL,    
          [NSEID] [int] NULL,    
          [PublisherID] [int] NOT NULL,    
          [CkeywordID] [int] NULL,    
          [AdCategoryID] [int] NULL,    
          [CampaignID] [int] NULL,    
          [OrigClientID] [int] NOT NULL,    
          [ExtraInfo1] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,    
          [OrigTransactionAmt] [money] NULL,    
          [CurrencyID] [int] NULL,    
          [OrigCurrencyID] [int] NULL,    
          [WebServerID] [int] NULL,    
          [AccessServerID] [int] NULL,    
          [TrackedActionID] [bigint] NOT NULL,    
          [TrackedExposureID] [bigint] NOT NULL,    
          [ChannelID] [int] NULL,    
          [ActionWeightPct] [numeric](3, 2) NOT NULL,    
          [ActionWeightFactor] [float] NULL,    
          [AttributedExposures] [int] NULL,    
          [ExposureSequence] [bigint] NULL,    
          [ActionQuantity] [float] NULL,    
          [KeywordID] [int] NULL,    
          [Keyword] [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,    
          [ExposureTypeID] [int] NULL,    
          [PaidInclusion] [int] NOT NULL,    
          [USDExchangeRate] [money] NULL,    
          [BinaryCheckSum] [INT] NOT NULL    
        )                      
    CREATE CLUSTERED INDEX [TrackedActionID_TrackedExposureID_BinaryCheckSum]    
        ON #Temp ( [TrackedActionID] ASC, [TrackedExposureID] ASC, [BinaryCheckSum] ASC )    
    ON  [PRIMARY];                      
                  
    
--Get a list of Affiliategroups that don't have clients with different timezone setup    
	WITH AffiliateCTE AS    
	(    
	SELECT     
		AffiliateID    
		,TimeZoneDisplayID    
		,TimeZoneID     
		,agc.ClientID    
	FROM AffiliateGroupClients agc    
		JOIN clients c ON agc.ClientID = c.ClientID    
	WHERE c.StatusFlag =1    
		AND agc.StatusFlag = 1    
	)    
	INSERT INTO @AffiliateGroup(AffiliateID)    
	SELECT DISTINCT AffiliateID 
	FROM dbo.AffiliateGroupClients    
	WHERE AffiliateID NOT IN    
		(SELECT DISTINCT a.AffiliateID     
		FROM AffiliateCTE a    
		JOIN AffiliateCTE a1 ON a.AffiliateID = a1.AffiliateID    
			AND    
    (    
     (a.TimeZoneDisplayID != a1.TimeZoneDisplayID)    
     OR    
     (a.TimeZoneID != a1.TimeZoneID)    
    )    
 )                  
--If we do not have a begin date then do one day and current date.                      
    IF @BeginDate IS NULL     
    BEGIN                      
--check to see if any reprocessdates are set.                      
        SELECT  @ReprocessAllID = ReprocessAllID,    
                @BeginDate = BeginDate,    
                @EndDate = EndDate,    
				@isRepeat = isRepeat    
        FROM    TrackedReprocessAll    
        WHERE   StatusFlag = 1    
                AND isAffiliate = 1    
                                  
        IF @BeginDate IS NULL
        BEGIN                      
            SET @EndDate = DATEADD(dd, 1, GETDATE())                      
            SET @BeginDate = DATEADD(dd, -2, GETDATE())                      
        END       
                           
        IF @Debug = 1     
        BEGIN                      
            PRINT '@EndDate = ' + CAST(@EndDate AS VARCHAR(20))            
            PRINT '@BeginDate = ' + CAST(@BeginDate AS VARCHAR(20))                      
        END                      
    END                      
                  
    IF @AffiliateID IS NOT NULL     
    BEGIN                      
        INSERT  INTO @Clients ( ClientID, AffiliateID )    
        SELECT  MIN(agc.ClientID),    
                AffiliateID    
        FROM    AffiliateGroupClients AS agc    
        WHERE   AffiliateID = @AffiliateID    
                AND affiliateid IN (SELECT AffiliateID FROM @AffiliateGroup)    
        GROUP BY AffiliateID                      
    END                      
    ELSE     
        IF @ModGroup IS NULL     
        BEGIN                      
            INSERT  INTO @Clients ( ClientID, AffiliateID )    
            SELECT  MIN(agc.ClientID),    
                    AffiliateID    
            FROM    AffiliateGroupClients AS agc    
            WHERE   affiliateID IN (    
                    SELECT DISTINCT    
                            [AffiliateID]    
                    FROM    SIProcessing_Attribution..trackedaction_AttributionTesting    
                    WHERE   CreateDateUTC >= DATEADD(dd, -1, @BeginDate)    
                            AND CreateDateUTC < DATEADD(dd, 1, @EndDate)    
                            AND affiliateid IN (SELECT AffiliateID FROM @AffiliateGroup) )    
                    AND agc.StatusFlag = 1    
            GROUP BY AffiliateID    
            ORDER BY AffiliateID                      
        END                      
        ELSE     
        BEGIN                
            INSERT  INTO @Clients ( ClientID, AffiliateID )    
			SELECT  
				MIN(agc.ClientID),    
				AffiliateID    
			FROM    AffiliateGroupClients AS agc    
			WHERE   affiliateID IN (    
				SELECT DISTINCT  [AffiliateID]    
				FROM    SIProcessing_Attribution..trackedaction_AttributionTesting    
				WHERE   CreateDateUTC >= DATEADD(dd, -1, @BeginDate)    
					AND CreateDateUTC < DATEADD(dd, 1, @EndDate)    
					AND affiliateid IN (SELECT AffiliateID FROM @AffiliateGroup) )    
					AND agc.StatusFlag = 1    
					AND affiliateID % 16 = @ModGroup    
				GROUP BY AffiliateID    
				ORDER BY AffiliateID                      
        END                      
                  
    IF @Debug = 1     
    BEGIN                      
        SELECT  *  FROM    @Clients                      
    END                      
                  
    SET @ProcessStart = GETDATE()                      
--Cursor through all clients in the list                      
    DECLARE ClientList CURSOR FOR 
		SELECT  
			ClientID
			,AffiliateID    
        FROM    @Clients    
        ORDER BY AffiliateID                      
    OPEN ClientList                      
    FETCH NEXT FROM ClientList INTO @ClientID, @AffiliateID                      
    WHILE @@FETCH_STATUS = 0                      
    BEGIN                      
        TRUNCATE TABLE #Temp                      

        INSERT  INTO #Temp    
                EXEC SI_SP_TransactionAffiliate_TE3_MarcTest @ClientID, @BeginDate, @EndDate, 0                
              
        SET @cnt = @@ROWCOUNT                      
        SET @SQLString = CONVERT(VARCHAR(20), GETDATE(), 114)    
            + ' EXEC SI_SP_TransactionAffiliate_TE3 '    
            + CAST(@ClientID AS VARCHAR(20)) + ','''    
            + CONVERT(VARCHAR(10), @BeginDate, 101) + ''','''    
            + CONVERT(VARCHAR(10), @EndDate, 101) + ''',0'       
                               
        IF @Debug = 1     
        BEGIN                      
            PRINT '@AffiliateID = ' + CAST(@AffiliateID AS VARCHAR(10))                      
            PRINT '@ClientID = ' + CAST(@ClientID AS VARCHAR(10))                      
            PRINT '@SQLString = ' + @SQLString                      
        END                      
              
        SET @retry = 0                      
        IF @cnt = 0     
            PRINT 'Skipping ' + @SQLString                      
        ELSE     
        BEGIN                      
            WHILE @retry <= 5                      
            BEGIN              
                BEGIN TRY                      
                    BEGIN TRAN                      
--Write to queue table                       
                    INSERT  INTO TrackedQueue    
					(    
						TrackedQueueHeaderID,    
						ClientID,    
						AffiliateID,    
						ProcessedDatetime,    
						GenerateBegin,    
						GenerateEnd,    
						TrackedStatusID,    
						ProcessStart,    
						RecordCount    
					)    
                    SELECT  
						@TrackedQueueHeaderID,    
                        ClientID,    
                        @AffiliateID,    
                        CONVERT(VARCHAR, GETDATE(), 110),    
                        @BeginDate,    
                        @EndDate,    
                        1,    
                        @ProcessStart,    
                        COUNT(1)    
                    FROM    #Temp    
                    GROUP BY clientid                      
         
--Delete any records for TrackeCache where not exists or changed in staged                 
                    DELETE  trackedCache_AttributionTesting   
                    WHERE   trackedCache_AttributionTesting.EasternCreateDate >= @BeginDate    
                            AND trackedCache_AttributionTesting.EasternCreateDate < @EndDate    
                            AND AffiliateID = @AffiliateID    
                            AND TrackedExposureID > 0    
                            AND TrackedActionID > 0    
                            AND NOT EXISTS ( SELECT 1    
                                             FROM   #Temp    
                                             WHERE  trackedCache_AttributionTesting.TrackedActionID = #Temp.TrackedActionID    
                                                    AND trackedCache_AttributionTesting.TrackedExposureID = #Temp.TrackedExposureID    
                                                    AND trackedCache_AttributionTesting.BinaryCheckSum = #Temp.BinaryCheckSum )                      
              
--Insert any new or modified records                      
						INSERT  trackedCache_AttributionTesting    
						(    
							[EasternCreateDate],    
							[TID],    
							[NTID],    
							[CSKID],    
							[TransactionAmount],    
							[CreatedDate],    
							[SessionGUID],    
							[TransactionTypeID],    
							[MoreInfo],    
							[N1],    
							[N2],    
							[N3],    
							[N4],    
							[N5],    
							[N6],    
							[N7],    
							[N8],    
							[N9],    
							[N10],    
							[X1],    
							[X2],    
							[X3],    
							[X4],    
							[X5],    
							[X6],    
							[X7],    
							[X8],    
							[X9],    
							[X10],    
							[CustomerTransactionTypeID],    
							[loginfo],    
							[ISContentMatch],                      
							[ClickTime],    
							[LatencyInSeconds],    
							[UserUniqueGuid],    
							[ClientID],    
							[KeywordID],    
							[ReferenceID],    
							[SEID],    
							[NSEID],    
							[PublisherID],    
							[CKeywordID],    
							[AdCategoryID],    
							[CampaignID],    
							[OrigClientID],    
							[ExtraInfo1],    
							[OrigTransactionAmt],    
							[CurrencyID],    
							[OrigCurrencyID],    
							[WebServerID],    
							[AccessServerID],    
							[TrackedActionID],    
							[TrackedExposureID],    
							[ChannelID],    
							[ActionWeightPct],    
							[ActionWeightFactor],    
							[AttributedExposures],    
							[ExposureSequence],    
							[ActionQuantity],    
							[Keyword],    
							[ExposureTypeID],    
							[PaidInclusion],    
							AffiliateID,    
							BinaryCheckSum,    
							USDExchangeRate    
                        )    
                        SELECT  
							tt.[EasternCreateDate],    
							tt.[TID],    
							tt.[NTID],    
							tt.[CSKID],    
							tt.[TransactionAmount],    
							tt.[CreatedDate],    
							tt.[SessionGUID],    
							tt.[TransactionTypeID],    
							tt.[MoreInfo],    
							tt.[N1],    
							tt.[N2],    
							tt.[N3],    
							tt.[N4],    
							tt.[N5],    
							tt.[N6],    
							tt.[N7],    
							tt.[N8],    
							tt.[N9],    
							tt.[N10],    
							tt.[X1],    
							tt.[X2],    
							tt.[X3],    
							tt.[X4],    
							tt.[X5],    
							tt.[X6],    
							tt.[X7],    
							tt.[X8],    
							tt.[X9],    
							tt.[X10],    
							tt.[CustomerTransactionTypeID],    
							tt.[loginfo],    
							tt.[ISContentMatch],                      
							tt.[ClickTime],    
							tt.[LatencyInSeconds],    
							tt.[UserUniqueGuid],    
							tt.[ClientID],    
							tt.[KeywordID],    
							tt.[ReferenceID],    
							tt.[SEID],    
							tt.[NSEID],    
							tt.[PublisherID],    
							tt.[CKeywordID],    
							tt.[AdCategoryID],    
							tt.[CampaignID],    
							tt.[OrigClientID],    
							tt.[ExtraInfo1],    
							tt.[OrigTransactionAmt],    
							tt.[CurrencyID],    
							tt.[OrigCurrencyID],    
							tt.[WebServerID],    
							tt.[AccessServerID],    
							tt.[TrackedActionID],    
							tt.[TrackedExposureID],    
							tt.[ChannelID],    
							tt.[ActionWeightPct],    
							tt.[ActionWeightFactor],    
							tt.[AttributedExposures],    
							tt.[ExposureSequence],    
							tt.[ActionQuantity],    
							tt.[Keyword],    
							tt.[ExposureTypeID],    
							tt.[PaidInclusion],    
							@AffiliateID,    
							tt.BinaryCheckSum,    
							TT.USDExchangeRate    
                        FROM    #Temp tt    
                                LEFT JOIN TrackedCache_AttributionTesting tc ON tt.TrackedActionID = tc.TrackedActionID    
                                                             AND tt.TrackedExposureID = tc.TrackedExposureID    
                        WHERE   tc.TrackedActionID IS NULL                      
                    COMMIT                      
                    BREAK                      
                END TRY                      
                BEGIN CATCH                      
                    WAITFOR DELAY '00:00:10' ;                      
                    WHILE @@TRANCOUNT > 0    
                        ROLLBACK                      
                    SELECT  @retry = @retry + 1                      
                    SELECT  @err = ERROR_NUMBER()                       
                    DECLARE @msg VARCHAR(2000)                          
                    SELECT  @msg = ERROR_MESSAGE()                      
                    IF @retry > 5 OR @err NOT IN ( 1205, 3930 )     
                    BEGIN                      
                        RAISERROR ( 'SI_SP_LoadTables errored (%d) times, the error number %d text %s.',  16, 1, @retry, @err, @msg )                      
                        UPDATE  TrackedQueue    
                        SET     TrackedStatusID = 99,    
                                GenerateEnd = @EndDate,    
                                RecordCount = @cnt,    
                                ProcessEnd = GETDATE(),    
                                ErrorMessage = @Err    
                        WHERE   TrackedQueueId = @TrackedQueueId                         
                        BREAK                      
                    END                      
                END CATCH                      
                END --While loop                         
            END                      
            IF @retry <= 5     
			BEGIN                      
				UPDATE  TrackedQueue    
					SET     TrackedStatusID = 2,    
                            ProcessEnd = GETDATE()    
                WHERE   AffiliateID = @AffiliateID    
                    AND ProcessStart = @ProcessStart                      
                      
                SET @TotalCount = @TotalCount + @cnt                            
            END                      
            FETCH NEXT FROM ClientList INTO @ClientID, @AffiliateID                      
        END                      
    CLOSE ClientList                      
    DEALLOCATE ClientList                      
                    
    IF @TrackedQueueHeaderID IS NOT NULL     
    BEGIN                      
        UPDATE  TrackedQueueHeader    
        SET     RecordCount = RecordCount + @TotalCount,    
                StatusMessage = StatusMessage + ': Mod group ' + CAST(@modgroup AS VARCHAR(5)) + ' Complete'    
        WHERE   TrackedQueueHeaderID = @TrackedQueueHeaderID                      
    END              
END         


GO


