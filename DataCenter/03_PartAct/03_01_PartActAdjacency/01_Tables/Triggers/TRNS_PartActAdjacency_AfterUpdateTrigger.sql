/*
This trigger executes TRNS.ERP_PartActHierarchy that rebuilds TRNS.PartActHierarchy table from scratch.
*/
CREATE TRIGGER TRNS_PartActAdjacency_AfterUpdateTrigger ON TRNS.PartActAdjacency
AFTER INSERT,UPDATE,DELETE
AS 
BEGIN
	EXEC TRNS.ERP_PartActHierarchy;
END;
GO
