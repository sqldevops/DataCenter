DISABLE TRIGGER [EXTR].[ORDERITEMS_AfterInsertTrigger] ON [EXTR].[ORDERITEMS] ;
DISABLE TRIGGER [EXTR].[ORDERITEMS_InsteadOfTrigger] ON [EXTR].[ORDERITEMS] ;
GO

INSERT INTO EXTR.ORDERITEMS	(
								RowEffectiveDate	,
								RowExpiryDate		,
								RowDateTimeStamp	,
								ORDI				,
								UDATE				,
								ORD					,
								ORDNAME				,
								ORDSTATUS			,
								ORDSTATUSDES		,
								CUST				,
								PART				,
								QUANT				,
								ABALANCE			,
								DUEDATE				,
								T$USER				,
								CLOSED				
							)
SELECT RowEffectiveDate		,
		RowExpiryDate		,						
	   RowDateTimeStamp		,
	   ORDI					,
	   UDATE				,
	   ORD					,
	   ORDNAME				,
	   ORDSTATUS			,
	   ORDSTATUSDES			,
	   CUST					,
	   PART					,
	   QUANT				,
	   ABALANCE				,
	   DUEDATE				,
	   T$USER				,
	   CLOSED				
FROM [$(ETL_Server)].[$(ETL_Database)].EXTR.ORDERITEMS;

ENABLE TRIGGER [EXTR].[ORDERITEMS_AfterInsertTrigger] ON [EXTR].[ORDERITEMS] ;
ENABLE TRIGGER [EXTR].[ORDERITEMS_InsteadOfTrigger] ON [EXTR].[ORDERITEMS] ;
GO