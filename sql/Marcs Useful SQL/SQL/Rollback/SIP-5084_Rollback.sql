--SIP-5084 ROLLBACK
--10.50.0.162
USE [Searchignite]

BEGIN TRAN 
UPDATE LUKeyWordStatus SET KeyWordStatusDesc = 'InActive' WHERE KeyWordStatusID = 3 
COMMIT TRAN 
