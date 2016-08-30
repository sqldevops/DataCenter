/*
This trigger will be fired only when [EXTR].[PROCACT] is updated.
[EXTR].[PROCACT] table is updated by PROCACT_ActPos procedure, that is executed 
after TRNS.PROCACT is populated.
This trigger will NOT be fired after data is inserted to [EXTR].[PROCACT],
by EXTR.ERP_PROCACT procedure.
*/
CREATE TRIGGER EXTR.PROCACT_AfterUpdateTrigger ON EXTR.PROCACT
AFTER UPDATE
AS
IF EXISTS(SELECT * FROM TRNS.PROCACT) EXEC LOAD.PROCACT_PartAct;
GO