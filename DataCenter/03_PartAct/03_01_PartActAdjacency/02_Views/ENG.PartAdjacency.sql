CREATE VIEW ENG.PartAdjacency
AS
SELECT  distinct	t3.PartID			as sonPartID,
		t2.PartID			as parentPartID,
		t3.Part				as sonPart
FROM TRNS.PartActAdjacency	as t1
LEFT JOIN ENG.PartAct		as t2 on t2.PartActID=t1.ParentPartActID
LEFT JOIN ENG.PartAct		as t3 on t3.PartActID=t1.SonPartActID
LEFT JOIN ENG.Parts			as t4 on t4.PartID=t3.PartID
where t4.PartType='P' and t3.WorkCenterID<>114 and t4.FamilyID<>265

GO