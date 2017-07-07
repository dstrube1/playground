USE SIOLAP

BEGIN TRAN
UPDATE dbo.ReportTypeFilter
SET IsPartOfFilter = 1
WHERE FilterParamName = 'includecustomertransaction'
 AND  RPTTypeID =501
 
--ROLLBACK
--COMMIT