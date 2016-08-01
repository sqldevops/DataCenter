﻿
#-------------------------------------------------------------------------------------#
# 0. Deployment variables setting
#-------------------------------------------------------------------------------------#
. .\DeployVariables.ps1

#-------------------------------------------------------------------------------------#
# 1. Build : 
#-------------------------------------------------------------------------------------#
#msbuild $proj /p:VisualStudioVersion=14.0

#-------------------------------------------------------------------------------------#
# 2. Set develop server objects
#-------------------------------------------------------------------------------------#
.\PriorityLinkedServer.ps1

#-------------------------------------------------------------------------------------#
# 3. Deploy DataCenter project on develop server
#-------------------------------------------------------------------------------------#
.\DeployProj.ps1

#-------------------------------------------------------------------------------------#
# 4. Post deployment commands
#-------------------------------------------------------------------------------------#
# Bulk Data transfer 


#-------------------------------------------------------------------------------------#