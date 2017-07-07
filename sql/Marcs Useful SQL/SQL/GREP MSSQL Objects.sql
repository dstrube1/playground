DECLARE
	@SearchStr NVARCHAR(100) = 'bTransactionAssumptionsHistory'
,	@RowsReturned INT = NULL
;

SELECT DISTINCT
	USER_NAME(o.uid) + '.' + OBJECT_NAME(c.id) AS ObjectName
,	CASE
        WHEN OBJECTPROPERTY(c.id, 'IsReplProc') = 1 THEN 'Replication stored procedure'
		WHEN OBJECTPROPERTY(c.id, 'IsExtendedProc') = 1 THEN 'Extended stored procedure'               
		WHEN OBJECTPROPERTY(c.id, 'IsProcedure') = 1 THEN 'Stored Procedure'
		WHEN OBJECTPROPERTY(c.id, 'IsTrigger') = 1 THEN 'Trigger'
		WHEN OBJECTPROPERTY(c.id, 'IsTableFunction') = 1 THEN 'Table-valued function'
		WHEN OBJECTPROPERTY(c.id, 'IsScalarFunction') = 1 THEN 'Scalar-valued function'
		WHEN OBJECTPROPERTY(c.id, 'IsInlineFunction') = 1 THEN 'Inline function'   
	END AS ObjectType
,	'EXEC sp_helptext ''' + USER_NAME(o.uid) + '.' + OBJECT_NAME(c.id) + ''''  AS RunThis
FROM
	dbo.syscomments AS c
    INNER JOIN dbo.sysobjects o ON c.id = o.id
WHERE
	c.text LIKE '%' + @SearchStr + '%'
	AND encrypted = 0
	AND
    (
		OBJECTPROPERTY(c.id, 'IsReplProc') = 1
		OR OBJECTPROPERTY(c.id, 'IsExtendedProc') = 1
		OR OBJECTPROPERTY(c.id, 'IsProcedure') = 1
		OR OBJECTPROPERTY(c.id, 'IsTrigger') = 1
		OR OBJECTPROPERTY(c.id, 'IsTableFunction') = 1
		OR OBJECTPROPERTY(c.id, 'IsScalarFunction') = 1
		OR OBJECTPROPERTY(c.id, 'IsInlineFunction') = 1   
    )
ORDER BY
	ObjectType
,	ObjectName
;

SET @RowsReturned = @@ROWCOUNT