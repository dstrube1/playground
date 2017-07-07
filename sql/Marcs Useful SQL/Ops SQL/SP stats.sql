
DECLARE @tmp TABLE(
	SP VARCHAR(1000),
	OBJECT_TYPE VARCHAR(1000)
)

INSERT INTO @tmp
EXEC sp_depends @objname = N'dbo.CampaignKeyword'

INSERT INTO @tmp( SP, OBJECT_TYPE )
VALUES  ( 'dbo.SI_SP_BulkKeyword_KeywordDataInsert', 'Missed by SP_depends' )

SELECT * FROM @tmp

SELECT  b.name, 
        a.last_execution_time
FROM    sys.dm_exec_procedure_stats a 
INNER JOIN sys.objects b  on  a.object_id = b.object_id 
JOIN @tmp t ON REPLACE(t.SP,'dbo.','') = b.name
ORDER BY 1 DESC


