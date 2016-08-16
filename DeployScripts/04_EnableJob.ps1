#-----------------------------------------------------------------------------------------------#
#Enable extraction jobs
#-----------------------------------------------------------------------------------------------#
[string[]] $jobs=@(
                    'ETL_EXRT_Policy_A',`
                    'ETL_EXRT_Policy_B',`
                    'ETL_EXRT_Policy_C',`
                    'ETL_EXRT_Policy_D'
                   );


foreach($item in $jobs){
                            $sql_str="EXEC msdb.dbo.sp_update_job @job_name = N'$item', @enabled = 1 ;"
                            sqlcmd -S $Target_Server -d $target_database -Q $sql_str;
                        };
#-----------------------------------------------------------------------------------------------#


