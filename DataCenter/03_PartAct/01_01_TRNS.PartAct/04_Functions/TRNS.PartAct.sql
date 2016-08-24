
/*
This function outputs updated PartAct rows
This function is used by LOAD.PROCACT_PartAct, LOAD.PART_PartAct procedures.
*/
CREATE FUNCTION TRNS.PartAct()
RETURNS @view TABLE
(			
	 PartID				INT							NOT NULL
	,Part				VARCHAR(22)			
	,PartIsRoot			BIT	
	,PartIsActive		BIT	
	,ProcessID			INT							NOT NULL		
	,ActID				INT							NOT NULL
	,Act				VARCHAR(10)									
	,ActPos				INT											--POS column in Priority								
	,PrevActID			INT		
	,NextActID			INT				
	,ActIsLast			BIT 
	,WorkCenterID		INT					
	,WorkCenter			VARCHAR(6)	
	,stdTimeEmployee	FLOAT 
	,stdTimeMachine		FLOAT

)
AS
BEGIN

WITH cte AS
(
SELECT	T4.PART															AS PartID			,
		T4.PARTNAME														AS Part				,
		IIF(T8.PART IS NULL,0,1)										AS PartIsRoot		,
		IIF(T4.PARTSTAT=1 OR T4.PARTSTAT=-2,0,1)						AS PartIsActive		,
		T2.T$PROC														AS ProcessID		,
		T2.ACT															AS ActID			,
		T5.ACTNAME														AS Act				,
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
JOIN [APC-DB1\TEST].[cele].dbo.PROCACT	AS T2 ON T2.T$PROC=T1.T$PROC
JOIN [APC-DB1\TEST].[cele].dbo.PART		AS T4 ON T4.T$PROC=T1.T$PROC AND T4.PART=T1.PART
JOIN [APC-DB1\TEST].[cele].dbo.ACT		AS T5 ON T5.ACT=T2.ACT
JOIN [APC-DB1\TEST].[cele].dbo.WORKC	AS T6 ON T6.WORKC=T5.WORKC
LEFT JOIN TRNS.PartActStdTime()			AS T7 ON T7.PartID=T4.PART AND T7.ActID=T5.ACT	--Left join is required, not all Act std Time is updated/syncronized !!!
OUTER APPLY	(
				 SELECT PART 
				 FROM TRNS.PartTopBom()		
				 WHERE PART=T1.PART
			)							AS T8
WHERE  T5.ACT	>0
)
INSERT @view (
				 PartID			
				,Part			
				,PartIsRoot		
				,PartIsActive	
				,ProcessID		
				,ActID			
				,Act			
				,ActPos			
				,PrevActID		
				,NextActID		
				,ActIsLast		
				,WorkCenterID	
				,WorkCenter		
				,stdTimeEmployee
				,stdTimeMachine	
			)
SELECT			 PartID			
				,Part			
				,PartIsRoot		
				,PartIsActive	
				,ProcessID		
				,ActID			
				,Act			
				,ROW_NUMBER()	OVER (PARTITION BY PartID,ProcessID ORDER BY POS)	AS ActPos	
				,PrevActID		
				,NextActID		
				,IIF(LastActId=ActID,1,0)											AS ActIsLast		
				,WorkCenterID	
				,WorkCenter		
				,stdTimeEmployee
				,stdTimeMachine	
			
FROM cte

RETURN;
END;