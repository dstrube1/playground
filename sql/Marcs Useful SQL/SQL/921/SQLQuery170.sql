

SELECT CAST(EasternCreateDate AS DATE) EDate,COUNT(DISTINCT TrackedActionID) 
FROM dbo.TrackedCache
WHERE ClientID = 754
AND EasternCreateDate >= '09/01/2012'
AND ChannelID = 1
GROUP BY CAST(EasternCreateDate AS DATE) 
ORDER BY CAST(EasternCreateDate AS DATE) 


    SELECT          
     TrackedActionID        
     ,CreateDateUTC        
     ,CurrencyID        
     ,TransactionAmount        
     ,CustomerTransactionTypeID        
     ,ClientID        
     ,UserUniqueGUID        
     ,LocalizedCreateDate        
     ,AffiliateID        
     ,N2    
     , 0 AS isProcessed    
    FROM SIProcessing_Attribution..TrackedAction ta        
 WHERE   LocalizedCreateDate >= '09/10/2012'
	AND LocalizedCreateDate < '09/18/2012'
	AND ClientID = 754
	AND RecordStatus = 'A'
        AND NOT EXISTS ( SELECT 1
                         FROM   SIProcessing_CacheHistory..ExposureSequence es
                         WHERE  es.TrackedActionID = ta.TrackedActionID
         
                               AND es.ActionLocalizedCreateDate = ta.LocalizedCreateDate )
                      
                      
                      SELECT * FROM SIProcessing..ClientCustomerTransactionType
                      WHERE ClientID = 754
                      AND CustomerTransactionTypeID IN (1355,1356) 
                      
                      
SELECT CAST(LocalizedCreateDate AS DATE) AS LDate, CASE CustomerTransactionTypeID WHEN 1355 THEN 'FFA Sale' WHEN 1356 THEN 'Non-FFA Sale' END AS CustomerTransactionType,COUNT(1) 
FROM  dbo.TrackedAction
WHERE ClientID = 754
	AND RecordStatus = 'A'
    AND LocalizedCreateDate >= '09/01/2012'
    AND LocalizedCreateDate < '10/01/2012'  
    AND CustomerTransactionTypeID IN (1355,1356)                         
GROUP BY CAST(LocalizedCreateDate AS DATE), CustomerTransactionTypeID  
ORDER BY CustomerTransactionTypeID , CAST(LocalizedCreateDate AS DATE)

SELECT '''' +MoreInfo +''',', COUNT(1) 
FROM dbo.TrackedAction
WHERE ClientID = 754
	AND RecordStatus = 'A'
    AND LocalizedCreateDate >= '09/01/2012'
    AND LocalizedCreateDate < '10/01/2012'  
    AND CustomerTransactionTypeID IN (1355,1356)  
GROUP BY MoreInfo
HAVING COUNT(1) > 1 

SELECT *
FROM dbo.TrackedAction
WHERE ClientID = 754
	AND RecordStatus = 'A'
    AND LocalizedCreateDate >= '09/01/2012'
    AND LocalizedCreateDate < '10/01/2012'  
    AND CustomerTransactionTypeID IN (1355,1356)  
	AND MoreInfo IN ('237BGFF284F2454C',
			'25HFG3G7297B4HF6',
			'36B8EA4468FA4H2E',
			'4EA3D2HC42A64GH9',
			'5BH2G2EADA8C425C',
			'6F7DH2A835894FH9',
			'89E9C97AF6BB4HDB',
			'89F66D6DHH6448G8',
			'9FE9B853EHED43C2',
			'B788G7458BHF4542',
			'C27776648BH64763',
			'CG6H5FB3H5254BD9',
			'D49E5ED37BDB4GC3',
			'HED3D3C384DC4D8E'
		)
	ORDER BY MoreInfo

SELECT * FROM SIProcessing..BatchTransactionHeader
WHERE clientid = 754
/*

2149
2157

*/
SELECT * FROM SIProcessing..BatchTransactionHistory
WHERE BatchTransactionHeaderID IN (124935,124964)
AND CustomerTransactionTypeID IN (1355,1356)  

EXEC SIProcessing..SI_SP_BatchTransactions_ProcessBatch @isDebug = 1, @BatchID = 2149
                                

				SELECT  124935 AS BatchTransactionHeaderID,
						bt.TrackedActionID,
						CASE WHEN bt.CustomerTransactionTypeID = 0
							 THEN NULL
							 ELSE bt.CustomerTransactionTypeID
						END AS CustomerTransactionTypeID
						,case when tt.TrackedActionID is null then 1 
							else 2 end as BatchTransactionRecordTypeID 
						,tt.TrackedActionID
						,tt.CreateDateUTC
						,tt.LocalizedCreateDate
				FROM    BatchTransaction bt
				JOIN SIProcessing_Attribution..TrackedAction tt ON  bt.ClientID = tt.ClientID
						AND RecordStatus = 'a'
					AND TT.MoreInfo = BT.MoreInfo 
					AND bt.CustomerTransactionTypeID IN (1355,1356)
				WHERE   BatchTransactionheaderID = 124964


SELECT CAST(LocalizedCreateDate AS DATE) AS LDate, CASE CustomerTransactionTypeID WHEN 1355 THEN 'FFA Sale' WHEN 1356 THEN 'Non-FFA Sale' END AS CustomerTransactionType,COUNT(1) 
FROM  dbo.TrackedAction
WHERE ClientID = 754
	AND RecordStatus = 'A'
    AND LocalizedCreateDate >= '09/01/2012'
    AND LocalizedCreateDate < '10/01/2012'  
    AND CustomerTransactionTypeID IN (1355,1356)    
    AND TrackingSourceID = 1                     
GROUP BY CAST(LocalizedCreateDate AS DATE), CustomerTransactionTypeID  
ORDER BY CustomerTransactionTypeID , CAST(LocalizedCreateDate AS DATE)
				
				
SELECT CAST(LocalizedCreateDate AS DATE) AS LDate, CASE CustomerTransactionTypeID WHEN 1355 THEN 'FFA Sale' WHEN 1356 THEN 'Non-FFA Sale' END AS CustomerTransactionType,COUNT(1) 
FROM  dbo.TrackedAction ta
WHERE ClientID = 754
	AND RecordStatus = 'A'
    AND LocalizedCreateDate >= '09/01/2012'
    AND LocalizedCreateDate < '10/01/2012'  
    AND CustomerTransactionTypeID IN (1355,1356)     
    AND EXISTS(SELECT 1 FROM BatchTransaction WHERE MoreInfo = ta.MoreInfo)               
GROUP BY CAST(LocalizedCreateDate AS DATE), CustomerTransactionTypeID  
ORDER BY CustomerTransactionTypeID , CAST(LocalizedCreateDate AS DATE)
