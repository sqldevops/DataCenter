CREATE TRIGGER TRNS.PartProcess_AfterInsertTrigger ON TRNS.PROCACT
AFTER INSERT
AS
BEGIN
	--Populate TRNS.PartAct table
	EXEC TRNS.ERP_PartAct;

	DECLARE @source VARCHAR(10);
	SELECT @source=Source FROM inserted;
	--If TRNS.PartProcess was changed by PROCACT then reset ActPos in EXTR.PROCACT table an only then execute LOAD.PROCACT_PartAct
	IF @source='PROCACT' EXEC TRNS.PROCACT_ActPos;
	--If TRNS.PartProcess was changed by PART
	IF @source='PART' EXEC LOAD.PART_PartAct;
	
END;