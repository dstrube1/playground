select UMKeywordID,
		 Keyword, 
		 sum(convert(bigint, NumImpressions)) as NumImpressions, 
		 sum(Cost * isnull(ExchangeRate, 1)) as Cost, 
		 sum(NetMedia) as NetMedia, 
		 sum(NumExposureReported) as NumClicksTracked, 
		 sum(TransactionCount) as TransactionCount, 
		 sum(TransactionAmount * isnull(ExchangeRate, 1)) as TransactionAmount, 
		 sum(TransactionCountWithWeight) as TransactionCountWithWeight 
	from dbo.RPT_UM_Summary_Keywords tt 
	join dbo.NatureSearchEngine se on tt.ClientID = 4360 and GenerateDate between 'Jul 17 2010 12:00AM' and 'Jul 18 2010 12:00AM'  and se.NSEID = tt.OTSEID 
	left join dbo.CurrencyExchangeData et on et.FromCurrencyID = se.CurrencyID and et.ToCurrencyID = 73 
	group by UMKeywordID, Keyword

select UMKeywordID,
		 Keyword, 
		 sum(convert(bigint, NumImpressions)) as NumImpressions, 
		 sum(Cost * isnull(ExchangeRate, 1)) as Cost, 
		 sum(NetMedia) as NetMedia, 
		 sum(NumExposureReported) as NumClicksTracked, 
		 sum(TransactionCount) as TransactionCount, 
		 sum(TransactionAmount * isnull(ExchangeRate, 1)) as TransactionAmount, 
		 sum(TransactionCountWithWeight) as TransactionCountWithWeight 
	from dbo.RPT_UM_Summary_Keywords tt 
	join dbo.NatureSearchEngine se on se.NSEID = tt.OTSEID 
	left join dbo.CurrencyExchangeData et on et.FromCurrencyID = se.CurrencyID and et.ToCurrencyID = 73 
	WHERE tt.ClientID = 4360 and GenerateDate between 'Jul 17 2010 12:00AM' and 'Jul 18 2010 12:00AM'
	group by UMKeywordID, Keyword

SELECT UserID FROM Users WHERE UserName like '%yyang@searchignite.com%'
SELECT * FROm Users WHERE UserID IN (3839,3834)

(SELECT UserID FROM Users WHERE UserName like '%jbaron@searchignite.com%')
SELECT * FROm Users WHERE UserID IN (3652,3831)

SELECT  CAST(GenerateDate as date) as GenerateDate,
	SUM(TransactionCount)
FROM RPT_UM_Summary_Keywords 
WHERE Clientid = 4360
AND GenerateDate >= '2010-07-01'
GROUP BY CAST(GenerateDate as DATE) 
ORDER BY CAST(GenerateDate as DATE)

SELECT 
	CAST(EasternCreateDate as Date) As EastDate,
	COUNT(1)
FROM SIProcessing_CacheHistory..TrackedCache w
WHERE ClientID = 4360
AND EasternCreateDate >= '2010-07-12'
AND EasternCreateDate < '2010-07-25'
GROUP BY CAST(EasternCreateDate as Date)
ORDER BY CAST(EasternCreateDate as Date)


SELECT *
FROM SIProcessing_CacheHistory..TrackedCache
WHERE ClientID = 4360
AND EasternCreateDate >= '2010-07-15'
AND EasternCreateDate < '2010-07-16'
