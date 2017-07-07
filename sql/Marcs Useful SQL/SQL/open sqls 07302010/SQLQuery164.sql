/*
dbo.SI_SP_TransactionLoadNonAffiliateClients
 @BeginDate = '2010-05-09'
, @EndDate = '2010-05-20'
, @ClientID = 2537
*/

SELECT CAST(localizedcreatedate AS DATE) AS TADate
 , COUNT(*) AS TACount 
from SIProcessing_Attribution..TrackedAction 
 where ClientID = 2537 and LocalizedCreateDate >= '2010-05-01' and LocalizedCreateDate < '2010-06-12' 
 and CustomerTransactionTypeID = 2753 and TrackingSourceID = 3 
group by CAST(localizedcreatedate AS DATE)
  
SELECT 
 CAST(easterncreatedate AS DATE) AS TEDate
 , SUM(actionquantity) AS ActionQty 
from SIProcessing_CacheHistory..Trackedcache 
where ClientID = 2537 and EasternCreateDate >= '2010-05-01' and EasternCreateDate < '2010-06-12' 
and CustomerTransactionTypeID = 2753 and channelid = 4 
group by CAST(easterncreatedate AS DATE)



SELECT COUNT(1), CAST(EasternCreateDate AS DATE) FROM SIProcessing_CacheHistory..TrackedCache 
WHERE EasternCreateDate BETWEEN '2010-04-21' AND '2010-05-20'
AND ClientID = 2537
ANd ChannelID = 4
Group by CAST(EasternCreateDate AS DATE)
ORDER BY CAST(EasternCreateDate AS DATE)

SELECT * FROM SIProcessing_CacheHistory..TrackedCache 
WHERE EasternCreateDate BETWEEN '2010-04-21' AND '2010-05-20'
AND ClientID = 2537
ANd ChannelID = 4


