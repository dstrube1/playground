
DECLARE @CallTimeStamp DATETIME = '2012-10-17 20:23:20.737',
			@StartDate DATETIME = '09/17/2012' ,
		   @EndDate DATETIME = '10/17/2012' ,
		   @CurrencyID INT = null,
		   @ConvertToCurrencyID INT = 73
	
/*

 SELECT * FROM FN_Social_AccountSummaryByDateClient(@CallTimeStamp,@StartDate,@EndDate,@CurrencyID,@ConvertToCurrencyID)
       

                SELECT  rp.GenerateDate ,
                        NULL AS KeyWordCount ,
                        ISNULL(SUM(CONVERT(BIGINT, NumImpressions)), 0) AS NumImpressions ,
                        ISNULL(SUM(Cost * ISNULL(ExchangeRate, 1.0)), 0.00) AS Cost ,
                        ISNULL(SUM(NumClicksReported), 0) AS NumClicksReported ,
                        ISNULL(SUM(NumClicksTracked), 0) AS NumClicksTracked ,
                        @ConvertToCurrencyID ,
                        ISNULL(SUM(TransactionCount), 0) AS TransactionCount ,
                        ISNULL(SUM(TransactionAmount * ISNULL(ExchangeRate,1.0)), 0.00) AS TransactionAmount ,
                        ISNULL(SUM(TransactionCountWithWeight), 0) AS TransactionCountWithWeight ,
                        ISNULL(SUM(CONVERT(BIGINT, SocialImpressions)), 0) AS SocialImpressions,
					    ISNULL(SUM(SocialClicks), 0) AS SocialClicks,
					    ISNULL(SUM(SocialCost), 0) AS SocialCost,
					    ISNULL(SUM(reach), 0) AS reach ,
					    ISNULL(SUM(socialreach), 0)  AS socialreach,
					    ISNULL(SUM(UniqueClicks), 0) AS UniqueClicks,
					    ISNULL(SUM(Conversions),0) AS Conversions,
						ISNULL(SUM(sga.FBACtions),0) AS FBACtions
                FROM    dbo.AccountSummaryClientList c WITH ( NOLOCK )
                JOIN dbo.RPT_Social_Summary_ClientLevel rp WITH ( NOLOCK ) ON c.clientid = rp.clientid
					AND rp.GenerateDate BETWEEN @StartDate AND  @EndDate
                LEFT JOIN SearchEngine se WITH ( NOLOCK ) ON se.SEID = rp.SEID 
                LEFT JOIN CurrencyExchangeData ed WITH ( NOLOCK ) ON se.CurrencyID = ed.FromCurrencyID
					AND ToCurrencyID = ISNULL(@ConvertToCurrencyID,FromCurrencyID)
				LEFT JOIN ( 
					SELECT sga.GenerateDate,sga.ClientID, SUM(sga.Clicks_1day+sga.Clicks_7day+sga.Clicks_28day+sga.Impressions_1day) AS FBACtions
					FROM SIOLAP..RPT_Social_Summary_GroupActions sga 
					JOIN AccountSummaryClientList ascl ON sga.ClientID = ascl.ClientID
						AND CallTimeStamp = @CallTimeStamp
					WHERE   sga.GenerateDate BETWEEN @StartDate AND  @EndDate
						AND EXISTS(SELECT 1 FROM SearchIgnite..CampaignAdCategory WHERE sga.ADCategoryID = ADCategoryID AND Statusflag = 1 AND ascl.ClientID = ClientID)
					GROUP BY sga.GenerateDate,sga.ClientID
					) AS sga ON sga.GenerateDate = rp.GenerateDate
						AND sga.ClientID = rp.ClientID
                WHERE   @CallTimeStamp = CallTimeStamp
                        AND ( @CurrencyID IS NULL
                              OR se.CurrencyID = @CurrencyID)
                        AND  NOT EXISTS (SELECT 1 FROM SearchEngine se2 WITH (NOLOCK) WHERE se2.seid =rp.seid AND se2.parentseid <>84)
                GROUP BY rp.GenerateDate
  */                      
            
SELECT * FROM FN_Social_AccountSummaryByPublisherClient (@CallTimeStamp,@StartDate,@EndDate,@CurrencyID,@ConvertToCurrencyID)            
     
     
            SELECT  c.GroupByClientID ,
                                rp.seid ,
                                se.searchengine ,
                                ISNULL(SUM(CONVERT(BIGINT, NumImpressions)), 0) AS NumImpressions ,
                                ISNULL(SUM(Cost * ISNULL(ExchangeRate, 1.0)),
                                       0.00) AS Cost ,
                                ISNULL(SUM(NumClicksReported), 0) AS NumClicksReported ,
                                ISNULL(SUM(NumClicksTracked), 0) AS NumClicksTracked ,
                                @ConvertToCurrencyID ,
                                ISNULL(SUM(TransactionCount),0) AS TransactionCount ,
                                ISNULL(SUM(rp.TransactionAmount * ISNULL(ExchangeRate, 1.0)), 0.00) AS TransactionAmount ,
                            ISNULL(SUM(TransactionCountWithWeight), 0) AS TransactionCountWithWeight ,
								ISNULL(SUM(SocialImpressions), 0) AS SocialImpressions,
								ISNULL(SUM(SocialClicks), 0) AS SocialClicks,
								ISNULL(SUM(SocialCost), 0) AS SocialCost,
								ISNULL(SUM(reach), 0) AS reach ,
								ISNULL(SUM(socialreach), 0)  AS socialreach,
								ISNULL(SUM(UniqueClicks), 0) AS UniqueClicks ,
								ISNULL(SUM(Conversions),0) AS Conversions,
								ISNULL(SUM(sga.FBACtions),0) AS FBACtions
                        FROM    dbo.AccountSummaryClientList c WITH (NOLOCK)
                                LEFT JOIN dbo.RPT_Social_Summary_ClientLevel rp WITH ( NOLOCK ) ON c.clientid = rp.clientid
									AND rp.GenerateDate BETWEEN @StartDate AND  @EndDate
                                LEFT JOIN SearchEngine se WITH ( NOLOCK ) ON rp.SEID = se.seid 
                                LEFT JOIN CurrencyExchangeData ed WITH ( NOLOCK ) ON se.CurrencyID = ed.FromCurrencyID
									AND ToCurrencyID = ISNULL(@ConvertToCurrencyID,FromCurrencyID)
								LEFT JOIN ( 
									SELECT sga.ClientID,sga.SEID, SUM(sga.Clicks_1day+sga.Clicks_7day+sga.Clicks_28day+sga.Impressions_1day) AS FBACtions
									FROM SIOLAP..RPT_Social_Summary_GroupActions sga 
									JOIN AccountSummaryClientList ascl ON sga.ClientID = ascl.ClientID
										AND CallTimeStamp = @CallTimeStamp
									WHERE   sga.GenerateDate BETWEEN @StartDate AND  @EndDate
										AND EXISTS(SELECT 1 FROM SearchIgnite..CampaignAdCategory WHERE sga.ADCategoryID = ADCategoryID AND Statusflag = 1 AND ascl.ClientID = ClientID)
									GROUP BY sga.ClientID,sga.SEID
								) AS sga ON sga.ClientID = rp.ClientID
									AND sga.SEID = rp.SEID
                        WHERE   @CallTimeStamp = CallTimeStamp
                                AND ( @CurrencyID IS NULL
                                      OR se.CurrencyID = @CurrencyID )
								AND NOT  EXISTS (SELECT 1 FROM SearchEngine se2 WITH (NOLOCK) WHERE se2.seid =rp.seid AND se2.parentseid <>84)
                        GROUP BY c.GroupByClientID ,
                                rp.SEID ,
                                se.searchengine 
              
              
              
               SELECT  c.GroupByClientID ,
                                rp.seid ,
                                se.searchengine ,
                                ISNULL(SUM(CONVERT(BIGINT, NumImpressions)), 0) AS NumImpressions ,
                                ISNULL(SUM(Cost * ISNULL(ExchangeRate, 1.0)),
                                       0.00) AS Cost ,
                                ISNULL(SUM(NumClicksReported), 0) AS NumClicksReported ,
                                ISNULL(SUM(NumClicksTracked), 0) AS NumClicksTracked ,
                                @ConvertToCurrencyID ,
                                ISNULL(SUM(TransactionCount),0) AS TransactionCount ,
                                ISNULL(SUM(rp.TransactionAmount * ISNULL(ExchangeRate, 1.0)), 0.00) AS TransactionAmount ,
                            ISNULL(SUM(TransactionCountWithWeight), 0) AS TransactionCountWithWeight ,
								ISNULL(SUM(SocialImpressions), 0) AS SocialImpressions,
								ISNULL(SUM(SocialClicks), 0) AS SocialClicks,
								ISNULL(SUM(SocialCost), 0) AS SocialCost,
								ISNULL(SUM(reach), 0) AS reach ,
								ISNULL(SUM(socialreach), 0)  AS socialreach,
								ISNULL(SUM(UniqueClicks), 0) AS UniqueClicks ,
								ISNULL(SUM(Conversions),0) AS Conversions,
								ISNULL(SUM(sga.FBACtions),0) AS FBACtions
                                      FROM    dbo.AccountSummaryClientList c WITH (NOLOCK)
                                LEFT JOIN dbo.RPT_Social_Summary_ClientLevel rp WITH ( NOLOCK ) ON c.clientid = rp.clientid
									AND rp.GenerateDate BETWEEN @StartDate AND  @EndDate
                                LEFT JOIN SearchEngine se WITH ( NOLOCK ) ON rp.SEID = se.seid 
                                LEFT JOIN CurrencyExchangeData ed WITH ( NOLOCK ) ON se.CurrencyID = ed.FromCurrencyID
									AND ToCurrencyID = ISNULL(@ConvertToCurrencyID,FromCurrencyID)
								LEFT JOIN ( 
									SELECT sga.GenerateDate,sga.ClientID,sga.SEID, SUM(sga.Clicks_1day+sga.Clicks_7day+sga.Clicks_28day+sga.Impressions_1day) AS FBACtions
									FROM SIOLAP..RPT_Social_Summary_GroupActions sga 
									JOIN AccountSummaryClientList ascl ON sga.ClientID = ascl.ClientID
										AND CallTimeStamp = @CallTimeStamp
									WHERE   sga.GenerateDate BETWEEN @StartDate AND  @EndDate
										AND EXISTS(SELECT 1 FROM SearchIgnite..CampaignAdCategory WHERE sga.ADCategoryID = ADCategoryID AND Statusflag = 1 AND ascl.ClientID = ClientID)
									GROUP BY sga.GenerateDate,sga.ClientID,sga.SEID
								) AS sga ON sga.ClientID = rp.ClientID
									AND sga.SEID = rp.SEID
									AND rp.GenerateDate = sga.GenerateDate
                        WHERE   @CallTimeStamp = CallTimeStamp
                                AND ( @CurrencyID IS NULL
                                      OR se.CurrencyID = @CurrencyID )
								AND NOT  EXISTS (SELECT 1 FROM SearchEngine se2 WITH (NOLOCK) WHERE se2.seid =rp.seid AND se2.parentseid <>84)
                 GROUP BY c.GroupByClientID ,
                                rp.SEID ,
                                se.searchengine 
                                  