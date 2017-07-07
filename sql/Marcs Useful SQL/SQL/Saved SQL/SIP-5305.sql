WITH CLIENTS AS(
	SELECT ClientID,
		ClientName,
		StatusFlag,
		ModifyDateUTC
	FROM SIProcessing..Clients 
),
EXPOSURE AS (
	SELECT c.ClientID,
		COUNT(1) AS ExposureCount,
		MAX(te.CreateDateUTC) AS LastReportedClick,
		MIN($PARTITION.PF_SI_ExposureClientID_Active(te.clientid)) AS PartitionNumber
	FROM CLIENTS c 
		LEFT JOIN SIProcessing_Attribution..TrackedExposure te ON te.clientid = c.clientid
	GROUP BY  c.ClientID
),
ACTION AS(
	SELECT c.ClientID
		,MAX(ta.CreateDateUTC) AS LastReportedAction
	FROM CLIENTS c 
		LEFT JOIN SIProcessing_Attribution..TrackedACtion ta ON ta.clientid = c.clientid
	GROUP BY c.ClientID
)
SELECT c.ClientID
      ,c.ClientName
      ,c.StatusFlag
      ,e.ExposureCount
      ,c.ModifyDateUTC
      ,e.PartitionNumber
      ,e.LastReportedClick
      ,a.LastReportedAction
      ,CASE WHEN ((c.ModifyDateUTC < e.LastReportedClick OR c.ModifyDateUTC < a.LastReportedAction) AND c.StatusFlag = 0) THEN 1 ELSE 0 END AS Still_Tracking
FROM CLIENTS c 
	LEFT JOIN EXPOSURE e ON e.clientid = c.clientid
	LEFT JOIN ACTION a ON a.clientid = c.clientid
ORDER BY c.ClientID
