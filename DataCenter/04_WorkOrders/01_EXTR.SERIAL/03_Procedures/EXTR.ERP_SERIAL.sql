CREATE PROCEDURE EXTR.ERP_SERIAL
AS
BEGIN

--Find last update date in extraction target table
DECLARE @LastDate INT = ISNULL((SELECT TOP(1) UDATE FROM EXTR.SERIAL ORDER BY UDATE DESC),0);

--Fetch latest updates from ERP system
INSERT INTO EXTR.SERIAL (	
						 RowEffectiveDate	
						,RowExpiryDate
						,RowDateTimeStamp	
						,SERIAL
						,UDATE
						,SERIALNAME
						,SERIALDES
						,SERIALSTATUS
						,SERIALSTATUSDES
						,PSDATE
						,PART
						,CLOSED
						,PEDATE
						,QUANT
						,CURDATE
						,CLOSEDATE
						,T$USER
						)
SELECT	 ERP.calDateTime (T1.UDATE)
		,CAST ('99991231' AS DATETIME)
		,GETDATE()
		,T1.SERIAL
		,T1.UDATE
		,T1.SERIALNAME
		,T1.SERIALDES
		,T2.SERIALSTATUS
		,T3.SERIALSTATUSDES
		,T1.PSDATE
		,T1.PART
		,T1.CLOSED
		,T1.PEDATE
		,T1.QUANT
		,T1.CURDATE
		,T1.CLOSEDATE
		,T1.T$USER
FROM [$(PriorityServer)].[$(PriorityDatabase)].dbo.SERIAL		AS T1
JOIN [$(PriorityServer)].[$(PriorityDatabase)].dbo.SERIALA		AS T2 ON T1.SERIAL=T2.SERIAL
JOIN [$(PriorityServer)].[$(PriorityDatabase)].dbo.SERIALSTATUS	AS T3 ON T3.SERIALSTATUS=T2.SERIALSTATUS
JOIN [$(PriorityServer)].[$(PriorityDatabase)].dbo.PART			AS T4 ON T4.PART=T1.PART
WHERE  T1.UDATE>@LastDate AND T4.TYPE='P' AND T2.SERIALSTATUS<>8 ;	--to filter out WMS data only P type parts
END;

--EXEC EXTR.ERP_SERIAL;
GO