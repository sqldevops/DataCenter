CREATE PROCEDURE LOAD.PROCACT_PartAct
--Nested procedure in EXTR.ERP_PROCACT for updating ENG.PartAct
AS
BEGIN


--1. Merge changes with ENG.PartAct
WITH cte AS
(
	SELECT T1.*
	FROM ENG.PartAct AS T1
	JOIN TRNS.PROCACT			AS T2 ON T2.T$PROC=T1.ProcessID AND T2.PART=T1.PartID
)
MERGE cte WITH (HOLDLOCK)				AS Target
USING	(SELECT	* FROM TRNS.PartAct)	AS Source
ON		(
			Target.ProcessID= Source.ProcessID	AND
			Target.ActID	= Source.ActID		AND
			Target.ActPos	= Source.ActPos
		)
WHEN NOT MATCHED BY Target THEN
INSERT	(
			PartID			,
			Part			,
			PartIsRoot		,
			PartIsActive	,
			ProcessID		,
			ActID			,
			Act				,
			ActPos			,
			PrevActID		,
			NextActID		,
			ActIsLast		,
			WorkCenterID	,
			WorkCenter		,
			stdTimeEmployee	,
			stdTimeMachine	,
			DateTimeStamp	,
			[Source]		
		)

VALUES	(
			Source.PartID			,
			Source.Part				,
			Source.PartIsRoot		,
			Source.PartIsActive		,
			Source.ProcessID		,
			Source.ActID			,
			Source.Act				,
			Source.ActPos			,
			Source.PrevActID		,
			Source.NextActID		,
			Source.ActIsLast		,
			Source.WorkCenterID		,
			Source.WorkCenter		,
			Source.stdTimeEmployee	,
			Source.stdTimeMachine	,
			GETDATE()				,
			'PROCACT'		
		)
WHEN NOT MATCHED BY Source THEN 
DELETE;

--2.
DELETE ENG.PartAct WHERE ActPos IS NULL;

END;
GO