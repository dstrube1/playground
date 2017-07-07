
DECLARE @OBJ INT


SELECT  @OBJ = object_id FROM tempdb.sys.tables WHERE CHARINDEX('#crawl_',name) =1

SELECT * 
FROM tempdb.sys.partitions
WHERE object_id = @OBJ

