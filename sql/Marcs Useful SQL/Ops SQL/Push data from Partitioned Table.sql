--Move data from partitioned table

/*
Improvement use a swap table instead of delete
*/

SET NOCOUNT ON

DECLARE @T1 sysname = 'RPT_PS_Summary_SearchQuery',
	@T2 sysname = 'RPT_PS_Summary_SearchQuery_New',
	@PFunction sysname,
	@PColumn sysname,
	@dsql NVARCHAR(MAX) ,
	@PNum INT,
	@include_identity BIT = 0,
	@columnlist VARCHAR(MAX)


IF OBJECT_ID('tempdb..#P1') IS NOT NULL
DROP TABLE #P1

CREATE TABLE #P1(
	PNUM INT,
	T1_COUNT INT,
	T2_COUNT INT,
	ProcessFlag BIT
)


SELECT DISTINCT @PFunction = pf.name
from sys.indexes i
inner join sys.data_spaces ds on i.data_space_id = ds.data_space_id
inner JOIN sys.partition_schemes ps on ds.data_space_id = ps.data_space_id
inner join sys.partition_functions pf on ps.function_id = pf.function_id
WHERE OBJECT_NAME(i.object_id) = @T1

SELECT @columnlist = COALESCE(@columnlist+',','') +name 
FROM sys.columns c
WHERE OBJECT_NAME(c.object_id) = @T1
AND (is_identity = 0
	OR is_identity = @include_identity
	)
	
SELECT DISTINCT @PColumn = c.name
FROM sys.partitions p
INNER JOIN sys.indexes i ON p.[object_id] = i.[object_id]
	and p.index_id = i.index_id
INNER JOIN sys.index_columns ic ON ic.index_id = i.index_id
	AND i.object_id = ic.object_id
	AND partition_ordinal > 0
INNER JOIN sys.columns c ON c.object_id = ic.object_id 
	and c.column_id = ic.column_id
 WHERE OBJECT_NAME(p.object_id) = @T1	

INSERT INTO #P1(PNUM ,T1_COUNT ,ProcessFlag)
SELECT  p.partition_number,MAX(rows),0
	FROM sys.partitions p 
	WHERE OBJECT_NAME(p.object_id) = @T1
	GROUP BY p.partition_number
	HAVING MAX(rows) > 0
	ORDER BY p.partition_number

;WITH t2 AS(
SELECT  p.partition_number,MAX(rows) NRows
	FROM sys.partitions p 
	WHERE OBJECT_NAME(p.object_id) = @T2
	GROUP BY p.partition_number
	HAVING MAX(rows) > 0
)
UPDATE p
SET T2_COUNT = ISNULL(t.NRows,0)
FROM #P1 p
LEFT JOIN t2 t ON p.PNUM = t.partition_number

UPDATE #P1
SET ProcessFlag = 1
WHERE T1_COUNT = T2_COUNT

SELECT * FROM #P1

WHILE EXISTS(SELECT TOP 1 1 FROM #P1 WHERE ProcessFlag = 0)
BEGIN

	SELECT TOP 1 @PNUM = PNUM, @dsql = ''
	FROM #P1 
	WHERE ProcessFlag = 0
	
	
	IF @include_identity = 1
	SET @dsql += '
	SET IDENTITY_INSERT '+CAST(@T2 AS VARCHAR(MAX))+' ON'
	
	SET @dsql += '
	DELETE '+CAST(@T2 AS VARCHAR(MAX))+'
	WHERE $PARTITION.'+CAST(@PFunction AS VARCHAR(200))+'('+CAST(@PColumn AS VARCHAR(200))+') = '+CAST(@PNum AS VARCHAR(200))+'
	
	INSERT INTO '+CAST(@T2 AS VARCHAR(MAX))+'('+@Columnlist+')
	SELECT '+@Columnlist+' 
	FROM '+CAST( @T1 AS VARCHAR(MAX))+ ' 
	WHERE $PARTITION.'+CAST(@PFunction AS VARCHAR(200))+'('+CAST(@PColumn AS VARCHAR(200))+') = '+CAST(@PNum AS VARCHAR(200))
	
	
	IF @include_identity = 1
	SET @dsql += '
	SET IDENTITY_INSERT '+CAST(@T2 AS VARCHAR(MAX))+' OFF'
	
	RAISERROR('%s',0,1,@dsql)WITH NOWAIT
	
	EXECUTE sp_executesql @dsql

	UPDATE #P1
	SET ProcessFlag = 1
	WHERE PNUM = @PNum

END




