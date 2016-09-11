/*
This procedure updates ENG.PartAct target table, with changes accur in cele.dbo.PART that effect Process.
The procedure is fired by EXTR.PART_InsteadOfTrigger.
*/
CREATE PROCEDURE LOAD.PART_PartAct
AS 
BEGIN
--In cele.dbo.PART changes are in the level of PART (T$PROC changes for a PART)
--In cele.dbo.PROCACT changes are in the level of the process (ACT changes for T$PROC)

--Delete from ENG.PartAct all Part row/s
DELETE T1
FROM ENG.PartAct T1
JOIN TRNS.PROCACT T2 on T2.PART=T1.PartID;

--Insert new data row/s

INSERT INTO ENG.PartAct	(
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
							Source		
							)
SELECT	PartID			,
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
		GETDATE()		,
		'PART'		
FROM TRNS.PartAct
END;
GO