/*
Post-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.		
 Use SQLCMD syntax to include a file in the post-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the post-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/


/* Configurations */
:r .\01_Config\JobsEnable.sql

/* Job Policies */
:r .\02_Jobs\ETL.ExtractPolicy.sql
:r .\02_Jobs\ExtractionPolicies.sql
:r .\02_Jobs\ExtractionTables.sql

/* Jobs */



/* Data  */
--Calendar
:r .\03_Data\GEN.Calendar.sql

--Parts
:r .\03_Data\EXTR.PART_Populate.sql
:r .\03_Data\ENG.PartAct_Populate.sql
:r .\03_Data\ENG.Parts_Populate.sql

:r .\03_Data\EXTR.PROCACT_Populate.sql


--Work Orders
:r .\03_Data\EXTR.SERIAL_Populate.sql
:r .\03_Data\OPR.WorkOrders_Populate.sql

--Production
:r .\03_Data\EXTR.ALINE_Populate.sql
:r .\03_Data\OPR.Production_Population.sql

--Clients
:r .\03_Data\EXTR.CUSTOMERS_Populate.sql
:r .\03_Data\MKT.Clients_Populate.sql

--Client Orders
:r .\03_Data\EXTR.ORDERITEMS_Populate.sql
:r .\03_Data\MKT.ClientOrders_Populate.sql

--Forecasts
:r .\03_Data\MKT.Forecasts_Populate.sql

--Fix AssemblyParts
:r .\03_Data\ENG.AssemblyHierarchy.sql



