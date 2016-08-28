/*
This trigger executes TRNS.ERP_PartActAdjacency that rebuilds TRNS.PartActAdjacency table from scratch.
*/
CREATE TRIGGER ENG_PartAct_AfterUpdateTrigger ON ENG.PartAct 
AFTER INSERT,UPDATE,DELETE
AS 
BEGIN
	EXEC TRNS.ERP_PartActAdjacency;
END;

