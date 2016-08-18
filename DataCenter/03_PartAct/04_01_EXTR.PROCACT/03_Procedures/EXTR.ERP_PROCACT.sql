/*
This procedure executes 2 tasks :
	FIRST : Merge data into EXTR.PROCACT.
	SECOND: Refreshe (truncate and populate) TRNS.PartProcess table.
*/
CREATE PROCEDURE EXTR.ERP_PROCACT
AS
BEGIN
TRUNCATE TABLE TRNS.PartProcess;

DECLARE @Process AS TABLE (T$PROC INT);

--Insert all updated processes into @PartProcess
INSERT INTO @Process (T$PROC)	
SELECT	T1.T$PROC
FROM
(
--Merge data into EXTR.PROCACT
	MERGE EXTR.PROCACT_Target	WITH (HOLDLOCK)												AS Target	--TARGET
	USING 
		(																								--SOURCE
			SELECT	DISTINCT T1.T$PROC,																	--SOURCE
			T1.ACT,																						--SOURCE
			T1.POS,																						--SOURCE
			ROW_NUMBER()		OVER (PARTITION BY T1.T$PROC ORDER BY T1.POS)	AS ActPos				--SOURCE
			FROM [$(PriorityServer)].[$(PriorityDatabase)].dbo.PROCACT	AS T1							--SOURCE
			WHERE T1.ACT>0 OR T1.ACT=-8																	--SOURCE
		)																					AS Source	--SOURCE
	ON	(
			Target.T$PROC	= Source.T$PROC		AND
			Target.ACT		= Source.ACT		AND
			Target.POS		= Source.POS
		)
	WHEN NOT MATCHED BY Target THEN
		INSERT	(
					RowEffectiveDate,
					RowExpiryDate	,
					T$PROC			,		
					ACT				,			
					POS				,
					ActPos	
				)
		VALUES	(
					GETDATE()						,
					CAST ('99991231' AS DATETIME)	,
					Source.T$PROC					,		
					Source.ACT						,		
					Source.POS						,	
					Source.ActPos
				)
	WHEN NOT MATCHED BY Source THEN
		UPDATE SET	Target.RowExpiryDate	= GETDATE(),ActPos=NULL	
	OUTPUT	COALESCE(INSERTED.RowID	, DELETED.RowID)	,
			$action										,
			COALESCE(INSERTED.T$PROC, DELETED.T$PROC)	,		
			COALESCE(INSERTED.ACT	, DELETED.ACT)		,
			COALESCE(INSERTED.POS	, DELETED.POS)		,
			COALESCE(INSERTED.ActPos, DELETED.ActPos)
) AS T1	(
			RowID		,
			RowChange	,
			T$PROC		,
			ACT			,
			POS			,
			ActPos	
		);

--2. Populate EXTR.Processes : Processes that are connected to parts only.

INSERT INTO TRNS.PartProcess (PART,T$PROC)
SELECT DISTINCT T2.PART,T1.T$PROC
FROM @Process		AS T1
JOIN [$(PriorityServer)].[$(PriorityDatabase)].dbo.PART	AS T2 ON T2.T$PROC=T1.T$PROC;
END;
GO