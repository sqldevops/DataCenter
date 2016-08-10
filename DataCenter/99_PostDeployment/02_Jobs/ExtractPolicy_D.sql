
PRINT 'Deploying job: ETL_EXRT_Policy_D';
/* Copy from below this line to the end of the script */


PRINT 'Deploying job: ETL_EXRT_Policy_D';
DECLARE @JobId_D  UNIQUEIDENTIFIER;

SELECT  @JobId_D = job_id
FROM    msdb.dbo.sysjobs
WHERE   name = 'ETL_EXRT_Policy_D';

/*
 * First we check existence of the specified job name and whether the RedeployJobs parameter
 * has been set to "YES".
 */
IF UPPER('$(RedeployJobs)') = 'YES'   /* Redeploy the job */
OR @JobId_D IS NULL                   /* It does not exist so deploy it anyway */
BEGIN;
    /*
     * Either this is a new job or the RedeployJobs parameter is set to YES.  If its an existing job
     * we need to remove it so that we can "redeploy" it.
     */
    IF @JobId_D IS NOT NULL
    BEGIN;
        PRINT ' Deleting existing job';
        EXEC msdb.dbo.sp_delete_job @job_id = @JobId_D;

        /*
         * Set the @JobId_D variable to NULL for the sp_add_job command later on.  If it is not null the
         * server things the job is from a MSX server
         */
        SET @JobId_D = NULL;
    END;
     
    /*
     * Add the job
     */
	 EXEC  msdb.dbo.sp_add_job @job_name=N'ETL_EXRT_Policy_D', 
		@enabled=0, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'CROW\ori', @job_id = @JobId_D OUTPUT
    /*
     * Add the job step(s)
     */
	 EXEC msdb.dbo.sp_add_jobstep @job_id=@JobId_D, @step_name=N'ExtractionPolicyD', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXEC ETL.ExtractPolicy ''D'';', 
		@database_name=N'$(TargetDataBase)', 
		@flags=0
    /*
     * Add the job schedule
     */
	 EXEC msdb.dbo.sp_add_jobschedule @job_id=@JobId_D, @name=N'ETL_EXRT_Policy_D', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20151027, 
		@active_end_date=99991231, 
		@active_start_time=0, 
		@active_end_time=235959, 
		@schedule_uid=N'683276bd-3764-4715-90f4-1c0d0d8666a7'
    /*
     * Add the job server
     */
    EXEC msdb.dbo.sp_add_jobserver @job_id = @JobId_D, @server_name = N'(local)';

    PRINT ' Created the job "ETL_EXRT_Policy_D"';
END;
ELSE
BEGIN;
    PRINT ' Bypassing job "ETL_EXRT_Policy_D" deployment as job exists and RedeployJob parameter is "$(RedeployJobs)"';
END;
GO