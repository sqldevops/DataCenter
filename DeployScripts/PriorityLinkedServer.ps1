#This code snippet creates "Priority" linked server on DEV server if it does'nt exist.
[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SqlServer.Smo");
$SQLSvrObj=New-Object Microsoft.SqlServer.Management.Smo.Server $target_server;
$SQLSvrObj.ConnectionContext.ConnectTimeout=21600;
$SQLSvrObj.ConnectionContext.StatementTimeout=0;

if ( -not ($SQLSvrObj.LinkedServers | Where-Object {$_.Name -eq 'Priority'}))
 {
    $linkedSvr = New-Object -TypeName Microsoft.SqlServer.Management.Smo.LinkedServer -ArgumentList $SQLSvrObj, "Priority"
    $linkedSvr.ProductName="SQL Server";
    $linkedSvr.Create();
};