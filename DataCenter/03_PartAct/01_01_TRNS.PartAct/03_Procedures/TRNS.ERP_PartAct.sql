CREATE PROCEDURE TRNS.ERP_PartAct
AS
BEGIN
TRUNCATE TABLE TRNS.PartAct;
WITH cte AS
(
SELECT	T1.PART														AS PartID		,										
		T1.PARTNAME													AS Part			,
		T2.T$PROC													AS ProcessID	,								
		T3.ACT														AS ActID		,
		T3.ACTNAME													AS Act			,
		ROW_NUMBER() OVER (PARTITION BY T1.PART ORDER BY T2.POS)	AS ActPos		,
		T4.WORKC													AS WorkCenterID	,
		T4.WORKCNAME												AS WorkCenter	,
		LAG(T3.ACT,1,0) OVER (PARTITION BY T1.PART ORDER BY T2.POS)	AS PreActID		,
		IIF(T2.ACTCANCEL='Y',1,0)									AS ActIsLast	,					
		T5.stdTimeEmployee															,
		T5.stdTimeMachine															,
		IIF(T6.PART IS NULL,0,1)									AS IsRoot  --Part level

FROM [$(PriorityServer)].[$(PriorityDatabase)].dbo.PART				AS T1
JOIN [$(PriorityServer)].[$(PriorityDatabase)].dbo.PROCACT			AS T2 ON T1.T$PROC	= T2.T$PROC 
JOIN [$(PriorityServer)].[$(PriorityDatabase)].dbo.ACT				AS T3 ON T3.ACT		= T2.ACT
JOIN [$(PriorityServer)].[$(PriorityDatabase)].dbo.WORKC			AS T4 ON T4.WORKC	= T3.WORKC
LEFT JOIN TRNS.PartActStdTime()			AS T5 ON T5.PartID	= T1.PART AND T5.ActID=T2.ACT 
OUTER APPLY	(
				 SELECT PART 
				 FROM TRNS.PartTopBom()		
				 WHERE PART=T1.PART
			)							AS T6
WHERE	T3.ACT>0 
	OR	T3.ACT=-8 --Phanto is also considered as act from engineering prespective (not for logistic)
)
INSERT INTO TRNS.PartAct	(
								PartID			,	
								Part			,
								ProcessID		,	
								ActID			,	
								Act				,
								ActPos			,
								WorkCenterID	,	
								WorkCenter		,
								PreActID		,	
								ActIsLast		,		
								stdTimeEmployee	,
								stdTimeMachine	,
								PartActDays		,
								IsRoot
							)
SELECT	PartID								,			
		T1.Part								,	
		T1.ProcessID						,			
		T1.ActID							,
		T1.Act								,
		T1.ActPos							,
		T1.WorkCenterID						,
		T1.WorkCenter						,
		T1.PreActID							,
		T1.ActIsLast						,
		T1.stdTimeEmployee					,
		T1.stdTimeMachine					,
		IIF(T1.WorkCenterID=114,10,1)		,
		IIF(T1.IsRoot=1 AND ActPos=1,1,0)		--Part-Act level
FROM cte AS T1;
END;
GO