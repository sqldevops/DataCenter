#Run job to populate database 
sqlcmd -S $target_server -Q "EXEC msdb.dbo.sp_start_job @job_name='ETL_EXRT_Policy_A'"