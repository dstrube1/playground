
DECLARE @UserID INT = 8613

SELECT * 
FROM Users 
WHERE UserID = @UserID

SELECT *
FROM AT_UserSession
WHERE UserID = @UserID

SELECT * 
FROM External_AdvertiserClient_MappingHistory
WHERE UserID = @UserID

SELECT * 
FROM AT_AuthenticationLog
WHERE UserID = @UserID

SELECT * 
FROM VirtualGroupTimeFrame
WHERE UserID = @UserID

SELECT * 
FROM UserClientHeirarchyCache
WHERE UserID = @UserID

SELECT * 
FROM AddressHistory
WHERE UserID = @UserID

SELECT * 
FROM FBSponsoredStoryRule
WHERE UserID = @UserID

SELECT * 
FROM AdvancedFilter
WHERE UserID = @UserID

SELECT * 
FROM CampaignHistory
WHERE UserID = @UserID

SELECT * 
FROM Users_LUViewPreference
WHERE UserID = @UserID

SELECT * 
FROM CampaignAdcategoryBidRuleHistory
WHERE UserID = @UserID

SELECT * 
FROM SavedReports
WHERE UserID = @UserID

SELECT * 
FROM DFARateCardHistory
WHERE UserID = @UserID

SELECT * 
FROM CampaignManagement_CampaignCacheAdmin
WHERE UserID = @UserID

SELECT * 
FROM CampaignBidRuleHistory
WHERE UserID = @UserID

SELECT * 
FROM ClientAttributionProfileSettingHistory
WHERE UserID = @UserID

SELECT * 
FROM VirtualGroupFilter
WHERE UserID = @UserID

SELECT * 
FROM VirtualGroupAdvMemberTree
WHERE UserID = @UserID

SELECT * 
FROM VirtualGroupAdvFilter
WHERE UserID = @UserID

SELECT * 
FROM AdBundle
WHERE UserID = @UserID

SELECT * 
FROM UsersHistory
WHERE UserID = @UserID

SELECT * 
FROM Users_LUFeature
WHERE UserID = @UserID

SELECT * 
FROM ClientMailOptionHistory
WHERE UserID = @UserID

SELECT * 
FROM ClientAttributionProfileSetting
WHERE UserID = @UserID

SELECT * 
FROM UserDetail
WHERE UserID = @UserID

SELECT * 
FROM CampaignOptimizerSettingsEmailQueue
WHERE UserID = @UserID

SELECT * 
FROM ClientContactHistory
WHERE UserID = @UserID

SELECT * 
FROM AT_ClientHeirarchyCacheRefreshJob
WHERE UserID = @UserID

SELECT * 
FROM UserDetailHistory
WHERE UserID = @UserID

SELECT * 
FROM LUDataGridColumn_User
WHERE UserID = @UserID

SELECT * 
FROM UserWSSession
WHERE UserID = @UserID

SELECT * 
FROM SigarUserSigned
WHERE UserID = @UserID

SELECT * 
FROM Users_Clients_Role
WHERE UserID = @UserID

SELECT * 
FROM OmniturePageViewMappingChange
WHERE UserID = @UserID

SELECT * 
FROM TrackingRuleHistory
WHERE UserID = @UserID

SELECT * 
FROM AlertQueue
WHERE UserID = @UserID

SELECT * 
FROM AccessRoleUserClientMap
WHERE UserID = @UserID

SELECT * 
FROM AlertSubscription_Users
WHERE UserID = @UserID

SELECT * 
FROM AlertSummary_Users
WHERE UserID = @UserID

SELECT * 
FROM ClientChargeHistory
WHERE UserID = @UserID

SELECT * 
FROM DMSBLOB..FileShare
WHERE UserID = @UserID

SELECT * 
FROM DMS_History..TrackingRuleHistory
WHERE UserID = @UserID

SELECT * 
FROM DMS_History..UserDetailHistory
WHERE UserID = @UserID

SELECT * 
FROM DMS_History..UsersHistory
WHERE UserID = @UserID

SELECT * 
FROM DMS_History..AT_AuthenticationLog
WHERE UserID = @UserID

SELECT * 
FROM SearchIgnite_Admin..SIEventLog
WHERE UserID = @UserID

SELECT * 
FROM SIOLAP..ReportQueue
WHERE UserID = @UserID

SELECT * 
FROM SIOLAP..ReportTemplate
WHERE UserID = @UserID

SELECT * 
FROM SIOLAP..ReportTemplateUserDefault
WHERE UserID = @UserID

SELECT * 
FROM SIOLAP..ReportQueueActivityHistory
WHERE UserID = @UserID

SELECT * 
FROM SIOLAP..ReportCustomizedMetric
WHERE UserID = @UserID

/*
DELETE
FROM Users 
WHERE UserID = @UserID

DELETE
FROM AT_UserSession
WHERE UserID = @UserID

DELETE
FROM External_AdvertiserClient_MappingHistory
WHERE UserID = @UserID

DELETE
FROM AT_AuthenticationLog
WHERE UserID = @UserID

DELETE
FROM VirtualGroupTimeFrame
WHERE UserID = @UserID

DELETE
FROM UserClientHeirarchyCache
WHERE UserID = @UserID

DELETE
FROM AddressHistory
WHERE UserID = @UserID

DELETE
FROM FBSponsoredStoryRule
WHERE UserID = @UserID

DELETE
FROM AdvancedFilter
WHERE UserID = @UserID

DELETE
FROM CampaignHistory
WHERE UserID = @UserID

DELETE
FROM Users_LUViewPreference
WHERE UserID = @UserID

DELETE
FROM CampaignAdcategoryBidRuleHistory
WHERE UserID = @UserID

DELETE
FROM SavedReports
WHERE UserID = @UserID

DELETE
FROM DFARateCardHistory
WHERE UserID = @UserID

DELETE
FROM CampaignManagement_CampaignCacheAdmin
WHERE UserID = @UserID

DELETE
FROM CampaignBidRuleHistory
WHERE UserID = @UserID

DELETE
FROM ClientAttributionProfileSettingHistory
WHERE UserID = @UserID

DELETE
FROM VirtualGroupFilter
WHERE UserID = @UserID

DELETE
FROM VirtualGroupAdvMemberTree
WHERE UserID = @UserID

DELETE
FROM VirtualGroupAdvFilter
WHERE UserID = @UserID

DELETE
FROM AdBundle
WHERE UserID = @UserID

DELETE
FROM UsersHistory
WHERE UserID = @UserID

DELETE
FROM Users_LUFeature
WHERE UserID = @UserID

DELETE
FROM ClientMailOptionHistory
WHERE UserID = @UserID

DELETE
FROM ClientAttributionProfileSetting
WHERE UserID = @UserID

DELETE
FROM UserDetail
WHERE UserID = @UserID

DELETE
FROM CampaignOptimizerSettingsEmailQueue
WHERE UserID = @UserID

DELETE
FROM ClientContactHistory
WHERE UserID = @UserID

DELETE
FROM AT_ClientHeirarchyCacheRefreshJob
WHERE UserID = @UserID

DELETE
FROM UserDetailHistory
WHERE UserID = @UserID

DELETE
FROM LUDataGridColumn_User
WHERE UserID = @UserID

DELETE
FROM UserWSSession
WHERE UserID = @UserID

DELETE
FROM SigarUserSigned
WHERE UserID = @UserID

DELETE
FROM Users_Clients_Role
WHERE UserID = @UserID

DELETE
FROM OmniturePageViewMappingChange
WHERE UserID = @UserID

DELETE
FROM TrackingRuleHistory
WHERE UserID = @UserID

DELETE
FROM AlertQueue
WHERE UserID = @UserID

DELETE
FROM AccessRoleUserClientMap
WHERE UserID = @UserID

DELETE
FROM AlertSubscription_Users
WHERE UserID = @UserID

DELETE
FROM AlertSummary_Users
WHERE UserID = @UserID

DELETE
FROM ClientChargeHistory
WHERE UserID = @UserID

DELETE
FROM DMSBLOB..FileShare
WHERE UserID = @UserID

DELETE
FROM DMS_History..TrackingRuleHistory
WHERE UserID = @UserID

DELETE
FROM DMS_History..UserDetailHistory
WHERE UserID = @UserID

DELETE
FROM DMS_History..UsersHistory
WHERE UserID = @UserID

DELETE
FROM DMS_History..AT_AuthenticationLog
WHERE UserID = @UserID

DELETE
FROM SearchIgnite_Admin..SIEventLog
WHERE UserID = @UserID

DELETE
FROM SIOLAP..ReportQueue
WHERE UserID = @UserID

DELETE
FROM SIOLAP..ReportTemplate
WHERE UserID = @UserID

DELETE
FROM SIOLAP..ReportTemplateUserDefault
WHERE UserID = @UserID

DELETE
FROM SIOLAP..ReportQueueActivityHistory
WHERE UserID = @UserID

DELETE
FROM SIOLAP..ReportCustomizedMetric
WHERE UserID = @UserID

*/
