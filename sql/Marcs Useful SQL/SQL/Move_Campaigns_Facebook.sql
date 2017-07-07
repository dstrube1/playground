/* COPY Campaign Over to Facebook 

SELECT * FROM JUNKDB..Facebook_Campaigns_TEMP

CREATE TABLE JUNKDB..Facebook_Campaigns_TEMP( 
NEW_Campaign INT, 
OLD_Campaign INT 
) 

CREATE TABLE JUNKDB..Facebook_AD_TEMP( 
NEW_AD INT, 
OLD_AD INT 
) 

CREATE TABLE JUNKDB..Facebook_CSK_TEMP( 
NEW_CSK INT, 
OLD_CSK INT 
) 
*/ 

USE [SIOLAP] 
GO 

DECLARE @CampaignID INT =68399, -- 1 Group & 1000 Keywords C 
@ClientID INT = 3386, 
@NEW_CampaignID INT, 
@NEW_CSID INT, 
@debug BIT = 0, 
@rollback BIT = 0 

IF OBJECT_ID('tempdb..#Campaign') IS NOT NULL 
DROP TABLE #Campaign ; 
IF OBJECT_ID('tempdb..#CampaignAdCategory') IS NOT NULL 
DROP TABLE #CampaignAdCategory ; 
IF OBJECT_ID('tempdb..#CSKeywords') IS NOT NULL 
DROP TABLE #CSKeywords ; 
IF OBJECT_ID('tempdb..#CampaignSearchEngine') IS NOT NULL 
DROP TABLE #CampaignSearchEngine ; 
IF OBJECT_ID('tempdb..#CampaignSETitleIDAdIDMapping ') IS NOT NULL 
DROP TABLE #CampaignSETitleIDAdIDMapping  ; 
IF OBJECT_ID('tempdb..#CampaignAdTitleMapping ') IS NOT NULL 
DROP TABLE #CampaignAdTitleMapping  ; 

SELECT * 
INTO #CampaignSearchEngine 
FROm SearchIgnite..CampaignSearchEngine 
WHERE CampaignID =@CampaignID 
-- AND StatusFlag =1	

SELECT * 
INTO #Campaign 
FROm SearchIgnite..Campaign 
WHERE CampaignID = @CampaignID 
AND ClientID = @ClientID 
-- AND StatusFlag =1 

SELECT * 
INTO #CampaignAdCategory 
FROm SearchIgnite..CampaignAdCategory 
WHERE CampaignID = @CampaignID 
AND ClientID = @ClientID 
--AND StatusFlag =1 

SELECT * 
INTO #CSKeywords 
FROm SearchIgnite..CSKeywords 
WHERE CampaignID = @CampaignID 
AND ClientID = @ClientID 
AND StatusFlag =1 

SELECT * 
INTO #CampaignSETitleIDAdIDMapping 
FROm SearchIgnite..CampaignSETitleIDAdIDMapping 
WHERE CampaignID =@CampaignID

SELECT * 
INTO #CampaignAdTitleMapping 
FROm SearchIgnite..CampaignAdTitleMapping 
WHERE CampaignID =@CampaignID


BEGIN TRAN 
INSERT INTO SearchIgnite..Campaign 
SELECT @CLientID AS ClientID, 
CampaignTitle, 
'12/31/2099' AS StartDate, 
CampaignDesc, 
EndDate, 
TotalBudget, 
1 AS StatusFlag, 
GETDATE() AS UpdateDate, 
CampaignStatusID, 
SSRedirect, 
Optimization, 
CurrencyID, 
KeepKeywordActive, 
AdRotation, 
DeliveryMethod, 
BidTypeID, 
SearchNetworkID, 
DisplayNetworkID 
FROM #Campaign 

SELECT @NEW_CampaignID = SCOPE_IDENTITY() 

BEGIN TRAN 
INSERT INTO SEARCHIGNITE..CampaignSETitleIDAdIDMapping
SELECT 84 AS SEID,
	@NEW_CampaignID AS  CampaignID,
	AdID,
	SETitleID
FROM #CampaignSETitleIDAdIDMapping 

BEGIN TRAN
INSERT INTO SEARCHIGNITE..CampaignAdTitleMapping
SELECT 84 AS SEID, 
	SETitleID, 
	AdTitleMappingID, 
	@NEW_CampaignID AS CampaignID, 
	Title, 
	Description1, 
	Description2, 
	DisplayUrl, 
	DefaultUrl, 
	TitleAsKeyword, 
	ExternalID, 
	IsDefault, 
	IsUpdatedDone, 
	AdTypeID, 
	AdStatusID, 
	1 AS StatusFlag, 
	QualityScore, 
	ContentQualityScore, 
	AdTitleOnOffStatusID, 
	ActivationDatetime, 
	PauseDateTime, 
	GETDATE() AS UpdateDate, 
	OptimizeLandingPage, 
	OptimizeByConversion, 
	CreateDate, 
	ImageID 
FROm #CampaignAdTitleMapping 

BEGIN TRAN 
INSERT SearchIgnite..CampaignSearchEngine 
SELECT 84 AS SEID, 
@NEW_CampaignID AS CampaignID, 
StartDate, 
'' AS EndDate, 
BudgetPCT, 
1 AS StatusFlag, 
GETDATE() AS UpdateDate, 
DailyBudget 
FROM #CampaignSearchEngine 

SELECT @NEW_CSID = SCOPE_IDENTITY() 



DECLARE @ADMapping TABLe ( 
NEW_ADID INT, 
OLD_ADID INT 
) 

BEGIN TRAN 
INSERT INTO SearchIgnite..CampaignAdCategory 
OUTPUT inserted.AdCategoryID, 0 INTO @ADMapping 
SELECT @NEW_CampaignID AS CampaignID, 
ad.AdTitleMappingID, 
ad.AdCategoryName, 
ad.AdCategoryDesc, 
1 AS StatusFlag, 
ad.AdCategoryStatusID, 
GETDATE() AS UpdateDate, 
ad.ExcludeKeywords, 
ClientID, 
ad.RetainPaused, 
ad.OptimizeLandingPage, 
ad.OptimizeByConversion, 
ad.KeepKeywordActive, 
ad.BidTypeID, 
ad.SearchNetworkID, 
ad.DisplayNetworkID, 
ad.AdCategorySearchEngineDetailStatusID 
FROM #CampaignAdCategory ad 

UPDATE @adMapping 
SET OLD_ADID = AD.OLD 
FROM( 
SELECT old.AdCategoryID AS OLD, new.AdCategoryID AS NEW FROm Searchignite..CampaignAdCategory new 
join #CampaignAdCategory old on old.AdTitleMappingID = new.AdTitleMappingID 
AND old.AdCategoryName = new.AdCategoryName 
AND old.AdCategoryDesc= new.AdCategoryDesc 
AND old.AdCategoryStatusID = new.AdCategoryStatusID 
AND ISNULL(old.ExcludeKeywords,0) = ISNULL(new.ExcludeKeywords,0) 
ANd old.ClientID = new.ClientID 
AND old.RetainPaused = new.RetainPaused 
AND old.OptimizeLandingPage = new.OptimizeLandingPage 
AND old.OptimizeByConversion = new.OptimizeByConversion 
AND ISNULL(old.KeepKeywordActive,0) = ISNULL(new.KeepKeywordActive,0) 
AND old.BidTypeID= new.BidTypeID 
AND old.SearchNetworkID = new.SearchNetworkID 
AND old.DisplayNetworkID = new.DisplayNetworkID 
AND ISNULL(old.AdCategorySearchEngineDetailStatusID,0) = ISNULL(new.AdCategorySearchEngineDetailStatusID,0) 
WHERE new.AdCategoryID IN (SELECT NEW_ADID FROm @adMapping) 
) AD 
WHERE AD.NEW = NEW_ADID 

DECLARE @CskMapping TABLe ( 
NEW_CSK INT, 
OLD_CSK INT 
) 

--SET IDENTITY_INsert Searchignite..CSKeywords OFF 
BEGIN TRAN 
INSERT INTO Searchignite..CSKeywords 
OUTPUT inserted.CSKID AS NEW_CSK, 0 INTO @CSKMapping 
SELECT 84 AS SEID, 
URL, 
CreateDate, 
CSKeywordstatusID, 
CKeywordID, 
MainBidAmount, 
GETDATE() AS UpdateDate, 
BidRuleID, 
KeywordSearchEngineDetailStatusID, 
KeywordMatchTypeID, 
1 AS StatusFlag, 
ClientID, 
@NEW_CampaignID AS CampaignID, 
IsRedirect, 
RedirectURL, 
ad.NEW_ADID AS AdCategoryID, 
MinBid, 
ContentBid, 
BulkNotes, 
KeywordID, 
Keyword, 
AdTitleMappingID, 
PausedByUser 
FROM #CSKeywords csk 
join @ADMapping ad ON csk.AdCategoryID = ad.OLD_ADID 

UPDATE @cskMapping 
SET OLD_CSK = P.OLD 
FROM ( 
SELECT new.cskid AS NEW,old.cskID AS OLD FROm Searchignite..CSKeywords new 
join #CSKeywords old on old.URL = NEW.URL 
AND old.CreateDate = new.CreateDate 
AND old.CSKeywordstatusID = new.CSKeywordstatusID 
AND old.CKeywordID = new.CKeywordID 
AND old.MainBidAmount = new.MainBidAmount 
AND ISNULL(old.BidRuleID,0) = ISNULL(new.BidRuleID,0) 
AND old.KeywordSearchEngineDetailStatusID =new.KeywordSearchEngineDetailStatusID 
AND old.KeywordMatchTypeID =new.KeywordMatchTypeID 
AND old.ClientID =new.ClientID 
AND old.IsRedirect =new.IsRedirect 
AND old.RedirectURL =new.RedirectURL 
AND old.MinBid = new.MinBid 
AND old.ContentBid = new.ContentBid 
AND ISNULL(old.BulkNotes,'') =ISNULL(new.BulkNotes, '') 
AND old.KeywordID = new.KeywordID 
AND old.Keyword =new.Keyword 
AND old.AdTitleMappingID = new.AdTitleMappingID 
AND ISNULL(old.PausedByUser,0) = ISNULL(new.PausedByUser,0) 
WHERE new.CSKID IN (SELECT NEW_CSK FROm @cskMapping) AND new.SEID = 84 ANd NEW.CampaignID = @NEW_CampaignID 
) P 
WHERE P.NEW = NEW_CSK 


BEGIN TRAN 
INSERT INTO RPT_PS_Summary_CampaignLevel 
SELECT ClientID, 
GenerateDate, 
84 AS SEID, 
IsContentMatch, 
@NEW_CampaignID AS CampaignID, 
NumImpressions, 
Cost, 
NumClicksReported, 
NumClicksTracked, 
transactionCount, 
TransactionAmount, 
TotalRank, 
TotalRankCount, 
TTCount 
FROM RPT_PS_Summary_CampaignLevel 
WHERE CampaignID = @CampaignID AND ClientID = @ClientID 




BEGIN TRAN 
INSERT INTO dbo.RPT_PS_Summary_GroupLevel 
SELECT @ClientID AS ClientID, 
GenerateDate, 
84 AS SEID, 
IsContentMatch, 
ad.NEW_ADID AS AdCategoryID, 
@NEW_CampaignID AS CampaignID, 
NumImpressions, 
Cost, 
NumClicksReported, 
NumClicksTracked, 
NumClicksAssisted, 
TransactionCount, 
TransactionAmount, 
TransactionCountWithWeight, 
TotalRank, 
TotalRankCount, 
TTCount 
FROM dbo.RPT_PS_Summary_GroupLevel gl 
JOIN @adMapping ad ON ad.OLD_ADID = gl.AdCategoryID 
WHERE CampaignID = @CampaignID AND ClientID = @ClientID 

BEGIN TRAN 
INSERT INTO dbo.RPT_PS_CreativeSummary_GroupLevel 
SELECT @ClientID AS ClientID, 
GenerateDate, 
84 AS SEID, 
IsContentMatch, 
ADID, 
ad.NEW_ADID AS AdCategoryID, 
SETitleID, 
NumImpressions, 
NumClicksReported, 
Cost, 
TransactionAmount, 
TransactionCount, 
TransactionCountWithWeight, 
TotalRank, 
TotalRankCount, 
NumClicksTracked, 
TTCount 
FROM dbo.RPT_PS_CreativeSummary_GroupLevel gl 
JOIN @adMapping ad ON ad.OLD_ADID = gl.AdCategoryID 
WHERE ClientID = @ClientID 

BEGIN TRAN 
INSERT INTO dbo.RPT_PS_Summary_CSKLevel 
SELECT @ClientID AS ClientID, 
GenerateDate, 
84 AS SEID, 
IsContentMatch, 
old.NEW_CSK AS CSKID, 
NumImpressions, 
Cost, 
NumClicksReported, 
NumClicksTracked, 
NumClicksAssisted, 
TransactionCount, 
TransactionAmount, 
TransactionCountWithWeight, 
TotalRank, 
TotalRankCount, 
TTCount 
FROM dbo.RPT_PS_Summary_CSKLevel csk 
JOIN @cskMapping old ON old.OLD_CSK = csk.CSKID 
WHERE ClientID = @ClientID 

BEGIN TRAN 
INSERT INTO JUNKDB..Facebook_Campaigns_TEMP 
SELECT @NEW_CampaignID, @CampaignID 

BEGIN TRAN 
INSERT INTO JUNKDB..Facebook_AD_TEMP 
SELECT NEW_ADID,OLD_ADID FROM @ADMapping 

BEGIN TRAN 
INSERT INTO JUNKDB..Facebook_CSK_TEMP 
SELECT NEW_CSK, OLD_CSK FROM @CskMapping 


IF @debug = 1 
BEGIN 
SELECT * FROm @adMapping 
SELECT * FROm @cskMapping 
SELECT * FROM SearchIgnite..Campaign WHERE CampaignID = @NEW_CampaignID 
SELECT * FROm SearchIgnite..CampaignSETitleIDAdIDMapping WHERE CampaignID = @NEW_CampaignID 
SELECT * FROM SearchIgnite..CampaignAdTitleMapping WHERE CampaignID = @NEW_CampaignID 
SELECT * FROM SearchIgnite..CampaignSearchEngine WHERE CSID = @NEW_CSID 
SELECT * FROM SearchIgnite..CampaignAdCategory WHERE CampaignID = @NEW_CampaignID AND ClientID = @ClientID 
SELECT * FROm SEarchIgnite..CSKeywords WHERE CampaignID = @NEW_CampaignID AND ClientID = @ClientID 

SELECT * FROM RPT_PS_Summary_CampaignLevel WHERE CampaignID = @NEW_CampaignID AND ClientID = @ClientID 
SELECT * FROm RPT_PS_Summary_GroupLevel WHERE AdCategoryID IN (SELECT NEW_ADID FROm @ADMapping) AND ClientID = @ClientID 
SELECT * FROm RPT_PS_CreativeSummary_GroupLevel WHERE AdCategoryID IN (SELECT NEW_ADID FROm @ADMapping) AND ClientID = @ClientID 
SELECT * FROm RPT_PS_Summary_CSKLevel WHERE ClientID = @ClientID AND CSKID IN (SELECT NEW_CSK FROM @CskMapping) 
END 

IF @rollback = 1 
BEGIN 
WHILE @@TRANCOUNT > 0 
ROLLBACK 
END 
ELSE 
BEGIN 
WHILE @@TRANCOUNT > 0 
COMMIT 
END 


IF @debug = 1 
BEGIN 
SELECT * FROM SearchIgnite..Campaign WHERE CampaignID = @NEW_CampaignID 
SELECT * FROm SearchIgnite..CampaignSETitleIDAdIDMapping WHERE CampaignID = @NEW_CampaignID 
SELECT * FROM SearchIgnite..CampaignAdTitleMapping WHERE CampaignID = @NEW_CampaignID 
SELECT * FROM SearchIgnite..CampaignSearchEngine WHERE CSID = @NEW_CSID 
SELECT * FROM SearchIgnite..CampaignAdCategory WHERE CampaignID = @NEW_CampaignID AND ClientID = @ClientID 
SELECT * FROm SEarchIgnite..CSKeywords WHERE CampaignID = @NEW_CampaignID AND ClientID = @ClientID 

SELECT * FROM RPT_PS_Summary_CampaignLevel WHERE CampaignID = @NEW_CampaignID AND ClientID = @ClientID 
SELECT * FROm RPT_PS_Summary_GroupLevel WHERE AdCategoryID IN (SELECT NEW_ADID FROm @ADMapping) AND ClientID = @ClientID 
SELECT * FROm RPT_PS_CreativeSummary_GroupLevel WHERE AdCategoryID IN (SELECT NEW_ADID FROm @ADMapping) AND ClientID = @ClientID 
SELECT * FROm RPT_PS_Summary_CSKLevel WHERE ClientID = @ClientID AND CSKID IN (SELECT NEW_CSK FROM @CskMapping) 
END