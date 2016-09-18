#-----------------------------------------------------------------------------------------------#
#Get publish file 
#-----------------------------------------------------------------------------------------------#
$profile_xml=[xml](Get-Content $profile_path);
#-----------------------------------------------------------------------------------------------#


#-----------------------------------------------------------------------------------------------#
#Update SqlCmdVariable 
#-----------------------------------------------------------------------------------------------#
# set Priority server name
$node1=$profile_xml.Project.ItemGroup.SqlCmdVariable | where {$_.Include -eq 'PriorityServer'}
$node1.value=$priority_server;
#Set Priority database name
$node1=$profile_xml.Project.ItemGroup.SqlCmdVariable | where {$_.Include -eq 'PriorityDatabase'}
$node1.value=$priority_database;
#Set target database name
$node1=$profile_xml.Project.ItemGroup.SqlCmdVariable | where {$_.Include -eq 'TargetDatabase'}
$node1.value=$target_database;

#Set data_center_server name
$node1=$profile_xml.Project.ItemGroup.SqlCmdVariable | where {$_.Include -eq 'DataCenterServer'}
$node1.value=$data_center_server;
#Set data_center_database name
$node1=$profile_xml.Project.ItemGroup.SqlCmdVariable | where {$_.Include -eq 'DataCenterDatabase'}
$node1.value=$data_center_database;

#Set etl_server name
$node1=$profile_xml.Project.ItemGroup.SqlCmdVariable | where {$_.Include -eq 'ETL_Server'}
$node1.value=$etl_server;
#Set etl_database name
$node1=$profile_xml.Project.ItemGroup.SqlCmdVariable | where {$_.Include -eq 'ETL_Database'}
$node1.value=$etl_database;
#-----------------------------------------------------------------------------------------------#


#-----------------------------------------------------------------------------------------------#
#Update project properties 
#-----------------------------------------------------------------------------------------------#
#TargetDatabaseName
$node2=$profile_xml.Project.PropertyGroup.ChildNodes.Item(1);
$node2.InnerText="$target_database"
#DeployScriptFileName" 
$node3=$profile_xml.Project.PropertyGroup.ChildNodes.Item(2);
$node3.InnerText="$target_database.sql"
#TargetConnectionString
$node4=$profile_xml.Project.PropertyGroup.ChildNodes.Item(3);
$node4.InnerText="Data Source=$target_server;Integrated Security=True;Persist Security Info=False;Pooling=False;MultipleActiveResultSets=False;Connect Timeout=60;Encrypt=False;TrustServerCertificate=True"
#-----------------------------------------------------------------------------------------------#


#-----------------------------------------------------------------------------------------------#
#Save changes in deployment file
#-----------------------------------------------------------------------------------------------#
$profile_xml.Save($profile_path);
#-----------------------------------------------------------------------------------------------#


#-----------------------------------------------------------------------------------------------#
#Get proj file 
#-----------------------------------------------------------------------------------------------#
$proj_xml=[xml](Get-Content $proj_path)
#-----------------------------------------------------------------------------------------------#

#-----------------------------------------------------------------------------------------------#
#Set SQL Server version in sqlproj xml file
#-----------------------------------------------------------------------------------------------#
#Database Schema Provider (DSP)
$proj_xml.Project.PropertyGroup.Item(0).("DSP")=$Target_Server_Version;
#-----------------------------------------------------------------------------------------------#



#-----------------------------------------------------------------------------------------------#
#Deploy
#-----------------------------------------------------------------------------------------------#
$depoy_exp="sqlpackage /Profile:""$profile_path"" /SourceFile:""$dacpac_path"" /Action:Publish"
Invoke-Expression $depoy_exp
#-----------------------------------------------------------------------------------------------#
