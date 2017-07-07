SELECT * FROM dbo.AffiliateGroupClients
WHERE ClientID = 754

SELECT * FROM UserClientHeirarchyCache
WHERE ClientID = 7733

UPDATE  SearchIgnite..AT_ClientHeirarchyCacheRefreshJob
SET ForceRefresh = 1 
WHERE UserID IN (SELECT UserID
FROM Searchignite..UserClientHeirarchyCache
WHERE ClientID = 7733)


SELECT * FROM SearchIgnite..AT_ClientHeirarchyCacheRefreshJob
WHERE ForceRefresh = 1 

exec SIOLAP..SI_SP_RPT_PS_Transaction_MultiVariable @StartDate=N'9/10/2012',@EndDate=N'9/11/2012',@ClientId=754,@customertransactiontypeid=N'1356'
