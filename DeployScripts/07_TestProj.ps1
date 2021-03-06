﻿
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
