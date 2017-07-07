
SELECT Name
FROM sys.procedures
WHERE OBJECT_DEFINITION(OBJECT_ID) LIKE '%VirtualGroup%'


exec SI_SP_VirtualGroup_BuildTempUserData @ClientID =7492,@UserID =4291,@VGID =7141
exec SI_SP_VirtualGroup_ReadByVGID @VGID =7141
exec SI_SP_VirtualGroupTimeFrame_ReadByVGID @UserID =4291,@VGID =7141
exec SI_SP_VirtualGroupAdvFilter_ReadByVGID @UserID =4291,@VGID =7141
exec SI_SP_VirtualGroup_PublisherTree_Read @UserID=4291,@StatusList=N'1,2',@ClientID=7492,@VGID=7141
exec SI_SP_VirtualGroupTimeFrame_ReadByVGID @UserID =4291,@VGID =7141
exec SI_SP_VirtualGroupAdvMemberTree_ReadByVGID @UserID=4291,@ClientID=7492,@VGID=7141
exec SI_SP_VirtualGroupAdvMemberTree_ReadByVGIDSEID @UserID=4291,@SEID=1,@ClientID=7492,@VGID=7141
exec SI_SP_VirtualGroupAdvMemberTree_ReadByVGIDSEID @UserID=4291,@SEID=82,@ClientID=7492,@VGID=7141

SELECT * FROM Clients WHERE CLientID = 7492

SELECT * FROM dbo.VirtualGroupTimeFrame
WHERE UserID = 4291
AND vgid IN (
SELECT VGID FROM dbo.VirtualGroup
WHERE ClientID IN (SELECT ClientID FROM Clients WHERE StatusFlag = 1 AND ParentClientID = 7491)

)




