
/*

SELECT CAST(CreateDate AS DATE), DATEPART(hh,CreateDate), COUNT(1)
FROM HistoryException..ClickTrackingRaw_History ct
WHERE CreateDate>= '07/17/2013'
AND CreateDate < '07/19/2013'
AND EXISTS (SELECT 1 FROM JunkDB..CSKeywords_5290 WHERE CSKID = ct.CSKID)
GROUP BY CAST(CreateDate AS DATE), DATEPART(hh,CreateDate)
ORDER  BY CAST(CreateDate AS DATE), DATEPART(hh,CreateDate)

SELECT CAST(CreateDate AS DATE), DATEPART(hh,CreateDate), COUNT(1)
FROM HistoryException..TransactionTrackingRaw_History ct (NOLOCK)
WHERE CreateDate>= '07/17/2013 23:00:00.000'
AND CreateDate < '07/18/2013 05:00:00.0000'
AND ClientID = 5290
GROUP BY CAST(CreateDate AS DATE), DATEPART(hh,CreateDate)
ORDER  BY CAST(CreateDate AS DATE), DATEPART(hh,CreateDate)

SELECT *
INTO JunkDB..MArcTest_Actions_5290 
FROM HistoryException..TransactionTrackingRaw_History ct (NOLOCK)
WHERE CreateDate >= '07/17/2013 23:00:00.000'
AND CreateDate < '07/18/2013 05:00:00.000'
AND ClientID = 5290



SELECT *
INTO JunkDB..MArcTest_Clicks_5290 
FROM HistoryException..ClickTrackingRaw_History ct (NOLOCK)
WHERE CreateDate >= '07/17/2013 23:00:00.000'
AND CreateDate < '07/18/2013 05:00:00.000'
AND EXISTS (SELECt 1 FROM JunkDB..CSKeywords_5290 WHERE ct.CSKID = CSKID AND StatusFlag = 1)


SELECT DATEPART(hh,CreateDate),COunt(1)
FROM JunkDB..MArcTest_Actions_5290 
GROUP BY DATEPART(hh,CreateDate)
ORDER BY DATEPART(hh,CreateDate)

SELECT DATEPART(hh,CreateDate),COunt(1) 
FROM JunkDB..MArcTest_Clicks_5290 
--where uSERuNIQUEgUID = 'ca19bef2-b844-46d8-8bed-11d37760943d'
GROUP BY DATEPART(hh,CreateDate)
ORDER BY DATEPART(hh,CreateDate)

SELECT DATEPART(hh,CreateDate), count(1)
FROM JunkDB..MArcTest_Actions_5290 a
WHERE EXISTS (SELECt 1 fROM JunkDB..MArcTest_Clicks_5290  WHERE UserUniqueGuid = a.UserUniqueGuid AND CreateDate >= DAteADD(hh,-1,a.CreateDate))
GROUP BY DATEPART(hh,CreateDate)
ORDER BY DATEPART(hh,CreateDate)

seelc



*/

USE SIAccess

DECLARE @SDATE DATETIME = '07/17/2013 19:00:00.000',
	@EDate DATETIME = '07/17/2013 23:00:00.000',
	@Increment_Hrs INT = 1
	
WHILE (@SDATE < @EDate)
BEGIN
	--Paid Clicks
	IF EXISTS (SELECT 1 FROM dbo.AT_ClickTransactionRawProcessing where ProcessingTableID = 1)
		INSERT INTO ClickTrackingRaw_A(CSKID, URL, IPAddress, OSVersion, BrowserVersion,  ReferralURL,ReferralPage, EasternCreateDate, ISContentMatch, ExtraInfo1, ExtraInfo2, ExceptionID, UserUniqueGuid, ReferenceID,CreateDate, WebServerName, TypedKeyword, QueriedPage,  Domain, URLID, DeliveryAllocation, URLTypeID, GlobalTrackingTypeID, GlobalTrackingID, AttributeCollection, DeviceType, DeviceModel)
		SELECT  CSKID, URL, IPAddress, OSVersion, BrowserVersion,  ReferralURL, ReferralPage, EasternCreateDate, ISContentMatch, ExtraInfo1, ExtraInfo2, ExceptionID, UserUniqueGuid, ReferenceID,CreateDate, WebServerName, TypedKeyword, QueriedPage,  Domain, URLID, DeliveryAllocation, URLTypeID, GlobalTrackingTypeID, GlobalTrackingID, AttributeCollection, DeviceType, DeviceModel
		FROM [HistoryException].[dbo].[ClickTrackingRaw_History] ct
		WHERE CreateDate>= @SDATE
			AND CreateDate < DATEADD(hh,@Increment_Hrs,@SDATE)
	ELSE
		INSERT INTO ClickTrackingRaw_B(CSKID, URL, IPAddress, OSVersion, BrowserVersion, ReferralURL,ReferralPage, EasternCreateDate, ISContentMatch, ExtraInfo1, ExtraInfo2, ExceptionID, UserUniqueGuid, ReferenceID,CreateDate, WebServerName, TypedKeyword, QueriedPage,  Domain, URLID, DeliveryAllocation, URLTypeID, GlobalTrackingTypeID, GlobalTrackingID, AttributeCollection, DeviceType, DeviceModel)
		SELECT  CSKID, URL, IPAddress, OSVersion, BrowserVersion,  ReferralURL, ReferralPage, EasternCreateDate, ISContentMatch, ExtraInfo1, ExtraInfo2, ExceptionID, UserUniqueGuid, ReferenceID,CreateDate, WebServerName, TypedKeyword, QueriedPage,  Domain, URLID, DeliveryAllocation, URLTypeID, GlobalTrackingTypeID, GlobalTrackingID, AttributeCollection, DeviceType, DeviceModel
		FROM [HistoryException].[dbo].[ClickTrackingRaw_History] ct
		WHERE CreateDate>= @SDATE
			AND CreateDate < DATEADD(hh,@Increment_Hrs,@SDATE)
	
	--Actions
	IF EXISTS (SELECT 1 FROM AT_ClickTransactionRawProcessing WHERE ProcessingTableID = 1)
		INSERT INTO dbo.TransactionTrackingRaw_A(ClientID, TransactionAmount, TransactionTypeID,IPAddress, BrowserVersion, MoreInfo, N1, N2, N3, N4, N5, N6, N7, N8, N9, N10, X1, X2, X3, X4, X5, X6, X7, X8,X9, X10, CustomerTransactionTypeID, loginfo, UserUniqueGuid, ReferenceID, OrigClientID,EasternCreateDate,CreateDate, ClickCreateDate,WebServerName)
		SELECT ClientID, TransactionAmount, TransactionTypeID,IPAddress, BrowserVersion, MoreInfo, N1, N2, N3, N4, N5, N6, N7, N8, N9, N10, X1, X2, X3, X4, X5, X6, X7, X8,X9, X10, CustomerTransactionTypeID, loginfo, UserUniqueGuid, ReferenceID, OrigClientID,EasternCreateDate,CreateDate, ClickCreateDate,WebServerName
		FROM HistoryException..TransactionTrackingRaw_History
		WHERE CreateDate>= @SDATE
			AND CreateDate < DATEADD(hh,@Increment_Hrs,@SDATE)
	ELSE
		INSERT INTO dbo.TransactionTrackingRaw_B(ClientID, TransactionAmount, TransactionTypeID,IPAddress, BrowserVersion, MoreInfo, N1, N2, N3, N4, N5, N6, N7, N8, N9, N10, X1, X2, X3, X4, X5, X6, X7, X8,X9, X10, CustomerTransactionTypeID, loginfo, UserUniqueGuid, ReferenceID, OrigClientID,EasternCreateDate,CreateDate, ClickCreateDate,WebServerName)
		SELECT ClientID, TransactionAmount, TransactionTypeID,IPAddress, BrowserVersion, MoreInfo, N1, N2, N3, N4, N5, N6, N7, N8, N9, N10, X1, X2, X3, X4, X5, X6, X7, X8,X9, X10, CustomerTransactionTypeID, loginfo, UserUniqueGuid, ReferenceID, OrigClientID,EasternCreateDate,CreateDate, ClickCreateDate,WebServerName
		FROM HistoryException..TransactionTrackingRaw_History
		WHERE CreateDate>= @SDATE
			AND CreateDate < DATEADD(hh,@Increment_Hrs,@SDATE)
			
	--Display Clicks
	IF EXISTS (SELECT 1 FROM dbo.AT_ClickTransactionRawProcessing where ProcessingTableID = 1)
		INSERT INTO DisplayClickTrackingRaw_A ([ImpressionID],[UserUniqueGuid],[ClientID],[AdvertiserID],[CreativeID],[AdCategoryID],[PublisherID],[URL],[ReferralURL],[OSVersion],[BrowserVersion],[IPAddress],[WebServerName],[CreateDateUTC],[ExceptionID],[GlobalTrackingTypeID], [GlobalTrackingID], [AttributeCollection])
		SELECT [ImpressionID],[UserUniqueGuid],[ClientID],[AdvertiserID],[CreativeID],[AdCategoryID],[PublisherID],[URL],[ReferralURL],[OSVersion],[BrowserVersion],[IPAddress],[WebServerName],[CreateDateUTC],[ExceptionID],[GlobalTrackingTypeID], [GlobalTrackingID], [AttributeCollection] 
		FROM HistoryException..DisplayClickTrackingRaw_History
		WHERE CreateDateUTC >= @SDATE
			AND CreateDateUTC < DATEADD(hh,@Increment_Hrs,@SDATE)
	ELSE
		INSERT INTO DisplayClickTrackingRaw_B ([ImpressionID],[UserUniqueGuid],[ClientID],[AdvertiserID],[CreativeID],[AdCategoryID],[PublisherID],[URL],[ReferralURL],[OSVersion],[BrowserVersion],[IPAddress],[WebServerName],[CreateDateUTC],[ExceptionID],[GlobalTrackingTypeID], [GlobalTrackingID], [AttributeCollection])
		SELECT [ImpressionID],[UserUniqueGuid],[ClientID],[AdvertiserID],[CreativeID],[AdCategoryID],[PublisherID],[URL],[ReferralURL],[OSVersion],[BrowserVersion],[IPAddress],[WebServerName],[CreateDateUTC],[ExceptionID],[GlobalTrackingTypeID], [GlobalTrackingID], [AttributeCollection] 
		FROM HistoryException..DisplayClickTrackingRaw_History
		WHERE CreateDateUTC >= @SDATE
			AND CreateDateUTC < DATEADD(hh,@Increment_Hrs,@SDATE)
			
	--Natural Clicks
	IF EXISTS (SELECT 1 FROM dbo.AT_ClickTransactionRawProcessing  WHERE ProcessingTableID = 1) 
		INSERT INTO NatureSearchClickTrackingRaw_A(EasternCreateDate, KeywordID, ClientID, NSEID, URL, IPAddress, OSVersion, BrowserVersion,ReferralURL, ReferralPage, IsPaidInclusion, ProductText, Keyword, UserUniqueGuid, ReferenceID,CreateDate, WebServerName, QueriedPage,Domain,ExceptionID,GlobalTrackingTypeID, GlobalTrackingID, AttributeCollection)
		SELECT EasternCreateDate, KeywordID, ClientID, NSEID, URL, IPAddress, OSVersion, BrowserVersion,ReferralURL, ReferralPage, IsPaidInclusion, ProductText, Keyword, UserUniqueGuid, ReferenceID,CreateDate, WebServerName, QueriedPage,Domain,ExceptionID,GlobalTrackingTypeID, GlobalTrackingID, AttributeCollection
		FROM HistoryException..NatureSearchClickTrackingRaw_History
		WHERE CreateDate >= @SDATE
			AND CreateDate < DATEADD(hh,@Increment_Hrs,@SDATE)
	ELSE
		INSERT INTO NatureSearchClickTrackingRaw_B(EasternCreateDate, KeywordID, ClientID, NSEID, URL, IPAddress, OSVersion, BrowserVersion,ReferralURL, ReferralPage, IsPaidInclusion, ProductText, Keyword, UserUniqueGuid, ReferenceID,CreateDate, WebServerName, QueriedPage,Domain,ExceptionID,GlobalTrackingTypeID, GlobalTrackingID, AttributeCollection)
		SELECT EasternCreateDate, KeywordID, ClientID, NSEID, URL, IPAddress, OSVersion, BrowserVersion,ReferralURL, ReferralPage, IsPaidInclusion, ProductText, Keyword, UserUniqueGuid, ReferenceID,CreateDate, WebServerName, QueriedPage,Domain,ExceptionID,GlobalTrackingTypeID, GlobalTrackingID, AttributeCollection
		FROM HistoryException..NatureSearchClickTrackingRaw_History
		WHERE CreateDate >= @SDATE
			AND CreateDate < DATEADD(hh,@Increment_Hrs,@SDATE)
			
	SET @SDate = DATEADD(hh,1,@SDate)
	
	RAISERROR('Batch Complete',0,1) WITH NOWAIT
	
	WAITFOR DELAY '1:00:00.000'
	
END
