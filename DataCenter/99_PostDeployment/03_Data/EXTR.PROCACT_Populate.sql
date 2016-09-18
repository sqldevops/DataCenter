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
FROM [$(ETL_Server)].[$(ETL_Database)].EXTR.PROCACT;
GO
ENABLE TRIGGER EXTR.PROCACT_AfterUpdateTrigger ON EXTR.PROCACT;
GO