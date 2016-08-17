﻿CREATE PROCEDURE TRNS.ERP_PartActAdjacency
AS 
BEGIN
TRUNCATE TABLE TRNS.PartActAdjacency;
WITH cte AS
(
--Root Parts
SELECT				 NULL			AS ParentPartActID
					,NULL			AS ParentID 
					,T.PartActID	AS SonPartActID
					,T.PartID		AS SonID
					,1				AS SonPartActCoef
					,T.PartActDays	AS SonPartActDays			
FROM TRNS.PartAct AS T
WHERE T.IsRoot=1
		
UNION ALL

--Linking two different parts (using PARTARC)
SELECT DISTINCT		 T3.PartActID	AS ParentPartActID
					,T3.PartID		AS ParentID
					,T4.PartActID	AS SonPartActID
					,T1.SON			AS SonID
					,T1.COEF		AS SonPartActCoef
					,T4.PartActDays	AS SonPartActDays
FROM [$(PriorityServer)].[$(PriorityDatabase)].dbo.PARTARC		AS T1
JOIN TRNS.PartAct					AS T3 ON T3.PartID	= T1.PART	AND T3.ActPos=1
JOIN TRNS.PartAct					AS T4 ON T4.PartID	= T1.SON	AND T4.ActIsLast=1

UNION ALL 

--Same part (using PartAct)
SELECT	 T1.PartActID	AS ParentPartActID
		,T1.PartID		AS ParentID
		,T2.PartActID	AS SonPartActID
		,T2.PartID		AS SonID
		,1				AS SonPartActCoef
		,T2.PartActDays	AS SonPartActDays
FROM TRNS.PartAct		AS T1
JOIN TRNS.PartAct		AS T2 ON	T2.PartID=T1.PartID AND	T2.ActID=T1.PreActID

--Edge parts
UNION ALL

SELECT	 T2.PartActID	AS ParentPartActID
		,T1.PART		AS ParentID
		,NULL			AS SonPartActID
		,NULL			AS SonID
		,NULL			AS SonPartActCoef
		,NULL			AS SonPartActDays
FROM [$(PriorityServer)].[$(PriorityDatabase)].dbo.PARTARC	AS T1
CROSS APPLY	(
				SELECT PartActID 
				FROM TRNS.PartAct
				WHERE PartID=T1.PART AND ActID=T1.ACT
			)		AS T2
GROUP BY T2.PartActID,T1.PART,T1.ACT
HAVING SUM(IIF(T1.SONACT<>-3,1,0))=0

--
)
INSERT INTO TRNS.PartActAdjacency	(
										 ParentPartActID
										,SonPartActID
										,SonRowNum
										,SonPartActCoef
										,SonPartActDays
									)
SELECT	 T.ParentPartActID
		,T.SonPartActID
		,ROW_NUMBER() OVER(PARTITION BY T.ParentID ORDER BY T.SonID)
		,T.SonPartActCoef
		,T.SonPartActDays
FROM cte AS T;


END;