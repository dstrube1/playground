		UPDATE dbo.UMTracking_History 
		SET ReportProcessedDate = null, 
		NumProcessed = 0 
		WHERE ClientID = 5067
		AND ReportDate >= '11/01/2011'
		AND ReportDate < '11/10/2011'
		
		SELECT* FROM UMTracking_History 
		WHERE ReportProcessedDate IS NULL

update DFAFileTracking
set LastProcessedDate = null,
	DFAProcessStatusID = 0
where ClientID in (5067)
and DFAReportDate in ('11/03/2011','11/04/2011','11/05/2011','11/06/2011','11/07/2011','11/08/2011','11/09/2011','11/10/2011')
go

SELECT * FROM DFAFileTracking
where ClientID in (5067)
and DFAReportDate in ('11/03/2011','11/04/2011','11/05/2011','11/06/2011','11/07/2011','11/08/2011','11/09/2011','11/10/2011')
	
	
select DFAProcessStatusID,COUNT(1) 
from DFAFileTracking 
GROUP BY DFAProcessStatusID 
	
SELECT *
FROM dbo.DFAFileQueue
WHERE DFAFileQueueStatusID <> 7

sp_who4

sp_who5
