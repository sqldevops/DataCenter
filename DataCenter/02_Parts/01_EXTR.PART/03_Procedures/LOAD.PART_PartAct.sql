CREATE PROCEDURE LOAD.PART_PartAct
AS 
BEGIN
--In cele.dbo.PART changes are in the level of PART (T$PROC changes for a PART)
--In cele.dbo.PROCACT changes are in the level of the process (ACT changes for T$PROC)

--Delete from ENG.PartAct all Part row/s
DELETE T1
FROM ENG.PartAct T1
JOIN TRNS.PartProcess T2 on T2.PART=T1.PartID;

--Insert new data row/s
with cte as
(
SELECT	T4.PART															AS PartID			,
		T4.PARTNAME														AS Part				,
		T2.T$PROC														AS ProcessID		,
		T2.ACT															AS ActID			,
		T5.ACTNAME														AS Act				,
		IIF(T4.PARTSTAT=1 OR T4.PARTSTAT=-2,0,1)						AS PartIsActive		,
		T2.POS																				,													
		T6.WORKC														AS WorkCenterID		,
		T6.WORKCNAME													AS WorkCenter		,
		LAG(T2.ACT,1,0)  OVER (PARTITION BY T2.T$PROC ORDER BY T2.POS)	AS PrevActID		,
		LEAD(T2.ACT,1,0) OVER (PARTITION BY T2.T$PROC ORDER BY T2.POS)	AS NextActID		,
		LAST_VALUE(T2.ACT) OVER (
									PARTITION BY T2.T$PROC 
									ORDER BY T2.POS ROWS 
									BETWEEN UNBOUNDED PRECEDING 
									AND		UNBOUNDED FOLLOWING
								)										AS LastActId		,
		T7.stdTimeEmployee												AS stdTimeEmployee	,
		T7.stdTimeMachine												AS stdTimeMachine
FROM TRNS.PartProcess				AS T1
JOIN [APC-DB1\TEST].[cele].dbo.PROCACT			AS T2 ON T2.T$PROC=T1.T$PROC
JOIN [APC-DB1\TEST].[cele].dbo.PART				AS T4 ON T4.T$PROC=T1.T$PROC AND T4.PART=T1.PART
JOIN [APC-DB1\TEST].[cele].dbo.ACT				AS T5 ON T5.ACT=T2.ACT
JOIN [APC-DB1\TEST].[cele].dbo.WORKC			AS T6 ON T6.WORKC=T5.WORKC
--Left join is required, not all Act std Time is updated/syncronized !!!
LEFT JOIN TRNS.PartActStdTime()	AS T7 ON T7.PartID=T4.PART AND T7.ActID=T5.ACT	
WHERE  T5.ACT	>0
)
insert into ENG.PartAct	(
							PartID			,
							Part			,
							ProcessID		,
							ActID			,
							Act				,
							PartIsActive	,
							ActPos			,
							WorkCenterID	,
							WorkCenter		,
							PrevActID		,
							NextActID		,
							ActIsLast		,
							stdTimeEmployee	,
							stdTimeMachine	,
							DateTimeStamp	,
							Originator		
							)
SELECT	PartID			,
		Part			,
		ProcessID		,
		ActID			,
		Act				,
		PartIsActive	,
		ROW_NUMBER()	OVER (PARTITION BY PartID,ProcessID ORDER BY POS) ,
		WorkCenterID	,
		WorkCenter		,
		PrevActID		,
		NextActID		,
		IIF(LastActId=ActID,1,0)	,
		stdTimeEmployee	,
		stdTimeMachine	,
		GETDATE()		,
		'PROCACT'		
from cte;
END;