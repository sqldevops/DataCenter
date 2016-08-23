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