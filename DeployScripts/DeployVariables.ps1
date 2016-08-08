#-----------------------------------------------------------------------------------------------#
#Root 
#-----------------------------------------------------------------------------------------------#
$root = "D:\SourceCode\SSDT";
#-----------------------------------------------------------------------------------------------#


#-----------------------------------------------------------------------------------------------#
#Data source for ETL process : 
#-----------------------------------------------------------------------------------------------#
$priority_server="APC-DB1\TEST" # For testing environment use Priority.cele database copy 
#$priority_server = "Priority"  # For develop environment use Priority linked server
$priority_database="cele"
#-----------------------------------------------------------------------------------------------#


#-----------------------------------------------------------------------------------------------#
#Solution Variables
#-----------------------------------------------------------------------------------------------#
$sln_name="DataCenter";
$sln_folder="$root\" + $sln_name;
$sln_path="$sln_folder\$sln_name" + ".sln";
#-----------------------------------------------------------------------------------------------#


#-----------------------------------------------------------------------------------------------#
#Project Variables
#-----------------------------------------------------------------------------------------------#
$proj_name=$sln_name;
$proj_folder="$sln_folder\" + $proj_name;
$proj_path = "$sln_folder\$sln_name\$proj_name\$proj_name" + ".sqlproj";
#-----------------------------------------------------------------------------------------------#


#-----------------------------------------------------------------------------------------------#
#Deployment Variables
#-----------------------------------------------------------------------------------------------#
#DACPAC
$dacpac_name="$sln_name.dacpac"
$dacpac_folder="$proj_folder\" +"bin\Debug\"
$dacpac_path=$dacpac_folder+$dacpac_name
#Deployment Profile
$profile_name = "$proj_name.publish.xml"
$profile_path = "$proj_folder\" + $profile_name
#-----------------------------------------------------------------------------------------------#


#-----------------------------------------------------------------------------------------------#
#Testing Variables
#-----------------------------------------------------------------------------------------------#
#Testing project
$test_name=$proj_name + "Test";
$test_folder="$root\" + $test_name;
$test_path="$test_folder\bin\Debug\" + "$test_name.dll";
#Test categiry
$test_category="ETL";
#Test results
$test_results_name="TestResults.trx";
$test_results_folder="$test_folder\TestResults";
$test_results_path="$test_results_folder\" +$test_results_name ;
#-----------------------------------------------------------------------------------------------#


#-----------------------------------------------------------------------------------------------#
#Target
#-----------------------------------------------------------------------------------------------#
#Target server : Testing
$target_server="APC-DB1\TEST" # Testing environment
#$Target_Server="APC-DB1\DEV" # Develop environment
#Target database : name = project name _ semantic version number _ git branch name
$SemVer=gitversion | ConvertFrom-JSON |select SemVer
$Branch=gitversion | ConvertFrom-JSON |select BranchName
$sln_name + '_' + $SemVer.SemVer + '_' + $Branch.BranchName
$target_database=$proj_name + '_' + $SemVer.SemVer + '_' + $Branch.BranchName;
#-----------------------------------------------------------------------------------------------#
