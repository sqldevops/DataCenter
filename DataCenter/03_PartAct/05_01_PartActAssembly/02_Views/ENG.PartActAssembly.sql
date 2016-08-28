CREATE VIEW ENG.PartActAssembly
AS
SELECT	T1.AssemblyPartActID	,
		T1.PartActID			,
		T2.PartID				,
		T2.Part					,
		T2.ActID				,
		T2.Act					,
		T2.ActPos				,
		T1.AssemblyPartID		,
		T3.Part	 AS AssemblyPart,
		T1.AssemblyBinPath	,
		T1.AssemblyBinPath.ToString() AS  AssemblyPath
FROM TRNS.PartActAssembly	AS T1
JOIN ENG.PartAct			AS T2 ON T2.PartActID=T1.PartActID
JOIN ENG.Parts				AS T3 ON T3.PartID=T1.AssemblyPartID