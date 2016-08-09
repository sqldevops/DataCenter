Production database objects :


Tables:
EXTR.ALINEA : Datawarehouse table, holds all production report data (ALINEA in Priority).
OPR.WorkOrders : Target table.

Views:
ERP.ALINEA : Current data on local server.

Procedures:
EXTR.ERP_ALINEA : Incremental load ETL process, loads last changes from Priority.cele.dbo.SERIAL table to local EXTR.SERIAL table.
The procedure is called by a Job according to the extraction policy (A in this case).

