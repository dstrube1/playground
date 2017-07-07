


USE SIProcessing

EXEC dbo.SI_SP_RPT_Social_Processing_Start


SELECT * FROM dbo.QueueSocialFileTracking

INSERT INTO dbo.QueueSocialFileTracking
        ( ClientID ,
          SEID ,
          LastLocalizedReportDate ,
          LastUpdate
        )
SELECT DISTINCT ClientID, SEID,LastLocalizedReportDate, GETDATE() 
FROM dbo.QueueSocialFileTracking_History
WHERE LastLocalizedReportDate >= '08/01/2012'


SELECT * FROM dbo.RPT_Social_GenerateList
