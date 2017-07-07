SELECT *
FROM dbo.FileRetention
WHERE Statusflag = 1


UPDATE dbo.FileRetention
SET FileExtension = 'csv'
WHERE FileRetentionID = 37
-6733

INSERT INTO dbo.FileRetention(FilePath,FileExtension,RetentionDays, Recursive )
SELECT '\\373895-BIDB05\datafiles$\rpt-stage-data-files','change',10,0