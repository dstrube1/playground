SELECT * FROM CSKeywords where CSKID in (155297718,
155297768) AND ClientID = 3999

SELECT AdCategoryName FROM dbo.CampaignAdCategory where AdCategoryID = 4831340
SELECT CampaignTitle FROM Campaign where CampaignID = 151323 and ClientID = 3999

SELECT * FROM SearchEngine where SEID = 60

SELECT * FROM BidHistory where CSKID = 122967580

SELECT * FROM BidRule WHERE BidRuleID = 2292113
SELECT * FROM BidRulePerformance WHERE BidRuleID = 2292113

SELECT PerformanceValue FROM dbo.BidRulePerformance 
WITH (NOLOCK) WHERE BidRuleID = 2292113 AND BRPerformanceTypeID = 3 and br.BidRuleTypeID = 3

SELECT * FROm  dbo.BulkSheetQueue where EmailAddress like '%msmith%'


SELECT * FROM CSKeywords where CSKID in (155297718, 155297768) AND ClientID = 3999 


exec dbo.SI_SP_ClientCustomerTransactionTypeWeight_read
@CustomerTransactionTypeID= 3016, @ClientID = 146

exec dbo.SI_SP_ClientCustomerTransactionType_readByClientID @ClientID = 146


SELECT c.ClientID,se.SearchEngine, c.CampaignTitle,cbr.ContentBid,cse.EnableContentMatch, cse.EnableSearchMatch, 
fROM CampaignSearchEngine cse
join Campaign c on cse.CampaignID = c.CampaignID
join CampaignBidRule cbr on cse.CampaignID = cbr.CampaignID
join SearchEngine se on se.SEID = cse.SEID 
WHERE cse.EnableContentMatch = 1 and cbr.ContentBid < .0001 AND cse.StatusFlag = 1 AND c.StatusFlag =1







