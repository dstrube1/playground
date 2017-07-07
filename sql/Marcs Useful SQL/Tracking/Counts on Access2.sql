USE SIAccess

SELECT COUNT(1)
FROM ClickTrackingRaw_A WITH (NOLOCK)

--TRUNCATE TABLE ClickTrackingRaw_A
/*
DELETE TOP (750000) 
FROM ClickTrackingRaw_B
OUTPUT deleted.CSKID, deleted.URL, deleted.SessionGUID, deleted.LongTermGUID, deleted.IPAddress, deleted.OSVersion, deleted.BrowserVersion, deleted.CreateDate, deleted.ReferralURL, deleted.ReferralPage, deleted.EasternCreateDate, deleted.ISContentMatch, deleted.ExtraInfo1, deleted.ExtraInfo2, deleted.UserUniqueGuid, deleted.ReferenceID, deleted.WebServerName, deleted.TypedKeyword, deleted.ExceptionID, deleted.QueriedPage, deleted.Domain, deleted.URLID, deleted.DeliveryAllocation, deleted.URLTypeID, deleted.GlobalTrackingTypeID, deleted.GlobalTrackingID, deleted.AttributeCollection, deleted.DeviceType, deleted.DeviceModel
INTO ClickTrackingRaw_A (CSKID, URL, SessionGUID, LongTermGUID, IPAddress, OSVersion, BrowserVersion, CreateDate, ReferralURL, ReferralPage, EasternCreateDate, ISContentMatch, ExtraInfo1, ExtraInfo2, UserUniqueGuid, ReferenceID, WebServerName, TypedKeyword, ExceptionID, QueriedPage, Domain, URLID, DeliveryAllocation, URLTypeID, GlobalTrackingTypeID, GlobalTrackingID, AttributeCollection, DeviceType, DeviceModel);

*/

SELECT COUNT(1)
FROM ClickTrackingRaw_B WITH (NOLOCK)

/*

SELECT CAST(EasternCreateDate AS DATE),DATEPART(hh,EasternCreateDate),COUNT(1)
FROM ClickTrackingRaw_B WITH (NOLOCK)
GROUP BY CAST(EasternCreateDate AS DATE),DATEPART(hh,EasternCreateDate)
ORDER BY CAST(EasternCreateDate AS DATE),DATEPART(hh,EasternCreateDate)
*/
/*
DELETE FROM ClickTrackingRaw_B 
WHERE CreateDate < '7/15/2013 20:00:00.000'
*/

SELECT COUNT(1)
FROM DisplayClickTrackingRaw_A WITH (NOLOCK)

--TRUNCATE TABLE DisplayClickTrackingRaw_A

SELECT COUNT(1)
FROM DisplayClickTrackingRaw_B WITH (NOLOCK)

--TRUNCATE TABLE DisplayClickTrackingRaw_B

SELECT COUNT(1)
FROM NatureSearchClickTrackingRaw_A WITH (NOLOCK)

--TRUNCATE TABLE NatureSearchClickTrackingRaw_A

SELECT COUNT(1)
FROM NatureSearchClickTrackingRaw_B WITH (NOLOCK)

--TRUNCATE TABLE NatureSearchClickTrackingRaw_B

SELECT COUNT(1)
FROM TransactionTrackingRaw_A WITH (NOLOCK)

--TRUNCATE TABLE TransactionTrackingRaw_A

SELECT COUNT(1)
FROM TransactionTrackingRaw_B WITH (NOLOCK)


--TRUNCATE TABLE TransactionTrackingRaw_B


