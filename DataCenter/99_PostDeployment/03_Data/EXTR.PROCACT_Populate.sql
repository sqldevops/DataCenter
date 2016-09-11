DISABLE TRIGGER EXTR.PROCACT_AfterUpdateTrigger ON EXTR.PROCACT;
GO

INSERT INTO EXTR.PROCACT	(
								RowEffectiveDate	,	
								RowExpiryDate		,
								T$PROC				,
								ACT					,
								POS					,
								ActPos			
							)
SELECT 							RowEffectiveDate	,	
								RowExpiryDate		,
								T$PROC				,
								ACT					,
								POS					,
								ActPos			
FROM ETL.EXTR.PROCACT;
GO
ENABLE TRIGGER EXTR.PROCACT_AfterUpdateTrigger ON EXTR.PROCACT;
GO