﻿CREATE TRIGGER EXTR.PROCACT_Trigger ON EXTR.PROCACT
AFTER UPDATE
AS
IF EXISTS(SELECT * FROM TRNS.PartProcess) EXEC LOAD.PROCACT_PartAct;
GO