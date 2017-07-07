      SELECT 
      distinct
            Partition_number
            ,ROWS
            ,value
      FROM sys.partitions p JOIN sys.indexes i
              ON p.object_id = i.object_id and p.index_id = i.index_id
               JOIN sys.partition_schemes ps
                              ON ps.data_space_id = i.data_space_id
               JOIN sys.partition_functions f
                                 ON f.function_id = ps.function_id
               LEFT JOIN sys.partition_range_values rv
      ON f.function_id = rv.function_id AND p.partition_number = rv.boundary_id
      WHERE OBJECT_NAME(i.object_id) = 'RPT_PS_Summary_CustomerTT_GroupHourLevel'
      AND ROWS > 0
      order by value    
      
      
      ALTER TABLE RPT_PS_Summary_GroupLevel switch PARTITION(45) TO
      RPT_PS_Summary_GroupLevel_swap PARTITION(45)

DROp Table SIOLAP.dbo.RPT_PS_Summary_GroupLevel_swap
