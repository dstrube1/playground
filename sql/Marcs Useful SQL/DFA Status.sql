SELECT* 
FROM dbo.DFAFileQueue
WHERE DFAFileQueueStatusID <> 7

--Check Deletes
SELECT CAST(CreateDateUTC AS DATE), COUNT(1) 
FROM DFAExposureDelete_Stage
WHERE TEMDelete = 0
GROUP BY CAST(CreateDateUTC AS DATE)
ORDER BY 1

SELECT ClientID, COUNT(1) 
FROM DFAExposureDelete_Stage
WHERE TEDelete = 0
GROUP BY ClientID
ORDER BY 1

SELECT * 
FROM DFAExposureDelete_Stage
--End Check Deletes

SELECT IsProcessed,COUNT(1) 
FROM dbo.TrackedExposure_ReadStageData
GROUP BY IsProcessed

sp_who4
sp_who5

