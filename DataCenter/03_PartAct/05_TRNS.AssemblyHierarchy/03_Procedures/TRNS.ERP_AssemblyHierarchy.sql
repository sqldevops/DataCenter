CREATE PROCEDURE TRNS.ERP_AssemblyHierarchy
AS
BEGIN
TRUNCATE TABLE TRNS.AssemblyHierarchy;
INSERT INTO  TRNS.AssemblyHierarchy	(
										 PartID
										,AssemblyBinPath
									)
SELECT	 T3.PartAssemblyID																		AS PartID
		,T3.PartAssemblyBinPath.GetReparentedValue(CAST('/' AS HIERARCHYID),T1.PartActBinPath)	AS AssemblyBinPath
FROM TRNS.PartActHierarchy							AS T1	
JOIN TRNS.PartActAdjacency							AS T2 ON T2.ParentPartActID=T1.PartActID			
CROSS APPLY (
				SELECT	 PartAssemblyID
						,PartAssemblyBinPath
				FROM TRNS.PartActAssembly
				WHERE T2.SonPartActID=PartActID
			)										AS T3


END;
GO