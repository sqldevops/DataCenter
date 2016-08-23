CREATE TRIGGER TRNS.PartProcess_AfterInsertTrigger ON TRNS.PartProcess
AFTER INSERT
AS
BEGIN
	DECLARE @source VARCHAR(10);
	SELECT @source=Source FROM inserted;
	--If TRNS.PartProcess was changed by PROCACT
	IF @source='PROCACT' EXEC TRNS.PROCACT_ActPos;
	--If TRNS.PartProcess was changed by PART
	IF @source='PART' EXEC LOAD.PART_PartAct;
	
END;