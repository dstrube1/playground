
SELECT * FROM dbo.PageViewQueue

      SELECT 
      distinct
            Partition_number
            ,ROWS
            ,value
      FROM sys.partitions p JOIN sys.indexes i
              ON p.object_id = i.object_id and p.index_id = i.index_id
               JOIN sys.partition_schemes ps
                              ON ps.data_space_id = i.data_space_id
               JOIN sys.partition_functions f
                                 ON f.function_id = ps.function_id
               LEFT JOIN sys.partition_range_values rv
      ON f.function_id = rv.function_id AND p.partition_number = rv.boundary_id
      WHERE OBJECT_NAME(i.object_id) = 'PageViewHistory'
      AND ROWS > 0
      order by value

      SELECT 
      distinct
            Partition_number
            ,ROWS
            ,value
      FROM sys.partitions p JOIN sys.indexes i
              ON p.object_id = i.object_id and p.index_id = i.index_id
               JOIN sys.partition_schemes ps
                              ON ps.data_space_id = i.data_space_id
               JOIN sys.partition_functions f
                                 ON f.function_id = ps.function_id
               LEFT JOIN sys.partition_range_values rv
      ON f.function_id = rv.function_id AND p.partition_number = rv.boundary_id
      WHERE OBJECT_NAME(i.object_id) = 'PageViewHistory'
      AND ROWS > 0
      order by value
      
      SELECT CAST(CreateDateUTC AS DATE) AS UTCDate, COUNT(1) AS RecordCount
      FROM dbo.PageViewHistory
      WHERE CreateDateUTC >= '11/01/2012'
      GROUP BY CAST(CreateDateUTC AS DATE)
      ORDER BY CAST(CreateDateUTC AS DATE)
      
      
      SELECT CAST(CreatedDate AS DATE) AS UTCDate, COUNT(1) AS RecordCount
      FROM SIProcessing_CacheHistory..TrackedCache
      WHERE TrackedExposureID < 0
      AND EasternCreateDate >= '11/01/2012'
      GROUP BY  CAST(CreatedDate AS DATE)
      ORDER BY  CAST(CreatedDate AS DATE)
      
      
      SELECT * FROM PageViewPartitionAdmin 
      WHERE PartitionID = 5
      
      
      SELECT * FROM dbo.LUPageViewPartitionStatus
      
      
      SELECT * FROM dbo.LUPageViewQueueStatus
      
UPDATE pvq
SET PageViewQueueStatusID = 6
FROM dbo.PageViewQueue pvq
WHERE PageViewQueueID =1032


SELECT pvr.*
FROM PageViewHistory pvr				
where $PARTITION.PF_PageView(PartitionID) = 5


SELECT 
				TrackedExposureID AS TrackedActionID
				,TrackedExposureID AS TrackedExposureID
				,ActionQuantity
				,pvr.cskid
				,ToClientID
				,FromClientID
				,pvr.ToCurrencyID
				,pvr.FromCurrencyID
				,1 AS ChannelID  --Paid Search
				,1 AS ExposureTypeID -- Click
				,(SELECT TOP 1 AffiliateID FROM SIProcessing.dbo.AffiliateGroupClients agc WHERE agc.clientID = pvr.FromClientID) AS AffiliateID
				, CustomerTransactionTypeID
				,TransactionAmount * ISNULL(ExchangeRate, 1) AS TransactionAmount
				,TransactionAmount
				,CreateDateUTC
				,ToLocalizedCreateDate
				,csk.SEID
				,csk.CampaignID
				,csk.AdCategoryID
				,CreativeID
				,KeywordID
				,CKeywordID
				,Keyword
				,0
				,MoreInfo,ISContentMatch,n1,n2,n3,n4,n5,n6,n7,n8,n9,n10,x1,x2,x3,x4,x5,x6,x7,x8,x9,x10 
			FROM PageViewHistory pvr				
JOIN SIProcessing..CSKeywords csk ON pvr.cskid = csk.cskid
				LEFT JOIN SIProcessing.dbo.CurrencyExchangeDataHistory ce ON pvr.FromCurrencyID <> pvr.ToCurrencyID
					AND ce.FromCurrencyID = pvr.FromCurrencyID
					AND ce.ToCurrencyID = pvr.ToCurrencyID
					AND  DATEDIFF(d,ce.CreateDate, CreateDateUTC) = 0
where $PARTITION.PF_PageView(PartitionID) = 5


SELECT * FROM dbo.PageViewWrite

/*

      ALTER TABLE PageViewHistory switch Partition(5) to PageViewWrite partition(5)

UPDATE pvq
SET PageViewQueueStatusID = 6
FROM dbo.PageViewQueue pvq
WHERE PageViewQueueID =1032


      UPDATE pvpa
      SET PageViewPartitionStatusID = 3
      FROM PageViewPartitionAdmin pvpa
      WHERE PartitionID = 5
    
    
    EXEC SIProcessing_CacheHistory..SI_SP_TransactionLoadPageView
    
    
    */  