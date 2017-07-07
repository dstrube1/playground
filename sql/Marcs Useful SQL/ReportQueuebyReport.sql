
SELECT u.UserName,rq.CreatedDate,rq.ClientID, CASE WHEN CHARINDEX('@ignitionone.com',u.UserName) > 0 OR CHARINDEX('@searchIgnite.com',u.UserName) > 0 THEN 1 ELSE 0 END AS InteralUser
FROM dbo.ReportQueue rq
JOIN dbo.Users u ON rq.UserID = u.UserID
WHERE RPTTypeID = 1948
	AND CreatedDate >= '12/01/2011'
ORDER BY CreatedDate

SELECT DATEPART(mm,CreatedDate),COUNT(DISTINCT rq.UserID) TotalCount
FROM dbo.ReportQueue rq
JOIN dbo.Users u ON rq.UserID = u.UserID
WHERE RPTTypeID = 1948
	AND CreatedDate >= '12/01/2011'
	AND (CHARINDEX('@ignitionone.com',u.UserName) = 0 
		OR CHARINDEX('@searchIgnite.com',u.UserName) = 0)
GROUP BY DATEPART(mm,CreatedDate)



SELECT * FROM dbo.ReportType
WHERE RPTTypeName LIKE '%Geo%'
