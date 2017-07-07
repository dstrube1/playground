--PROC AND DW, just change for every channel
BEGIN TRAN
DELETE
FROm SIProcessing_Attribution..TrackedExposure
WHERE ChannelID = 4
 AND LocalizedCreateDate >= '01/01/2011'
  AND LocalizedCreateDate < GETDATE()
  
  
  COMMIT
  --2,817,134
  