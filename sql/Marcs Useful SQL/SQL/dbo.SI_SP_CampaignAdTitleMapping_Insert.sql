USE [Searchignite]
GO

/****** Object:  StoredProcedure [dbo].[SI_SP_CampaignAdTitleMapping_Insert]    Script Date: 07/29/2011 12:11:42 ******/
IF EXISTS ( SELECT  *
            FROM    sys.objects
            WHERE   object_id = OBJECT_ID(N'[dbo].[SI_SP_CampaignAdTitleMapping_Insert]')
                    AND type IN ( N'P', N'PC' ) ) 
    DROP PROCEDURE [dbo].[SI_SP_CampaignAdTitleMapping_Insert]
GO

USE [Searchignite]
GO

/****** Object:  StoredProcedure [dbo].[SI_SP_CampaignAdTitleMapping_Insert]    Script Date: 07/29/2011 12:11:42 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [dbo].[SI_SP_CampaignAdTitleMapping_Insert]
    @SEID [smallint] ,
    @SETitleID [int] ,
    @AdTitleMappingID [int] ,
    @CampaignID [int] ,
    @Title [nvarchar](120) = NULL ,
    @Description [nvarchar](1000) = NULL ,
    @Description2 [nvarchar](500) = NULL ,
    @DisplayUrl [nvarchar](2048) = NULL ,
    @DefaultUrl [nvarchar](2048) = NULL ,
    @TitleAsKeyword [bit] = 0 ,
    @ExternalID [varchar](30) = NULL ,
    @IsDefault [bit] = NULL ,
    @IsUpdatedDone [bit] = NULL ,
    @AdTypeID [tinyint] = NULL ,
    @AdStatusID [tinyint] = NULL ,
    @AdImage VARBINARY(MAX) = NULL ,
    @QualityScore [real] = NULL ,
    @ContentQualityScore [real] = NULL ,
    @AdTitleOnOffStatusID [tinyint] = NULL ,
    @OptimizeLandingPage BIT = NULL ,
    @OptimizeByConversion BIT = NULL ,
    @AdImageHash VARCHAR(1024) = NULL ,
    @ImageName NVARCHAR(200) = NULL ,
    @ImageID INT = NULL
AS ------------------------------------------------------------
--Change History
------------------------------------------------------------
-- 06/05/06 YZ add new columns per Calvin
-- 10/20/06 YZ Make ExternalID '' if it is null
-- 01/23/07 YZ Add QualityScore
-- 05/02/08 YZ Change URL Data Type from Varchar to nvarchar
-- 10/02/08 YZ Change @Title size to nvarchar(120)
-- 01/21/09 DA Add Jira 657 & 908: OptimizeByConversion, OptimizeLandingPage
-- 11/05/10 JC  SIP-5724 change datatype of AdImage to nvarchar(260)
-- 01/05/11 JC  SIP-5931 change datatype of AdImage to varbinary(max)
------------------------------------------------------------
    BEGIN
        SET nocount ON
        IF @AdImage IS NOT NULL 
            BEGIN
                SELECT  i.ImageID,*
                FROM    ImageLibrary i
                WHERE   i.ExternalHash = @AdImageHash
					AND i.FullImage = @AdImage
	
                IF @ImageID IS NULL 
                    EXEC @ImageID= SI_SP_Image_Insert @AdImageHash, @ImageName,
                        @AdImage 
            END
	
        IF NOT EXISTS ( SELECT  *
                        FROM    CampaignAdTitleMapping
                        WHERE   SEID = @SEID
                                AND SETitleID = @SETitleID
                                AND AdTitleMappingID = @AdTitleMappingID ) 
            BEGIN
                INSERT  INTO CampaignAdTitleMapping
                        ( SEID ,
                          SETitleID ,
                          AdTitleMappingID ,
                          CampaignID ,
                          Title ,
                          Description1 ,
                          Description2 ,
                          DisplayURL ,
                          DefaultUrl ,
                          TitleAsKeyword ,
                          ExternalID ,
                          IsDefault ,
                          IsUpdatedDone ,
                          AdTypeID ,
                          AdStatusID ,
                          ImageID ,
                          QualityScore ,
                          ContentQualityScore ,
                          AdTitleOnOffStatusID ,
                          OptimizeByConversion ,
                          OptimizeLandingPage
                        )
                VALUES  ( @SEID ,
                          @SETitleID ,
                          @AdTitleMappingID ,
                          @CampaignID ,
                          @Title ,
                          @Description ,
                          @Description2 ,
                          @DisplayURL ,
                          @DefaultUrl ,
                          ISNULL(@TitleAsKeyword, 0) ,
                          ISNULL(@ExternalID, '') ,
                          ISNULL(@IsDefault, 1) ,
                          ISNULL(@IsUpdatedDone, 1) ,
                          @AdTypeID ,
                          @AdStatusID ,
                          @ImageID ,
                          ISNULL(@QualityScore, 0) ,
                          ISNULL(@ContentQualityScore, 0) ,
                          ISNULL(@AdTitleOnOffStatusID, 1) ,
                          @OptimizeByConversion ,
                          @OptimizeLandingPage
                        )

            END
        ELSE 
            BEGIN
                UPDATE  CampaignAdTitleMapping
                SET     Title = @Title ,
                        Description1 = @Description ,
                        Description2 = @Description2 ,
                        DisplayUrl = @DisplayUrl ,
                        DefaultUrl = @DefaultUrl ,
                        TitleAsKeyword = ISNULL(@TitleAsKeyword,
                                                TitleAsKeyword) ,
                        ExternalID = ISNULL(@ExternalID, ExternalID) ,
                        IsDefault = ISNULL(@IsDefault, IsDefault) ,
                        IsUpdatedDone = ISNULL(@IsUpdatedDone, IsUpdatedDone) ,
                        AdTypeID = ISNULL(@AdTypeID, AdTypeID) ,
                        AdStatusID = ISNULL(@AdStatusID, AdStatusID) ,
                        ImageID = ISNULL(@ImageID, ImageID) ,
                        QualityScore = ISNULL(@QualityScore, QualityScore) ,
                        ContentQualityScore = ISNULL(@ContentQualityScore,
                                                     ContentQualityScore) ,
                        AdTitleOnOffStatusID = ISNULL(@AdTitleOnOffStatusID,
                                                      AdTitleOnOffStatusID) ,
                        UpdateDate = GETUTCDATE() ,
                        OptimizeLandingPage = ISNULL(@OptimizeLandingPage,
                                                     OptimizeLandingPage) ,
                        OptimizeByConversion = ISNULL(@OptimizeByConversion,
                                                      OptimizeByConversion)
                WHERE   SETitleID = @SETitleID
            END

        IF NOT EXISTS ( SELECT  1
                        FROM    dbo.CampaignSETitleIDAdIDMapping
                        WHERE   SEID = @SEID
                                AND CampaignID = @CampaignID
                                AND SETitleID = @SETitleID
                                AND AdID = @ExternalID )
            AND @SETitleID IS NOT NULL
            AND @ExternalID IS NOT NULL 
            INSERT  INTO dbo.CampaignSETitleIDAdIDMapping
                    ( SEID ,
                      CampaignID ,
                      SETitleID ,
                      AdID
                    )
            VALUES  ( @SEID ,
                      @CampaignID ,
                      @SETitleID ,
                      @ExternalID
                    )

        INSERT  LandingPageOptimize
                ( AdTitleMappingID ,
                  ClientID
                )
                SELECT  AdTitleMappingID ,
                        ClientID
                FROM    CampaignAdCategory
                WHERE   AdTitleMappingID = @AdTitleMappingID
    END






GO

GRANT EXECUTE ON [dbo].[SI_SP_CampaignAdTitleMapping_Insert] TO [webaccess] AS [dbo]
GO


