CREATE VIEW ENG.PartActAdjacency
AS
SELECT	t1.ParentPartActID	,
		t2.PartID			as parentPartID,
		t2.Part				as parentPart,
		t1.SonPartActID		,
		t3.PartID			as sonPartID,
		t3.Part				as sonPart
FROM TRNS.PartActAdjacency	as t1
LEFT JOIN ENG.PartAct		as t2 on t2.PartActID=t1.ParentPartActID
LEFT JOIN ENG.PartAct		as t3 on t3.PartActID=t1.SonPartActID;
GO