
USE Searchignite

/*
SELECT * FROM dbo.VirtualGroup
WHERE ClientID = 7493
	AND StatusFlag = 1
*/

--2 Campaigns
DECLARE @VGID INT = 6054,
	@ClientID INT = 7493,
	@UserID INT = 4291,
	@VirtualGroup nvarchar(500) = N'Group C: National',
	@VGFilter XML = N'<si><VGFilter xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" SEID="82" CampaignID="347093" GroupID="0" Included="1" /><VGFilter xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" SEID="82" CampaignID="347166" GroupID="0" Included="1" /><VGFilter xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" SEID="82" CampaignID="347168" GroupID="0" Included="1" /><VGFilter xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" SEID="82" CampaignID="347165" GroupID="0" Included="1" /><VGFilter xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" SEID="82" CampaignID="347169" GroupID="0" Included="1" /><VGFilter xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" SEID="82" CampaignID="347167" GroupID="0" Included="1" /></si>'

exec SI_SP_VirtualGroup_BuildTempUserData 
	@ClientID =@ClientID,
	@UserID =@UserID,
	@VGID =@VGID

exec SI_SP_VirtualGroupFilter_Delete 
	@VGFilter = @VGFilter,
	@UserID =@UserID,
	@VGID =@VGID
	
exec SI_SP_VirtualGroupFilter_Insert 
	@VGFilter =@VGFilter,
	@UserID =@UserID,
	@VGID =@VGID
	
exec SI_SP_VirtualGroup_InsertUpdate 
	@ClientID =@ClientID,
	@VirtualGroup = @VirtualGroup,
	@AutoRefresh=1,
	@VGID =@VGID
	
exec SI_SP_VirtualGroup_Save 
	@ClientID =@ClientID,
	@UserID =@UserID,
	@VGID =@VGID
	
exec SI_SP_VirtualGroupAdvFilter_RefreshResult 
	@ClientID =@ClientID,
	@UserID =@UserID,
	@VGID =@VGID

exec SI_SP_VirtualGroupDetailCache_Generate 
	@ClientID =@ClientID,
	@VGID =@VGID
