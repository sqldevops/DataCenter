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
:r .\02_Jobs\ExtractionPolicies.sql
:r .\02_Jobs\ExtractionTable.sql

/* Jobs */

:r .\02_Jobs\ExtractPolicy_A.sql
:r .\02_Jobs\ExtractPolicy_B.sql
:r .\02_Jobs\ExtractPolicy_C.sql
:r .\02_Jobs\ExtractPolicy_D.sql

/* Data  */



