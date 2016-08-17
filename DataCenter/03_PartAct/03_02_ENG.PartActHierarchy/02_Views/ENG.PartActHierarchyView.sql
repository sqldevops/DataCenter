CREATE VIEW ENG.PartActHierarchyView
AS
SELECT	 T2.PartActID		AS PartActID
		,T2.PartID			AS PartID
		,T2.Part			AS Part
		,T2.ActID			AS ActID
		,T2.Act				AS Act
		,T2.WorkCenterID	AS SonWorkCenterID
		,T2.WorkCenter		AS SonWorkCenter
		,T1.PartActCoef
		,T1.PartActDays
		,T1.PartActBinPath
		,T1.PartActLev
		,T1.PartActBinRoot
FROM ENG.PartActHierarchy	AS T1
LEFT JOIN ENG.PartAct		AS T2 ON T2.PartActID=T1.PartActID
GO