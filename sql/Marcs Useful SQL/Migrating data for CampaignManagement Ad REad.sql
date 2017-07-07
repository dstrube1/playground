
					

			DECLARE @ClientID INT = 3386		
			/*	
					SELECT * FROM CampaignAdCategory WHERE ClientID = @ClientID -- 93534
							SELECT * FROM Campaign  WHERE ClientID = @ClientID -- 94
					SELECT * FROM  ClientSearchEngineMapping  WHERE ClientID = @ClientID--4
					SELECT * FROM  ClientCustomerTransactionTypeWeightHistory  tt  WHERE tt.ClientID = @ClientID --151
				
					
					SELECT * FROM siolap.dbo.RPT_PS_CreativeSUMmary_GroupLevel WHERE ClientID = @ClientID AND GENERATEDATE > '11/01/2011'--799357
					SELECT * FROM SIOLAP.dbo.RPT_PS_SUMmary_CustomerTT_CreativeLevel WHERE ClientID = @ClientID AND GENERATEDATE > '11/01/2011'--1182591
					
					--CampaignID
					SELECT * FROM CampaignSearchEngine cse
					WHERE EXISTS(SELECT 1 FROM dbo.Campaign c WHERE c.CampaignID=cse.CampaignID AND c.ClientID = 3386)--94
					
					SELECT * FROM CampaignAdTitleMapping catm
					WHERE EXISTS(SELECT 1 FROM dbo.Campaign c WHERE c.CampaignID=catm.CampaignID AND c.ClientID = @ClientID)--123510
					
					SELECT  * FROM CampaignSETitleIDAdIDMapping csem
					WHERE EXISTS(SELECT 1 FROM dbo.Campaign c WHERE c.CampaignID=csem.CampaignID AND c.ClientID = @ClientID)--168191
	
					--AdCategpryID
					SELECT * FROM CampaignAdcategoryBidRule br
					WHERE EXISTS(SELECT 1 FROM dbo.CampaignAdCategory cac WHERE cac.AdCategoryID=br.AdcategoryID AND cac.ClientID = @ClientID)--31935
*/
--Deletes
BEGIN TRAN
--DELETE FROM CampaignAdCategory WHERE ClientID = @ClientID -- 93534
----DELETE FROM Campaign  WHERE ClientID = @ClientID -- 94
--DELETE  FROM  ClientSearchEngineMapping  WHERE ClientID = @ClientID--4
--DELETE  FROM  ClientCustomerTransactionTypeWeightHistory WHERE ClientID = @ClientID --15

--DELETE  FROM siolap.dbo.RPT_PS_CreativeSUMmary_GroupLevel WHERE ClientID = @ClientID AND GENERATEDATE > '11/01/2011'--799357
--DELETE  FROM SIOLAP.dbo.RPT_PS_SUMmary_CustomerTT_CreativeLevel WHERE ClientID = @ClientID AND GENERATEDATE > '11/01/2011'--1182591

----CampaignID
--DELETE  cse
--FROM CampaignSearchEngine cse
--WHERE EXISTS(SELECT 1 FROM dbo.Campaign c WHERE c.CampaignID=cse.CampaignID AND c.ClientID = @ClientID)--94

DELETE  catm
FROM CampaignAdTitleMapping catm
WHERE EXISTS(SELECT 1 FROM dbo.Campaign c WHERE c.CampaignID=catm.CampaignID AND c.ClientID = @ClientID)--123510

--DELETE  csem
--FROM CampaignSETitleIDAdIDMapping csem
--WHERE EXISTS(SELECT 1 FROM dbo.Campaign c WHERE c.CampaignID=csem.CampaignID AND c.ClientID = @ClientID)--168191

----AdCategpryID
--DELETE  br
--FROM CampaignAdcategoryBidRule br
--WHERE EXISTS(SELECT 1 FROM dbo.CampaignAdCategory cac WHERE cac.AdCategoryID=br.AdcategoryID AND cac.ClientID = @ClientID)--31935



COMMIT



 EXEC SI_SP_CampaignManagement_Ads_ReadByFilterHierID
   @ClientID = 3386
  ,@StartDate = '11/20/2011'
  ,@ENDDate = '12/20/2011'
  ,@UserID = 5340
  ,@viewID = 8
, @FilterHierID = -1
 ,@FilterHierTypeID = -1
 ,@currencyID = 73
 ,@SortDataGridColumnID = 54
 ,@SortDescending = 1