USE SearchIgnite

DECLARE @Insert BIT =1

DECLARE @CopySEID TINYINT = 137,
	@URL VARCHAR(200) = 'http://facebook.com',
	@SignupPage VARCHAR(200) = 'http://facebook.com',
	@ImageName VARCHAR(200) = 'Facebook.png',
	@ParentPublisherID INT = 488,
	@ParentSEID INT = 84

DECLARE @SEID_control TABLE(
	SEID SMALLINT,
	SearchEngine_19 NVARCHAR(2000),
	Abbreviation_68 NVARCHAR(2000),
	PublisherRegionID TINYINT,
	CurrencyID INT,
	CurrencyCode_35 NVARCHAR(2000),
	MaxBidPrice_24 NVARCHAR(2000),
	CountryCode_167 NVARCHAR(2000),
	UTCDiff_88 NVARCHAR(2000),
	isProcessed BIT
)

INSERT INTO @SEID_control
        ( SEID ,
          SearchEngine_19 ,
          Abbreviation_68 ,
          PublisherRegionID ,
          CurrencyID ,
          CurrencyCode_35 ,
          MaxBidPrice_24 ,
          CountryCode_167,
          UTCDiff_88,
          isProcessed
        )
VALUES ( 146/*SEID*/, N'FBX Brasil'/*SearchEngine_19*/, N'FBX(BR)'/*Abbreviation_68*/ ,1/*PublisherRegionID*/ , 11/*CurrencyID*/ , N'BRL'/*CurrencyCode_35*/, N'100' /*MaxBidPrice_24*/, 'BR'/*CountryCode_167*/,'-5'/*UTCDiff_88*/, 0)
	
SELECT  *
FROM    @SEID_control
/*
SELECT * FROM dbo.TargetingLocation
WHERE ParentSEID = 82


SELECT * FROM SearchEngine WHERE SEID = 137

DECLaRE @MAX INT

SELECT @MAX  = MAX(PublisherID)+1 FROM LUPublisher

DBCC CHECKIDENT (LUPublisher, RESEED,@MAX )

DBCC CHECKIDENT (LUPublisher, NORESEED)

SELECT * FROm LUPublisher
where LegacySearchEngineID in (82,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130)
AND IsLegacyNatureSearchEngine = 0

SELECT * FROM SearchEngine
WHERE SEID IN   (82,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130)

SELECT * FROM dbo.SearchEngineGeneralConfig se
JOIN dbo.LUSEGeneralConfig lu ON se.ConfigID = lu.ConfigID
WHERE SEID = 110

	selEct * froM luPublisherRegion
	
	SELECT * FR
	
	select * FROM dbo.SearchEngine
	WHERE PublisherRegionID= 3
WHERE SEID IN (110)

select * from LUPublisherNetworkBySearchEngine where SEID in (110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130)

*/
    
    DELETE  a
    FROM    dbo.LUPublisher a
            JOIN @SEID_control b ON a.LegacySearchEngineID = b.SEID
    WHERE   IsLegacyNatureSearchEngine = 0

    DELETE  a
    FROM    SearchEngineGeneralConfig a
            JOIN @SEID_control b ON a.SEID = b.SEID

    DELETE  a
    FROM    LUCrawlRawRecordTypeToCrawlTypeMapping a
            JOIN @SEID_control b ON a.SEID = b.SEID

    DELETE  a
    FROM    crawltask a
            JOIN @SEID_control b ON a.SEID = b.SEID
    
    
    DELETE  a
    FROM    LUPublisherNetworkBySearchEngine a
            JOIN @SEID_control b ON a.SEID = b.SEID

	/*--IF (SELECT COUNT(1) FROM dbo.SearchEngine a JOIN @SEID_control b ON a.SEID = b.SEID /*WHERE StatusFlag = 0*/) >0 
		UPDATE  a
		SET StatusFlag = 1
		FROM    dbo.SearchEngine a
				JOIN @SEID_control b ON a.SEID = b.SEID	
	ELSE
	*/	DELETE  a
		FROM    dbo.SearchEngine a
				JOIN @SEID_control b ON a.SEID = b.SEID
	
	 --DELETE  FROM LUSEGeneralConfig
  --  WHERE   ConfigID = 167

    

    IF @Insert = 1 
        BEGIN 
        
			--INSERT  INTO dbo.LUSEGeneralConfig
   --                 ( ConfigID, KeyName )
   --         VALUES  ( 167, N'Bing V7 CountryCode' )

            DECLARE @SEID SMALLINT ,
                @SearchEngine_19 NVARCHAR(2000) ,
                @CurrencyID INT,
                @PublisherRegionID INT
		
            WHILE EXISTS ( SELECT TOP 1
                                    1
                           FROM     @SEID_control
                           WHERE    isProcessed = 0 ) 
                BEGIN
		
                    SELECT TOP 1
                            @SEID = SEID ,
                            @SearchEngine_19 = SearchEngine_19 ,
                            @CurrencyID = CurrencyID,
							@PublisherRegionID = PublisherRegionID
                    FROM    @SEID_control
                    WHERE   isProcessed = 0
		
			IF (SELECT COUNT(1) FROM dbo.SearchEngine WHERE SEID = @SEID) > 0
				UPDATE SearchEngine
				SET StatusFlag = 1
				WHERE SEID = @SEID
			ELSE 	
				INSERT INTO dbo.SearchEngine(SEID,SearchEngine,URL,StatusFlag,BidUpdateDelayMinutes,SignupPage,AllowOptimize,CurrencyID,ParentSEID,SortOrder,ShowInReport,ImageID,PublisherImageName,PublisherRegionID)
				values (@SEID, @SearchEngine_19, @URL, 1, 15/**/, @SignUpPage, 1, @CurrencyID, @ParentSEID, 100, 1, null, @ImageName, @PublisherRegionID)
				
			IF (SELECT COUNT(1) FROM dbo.LUPublisher WHERE LegacySearchEngineID = @SEID AND IsLegacyNatureSearchEngine =0) = 0 
					INSERT INTO [dbo].[LUPublisher] ([TrackingSourceID], [PublisherName], [URL], [StatusFlag], [LegacySearchEngineID], [IsLegacyNatureSearchEngine], [LegacyNSTypeID], [BidUpdateDelayMIN], [SignupPage], [AllowOptimize], [CurrencyID], [ParentPublisherID], [SortOrder], [ShowInReport], [CreateDateUTC], [ImageID], [PublisherRegionID], [PublisherImageName]) 
					VALUES (1, @SearchEngine_19, @URL, 1, @SEID, 0, NULL, 15, @SignUpPage, 0, @CurrencyID, @ParentPublisherID, 100, 1, GETUTCDATE(), NULL,  @PublisherRegionID, @ImageName)


			INSERT INTO LUPublisherNetworkBySearchEngine(SEID,SearchDisplayIndicator,PublisherNetworkID,PublisherNetworkDesc,DefaultOrder,resource_id)
			select  @SEID,SearchDisplayIndicator,PublisherNetworkID,PublisherNetworkDesc,DefaultOrder,resource_id
			from LUPublisherNetworkBySearchEngine 
			WHERE SEID = @CopySEID

                    INSERT  [dbo].[SearchEngineGeneralConfig]
                            ( [SEID] ,
                              [ConfigID] ,
                              [ConfigValue]
                            )
                            SELECT  @SEID ,
                                    ConfigID ,
                                    ConfigValue
                            FROM    dbo.SearchEngineGeneralConfig
                            WHERE   SEID = @CopySEID
                                    AND ConfigID IN ( 19, 68, 35,
                                                          24, 167,88 )
                                                        
                                                          
                  INSERT  [dbo].[SearchEngineGeneralConfig]
                            ( [SEID] ,
                              [ConfigID] ,
                              [ConfigValue]
                            )
                            SELECT  @SEID ,
                                    88 ,
                                    UTCDiff_88
                            FROM    @SEID_Control
                            WHERE   UTCDiff_88 IS NOT NULL
                                    AND SEID = @SEID
	
                    INSERT  [dbo].[SearchEngineGeneralConfig]
                            ( [SEID] ,
                              [ConfigID] ,
                              [ConfigValue]
                            )
                            SELECT  @SEID ,
                                    19 ,
                                    SearchEngine_19
                            FROM    @SEID_Control
                            WHERE   SearchEngine_19 IS NOT NULL
                                    AND SEID = @SEID
	
                    INSERT  [dbo].[SearchEngineGeneralConfig]
                            ( [SEID] ,
                              [ConfigID] ,
                              [ConfigValue]
                            )
                            SELECT  @SEID ,
                                    68 ,
                                    Abbreviation_68
                            FROM    @SEID_Control
                            WHERE   Abbreviation_68 IS NOT NULL
                                    AND SEID = @SEID
	
                    INSERT  [dbo].[SearchEngineGeneralConfig]
                            ( [SEID] ,
                              [ConfigID] ,
                              [ConfigValue]
                            )
                            SELECT  @SEID ,
                                    35 ,
                                    CurrencyCode_35
                            FROM    @SEID_Control
                            WHERE   CurrencyCode_35 IS NOT NULL
                                    AND SEID = @SEID
	
	
                    INSERT  [dbo].[SearchEngineGeneralConfig]
                            ( [SEID] ,
                              [ConfigID] ,
                              [ConfigValue]
                            )
                            SELECT  @SEID ,
                                    24 ,
                                    MaxBidPrice_24
                            FROM    @SEID_Control
                            WHERE   MaxBidPrice_24 IS NOT NULL
                                    AND SEID = @SEID
	
		
                    INSERT  [dbo].[SearchEngineGeneralConfig]
                            ( [SEID] ,
                              [ConfigID] ,
                              [ConfigValue]
                            )
                            SELECT  @SEID ,
                                    167 ,
                                    CountryCode_167
                            FROM    @SEID_Control
                            WHERE   CountryCode_167 IS NOT NULL
                                    AND SEID = @SEID		

	--Add new config here
                    INSERT  INTO dbo.CrawlTask
                            ( SEID ,
                              CrawlTypeID ,
                              RootSequenceID ,
                              TaskName ,
                              AssemblyName ,
                              ClassName
                            )
                            SELECT  @SEID ,
                                    CrawlTypeID ,
                                    RootSequenceID ,
                                    TaskName ,
                                    AssemblyName ,
                                    ClassName
                            FROM    dbo.CrawlTask
                            WHERE   SEID = @CopySEID

                    INSERT  INTO dbo.LUCrawlRawRecordTypeToCrawlTypeMapping
                            ( CrawlRawRecordTypeID ,
                              CrawlTypeID ,
                              AssemblyName ,
                              ClassName ,
                              SimpleMode ,
                              SEID
                            )
                            SELECT  CrawlRawRecordTypeID ,
                                    CrawlTypeID ,
                                    AssemblyName ,
                                    ClassName ,
                                    SimpleMode ,
                                    @SEID
                            FROM    LUCrawlRawRecordTypeToCrawlTypeMapping
                            WHERE   SEID = @CopySEID

	
                    UPDATE  @SEID_control
                    SET     isProcessed = 1
                    WHERE   SEID = @SEID
                    
	
                END 

        END
        
 --IF (SELECT COUNT(1) FROM dbo.LUPublisher a JOIN @SEID_control b ON a.LegacySearchEngineID = b.SEID WHERE   IsLegacyNatureSearchEngine = 0) = 0 
 --BEGIN
	---- Add rows to [dbo].[LUPublisher]
	--SET IDENTITY_INSERT [dbo].[LUPublisher] ON
	--INSERT INTO [dbo].[LUPublisher] ([PublisherID], [TrackingSourceID], [PublisherName], [URL], [StatusFlag], [LegacySearchEngineID], [IsLegacyNatureSearchEngine], [LegacyNSTypeID], [BidUpdateDelayMIN], [SignupPage], [AllowOptimize], [CurrencyID], [ParentPublisherID], [SortOrder], [ShowInReport], [CreateDateUTC], [ImageID], [PublisherRegionID], [PublisherImageName]) VALUES (723, 1, N'Yahoo! Search | Bing (AT)', N'http://bing.com', 1, 110, 0, NULL, 15, N'http://bing.com', 1, 26, 286, 100, 1, '2012-03-06 06:30:22.783', NULL, 3, 'YahooBing.png')
	--INSERT INTO [dbo].[LUPublisher] ([PublisherID], [TrackingSourceID], [PublisherName], [URL], [StatusFlag], [LegacySearchEngineID], [IsLegacyNatureSearchEngine], [LegacyNSTypeID], [BidUpdateDelayMIN], [SignupPage], [AllowOptimize], [CurrencyID], [ParentPublisherID], [SortOrder], [ShowInReport], [CreateDateUTC], [ImageID], [PublisherRegionID], [PublisherImageName]) VALUES (724, 1, N'Yahoo! Search | Bing (AU)', N'http://bing.com', 1, 111, 0, NULL, 15, N'http://bing.com', 1, 5, 286, 100, 1, '2012-03-06 06:30:22.827', NULL, 3, 'YahooBing.png')
	--INSERT INTO [dbo].[LUPublisher] ([PublisherID], [TrackingSourceID], [PublisherName], [URL], [StatusFlag], [LegacySearchEngineID], [IsLegacyNatureSearchEngine], [LegacyNSTypeID], [BidUpdateDelayMIN], [SignupPage], [AllowOptimize], [CurrencyID], [ParentPublisherID], [SortOrder], [ShowInReport], [CreateDateUTC], [ImageID], [PublisherRegionID], [PublisherImageName]) VALUES (725, 1, N'Yahoo! Search | Bing (BR)', N'http://bing.com', 1, 112, 0, NULL, 15, N'http://bing.com', 1, 11, 286, 100, 1, '2012-03-06 06:30:22.980', NULL, 3, 'YahooBing.png')
	--INSERT INTO [dbo].[LUPublisher] ([PublisherID], [TrackingSourceID], [PublisherName], [URL], [StatusFlag], [LegacySearchEngineID], [IsLegacyNatureSearchEngine], [LegacyNSTypeID], [BidUpdateDelayMIN], [SignupPage], [AllowOptimize], [CurrencyID], [ParentPublisherID], [SortOrder], [ShowInReport], [CreateDateUTC], [ImageID], [PublisherRegionID], [PublisherImageName]) VALUES (726, 1, N'Yahoo! Search | Bing (CA)', N'http://bing.com', 1, 113, 0, NULL, 15, N'http://bing.com', 1, 13, 286, 100, 1, '2012-03-06 06:30:22.983', NULL, 3, 'YahooBing.png')
	--INSERT INTO [dbo].[LUPublisher] ([PublisherID], [TrackingSourceID], [PublisherName], [URL], [StatusFlag], [LegacySearchEngineID], [IsLegacyNatureSearchEngine], [LegacyNSTypeID], [BidUpdateDelayMIN], [SignupPage], [AllowOptimize], [CurrencyID], [ParentPublisherID], [SortOrder], [ShowInReport], [CreateDateUTC], [ImageID], [PublisherRegionID], [PublisherImageName]) VALUES (727, 1, N'Yahoo! Search | Bing (CA)(FR)', N'http://bing.com', 1, 114, 0, NULL, 15, N'http://bing.com', 1, 13, 286, 100, 1, '2012-03-06 06:30:22.990', NULL, 3, 'YahooBing.png')
	--INSERT INTO [dbo].[LUPublisher] ([PublisherID], [TrackingSourceID], [PublisherName], [URL], [StatusFlag], [LegacySearchEngineID], [IsLegacyNatureSearchEngine], [LegacyNSTypeID], [BidUpdateDelayMIN], [SignupPage], [AllowOptimize], [CurrencyID], [ParentPublisherID], [SortOrder], [ShowInReport], [CreateDateUTC], [ImageID], [PublisherRegionID], [PublisherImageName]) VALUES (728, 1, N'Yahoo! Search | Bing (CH)', N'http://bing.com', 1, 115, 0, NULL, 15, N'http://bing.com', 1, 26, 286, 100, 1, '2012-03-06 06:30:22.997', NULL, 3, 'YahooBing.png')
	--INSERT INTO [dbo].[LUPublisher] ([PublisherID], [TrackingSourceID], [PublisherName], [URL], [StatusFlag], [LegacySearchEngineID], [IsLegacyNatureSearchEngine], [LegacyNSTypeID], [BidUpdateDelayMIN], [SignupPage], [AllowOptimize], [CurrencyID], [ParentPublisherID], [SortOrder], [ShowInReport], [CreateDateUTC], [ImageID], [PublisherRegionID], [PublisherImageName]) VALUES (729, 1, N'Yahoo! Search | Bing (DE)', N'http://bing.com', 1, 116, 0, NULL, 15, N'http://bing.com', 1, 26, 286, 100, 1, '2012-03-06 06:30:23.117', NULL, 3, 'YahooBing.png')
	--INSERT INTO [dbo].[LUPublisher] ([PublisherID], [TrackingSourceID], [PublisherName], [URL], [StatusFlag], [LegacySearchEngineID], [IsLegacyNatureSearchEngine], [LegacyNSTypeID], [BidUpdateDelayMIN], [SignupPage], [AllowOptimize], [CurrencyID], [ParentPublisherID], [SortOrder], [ShowInReport], [CreateDateUTC], [ImageID], [PublisherRegionID], [PublisherImageName]) VALUES (730, 1, N'Yahoo! Search | Bing (DK)', N'http://bing.com', 1, 117, 0, NULL, 15, N'http://bing.com', 1, 26, 286, 100, 1, '2012-03-06 06:30:23.120', NULL, 3, 'YahooBing.png')
	--INSERT INTO [dbo].[LUPublisher] ([PublisherID], [TrackingSourceID], [PublisherName], [URL], [StatusFlag], [LegacySearchEngineID], [IsLegacyNatureSearchEngine], [LegacyNSTypeID], [BidUpdateDelayMIN], [SignupPage], [AllowOptimize], [CurrencyID], [ParentPublisherID], [SortOrder], [ShowInReport], [CreateDateUTC], [ImageID], [PublisherRegionID], [PublisherImageName]) VALUES (731, 1, N'Yahoo! Search | Bing (ES)', N'http://bing.com', 1, 118, 0, NULL, 15, N'http://bing.com', 1, 26, 286, 100, 1, '2012-03-06 06:30:23.123', NULL, 3, 'YahooBing.png')
	--INSERT INTO [dbo].[LUPublisher] ([PublisherID], [TrackingSourceID], [PublisherName], [URL], [StatusFlag], [LegacySearchEngineID], [IsLegacyNatureSearchEngine], [LegacyNSTypeID], [BidUpdateDelayMIN], [SignupPage], [AllowOptimize], [CurrencyID], [ParentPublisherID], [SortOrder], [ShowInReport], [CreateDateUTC], [ImageID], [PublisherRegionID], [PublisherImageName]) VALUES (732, 1, N'Yahoo! Search | Bing (FI)', N'http://bing.com', 1, 119, 0, NULL, 15, N'http://bing.com', 1, 26, 286, 100, 1, '2012-03-06 06:30:23.123', NULL, 3, 'YahooBing.png')
	--INSERT INTO [dbo].[LUPublisher] ([PublisherID], [TrackingSourceID], [PublisherName], [URL], [StatusFlag], [LegacySearchEngineID], [IsLegacyNatureSearchEngine], [LegacyNSTypeID], [BidUpdateDelayMIN], [SignupPage], [AllowOptimize], [CurrencyID], [ParentPublisherID], [SortOrder], [ShowInReport], [CreateDateUTC], [ImageID], [PublisherRegionID], [PublisherImageName]) VALUES (733, 1, N'Yahoo! Search | Bing (FR)', N'http://bing.com', 1, 120, 0, NULL, 15, N'http://bing.com', 1, 26, 286, 100, 1, '2012-03-06 06:30:23.127', NULL, 3, 'YahooBing.png')
	--INSERT INTO [dbo].[LUPublisher] ([PublisherID], [TrackingSourceID], [PublisherName], [URL], [StatusFlag], [LegacySearchEngineID], [IsLegacyNatureSearchEngine], [LegacyNSTypeID], [BidUpdateDelayMIN], [SignupPage], [AllowOptimize], [CurrencyID], [ParentPublisherID], [SortOrder], [ShowInReport], [CreateDateUTC], [ImageID], [PublisherRegionID], [PublisherImageName]) VALUES (734, 1, N'Yahoo! Search | Bing (HK)', N'http://bing.com', 1, 121, 0, NULL, 15, N'http://bing.com', 1, 29, 286, 100, 1, '2012-03-06 06:30:23.130', NULL, 3, 'YahooBing.png')
	--INSERT INTO [dbo].[LUPublisher] ([PublisherID], [TrackingSourceID], [PublisherName], [URL], [StatusFlag], [LegacySearchEngineID], [IsLegacyNatureSearchEngine], [LegacyNSTypeID], [BidUpdateDelayMIN], [SignupPage], [AllowOptimize], [CurrencyID], [ParentPublisherID], [SortOrder], [ShowInReport], [CreateDateUTC], [ImageID], [PublisherRegionID], [PublisherImageName]) VALUES (735, 1, N'Yahoo! Search | Bing (IT)', N'http://bing.com', 1, 122, 0, NULL, 15, N'http://bing.com', 1, 26, 286, 100, 1, '2012-03-06 06:30:23.130', NULL, 3, 'YahooBing.png')
	--INSERT INTO [dbo].[LUPublisher] ([PublisherID], [TrackingSourceID], [PublisherName], [URL], [StatusFlag], [LegacySearchEngineID], [IsLegacyNatureSearchEngine], [LegacyNSTypeID], [BidUpdateDelayMIN], [SignupPage], [AllowOptimize], [CurrencyID], [ParentPublisherID], [SortOrder], [ShowInReport], [CreateDateUTC], [ImageID], [PublisherRegionID], [PublisherImageName]) VALUES (736, 1, N'Yahoo! Search | Bing (KR)', N'http://bing.com', 1, 123, 0, NULL, 15, N'http://bing.com', 1, 42, 286, 100, 1, '2012-03-06 06:30:23.130', NULL, 3, 'YahooBing.png')
	--INSERT INTO [dbo].[LUPublisher] ([PublisherID], [TrackingSourceID], [PublisherName], [URL], [StatusFlag], [LegacySearchEngineID], [IsLegacyNatureSearchEngine], [LegacyNSTypeID], [BidUpdateDelayMIN], [SignupPage], [AllowOptimize], [CurrencyID], [ParentPublisherID], [SortOrder], [ShowInReport], [CreateDateUTC], [ImageID], [PublisherRegionID], [PublisherImageName]) VALUES (737, 1, N'Yahoo! Search | Bing (MX)(USD)', N'http://bing.com', 1, 124, 0, NULL, 15, N'http://bing.com', 1, 73, 286, 100, 1, '2012-03-06 06:30:23.133', NULL, 3, 'YahooBing.png')
	--INSERT INTO [dbo].[LUPublisher] ([PublisherID], [TrackingSourceID], [PublisherName], [URL], [StatusFlag], [LegacySearchEngineID], [IsLegacyNatureSearchEngine], [LegacyNSTypeID], [BidUpdateDelayMIN], [SignupPage], [AllowOptimize], [CurrencyID], [ParentPublisherID], [SortOrder], [ShowInReport], [CreateDateUTC], [ImageID], [PublisherRegionID], [PublisherImageName]) VALUES (738, 1, N'Yahoo! Search | Bing (NL)', N'http://bing.com', 1, 125, 0, NULL, 15, N'http://bing.com', 1, 26, 286, 100, 1, '2012-03-06 06:30:23.137', NULL, 3, 'YahooBing.png')
	--INSERT INTO [dbo].[LUPublisher] ([PublisherID], [TrackingSourceID], [PublisherName], [URL], [StatusFlag], [LegacySearchEngineID], [IsLegacyNatureSearchEngine], [LegacyNSTypeID], [BidUpdateDelayMIN], [SignupPage], [AllowOptimize], [CurrencyID], [ParentPublisherID], [SortOrder], [ShowInReport], [CreateDateUTC], [ImageID], [PublisherRegionID], [PublisherImageName]) VALUES (739, 1, N'Yahoo! Search | Bing (NO)', N'http://bing.com', 1, 126, 0, NULL, 15, N'http://bing.com', 1, 26, 286, 100, 1, '2012-03-06 06:30:23.140', NULL, 3, 'YahooBing.png')
	--INSERT INTO [dbo].[LUPublisher] ([PublisherID], [TrackingSourceID], [PublisherName], [URL], [StatusFlag], [LegacySearchEngineID], [IsLegacyNatureSearchEngine], [LegacyNSTypeID], [BidUpdateDelayMIN], [SignupPage], [AllowOptimize], [CurrencyID], [ParentPublisherID], [SortOrder], [ShowInReport], [CreateDateUTC], [ImageID], [PublisherRegionID], [PublisherImageName]) VALUES (740, 1, N'Yahoo! Search | Bing (SE)', N'http://bing.com', 1, 127, 0, NULL, 15, N'http://bing.com', 1, 26, 286, 100, 1, '2012-03-06 06:30:23.140', NULL, 3, 'YahooBing.png')
	--INSERT INTO [dbo].[LUPublisher] ([PublisherID], [TrackingSourceID], [PublisherName], [URL], [StatusFlag], [LegacySearchEngineID], [IsLegacyNatureSearchEngine], [LegacyNSTypeID], [BidUpdateDelayMIN], [SignupPage], [AllowOptimize], [CurrencyID], [ParentPublisherID], [SortOrder], [ShowInReport], [CreateDateUTC], [ImageID], [PublisherRegionID], [PublisherImageName]) VALUES (741, 1, N'Yahoo! Search | Bing (SEA)', N'http://bing.com', 1, 128, 0, NULL, 15, N'http://bing.com', 1, 73, 286, 100, 1, '2012-03-06 06:30:23.143', NULL, 3, 'YahooBing.png')
	--INSERT INTO [dbo].[LUPublisher] ([PublisherID], [TrackingSourceID], [PublisherName], [URL], [StatusFlag], [LegacySearchEngineID], [IsLegacyNatureSearchEngine], [LegacyNSTypeID], [BidUpdateDelayMIN], [SignupPage], [AllowOptimize], [CurrencyID], [ParentPublisherID], [SortOrder], [ShowInReport], [CreateDateUTC], [ImageID], [PublisherRegionID], [PublisherImageName]) VALUES (742, 1, N'Yahoo! Search | Bing (TW)', N'http://bing.com', 1, 129, 0, NULL, 15, N'http://bing.com', 1, 72, 286, 100, 1, '2012-03-06 06:30:23.143', NULL, 3, 'YahooBing.png')
	--INSERT INTO [dbo].[LUPublisher] ([PublisherID], [TrackingSourceID], [PublisherName], [URL], [StatusFlag], [LegacySearchEngineID], [IsLegacyNatureSearchEngine], [LegacyNSTypeID], [BidUpdateDelayMIN], [SignupPage], [AllowOptimize], [CurrencyID], [ParentPublisherID], [SortOrder], [ShowInReport], [CreateDateUTC], [ImageID], [PublisherRegionID], [PublisherImageName]) VALUES (743, 1, N'Yahoo! Search | Bing (UK)', N'http://bing.com', 1, 130, 0, NULL, 15, N'http://bing.com', 1, 28, 286, 100, 1, '2012-03-06 06:30:23.147', NULL, 3, 'YahooBing.png')
	--SET IDENTITY_INSERT [dbo].[LUPublisher] OFF
 
 --END

--END TRY

--BEGIN CATCH
    --IF @@TRANCOUNT > 0 
    --    ROLLBACK TRAN ;
        
--     PRINT 'Error occured while processing'
--END CATCH


--IF @@TRANCOUNT > 0 
--    COMMIT TRAN ;