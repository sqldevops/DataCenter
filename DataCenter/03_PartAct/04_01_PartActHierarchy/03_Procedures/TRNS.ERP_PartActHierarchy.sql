CREATE PROCEDURE TRNS.ERP_PartActHierarchy
AS
BEGIN
TRUNCATE TABLE TRNS.PartActHierarchy;
WITH cte AS
(	
	SELECT	  T1.SonPartActID															AS PartActID	
			 ,CAST('/' + CAST(T1.SonRowNum AS VARCHAR(10))+'/'		AS VARCHAR(900))	AS PartActBinPath
			 ,CAST('/' + CAST(T1.SonPartActID AS VARCHAR(10))+'/'	AS VARCHAR(900))	AS PartActBinRoot										
			 ,1																			AS PartActLev
			 ,T1.SonPartActCoef															AS PartActCoef
			 ,T1.SonActDays															AS ActDays
	FROM TRNS.PartActAdjacency		AS T1
	WHERE ParentPartActID IS NULL

	UNION ALL

	SELECT	 S.SonPartActID
			,CAST(PartActBinPath + CAST(S.SonRowNum AS VARCHAR(20)) + '/' AS VARCHAR(900))
			,P.PartActBinRoot
			,P.PartActLev+1
			,P.PartActCoef*S.SonPartActCoef
			,P.ActDays+S.SonActDays
	FROM cte			AS P
	JOIN TRNS.PartActAdjacency	AS S ON S.ParentPartActID=P.PartActID
) 
INSERT INTO TRNS.PartActHierarchy	(
										 PartActID
										,PartActBinPath
										,PartActBinRoot
										,PartActCoef
										,ActDays	
									)
SELECT	 T.PartActID
		,T.PartActBinPath
		,T.PartActBinRoot
		,T.PartActCoef
		,T.ActDays
FROM cte	AS T
WHERE T.PartActID IS NOT NULL;
END;
GO