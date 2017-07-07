select @@SERVERNAME AS Server,job_name, step_id,step_name, run_datetime, run_duration, CASE run_status WHEN 0 THEN 'Failed' WHEN 1 THEN 'Sucess' WHEN 2 THEN 'Retry' WHEN 3 THEN 'Canceled' END AS JobStatus, message
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
    ) t
    WHERE run_datetime >= DATEADD(hh,-24,GETDATE())
    AND t.run_status = 0
    AND t.step_id <> 0
) t
ORDER BY t.run_datetime, t.step_id