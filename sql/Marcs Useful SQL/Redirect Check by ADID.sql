
--sp_who4 232   

--sp_who5

DECLARE @ADID INT =  127390927 ,
	@AdTitleUrlID INT,
	@ExternalID VARCHAR(30)

SELECT * 
FROM DMS_Campaign..CampaignAdTitleMapping_Base
WHERE SETitleID = @ADID

SELECT @ExternalID = ExternalID 
FROM DMS_Campaign..CampaignAdTitleMapping_Base
WHERE SETitleID = @ADID

SELECT * 
FROM  SearchIgnite.dbo.CampaignADTitleURLs
WHERE SETitleID = @ADID

SELECT @AdTitleUrlID = AdTitleUrlID 
FROM  SearchIgnite.dbo.CampaignADTitleURLs
WHERE SETitleID = @ADID

SELECT * 
FROM DMS_History.dbo.CampaignADTitleURLs_History
WHERE AdTitleUrlID =@AdTitleUrlID

SELECT * 
FROM RedirectHub.dbo.Tracking_CreativeRedirects
WHERE ExternalID = @ExternalID

