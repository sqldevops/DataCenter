CREATE PROCEDURE EXTR.ERP_ORDERITEMS
AS
BEGIN 
--Find last update date in extraction target table
DECLARE @LastDate INT = ISNULL((SELECT TOP(1) UDATE FROM EXTR.ORDERITEMS ORDER BY UDATE DESC),0);

--Fetch latest updates from ERP system
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
								T$USER			,
								CLOSED		
							)
SELECT	ERP.calDateTime (T1.UDATE)		,
		CAST ('99991231' AS DATETIME)	,
		GETDATE()						,
		T1.ORDI							,
		T1.UDATE						,
		T2.ORD							,
		T2.ORDNAME						,
		T2.ORDSTATUS					,
		T3.ORDSTATUSDES					,
		T2.CUST							,
		T1.PART							,
		T1.QUANT						,
		T1.ABALANCE						,
		T1.DUEDATE						,
		T1.T$USER						,
		T1.CLOSED
FROM [$(PriorityServer)].[$(PriorityDatabase)].dbo.ORDERITEMS		AS T1
JOIN [$(PriorityServer)].[$(PriorityDatabase)].dbo.ORDERS			AS T2 ON T2.ORD	=	T1.ORD
JOIN [$(PriorityServer)].[$(PriorityDatabase)].dbo.ORDSTATUS			AS T3 ON T3.ORDSTATUS=T2.ORDSTATUS
WHERE	T2.ORDSTATUS	<>-6 
	AND T2.ORD			> 0 
	AND T2.CUST			<>940	--Afula warehouse
	AND T2.CUST			<>1009	--Alon tavor warehouse
	AND T2.CUST			<>1141	--Lod warehouse
	AND T1.PART			> 0
	AND T1.UDATE		> @LastDate;
END;
GO