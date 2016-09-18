--Disable triggers on EXTR.SERIAL 
DISABLE TRIGGER [EXTR].[SERIAL_AfterInsertTrigger] ON EXTR.SERIAL ;
DISABLE TRIGGER [EXTR].[SERIAL_InsteadOfTrigger] ON EXTR.SERIAL; 

--Populate table (RowID is identity)
INSERT INTO	EXTR.SERIAL	(
							RowEffectiveDate	,	
							RowExpiryDate		,
							RowDateTimeStamp	,
							SERIAL				,
							UDATE				,
							SERIALNAME			,
							SERIALDES			,
							SERIALSTATUS		,
							SERIALSTATUSDES		,
							PSDATE				,
							PART				,
							CLOSED				,
							PEDATE				,
							QUANT				,
							CURDATE				,
							CLOSEDATE			,
							T$USER			
						)
SELECT						RowEffectiveDate	,	
							RowExpiryDate		,
							RowDateTimeStamp	,
							SERIAL				,
							UDATE				,
							SERIALNAME			,
							SERIALDES			,
							SERIALSTATUS		,
							SERIALSTATUSDES		,
							PSDATE				,
							PART				,
							CLOSED				,
							PEDATE				,
							QUANT				,
							CURDATE				,
							CLOSEDATE			,
							T$USER			
FROM [$(ETL_Server)].[$(ETL_Database)].EXTR.SERIAL;

--Enable triggers on EXTR.SERIAL 
ENABLE TRIGGER [EXTR].[SERIAL_AfterInsertTrigger] ON EXTR.SERIAL ;
ENABLE TRIGGER [EXTR].[SERIAL_InsteadOfTrigger] ON EXTR.SERIAL; 
