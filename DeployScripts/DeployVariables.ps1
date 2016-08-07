#Develop environment Variables
#$source_server="IT-DEV-01\DataCenter"
#$source_database_ETL="ETL"
#$source_database_DataCenter="DataCenter"



#Data source for ETL process : for testing environment use copy on dev machine
$priority_server="Priority"
$priority_database="cele"

$proj_folder="D:\SourceCode\SSDT"

#Projects names
$proj_name="DataCenter";

#Projects paths
$path = "$proj_folder\$proj_name\$proj_name\"


#project full path
$proj=$path + $proj_name + ".sqlproj"


#Dacpac files full path
$path_bin=$path +"bin\Debug\"
$dacpac_name="$proj_name.dacpac"
$dacpac=$path_bin+$dacpac_name


#Publish profiles path
$profile_name = "$proj_name.publish.xml"
$profile = $path + $profile_name

#Develop target server 
$target_server="APC-DB1\DEV"

#Target database on target server name is : project name _ semantic version number _ git branch name
$SemVer=gitversion | ConvertFrom-JSON |select SemVer
$Branch=gitversion | ConvertFrom-JSON |select BranchName
'DataCenter' + '_' + $SemVer.SemVer + '_' + $Branch.BranchName
$target_database=$proj_name + '_' + $SemVer.SemVer + '_' + $Branch.BranchName;

