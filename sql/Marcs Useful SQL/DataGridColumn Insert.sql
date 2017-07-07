
DECLARE @ID INT,
	@DataGridIds VARCHAR(2000) = '15,16,17,18'/*11,27,28,29,30,*/
	
SELECT * FROM dbo.LUDataGrid
WHERE DATAGRIDID IN (SELECT ParseID AS DataGridID FROM dbo.fn_ParseNumList(@DataGridIds))

IF OBJECT_ID('tempdb..#tmp') IS NOT NULL
DROP TABLE #tmp

CREATE TABLE #tmp (
	[HeaderText] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[DataField] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[DataGridID] [int] NULL,
	[Ordinal] [smallint] NULL,
	[isDefault] [tinyint] default (1),
	[DataTypeID] [int] default (24),
	[Precision] [tinyint] default (2),
	[ColumnWidth] [int]  default (100),
	[isVisible] [bit] default (1),
	[isConfigurable] [bit] default (1),
	[PermissionID] [int] default (86),
	[HeaderText_resource_key_id] [int] NULL
)

INSERT INTO #tmp(HeaderText ,DataField,HeaderText_resource_key_id, DataGridID )
	SELECT  HeaderText ,DAtaField ,HeaderText_resource_key_id, DataGridID
	FROM 
	(
		--SELECT 'FaceBook Actions' AS HeaderText, 'FBActions' AS DAtaField, 0 AS Ordinal , 2559 AS HeaderText_resource_key_id
		
	) s
	CROSS JOIN (SELECT  ParseID AS DataGridID FROM dbo.fn_ParseNumList(@DataGridIds)) dg

DELETE lu
FROM dbo.LUDataGridColumn lu
WHERE EXISTS (SELECT 1 FROM #tmp WHERE HeaderText= lu.HeaderText AND DataGridID = lu.DataGridID)

SELECT @ID = MAX(DataGridColumnID) FROM dbo.LUDataGridColumn

INSERT INTO dbo.LUDataGridColumn( DataGridColumnID,HeaderText,DataField,DataGridID,Ordinal,isDefault,DataTypeID,[PRECISION],ColumnWidth,isVisible,isConfigurable,PermissionID,HeaderText_resource_key_id)
SELECT  @ID + ROW_NUMBER() OVER (ORDER BY dg.DataGridID,t.HeaderText) AS DataGridColumnID,HeaderText ,DAtaField ,t.DataGridID , Mord + ROW_NUMBER() OVER (PartitioN BY t.DataGridID ORDER BY t.HeaderText) AS Ordinal,isDefault,DataTypeID,[PRECISION],ColumnWidth,isVisible,isConfigurable,PermissionID,HeaderText_resource_key_id
FROM #tmp t
JOIN (
SELECT DataGridID, MAX(Ordinal) Mord
FROM dbo.LUDataGridColumn
WHERE DATAGRIDID IN (SELECT ParseID AS DataGridID FROM dbo.fn_ParseNumList(@DataGridIds))
GROUP BY DataGridID
) dg ON t.DataGridID = dg.DataGridID

SELECT *
FROM dbo.LUDataGridColumn lu
WHERE EXISTS (SELECT 1 FROM #tmp WHERE HeaderText= lu.HeaderText AND DataGridID = lu.DataGridID)

UPDATE LUDataGridColumn
SET DataField = 'CurrentFBActions'
WHERE DataGridColumnID IN (1269,1270,1271,1272)

SELECT *
FROM dbo.LUDataGridColumn lu
WHERE DataGridID = 16

