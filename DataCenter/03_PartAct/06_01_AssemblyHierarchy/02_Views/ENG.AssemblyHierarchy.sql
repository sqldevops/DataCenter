CREATE VIEW ENG.AssemblyHierarchy
AS
SELECT	T1.AssemblyPartID	,
		T1.AssemblyPart		,
		T1.AssemblyBinPath	,
		T1.AssemblyBinPath.ToString() AS AssemblyPath	,
		T2.*
FROM TRNS.AssemblyHierarchy	AS T1
JOIN ENG.PartActHierarchy	AS T2 ON T2.PartActBinPath=T1.[AssemblyBinPath].GetAncestor(1)
GO