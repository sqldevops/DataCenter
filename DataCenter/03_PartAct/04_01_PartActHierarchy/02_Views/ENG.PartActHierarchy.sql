CREATE VIEW ENG.PartActHierarchy
AS
SELECT	--T1.PartActBinPath	,
		--T1.PartActBinRoot	,
		T3.PartActID	AS RootPartActID		,
		T1.PartActID		,
		T2.PartID			,
		T2.Part				,
		T2.ActID			,
		T2.Act				,
		T2.WorkCenterID		,
		T2.WorkCenter		,
		T1.PartActBinPath	,
		T1.PartActBinPath.ToString() AS PartActPath,
		T1.PartActBinPath.GetLevel() AS PartActLevel
FROM TRNS.PartActHierarchy	AS T1
JOIN ENG.PartAct			AS T2 ON T1.PartActID=T2.PartActID
JOIN ENG.PartAct			AS T3 ON T3.PartActBin=T1.PartActBinRoot;
GO