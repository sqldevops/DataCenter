CREATE PROCEDURE TRNS.ERP_PartActAssembly
AS
TRUNCATE TABLE TRNS.PartActAssembly;
INSERT INTO TRNS.PartActAssembly	(
										 PartActID
										,AssemblyPartID
										,AssemblyBinPath
									)
SELECT	 T1.PartActID
		,T2.SON	
		,CAST('/'+ CAST(ROW_NUMBER() OVER (PARTITION BY T1.PartActID ORDER BY T2.SON) AS VARCHAR(3)) +'/' AS HIERARCHYID) 
FROM ENG.PartAct											AS T1
JOIN [$(PriorityServer)].[$(PriorityDatabase)].dbo.PARTARC	AS T2 ON T2.PART=T1.PartID AND T2.ACT=T1.ActID
WHERE T2.SONACT=-3;
GO