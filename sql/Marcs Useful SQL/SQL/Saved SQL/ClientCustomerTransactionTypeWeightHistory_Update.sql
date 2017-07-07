

DECLARE @CTTID INT,
	@ClientID INT = 3289,
	@StartDate DATETIME = '8/1/2010',
	@EndDate DATETIME = '8/15/2010',
	@Weight DECIMAL(13,2) = .25


DECLARE db_cursor CURSOR FOR  
SELECT DISTINCT CustomerTransactionTypeID
FROM  SearchIgnite..ClientCustomerTransactionTypeWeightHistory 
WHERE ClientID = @ClientID 

OPEN db_cursor   
FETCH NEXT FROM db_cursor INTO @CTTID   

WHILE @@FETCH_STATUS = 0   
BEGIN   

BEGIN TRAN
UPDATe SearchIgnite..ClientCustomerTransactionTypeWeightHistory 
SET EndDate = DATEADD(dd,-1,@StartDate) 
WHERE EndDate > @StartDate AND ClientID = @ClientID AND CustomerTransactionTypeID = @CTTID

BEGIN TRAN
INSERT INTO SearchIgnite..ClientCustomerTransactionTypeWeightHistory 
VALUES(@CLientID,@StartDate,@EndDate, @CTTID ,@weight)

BEGIN TRAN
INSERT INTO SearchIgnite..ClientCustomerTransactionTypeWeightHistory 
VALUES(@CLientID,DATEADD(dd,1,@EndDATE),'2075-12-31', @CTTID ,1.00)



     FETCH NEXT FROM db_cursor INTO @CTTID   
END   

CLOSE db_cursor   
DEALLOCATE db_cursor

 SELECT * FROM SearchIgnite..ClientCustomerTransactionTypeWeightHistory WHERE ClientID = @ClientID
 ORDER BY CUstomerTransactionTypeID, StartDate
 
 /*
WHILE @@TRANCOUNT > 0
	COMMIT
*/	


