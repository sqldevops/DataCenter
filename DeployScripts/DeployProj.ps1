#Set deployment variables in publish file 
$xml=[xml](Get-Content $profile)

#Update SqlCmdVariable in publish xml file : set target database name
$node1=$xml.Project.ItemGroup.SqlCmdVariable | where {$_.Include -eq 'TargetDatabase'}
$node1.value=$target_database;

#Update "TargetDatabaseName" in publish xml file
$node2=$xml.Project.PropertyGroup.ChildNodes.Item(1);
$node2.InnerText="$target_database"

#Update "DeployScriptFileName" in publish xml file
$node3=$xml.Project.PropertyGroup.ChildNodes.Item(2);
$node3.InnerText="$target_database.sql"

#Update "TargetConnectionString" in publish xml file
$node4=$xml.Project.PropertyGroup.ChildNodes.Item(3);
$node4.InnerText="Data Source=$target_server;Integrated Security=True;Persist Security Info=False;Pooling=False;MultipleActiveResultSets=False;Connect Timeout=60;Encrypt=False;TrustServerCertificate=True"

#Save changes in deployment file
$xml.Save($profile);

#Deploy
$depoy_exp="sqlpackage /Profile:""$profile"" /SourceFile:""$dacpac"" /Action:Publish"
Invoke-Expression $depoy_exp