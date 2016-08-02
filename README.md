Work Orders database objects :

Schemas:
OPR : Schema for oerations department database objects.

Tables:
EXTR.SERIAL : Datawarehouse slowly changing dimension table, holds all work orders data (SERIAL in Priority).
OPR.WorkOrders : Target table.

Views:
ERP.SERIAL : Current data on local server.

Procedures:
EXTR.ERP_SERIAL : Incremental load ETL process, loads last changes from Priority.cele.dbo.SERIAL table to local EXTR.SERIAL table.
The procedure is called by a Job according to the extraction policy (A for this case).

