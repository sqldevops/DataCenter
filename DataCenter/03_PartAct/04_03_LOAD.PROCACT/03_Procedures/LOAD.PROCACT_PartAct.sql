CREATE PROCEDURE LOAD.PROCACT_PartAct
--Nested procedure in EXTR.ERP_PROCACT for updating ENG.PartAct
AS
BEGIN


--3. Merge changes with ENG.PartAct
WITH cte AS
(
	SELECT *
	FROM ENG.PartAct AS T1
	JOIN TRNS.PartProcess			AS T2 ON T2.T$PROC=T1.ProcessID AND T2.PART=T1.PartID
)
MERGE cte WITH (HOLDLOCK)																					AS Target
USING	(
			SELECT	T4.PART															AS PartID			,
					T4.PARTNAME														AS Part				,
					T2.T$PROC														AS ProcessID		,
					T2.ACT															AS ActID			,
					T5.ACTNAME														AS Act				,
					IIF(T4.PARTSTAT=1 OR T4.PARTSTAT=-2,0,1)						AS PartIsActive		,
					T2.ActPos														AS ActPos			,
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
			JOIN EXTR.PROCACT				AS T2 ON T2.T$PROC=T1.T$PROC
			JOIN [$(PriorityServer)].[$(PriorityDatabase)].dbo.PART				AS T4 ON T4.T$PROC=T1.T$PROC AND T4.PART=T1.PART
			JOIN [$(PriorityServer)].[$(PriorityDatabase)].dbo.ACT				AS T5 ON T5.ACT=T2.ACT
			JOIN [$(PriorityServer)].[$(PriorityDatabase)].dbo.WORKC				AS T6 ON T6.WORKC=T5.WORKC
			--Left join is required, not all Act std Time is updated/syncronized !!!
			LEFT JOIN TRNS.PartActStdTime()	AS T7 ON T7.PartID=T4.PART AND T7.ActID=T5.ACT	 
			WHERE T2.RowExpiryDate>GETDATE() 
		)																										AS Source
ON		(
			Target.ProcessID= Source.ProcessID	AND
			Target.ActID	= Source.ActID		AND
			Target.ActPos	= Source.ActPos
		)
WHEN NOT MATCHED BY Target THEN
INSERT	(
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

VALUES	(
			Source.PartID			,
			Source.Part				,
			Source.ProcessID		,
			Source.ActID			,
			Source.Act				,
			Source.PartIsActive		,
			Source.ActPos			,
			Source.WorkCenterID		,
			Source.WorkCenter		,
			Source.PrevActID		,
			Source.NextActID		,
			IIF(Source.LastActId=Source.ActID,1,0)	,
			Source.stdTimeEmployee	,
			Source.stdTimeMachine	,
			GETDATE()				,
			'PROCACT'		
		)
WHEN NOT MATCHED BY Source THEN 
DELETE;
DELETE ENG.PartAct WHERE ActPos IS NULL;
END;
GO