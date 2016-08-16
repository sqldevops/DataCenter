$Source_Server="IT-DEV-01\DataCenter";


#-----------------------------------------------------------------------------------------------#
# Target tables from DataCenter database 
#-----------------------------------------------------------------------------------------------#
$Source_Database="DataCenter";

[string[]]$files=@(
                         "ENG.Parts",`
                         "OPR.WorkOrders",`
                         "OPR.Production"
                        );

foreach($file in $files) 
{
    #Truncate target table
    sqlcmd -S $Target_Server -d $target_database -Q "TRUNCATE TABLE $file";
    #Bulk load  table from source
    bcp $file OUT ..\bcp\$file  -T -n -S $Source_Server -d $Source_Database
    #Populate target database with bcp file
    bcp $file IN  ..\bcp\$file  -T -n -S $Target_Server -d $target_database
};

#-----------------------------------------------------------------------------------------------#
# Data warehouse tables from ETL database
#-----------------------------------------------------------------------------------------------#
$Source_Database="ETL";
[string[]]$files=@(
                        "EXTR.PART",`
                        "EXTR.SERIAL",`
                        "EXTR.ALINE"`
                    );
foreach($file in $files)
{
    #Truncate target table
    sqlcmd -S $Target_Server -d $target_database -Q "TRUNCATE TABLE $file";
    #Bulk load  table from source
    bcp $file OUT ..\bcp\$file  -T -n -S $Source_Server -d $Source_Database
    #Populate target database with bcp file
    bcp $file IN  ..\bcp\$file  -T -n -S $Target_Server -d $target_database
};
#-----------------------------------------------------------------------------------------------#
