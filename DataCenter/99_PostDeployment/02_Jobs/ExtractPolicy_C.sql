

PRINT 'Deploying job: ETL_EXRT_Policy_C';
/* Copy from below this line to the end of the script */


PRINT 'Deploying job: ETL_EXRT_Policy_C';
DECLARE @JobId_C  UNIQUEIDENTIFIER;

SELECT  @JobId_C = job_id
FROM    msdb.dbo.sysjobs
WHERE   name = 'ETL_EXRT_Policy_C';

/*
 * First we check existence of the specified job name and whether the RedeployJobs parameter
 * has been set to "YES".
 */
IF UPPER('$(RedeployJobs)') = 'YES'   /* Redeploy the job */
OR @JobId_C IS NULL                   /* It does not exist so deploy it anyway */
BEGIN;
    /*
     * Either this is a new job or the RedeployJobs parameter is set to YES.  If its an existing job
     * we need to remove it so that we can "redeploy" it.
     */
    IF @JobId_C IS NOT NULL
    BEGIN;
        PRINT ' Deleting existing job';
        EXEC msdb.dbo.sp_delete_job @job_id = @JobId_C;

        /*
         * Set the @JobId_C variable to NULL for the sp_add_job command later on.  If it is not null the
         * server things the job is from a MSX server
         */
        SET @JobId_C = NULL;
    END;
     
    /*
     * Add the job
     */
	 EXEC  msdb.dbo.sp_add_job @job_name=N'ETL_EXRT_Policy_C', 
		@enabled=0, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'CROW\ori', @job_id = @JobId_C OUTPUT
    /*
     * Add the job step(s)
     */
	 EXEC msdb.dbo.sp_add_jobstep @job_id=@JobId_C, @step_name=N'ExtractionPolicyC', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXEC ETL.ExtractPolicy ''C'';', 
		@database_name=N'$(TargetDataBase)', 
		@flags=0
    /*
     * Add the job schedule
     */
	 EXEC msdb.dbo.sp_add_jobschedule @job_id=@JobId_C,  @name=N'60min', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=8, 
		@freq_subday_interval=1, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20151027, 
		@active_end_date=99991231, 
		@active_start_time=60000, 
		@active_end_time=200000, 
		@schedule_uid=N'2515ed55-1525-4147-b222-e13ef544bca2'
    /*
     * Add the job server
     */
    EXEC msdb.dbo.sp_add_jobserver @job_id = @JobId_C, @server_name = N'(local)';

    PRINT ' Created the job "ETL_EXRT_Policy_C"';
END;
ELSE
BEGIN;
    PRINT ' Bypassing job "ETL_EXRT_Policy_C" deployment as job exists and RedeployJob parameter is "$(RedeployJobs)"';
END;
GO