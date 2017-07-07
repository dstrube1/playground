USE JunkDB
GO

IF OBJECT_ID('MS_Test') IS NOT NULL
DROP TABLE MS_Test

IF  EXISTS (SELECT * FROM sys.partition_schemes WHERE name = N'PS_Test')
DROP PARTITION SCHEME [PS_Test]
GO

IF  EXISTS (SELECT * FROM sys.partition_functions WHERE name = N'PF_Test')
DROP PARTITION FUNCTION [PF_Test]
GO

CREATE PARTITION FUNCTION [PF_Test](datetime) AS RANGE RIGHT FOR VALUES (N'2013-07-15T00:00:00.000', N'2013-07-16T00:00:00.000')
GO

CREATE PARTITION SCHEME [PS_Test] AS PARTITION [PF_Test] ALL TO ([PRIMARY])
GO

CREATE TABLE MS_Test (
	GDATE DATETIME
) ON PS_Test(GDATE)

--Before function
INSERT INTO MS_Test 
VALUES ('07/14/2013')

	SELECT 
	distinct
		p.partition_number,
		value
		,ROWS
	FROM sys.partitions p JOIN sys.indexes i
		  ON p.object_id = i.object_id and p.index_id = i.index_id
		   JOIN sys.partition_schemes ps
					ON ps.data_space_id = i.data_space_id
		   JOIN sys.partition_functions f
					   ON f.function_id = ps.function_id
		   LEFT JOIN sys.partition_range_values rv
	ON f.function_id = rv.function_id AND p.partition_number = rv.boundary_id
	WHERE i.object_id = OBJECT_ID('MS_Test')
	order by value	

TRUNCATE TABLE MS_Test

--Way before function

INSERT INTO MS_Test 
VALUES ('07/14/2012')

	SELECT 
	distinct
		p.partition_number,
		value
		,ROWS
	FROM sys.partitions p JOIN sys.indexes i
		  ON p.object_id = i.object_id and p.index_id = i.index_id
		   JOIN sys.partition_schemes ps
					ON ps.data_space_id = i.data_space_id
		   JOIN sys.partition_functions f
					   ON f.function_id = ps.function_id
		   LEFT JOIN sys.partition_range_values rv
	ON f.function_id = rv.function_id AND p.partition_number = rv.boundary_id
	WHERE i.object_id = OBJECT_ID('MS_Test')
	order by value	

TRUNCATE TABLE MS_Test


--Inside range
INSERT INTO MS_Test 
VALUES ('07/15/2013')

	SELECT 
	distinct
		p.partition_number,
		value
		,ROWS
	FROM sys.partitions p JOIN sys.indexes i
		  ON p.object_id = i.object_id and p.index_id = i.index_id
		   JOIN sys.partition_schemes ps
					ON ps.data_space_id = i.data_space_id
		   JOIN sys.partition_functions f
					   ON f.function_id = ps.function_id
		   LEFT JOIN sys.partition_range_values rv
	ON f.function_id = rv.function_id AND p.partition_number = rv.boundary_id
	WHERE i.object_id = OBJECT_ID('MS_Test')
	order by value	

TRUNCATE TABLE MS_Test


--After Function
INSERT INTO MS_Test 
VALUES ('07/18/2013')

	SELECT 
	DISTINCT
		p.partition_number,
		value
		,ROWS
	FROM sys.partitions p JOIN sys.indexes i
		  ON p.object_id = i.object_id and p.index_id = i.index_id
		   JOIN sys.partition_schemes ps
					ON ps.data_space_id = i.data_space_id
		   JOIN sys.partition_functions f
					   ON f.function_id = ps.function_id
		   LEFT JOIN sys.partition_range_values rv
	ON f.function_id = rv.function_id AND p.partition_number = rv.boundary_id
	WHERE i.object_id = OBJECT_ID('MS_Test')
	order by value	

TRUNCATE TABLE MS_Test


