/*

sp_who4
sp_who5
DBCC INPUTBUFFER (94)

exec msdb.dbo.sp_start_job N'Creative Data plus PS Report Summary'

*/
DECLARE @MaxStep INT,
	@job NVARCHAR(200) ='Flexible Attribution - Populate ExposureSequence (New)'
	,@start DATETIME = DATEADD(DD,-1,GETDATE())

IF OBJECT_ID('tempdb..#job_history') IS NOT NULL
DROP TABLE #job_history

CREATE TABLE #job_history (
	job_name SYSNAME, 
	step_id INT,
	step_name SYSNAME, 
	run_datetime DATETIME, 
	run_duration TIME,
	JobStatus VARCHAR(50), 
	MESSAGE NVARCHAR(MAX)
	
)
INSERT INTO #job_history( job_name,step_id,step_name,run_datetime,run_duration,JobStatus,MESSAGE)
select job_name, step_id,step_name, run_datetime, run_duration, CASE run_status WHEN 0 THEN 'Failed' WHEN 1 THEN 'Sucess' WHEN 2 THEN 'Retry' WHEN 3 THEN 'Canceled' END AS JobStatus, message
from
(
    select job_name, run_datetime,
        SUBSTRING(run_duration, 1, 2) + ':' + SUBSTRING(run_duration, 3, 2) + ':' +
        SUBSTRING(run_duration, 5, 2) AS run_duration,
        run_status
        , step_id
        , message
        ,step_name
    from
    (
        select DISTINCT
            j.name as job_name, 
            run_datetime = CONVERT(DATETIME, RTRIM(run_date)) +  
                (run_time * 9 + run_time % 10000 * 6 + run_time % 100 * 10) / 216e4,
            run_duration = RIGHT('000000' + CONVERT(varchar(6), run_duration), 6),
            run_status
            , step_id
            , message
            ,step_name
        from msdb..sysjobhistory h
        inner join msdb..sysjobs j 
        on h.job_id = j.job_id
        WHERE j.name = @job
    ) t
    WHERE run_datetime >= @start
) t

--Job Duration
SELECT * 
FROM #job_history
WHERE step_id = 0
order by job_name, run_datetime,step_id

SELECT @MaxStep = MAX(step_id) FROM #job_history

--Job History
SELECT * 
FROM #job_history
WHERE step_id <> 0
AND run_datetime > (SELECT MAX(run_datetime) FROM #job_history WHERE step_id = @MaxStep)
order by job_name, run_datetime,step_id



