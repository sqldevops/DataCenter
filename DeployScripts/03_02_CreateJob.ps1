#Create server object for target server.
$SQLSvrObj=New-Object Microsoft.SqlServer.Management.Smo.Server $target_server;
$SQLSvrObj.ConnectionContext.ConnectTimeout=21600;
$SQLSvrObj.ConnectionContext.StatementTimeout=0;

#Create SQL Server Agent job : ExtractionPolicy_A : update every 1 min
$job_name='ExtractionPolicy_A';
if ($SQLSvrObj.JobServer.Jobs | where {$_.name -like $job_name}) {
    $SQLSvrObj.JobServer.Jobs[$job_name].drop();
}

$job = new-object ('Microsoft.SqlServer.Management.Smo.Agent.Job') ($SQLSvrObj.JobServer, $job_name);
$job.Description = 'Start Perfmon data capture';
$job.OwnerLoginName = 'CROW\ori';
$job.Create();

#Create job step
$job_step_01 = new-object ('Microsoft.SqlServer.Management.Smo.Agent.JobStep') ($job, 'Step 01');
$job_step_01.SubSystem = 'TransactSql';
$job_step_01.Command = "EXEC ETL.ExtractPolicy 'A';"
$job_step_01.OnSuccessAction = 'QuitWithSuccess';
$job_step_01.OnFailAction = 'QuitWithFailure';
$job_step_01.DatabaseName="$target_database";
$job_step_01.Create();


#Set target server and start job
$job_step_01_id = $job_step_01.ID;
$job.ApplyToTargetServer($target_server.Name);
$job.StartStepID = $job_step_01_id;
$job.Alter();

#Create schedual
$job_sch = New-Object ('Microsoft.SqlServer.Management.Smo.Agent.JobSchedule') ($job, 'Sched 01');
$job_sch.FrequencyTypes =4;
$job_sch.FrequencyInterval=1;
$job_sch.FrequencySubDayTypes=4;
$job_sch.FrequencySubDayInterval=1;

$start_time=New-Object -TypeName timespan -ArgumentList 6,0,0;
$end_time  =New-Object -TypeName timespan -ArgumentList 20,0,0;
$job_sch.ActiveStartTimeOfDay=$start_time;
$job_sch.ActiveEndTimeOfDay=$end_time;
$job_sch.Create();

#------------------------------------------------------------------------------------------------------------
#Create SQL Server Agent job : ExtractionPolicy_B : update every 15 min
$job_name='ExtractionPolicy_B';
if ($SQLSvrObj.JobServer.Jobs | where {$_.name -like $job_name}) {
   $SQLSvrObj.JobServer.Jobs[$job_name].Drop();
}
# create job from scratch
$job = new-object ('Microsoft.SqlServer.Management.Smo.Agent.Job') ($SQLSvrObj.JobServer, $job_name);
$job.Description = 'Start Perfmon data capture';
$job.OwnerLoginName = 'CROW\ori';
$job.Create();

#Create job step
$job_step_01 = new-object ('Microsoft.SqlServer.Management.Smo.Agent.JobStep') ($job, 'Step 01');
$job_step_01.SubSystem = 'TransactSql';
$job_step_01.Command = "EXEC ETL.ExtractPolicy 'B';"
$job_step_01.OnSuccessAction = 'QuitWithSuccess';
$job_step_01.OnFailAction = 'QuitWithFailure';
$job_step_01.DatabaseName="$target_database";
$job_step_01.Create();
    
#Set target server and start job
$job_step_01_id = $job_step_01.ID;
$job.ApplyToTargetServer($target_server.Name);
$job.StartStepID = $job_step_01_id;
$job.Alter();

#Create schedual
$job_sch = New-Object ('Microsoft.SqlServer.Management.Smo.Agent.JobSchedule') ($job, 'Sched 02');
$job_sch.FrequencyTypes =4;
$job_sch.FrequencyInterval=1;
$job_sch.FrequencySubDayTypes=4;
$job_sch.FrequencySubDayInterval=15;

$start_time=New-Object -TypeName timespan -ArgumentList 6,0,0;
$end_time  =New-Object -TypeName timespan -ArgumentList 20,0,0;
$job_sch.ActiveStartTimeOfDay=$start_time;
$job_sch.ActiveEndTimeOfDay=$end_time;
$job_sch.Create();

#------------------------------------------------------------------------------------------------------------
#Create SQL Server Agent job : ExtractionPolicy_C : update every 60 min
$job_name='ExtractionPolicy_C';
if ($SQLSvrObj.JobServer.Jobs | where {$_.name -like $job_name}) {
    $SQLSvrObj.JobServer.Jobs[$job_name].drop();
}

$job = new-object ('Microsoft.SqlServer.Management.Smo.Agent.Job') ($SQLSvrObj.JobServer, $job_name);
$job.Description = 'Start Perfmon data capture';
$job.OwnerLoginName = 'CROW\ori';
$job.Create();

#Create job step
$job_step_01 = new-object ('Microsoft.SqlServer.Management.Smo.Agent.JobStep') ($job, 'Step 01');
$job_step_01.SubSystem = 'TransactSql';
$job_step_01.Command = "EXEC ETL.ExtractPolicy 'C';"
$job_step_01.OnSuccessAction = 'QuitWithSuccess';
$job_step_01.OnFailAction = 'QuitWithFailure';
$job_step_01.DatabaseName="$target_database";
$job_step_01.Create();


#Set target server and start job
$job_step_01_id = $job_step_01.ID;
$job.ApplyToTargetServer($target_server.Name);
$job.StartStepID = $job_step_01_id;
$job.Alter();

#Create schedual
$job_sch = New-Object ('Microsoft.SqlServer.Management.Smo.Agent.JobSchedule') ($job, 'Sched 03');
$job_sch.FrequencyTypes =4;
$job_sch.FrequencyInterval=1;
$job_sch.FrequencySubDayTypes=8;
$job_sch.FrequencySubDayInterval=1;

$start_time=New-Object -TypeName timespan -ArgumentList 6,0,0;
$end_time  =New-Object -TypeName timespan -ArgumentList 20,0,0;
$job_sch.ActiveStartTimeOfDay=$start_time;
$job_sch.ActiveEndTimeOfDay=$end_time;
$job_sch.Create();
#------------------------------------------------------------------------------------------------------------
#Create SQL Server Agent job : ExtractionPolicy_D : update once a day
$job_name='ExtractionPolicy_D';
if ($SQLSvrObj.JobServer.Jobs | where {$_.name -like $job_name}) {
    $SQLSvrObj.JobServer.Jobs[$job_name].drop();
}

$job = new-object ('Microsoft.SqlServer.Management.Smo.Agent.Job') ($SQLSvrObj.JobServer, $job_name);
$job.Description = 'Start Perfmon data capture';
$job.OwnerLoginName = 'CROW\ori';
$job.Create();

#Create job step
$job_step_01 = new-object ('Microsoft.SqlServer.Management.Smo.Agent.JobStep') ($job, 'Step 01');
$job_step_01.SubSystem = 'TransactSql';
$job_step_01.Command = "EXEC ETL.ExtractPolicy 'D';"
$job_step_01.OnSuccessAction = 'QuitWithSuccess';
$job_step_01.OnFailAction = 'QuitWithFailure';
$job_step_01.DatabaseName="$target_database";
$job_step_01.Create();


#Set target server and start job
$job_step_01_id = $job_step_01.ID;
$job.ApplyToTargetServer($target_server.Name);
$job.StartStepID = $job_step_01_id;
$job.Alter();

#Create schedual
$job_sch = New-Object ('Microsoft.SqlServer.Management.Smo.Agent.JobSchedule') ($job, 'Sched 03');
$job_sch.FrequencyTypes =4;
$job_sch.FrequencyInterval=1;
$job_sch.FrequencySubDayTypes=1;
$job_sch.FrequencySubDayInterval=0;

$start_time=New-Object -TypeName timespan -ArgumentList 0,0,0;
$end_time  =New-Object -TypeName timespan -ArgumentList 23,59,59;
$job_sch.ActiveStartTimeOfDay=$start_time;
$job_sch.ActiveEndTimeOfDay=$end_time;
$job_sch.Create();