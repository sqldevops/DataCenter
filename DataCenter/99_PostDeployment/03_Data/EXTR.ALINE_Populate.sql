DISABLE TRIGGER [EXTR].[ALINE_AfterInsertTrigger] ON [EXTR].[ALINE];
DISABLE TRIGGER [EXTR].[ALINE_InsteadOfTrigger] ON [EXTR].[ALINE];

INSERT INTO EXTR.ALINE	(
							RowEffectiveDate	,	
							RowExpiryDate		,
							RowDateTimeStamp	,
							AL					,
							UDATE				,
							FORM				,
							FORMNAME			,
							SERIAL				,
							PART				,
							ACT					,
							SERCANCEL			,
							CURDATE				,
							QUANT				,
							SQUANT				,
							EMPEDATE			,
							EMPSDATE			,
							EMPASPAN			,
							WORKC				,
							SERN	
						)			
SELECT RowEffectiveDate		,
	   RowExpiryDate		,
	   RowDateTimeStamp		,
	   AL					,
	   UDATE				,
	   FORM					,
	   FORMNAME				,
	   SERIAL				,
	   PART					,
	   ACT					,
	   SERCANCEL			,
	   CURDATE				,
	   QUANT				,
	   SQUANT				,
	   EMPEDATE				,
	   EMPSDATE				,
	   EMPASPAN				,
	   WORKC				,
	   SERN	
FROM [$(ETL_Server)].[$(ETL_Database)].EXTR.ALINE;			
GO

ENABLE TRIGGER [EXTR].[ALINE_AfterInsertTrigger] ON [EXTR].[ALINE];
ENABLE TRIGGER [EXTR].[ALINE_InsteadOfTrigger] ON [EXTR].[ALINE];
GO