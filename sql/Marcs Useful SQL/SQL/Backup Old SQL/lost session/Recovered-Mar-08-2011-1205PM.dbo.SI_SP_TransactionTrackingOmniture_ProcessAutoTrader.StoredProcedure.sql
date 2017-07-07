USE [SIProcessing]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SI_SP_TransactionTrackingOmniture_ProcessAutoTrader]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SI_SP_TransactionTrackingOmniture_ProcessAutoTrader]
GO

USE [SIProcessing]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



 
CREATE PROC [dbo].[SI_SP_TransactionTrackingOmniture_ProcessAutoTrader] ( @debug BIT = 0 )
AS /*
03/02/2011 MRS Initial-Custom AutoTrader Integration

[SI_SP_TransactionTrackingOmniture_ProcessAutoTrader] 1

SELECT * FROM TransactionTrackingOmnitureFileLoad

*/
    BEGIN 

        IF OBJECT_ID('tempdb..#CONVERT') IS NOT NULL 
            DROP TABLE #CONVERT ;
        
        IF OBJECT_ID('tempdb..#AutoTrader_Processing') IS NOT NULL 
            DROP TABLE #AutoTrader_Processing ;        
        
        DECLARE @ProcessID INT,
			@TransactionCount INT,
			@CSKID INT,
            @SETitleID BigINT,
            @IsContentMatch INT,
            @GenerateDate SMALLDATETIME,
            @StartDate SMALLDATETIME,
            @EndDate SMALLDATETIME,
            @ColumnHeaders NVARCHAR(MAX),	-- comma-separated list
            @ColumnValues NVARCHAR(MAX),
            @sqltxt VARCHAR(MAX)   

        IF EXISTS ( SELECT TOP 1 1 FROM    TransactionTrackingOmniture_AT_Raw ) 
            BEGIN
                SELECT  DATEADD(dd, -1, CAST(GenerateDate AS DATE)) AS GenerateDAte,
                        CAST(CSKID AS INT) AS CSKID,
                        CAST(ExternalADID AS BIGINT) AS SETitleID,
                        CASE CAST(isContent AS BIT)
                          WHEN 0 THEN 1
                          ELSE 0
                        END AS IsContentMatch,
                        CAST(CustomerTransactionType AS VARCHAR(MAX)) AS CustomerTransactionType,
                        TransactionCount
                INTO    #CONVERT
                FROM    TransactionTrackingOmniture_AT_Raw ttar
                WHERE   PATINDEX('%[A,Z]%', ExternalADID) = 0
                        AND PATINDEX('%[A,Z]%', CSKID) = 0
                        AND ( isContent = '0'
                              OR isContent = '1'
                            )
                        AND TransactionCount > 0
                        
               SELECT @ProcessID = MAX(ProcessID) FROM  TransactionTrackingOmnitureFileLoad
                        
                UPDATE TransactionTrackingOmnitureFileLoad
				SET OmnitureFileLoadStatusID = 5
				WHERE ProcessID = @ProcessID AND OmnitureFileLoadStatusID = 4

				-- Make Comma Delimited List using mxl
                SELECT  con.GenerateDate,
                        con.CSKID,
                        con.SETitleID,
                        con.IsContentMatch,
                        SUBSTRING(RTRIM(REPLACE(REPLACE(t.list,
                                                        '<CustomerTransactionType>',
                                                        ''),
                                                '</CustomerTransactionType>',
                                                ', ')), 1,
                                  LEN(RTRIM(REPLACE(REPLACE(t.list,
                                                            '<CustomerTransactionType>',
                                                            ''),
                                                    '</CustomerTransactionType>',
                                                    ', '))) - 1) AS ColumnHeaders,
                        REPLACE(RTRIM(REPLACE(REPLACE(c.list,
                                                      '<TransactionCount>', ''),
                                              '</TransactionCount>', ' ')),
                                ' ', ', ') AS ColumnValues
                INTO    #AutoTrader_Processing
                FROM    #CONVERT con
                        CROSS APPLY ( SELECT    CustomerTransactionType
                                      FROM      #CONVERT
                                      WHERE     con.GenerateDate = GenerateDate
                                                AND con.CSKID = CSKID
                                                AND con.SETitleID = SETitleID
                                                ANd con.IsContentMatch = IsContentMatch
                                      order by  GenerateDate,
                                                CSKID,
                                                SETitleID,
                                                IsContentMatch
                                    FOR
                                      XML PATH('')
                                    ) t ( list )
                        CROSS APPLY ( SELECT    TransactionCount
                                      FROM      #CONVERT
                                      WHERE     con.GenerateDate = GenerateDate
                                                AND con.CSKID = CSKID
                                                AND con.SETitleID = SETitleID
                                                ANd con.IsContentMatch = IsContentMatch
                                      order by  GenerateDate,
                                                CSKID,
                                                SETitleID,
                                                IsContentMatch
                                    FOR
                                      XML PATH('')
                                    ) c ( list )
                group by con.GenerateDate,
                        con.CSKID,
                        con.SETitleID,
                        con.IsContentMatch,
                        t.list,
                        c.list
        
                IF @debug = 1 
                    SELECT  * FROM    #AutoTrader_Processing
                    
                    
                    
                    DECLARE Processing_cursor CURSOR FAST_FORWARD FOR
						SELECT CSKID, SETitleID,IsContentMatch,GenerateDate,ColumnHeaders,ColumnValues
					FROM #AutoTrader_Processing 
					
					OPEN Processing_cursor

					FETCH NEXT FROM Processing_cursor
					INTO  @CSKID,@SETitleID,@IsContentMatch,@GenerateDate,@ColumnHeaders,@ColumnValues


					WHILE @@FETCH_STATUS = 0 
					BEGIN 
					
						 SET @sqltxt = 'SI_SP_TransactionTracking_Processing_Omniture @CSKID='
                            + CAST(@CSKID AS VARCHAR) + ', @SETitleID='
                            + CAST(@SETitleID AS VARCHAR)
                            + ', @IsContentMatch='
                            + CAST(@IsContentMatch AS VARCHAR)
                            + ', @GenerateDate='''
                            + CONVERT(VARCHAR, @GenerateDate, 111)
                            + ''', @ColumnHeaders=''' + @ColumnHeaders
                            + ''', @ColumnValues = ''' + @ColumnValues + ''''
			
                        IF @debug = 1 
                            PRINT ( @sqltxt )
                        ELSE 
                            EXEC ( @sqltxt )
						
						FETCH NEXT FROM Processing_cursor
						INTO  @CSKID,@SETitleID,@IsContentMatch,@GenerateDate,@ColumnHeaders,@ColumnValues

					END 
					
					CLOSE Processing_cursor 
					DEALLOCATE Processing_cursor
                    
        
                SELECT  @StartDate = MIN(GenerateDATE),
                        @EndDate = DATEADD(dd, 1, MAX(GenerateDATE))
                FROM    #AutoTrader_Processing
                
                
                IF @debug = 1 
                    SELECT  @StartDate,
                            @EndDate
                ELSE 
                    EXEC SIAdmin.SI_SP_ResummarizeTrackedAndReported @StartDate = @StartDate,
                        @EndDate = @EndDate,
                        @Comment = 'Reprocess for AutoTrader[SI_SP_TransactionTrackingOmniture_ProcessAutoTrader]',
                        @AffiliateID = 260
                
                SELECT TransactionTrackingOmnitureFileLoadID,
					SUM(TransactionCount) AS TTCount
				INTO #SUM
				FROM TransactionTrackingOmniture_AT_Raw
				GROUP BY TransactionTrackingOmnitureFileLoadID
                        
                UPDATE TransactionTrackingOmnitureFileLoad
				SET OmnitureFileLoadStatusID = 6, ProcessEndUTC = GETUTCDATE(), TransactionCount = #SUM.TTCount
				FROM #SUM
				WHERE TransactionTrackingOmnitureFileLoad.ProcessID = @ProcessID AND TransactionTrackingOmnitureFileLoad.OmnitureFileLoadStatusID = 5 AND TransactionTrackingOmnitureFileLoad.TransactionTrackingOmnitureFileLoadID = #SUM.TransactionTrackingOmnitureFileLoadID

            END
    END


GO


