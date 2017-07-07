
--Get files 
SELECT ''''+DataFileName+''','
FROM SIProcessing..Apple_Order ao 
WHERE PATINDEX('c:\tmp\SIG_2012062[0-9][0-9][0-9][0-9][0-9][0-9][0-9]_2817.txt',DataFileName) = 1
GROUP BY  DataFileName 
ORDER BY  DataFileName 

--get files by file name
SELECT  DataFileName, COUNT(1) 
FROM SIProcessing..Apple_Order
WHERE DataFileName IN ( 
	'c:\tmp\SIG_20120626030005_2817.txt'
)
GROUP BY DataFileName

-- # of actions
SELECT DataFileName, COUNT(1), SUM(CASE WHEN ta.TrackedActionID IS NULL THEN 0 ELSE 1 END) MatchedActions
FROM SIProcessing..Apple_Order ao 
LEFT JOIN SIProcessing_Attribution..TRackedAction ta WITH (INDEX(IX_ClientID_UserUniqueGUID__CustomerTransactionTypeID_TransactionTypeID_TransactionAmount_MoreInfo)) ON ao.ClientId = ta.ClientID
	AND ta.UserUniqueGUID = ao.BillingUserUniqueID
	AND InvoiceDate = ta.CreateDateUTC
	AND RecordStatus = 'A'
WHERE ao.DataFileName IN (
'c:\tmp\SIG_20120620030004_2817.txt'
)
GROUP BY  DataFileName 
ORDER BY  DataFileName 

-- Attributed from file
SELECT  ao.DataFileName, COUNT(1)
FROM SIProcessing_CacheHistory..TrackedCache tc
JOIN SIProcessing_Attribution..TRackedAction ta WITH (INDEX(IX_ClientID_UserUniqueGUID__CustomerTransactionTypeID_TransactionTypeID_TransactionAmount_MoreInfo)) 
ON tc.TRackedActionID = ta.TRackedActionID
JOIN SIProcessing..Apple_Order ao ON ta.UserUniqueGUID = ao.BillingUserUniqueID
	AND InvoiceDate = ta.CreateDateUTC
	AND ao.ClientId = ta.ClientID
WHERE ao.DataFileName IN (
'c:\tmp\SIG_20120626030005_2817.txt'
)
AND TA.RecordStatus = 'A'
GROUP BY ao.DataFileName
ORDER BY ao.DataFileName

