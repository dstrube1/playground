-- If necessary do a FIND/REPLACE for the following otherwise just execute the script

-- If cpr was not used as the name for the EncounterPRO database then do a FIND/REPLACE 
-- for cpr with the name that was used for the database before running the script

-- -UseDefDir (Only if you are not using the default path as the location for your Full Backup 
-- and Transaction Log Backup)  Replace with “PATH” (i.e. “d:\backup”)
----------------------------------------------------------------------------------------------
-- Deleting a maintenance plan - Run help store procedure to obtain plan_id

-- EXECUTE sp_help_maintenance_plan
-- EXECUTE sp_delete_maintenance_plan Plan_id

USE msdb

-- Create New Maintenance Plan

DECLARE   @@myplan_id UNIQUEIDENTIFIER
EXECUTE   sp_add_maintenance_plan N'EPRO DB Maintenance Plan',@plan_id=@@myplan_id OUTPUT

PRINT	'The id for the maintenance plan "EPRO DB Maintenance Plan"
is:'+convert(varchar(256),@@myplan_id)

Execute   sp_add_maintenance_plan_db @@myplan_id, 'cpr'

-- Now create jobs and associate then with the Maintenance plan just created

--------------------------------------------------------------
-- Create DB Backup Job
--------------------------------------------------------------
DECLARE @Backupjob_id UNIQUEIDENTIFIER
EXECUTE sp_add_job @job_name = 'EPRO DB Backup',
   @owner_login_name = 'sa',
   @job_id=@Backupjob_id OUTPUT

DECLARE @Tmpcommand varchar(512) 
SET @Tmpcommand = 'EXECUTE master.dbo.xp_sqlmaint N''-PlanID '+ CAST(@@myplan_id AS VARCHAR(36)) +' -Rpt "C:\Temp\EPRO DB Maintenance Plan.txt" -DelTxtRpt 4WEEKS -WriteHistory -VrfyBackup -BkUpMedia DISK -BkUpDB -UseDefDir -DelBkUps 1DAYS -BkExt "BAK"'''
PRINT @tmpcommand
EXECUTE sp_add_jobstep @job_id=@Backupjob_id,
   @step_name = 'Step 1',
   @database_name = 'cpr',
   @subsystem = 'TSQL',
   @command = @Tmpcommand,
   @retry_attempts = 2,
   @retry_interval = 5

EXECUTE sp_add_jobschedule @job_id=@Backupjob_id, 
   @name = 'Scheduled 1',
   @freq_type = 8, -- weekly
   @freq_recurrence_factor = 1,
   @freq_interval = 9,
   @active_start_time = 220000

EXECUTE sp_add_jobserver @job_id=@Backupjob_id, 
   @server_name = @@SERVERNAME

EXECUTE sp_add_maintenance_plan_job @@myplan_id, @Backupjob_id

--------------------------------------------------------------
-- End DB Backup Job
--------------------------------------------------------------

--------------------------------------------------------------
-- Create Transaction Log Backup Job
--------------------------------------------------------------
DECLARE @Transactionjob_id UNIQUEIDENTIFIER
EXECUTE sp_add_job @job_name = 'EPRO Transaction Log Backup',
   @owner_login_name = 'sa',
   @job_id=@Transactionjob_id OUTPUT

DECLARE @Tmpcommand2 varchar(512) 
SET @Tmpcommand2 = 'EXECUTE master.dbo.xp_sqlmaint N''-PlanID '+ CAST(@@myplan_id AS VARCHAR(36)) +' -Rpt "C:\Temp\EPRO DB Maintenance Plan0.txt" -DelTxtRpt 4WEEKS -WriteHistory -VrfyBackup -BkUpMedia DISK -BkUpLog -UseDefDir -DelBkUps 1WEEKS -BkExt "TRN"'''

PRINT @tmpcommand2
EXECUTE sp_add_jobstep @job_id=@Transactionjob_id,
   @step_name = 'Step 1',
   @database_name = 'cpr',
   @subsystem = 'TSQL',
   @command = @Tmpcommand2,
   @retry_attempts = 2,
   @retry_interval = 5

EXECUTE sp_add_jobschedule @job_id=@Transactionjob_id, 
   @name = 'Scheduled 1',
   @freq_type = 4, -- daily
   @freq_interval = 1,
   @active_start_time = 210000

EXECUTE sp_add_jobserver @job_id=@Transactionjob_id, 
   @server_name = @@SERVERNAME

EXECUTE sp_add_maintenance_plan_job @@myplan_id, @Transactionjob_id

--------------------------------------------------------------
-- End Transaction Log Backup Job
--------------------------------------------------------------

--------------------------------------------------------------
-- Create Optimizations Job
--------------------------------------------------------------
DECLARE @Optimizationsjob_id UNIQUEIDENTIFIER
EXECUTE sp_add_job @job_name = 'EPRO Optimizations',
   @owner_login_name = 'sa',
   @job_id=@Optimizationsjob_id OUTPUT

EXECUTE sp_add_jobstep @job_id=@Optimizationsjob_id,
	@step_id = 1, 
	@step_name = N'PreOptimize', 
	@command = N'ALTER DATABASE cpr SET RECOVERY BULK_LOGGED', 
	@database_name = N'cpr', 
	@server = N'', 
	@database_user_name = N'', 
	@subsystem = N'TSQL', 
	@cmdexec_success_code = 0, 
	@flags = 0, 
	@retry_attempts = 0, 
	@retry_interval = 1, 
	@output_file_name = N'', 
	@on_success_step_id = 0, 
	@on_success_action = 3, 
	@on_fail_step_id = 0, 
	@on_fail_action = 2

DECLARE @Tmpcommand3 varchar(256) 
SET @Tmpcommand3 = 'EXECUTE master.dbo.xp_sqlmaint N''-PlanID '+ CAST(@@myplan_id AS VARCHAR(36)) +' -Rpt "C:\temp\EPRO DB Maintenance Plan1.txt" -DelTxtRpt 4WEEKS -WriteHistory  -RebldIdx 100 '''
PRINT @tmpcommand3
EXECUTE sp_add_jobstep @job_id=@Optimizationsjob_id,
	@step_id = 2, 
	@step_name = 'Optimize',
	@database_name = 'cpr',
	@server = N'', 
	@database_user_name = N'', 
	@subsystem = 'TSQL',
	@command = @Tmpcommand3,
	@retry_attempts = 2,
	@retry_interval = 5,
	@cmdexec_success_code = 0, 
	@flags = 0, 
	@on_success_step_id = 0, 
	@on_success_action = 3, 
	@on_fail_step_id = 0, 
	@on_fail_action = 3

EXECUTE sp_add_jobstep @job_id=@Optimizationsjob_id,
	@step_id = 3, 
	@step_name = N'PostOptimize', 
	@command = N'ALTER DATABASE cpr SET RECOVERY FULL', 
	@database_name = N'cpr', 
	@server = N'', 
	@database_user_name = N'', 
	@subsystem = N'TSQL', 
	@cmdexec_success_code = 0, 
	@flags = 0, 
	@retry_attempts = 0, 
	@retry_interval = 1, 
	@output_file_name = N'', 
	@on_success_step_id = 0, 
	@on_success_action = 1, 
	@on_fail_step_id = 0, 
	@on_fail_action = 2


EXECUTE sp_update_job @job_id=@Optimizationsjob_id, @start_step_id = 1 

EXECUTE sp_add_jobschedule @job_id=@Optimizationsjob_id, 
	@name = N'Scheduled 1', 
	@enabled = 1, 
	@freq_type = 8, 
	@active_start_date = 20041006, 
	@active_start_time = 233000, 
	@freq_interval = 1, 
	@freq_subday_type = 1, 
	@freq_subday_interval = 0, 
	@freq_relative_interval = 0, 
	@freq_recurrence_factor = 1, 
	@active_end_date = 99991231, 
	@active_end_time = 235959

EXECUTE sp_add_jobserver @job_id=@Optimizationsjob_id, 
   @server_name = @@SERVERNAME

-- EXECUTE sp_add_maintenance_plan_job @@myplan_id, @Optimizationsjob_id
-- Do not add this to the Maint Plan.
-- It will break if you do.

--------------------------------------------------------------
-- End Optimizations Job
--------------------------------------------------------------

--------------------------------------------------------------
-- Create Integrity Checks Job
--------------------------------------------------------------
DECLARE @Integrityjob_id UNIQUEIDENTIFIER
EXECUTE sp_add_job @job_name = 'EPRO Integrity Checks',
   @owner_login_name = 'sa',
   @job_id=@Integrityjob_id OUTPUT

DECLARE @Tmpcommand4 varchar(256) 
SET @Tmpcommand4 = 'EXECUTE master.dbo.xp_sqlmaint N''-PlanID '+ CAST(@@myplan_id AS VARCHAR(36)) +' -Rpt "C:\Temp\EPRO DB Maintenance Plan2.txt" -DelTxtRpt 4WEEKS -WriteHistory  -CkDB  '''
PRINT @tmpcommand4
EXECUTE sp_add_jobstep @job_id=@Integrityjob_id,
   @step_name = 'Step 1',
   @database_name = 'cpr',
   @subsystem = 'TSQL',
   @command = @tmpcommand4,
   @retry_attempts = 5,
   @retry_interval = 5

EXECUTE sp_add_jobschedule @job_id=@Integrityjob_id, 
   @name = 'Scheduled 1',
   @freq_type = 4, -- Daily
   @freq_interval = 1,
   @active_start_time = 000000

EXECUTE sp_add_jobserver @job_id=@Integrityjob_id, 
   @server_name = @@SERVERNAME

EXECUTE sp_add_maintenance_plan_job @@myplan_id, @Integrityjob_id

--------------------------------------------------------------
-- End Integrity Checks Job
--------------------------------------------------------------

--------------------------------------------------------------
-- Create Rebuild Constraints Job
--------------------------------------------------------------
DECLARE @RebuildConstraintsjob_id UNIQUEIDENTIFIER
EXECUTE sp_add_job @job_name = 'EPRO Rebuild Constraints',
   @owner_login_name = 'sa',
   @job_id=@RebuildConstraintsjob_id OUTPUT

EXECUTE sp_add_jobstep @job_id=@RebuildConstraintsjob_id,
	@step_id = 1, 
	@step_name = N'PreRebuild', 
	@command = N'ALTER DATABASE cpr SET RECOVERY BULK_LOGGED', 
	@database_name = N'cpr', 
	@server = N'', 
	@database_user_name = N'', 
	@subsystem = N'TSQL', 
	@cmdexec_success_code = 0, 
	@flags = 0, 
	@retry_attempts = 0, 
	@retry_interval = 1, 
	@output_file_name = N'', 
	@on_success_step_id = 0, 
	@on_success_action = 3, 
	@on_fail_step_id = 0, 
	@on_fail_action = 2

EXECUTE sp_add_jobstep @job_id=@RebuildConstraintsjob_id,
	@step_id = 2, 
	@step_name = N'Rebuild', 
	@command = N'sp_rebuild_constraints ''%''', 
	@database_name = N'cpr', 
	@server = N'', 
	@database_user_name = N'', 
	@subsystem = N'TSQL', 
	@cmdexec_success_code = 0, 
	@flags = 0, 
	@retry_attempts = 0, 
	@retry_interval = 0, 
	@output_file_name = N'', 
	@on_success_step_id = 0, 
	@on_success_action = 3, 
	@on_fail_step_id = 0, 
	@on_fail_action = 3

EXECUTE sp_add_jobstep @job_id=@RebuildConstraintsjob_id,
	@step_id = 3, 
	@step_name = N'PostRebuild', 
	@command = N'ALTER DATABASE cpr SET RECOVERY FULL', 
	@database_name = N'cpr', 
	@server = N'', 
	@database_user_name = N'', 
	@subsystem = N'TSQL', 
	@cmdexec_success_code = 0, 
	@flags = 0, 
	@retry_attempts = 0, 
	@retry_interval = 1, 
	@output_file_name = N'', 
	@on_success_step_id = 0, 
	@on_success_action = 1, 
	@on_fail_step_id = 0, 
	@on_fail_action = 2


EXECUTE sp_update_job @job_id=@RebuildConstraintsjob_id, @start_step_id = 1 

EXECUTE sp_add_jobschedule @job_id=@RebuildConstraintsjob_id,
	@name = N'2nd Sunday', 
	@enabled = 1, 
	@freq_type = 32, 
	@active_start_date = 19900101, 
	@active_start_time = 20000, 
	@freq_interval = 1, 
	@freq_subday_type = 1, 
	@freq_subday_interval = 0, 
	@freq_relative_interval = 2, 
	@freq_recurrence_factor = 1, 
	@active_end_date = 99991231, 
	@active_end_time = 235959

EXECUTE sp_add_jobschedule @job_id=@RebuildConstraintsjob_id,
	@name = N'4th Sunday', 
	@enabled = 1, 
	@freq_type = 32, 
	@active_start_date = 20050105, 
	@active_start_time = 20000, 
	@freq_interval = 1, 
	@freq_subday_type = 1, 
	@freq_subday_interval = 0, 
	@freq_relative_interval = 8, 
	@freq_recurrence_factor = 1, 
	@active_end_date = 99991231, 
	@active_end_time = 235959

EXECUTE sp_add_jobserver @job_id=@RebuildConstraintsjob_id, 
   @server_name = @@SERVERNAME

EXECUTE sp_add_maintenance_plan_job @@myplan_id, @RebuildConstraintsjob_id
--------------------------------------------------------------
-- End Rebuild Constraints Job
--------------------------------------------------------------

--------------------------------------------------------------
-- Create Maintenance Frequent Job
--------------------------------------------------------------
DECLARE @MaintFreqjob_id UNIQUEIDENTIFIER
EXECUTE sp_add_job @job_name = 'EPRO Maintenance Frequent',
   @owner_login_name = 'sa',
   @job_id=@MaintFreqjob_id OUTPUT

EXECUTE sp_add_jobstep @job_id=@MaintFreqjob_id,
   @step_name = 'Step 1',
   @database_name = 'cpr',
   @subsystem = 'TSQL',
   @command = 'EXECUTE sp_maintenance_frequent',
   @retry_attempts = 2,
   @retry_interval = 5

EXECUTE sp_add_jobschedule @job_id=@MaintFreqjob_id, 
   @name = 'Scheduled 1',
   @freq_type = 4, -- Daily
   @freq_recurrence_factor = 1,
   @freq_interval = 1,
   @active_start_time = 70000

EXECUTE sp_add_jobserver @job_id=@MaintFreqjob_id, 
   @server_name = @@SERVERNAME

--------------------------------------------------------------
-- End Maintenance Frequent Job
--------------------------------------------------------------

--------------------------------------------------------------
-- Create Transaction Log Backup Pre/Post Job
--------------------------------------------------------------
DECLARE @TransLBUPrePostjob_id UNIQUEIDENTIFIER
EXECUTE sp_add_job @job_name = 'EPRO Transaction Log Backup PRE/POST',
   @owner_login_name = 'sa',
   @job_id=@TransLBUPrePostjob_id OUTPUT

EXECUTE sp_add_jobstep @job_id=@TransLBUPrePostjob_id,
   @step_name = 'Step 1',
   @database_name = 'cpr',
   @subsystem = 'TSQL',
   @command = 'CHECKPOINT',
   @on_Success_action = 3,
   @retry_attempts = 2,
   @retry_interval = 5

EXECUTE sp_add_jobstep @job_id=@TransLBUPrePostjob_id,
   @step_name = 'Step 2',
   @database_name = 'cpr',
   @subsystem = 'TSQL',
   @command = 'DBCC SHRINKFILE (2,300)',
   @retry_attempts = 2,
   @retry_interval = 5

EXECUTE sp_add_jobschedule @job_id=@TransLBUPrePostjob_id, 
   @name = 'Scheduled 1',
   @freq_type = 4, -- Daily
   @freq_interval = 1,
   @active_start_time = 205500

EXECUTE sp_add_jobschedule @job_id=@TransLBUPrePostjob_id, 
   @name = 'Scheduled 2',
   @freq_type = 4, -- Daily
   @freq_interval = 1,
   @active_start_time = 215500

EXECUTE sp_add_jobserver @job_id=@TransLBUPrePostjob_id, 
   @server_name = @@SERVERNAME
--------------------------------------------------------------
-- End Transaction Log Backup Pre/Post Job
--------------------------------------------------------------

--------------------------------------------------------------
-- Create Backup Delete Job
--------------------------------------------------------------
DECLARE @BackupDeletejob_id UNIQUEIDENTIFIER
EXECUTE sp_add_job @job_name = 'EPRO Backup Delete',
   @owner_login_name = 'sa',
   @job_id=@BackupDeletejob_id OUTPUT

--NOTE:
-- DEL command given flag /A-A so as to delete only cpr*bak files 
-- with the attribute of archive flag set to clear;
-- i.e. files that have already been archived

EXECUTE sp_add_jobstep @job_id=@BackupDeletejob_id,
   @step_name = 'Step 1',
   @database_name = 'cpr',
   @subsystem = 'CMDEXEC',
   @command = 'DEL /A-A "D:\Program Files\Microsoft SQL Server\MSSQL\BACKUP\cpr*.bak"',
   @retry_attempts = 2,
   @retry_interval = 5

EXECUTE sp_add_jobschedule @job_id=@BackupDeletejob_id, 
   @name = 'Scheduled 1',
   @freq_type = 8, -- Weekly
   @freq_recurrence_factor = 1,
   @freq_interval = 9,
   @active_start_time = 215000

EXECUTE sp_add_jobserver @job_id=@BackupDeletejob_id, 
   @server_name = @@SERVERNAME
--------------------------------------------------------------
-- End Backup Delete Job
--------------------------------------------------------------

GO