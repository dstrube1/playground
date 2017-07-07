
SELECT * 
FROM dbo.DFAFileTracking dft
WHERE EXISTS (SELECT 1 FROM dbo.DFAFileTracking dft2 WHERE dft.ClientID = dft2.ClientID AND dft.DFAReportDate = dft2.DFAReportDate AND dft2.DFAProcessStatusID = 0)
 
 /*
BEGIN TRAN
	UPDATE dft
	SET RecordCount = CASE WHEN RecordCount = 0 THEN 1 ELSE RecordCount END,
		DFAProcessStatusID = 0
	FROM dbo.DFAFileTracking dft
	WHERE EXISTS (SELECT 1 FROM dbo.DFAFileTracking dft2 WHERE dft.ClientID = dft2.ClientID AND dft.DFAReportDate = dft2.DFAReportDate AND dft2.DFAProcessStatusID = 0)
COMMIT
*/
