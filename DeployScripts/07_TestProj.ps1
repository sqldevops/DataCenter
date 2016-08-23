#-----------------------------------------------------------------------------------------------#
# Get config file
#-----------------------------------------------------------------------------------------------#
$xml=[xml](Get-Content $test_config)
#-----------------------------------------------------------------------------------------------#

#-----------------------------------------------------------------------------------------------#
# Set connection string for testing
#-----------------------------------------------------------------------------------------------#
$connection_string=
"Data Source=$target_server;" +
"Initial Catalog=$target_database;" + 
"Integrated Security=True;" +
 "Persist Security Info=False;" + 
 "Pooling=False;" +
 "MultipleActiveResultSets=False;" +
 "Connect Timeout=60;" + 
 "Encrypt=False;" +
 "TrustServerCertificate=True"
#-----------------------------------------------------------------------------------------------#

#-----------------------------------------------------------------------------------------------#
# Set configuration file connection string
#-----------------------------------------------------------------------------------------------#
$xml.configuration.SqlUnitTesting.ExecutionContext.ConnectionString=$connection_string;
$xml.configuration.SqlUnitTesting.PrivilegedContext.ConnectionString=$connection_string;
$xml.Save($test_config);
#-----------------------------------------------------------------------------------------------#


#-----------------------------------------------------------------------------------------------#
# Delete test results file if exists.
#-----------------------------------------------------------------------------------------------#
if (Test-Path $test_results_path) {Remove-Item $test_results_path};
#-----------------------------------------------------------------------------------------------#

#-----------------------------------------------------------------------------------------------#
# Run tests by category
#-----------------------------------------------------------------------------------------------#
# Database unit tests supported only in old MSTest, not in VSTest.Console.Exe  .
# Link: https://msdn.microsoft.com/en-us/library/ms253138(v=vs.110).aspx#Runner.
# Cant run ordertest and playlist in MSTest, order is hopefully set as "alphnumeric".
mstest /testcontainer:$test_path /category:$test_category /resultsfile:"$test_results_path";
#-----------------------------------------------------------------------------------------------#
