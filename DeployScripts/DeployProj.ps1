#-----------------------------------------------------------------------------------------------#
#Get publish file 
#-----------------------------------------------------------------------------------------------#
$xml=[xml](Get-Content $profile_path)
#-----------------------------------------------------------------------------------------------#


#-----------------------------------------------------------------------------------------------#
#Update SqlCmdVariable 
#-----------------------------------------------------------------------------------------------#
# set Priority server name
$node1=$xml.Project.ItemGroup.SqlCmdVariable | where {$_.Include -eq 'PriorityServer'}
$node1.value=$priority_server;
#Set Priority database name
$node1=$xml.Project.ItemGroup.SqlCmdVariable | where {$_.Include -eq 'PriorityDatabase'}
$node1.value=$priority_database;
#Set target database name
$node1=$xml.Project.ItemGroup.SqlCmdVariable | where {$_.Include -eq 'TargetDatabase'}
$node1.value=$target_database;
#-----------------------------------------------------------------------------------------------#


#-----------------------------------------------------------------------------------------------#
#Update project properties 
#-----------------------------------------------------------------------------------------------#
#TargetDatabaseName
$node2=$xml.Project.PropertyGroup.ChildNodes.Item(1);
$node2.InnerText="$target_database"
#DeployScriptFileName" 
$node3=$xml.Project.PropertyGroup.ChildNodes.Item(2);
$node3.InnerText="$target_database.sql"
#TargetConnectionString
$node4=$xml.Project.PropertyGroup.ChildNodes.Item(3);
$node4.InnerText="Data Source=$target_server;Integrated Security=True;Persist Security Info=False;Pooling=False;MultipleActiveResultSets=False;Connect Timeout=60;Encrypt=False;TrustServerCertificate=True"
#-----------------------------------------------------------------------------------------------#


#-----------------------------------------------------------------------------------------------#
#Save changes in deployment file
#-----------------------------------------------------------------------------------------------#
$xml.Save($profile_path);
#-----------------------------------------------------------------------------------------------#


#-----------------------------------------------------------------------------------------------#
#Deploy
#-----------------------------------------------------------------------------------------------#
$depoy_exp="sqlpackage /Profile:""$profile_path"" /SourceFile:""$dacpac_path"" /Action:Publish"
Invoke-Expression $depoy_exp
#-----------------------------------------------------------------------------------------------#
