CREATE PROCEDURE TRNS.ERP_AssemblyHierarchy
AS
BEGIN
TRUNCATE TABLE TRNS.AssemblyHierarchy;
INSERT INTO  TRNS.AssemblyHierarchy	(
										AssemblyPartID	,
										AssemblyPart	,
										AssemblyBinPath
									)
SELECT 	T1.AssemblyPartID	,
		T1.AssemblyPart		,
		T1.AssemblyBinPath.GetReparentedValue(CAST('/' AS HIERARCHYID),T2.PartActBinPath)	
FROM ENG.PartActAssembly	AS T1
JOIN ENG.PartActHierarchy	AS T2 ON T2.PartActID=T1.PartActID
END;
GO

