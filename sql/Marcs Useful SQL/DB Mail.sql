

SELECT *
FROM msdb..sysmail_profile
WHERE name LIKE ('%DB%')
ORDER BY profile_id DESC

EXEC msdb.dbo.sp_send_dbmail 
	@profile_name = 'IOne DB Dev Alert',
	@recipients = 'msmith@ignitionone.com',
	@subject = 'ALERT: bids above threshold',
	@body = 'test'
					
EXEC msdb.dbo.sysmail_help_principalprofile_sp;						
EXEC msdb.dbo.sysmail_help_status_sp;
EXEC msdb.dbo.sysmail_help_queue_sp @queue_type = 'mail';
EXEC msdb.dbo.sysmail_stop_sp
EXEC msdb.dbo.sysmail_start_sp

SELECT TOP 50 * 
FROM msdb.dbo.sysmail_event_log
ORDER BY last_mod_date DESC


    EXECUTE msdb.dbo.sysmail_help_account_sp ;
    
    
    