﻿
#-------------------------------------------------------------------------------------#
# 0. Deployment variables setting
#-------------------------------------------------------------------------------------#
. .\DeployVariables.ps1

#-------------------------------------------------------------------------------------#
# 1. Build DataCenter project : creates dacpac file, next to be deployed 
#-------------------------------------------------------------------------------------#
. .\BuildProj.ps1

#-------------------------------------------------------------------------------------#
# 2. Set develop server objects
#-------------------------------------------------------------------------------------#
#.\PriorityLinkedServer.ps1

#-------------------------------------------------------------------------------------#
# 4. Deploy DataCenter project on develop server
#-------------------------------------------------------------------------------------#
. .\DeployProj.ps1

#-------------------------------------------------------------------------------------#
# 8. Post deployment commands
#-------------------------------------------------------------------------------------#
. .\bcp.ps1;
#Job doesn work properly on SQL Server 2016
#. .\EnableJob.ps1;