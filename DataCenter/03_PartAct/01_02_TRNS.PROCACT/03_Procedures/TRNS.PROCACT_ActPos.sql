/*
This procedure is fired by TRNS.PartProcess_AfterInsertTrigger ON TRNS.PartProcess
*/
CREATE PROCEDURE TRNS.PROCACT_ActPos 
AS
BEGIN

--1. Recalculate and Update ActPos for all Acts of the Process that was updated.
	WITH cte AS
	(
		SELECT	T1.T$PROC,
				T1.ACT,
				ROW_NUMBER()	OVER (PARTITION BY T1.T$PROC ORDER BY T1.POS) AS ActPos
		FROM ERP.PROCACT	AS T1
	)
	UPDATE ERP.PROCACT
	SET ActPos=T2.ActPos
	FROM ERP.PROCACT		AS T1
	JOIN cte				AS T2 ON T2.T$PROC=T1.T$PROC AND T1.ACT=T2.ACT
	JOIN TRNS.PROCACT	AS T3 ON  T3.T$PROC=T1.T$PROC;

--2. Truncate TRNS.PartProcess after finishing using it.
	--TRUNCATE TABLE TRNS.PartProcess;

END;
--Nested procedure in EXTR.ERP_PROCACT for recalculating ActPos
GO