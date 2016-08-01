CREATE PROCEDURE EXTR.ERP_PART
AS
BEGIN 
--Find last update date in extraction target table
DECLARE @LastDate INT = ISNULL((SELECT TOP(1) UDATE FROM EXTR.PART ORDER BY UDATE DESC),0);

--Fetch latest updates from ERP system
INSERT INTO EXTR.PART	(
							 RowEffectiveDate
							,RowExpiryDate	
							,RowDateTimeStamp
							,PART				
							,UDATE				
							,PARTNAME
							,PARTDES
							,EPARTDES			
							,TYPE				
							,T$PROC	
							,PROCNAME		
							,FAMILY	
							,FAMILYNAME
							,FAMILYDES		
							,PARTSTAT	
							,STATDES
							,SPEC3
							,SPEC4
							,SPEC8
							,SPEC10
							,SPEC19
							)
SELECT	 ERP.calDateTime (T1.UDATE)
		,CAST ('99991231' AS DATETIME)
		,GETDATE()
		,T1.PART				
		,T1.UDATE				
		,T1.PARTNAME	
		,T1.PARTDES	
		,T6.EPARTDES		
		,T1.TYPE				
		,T1.T$PROC	
		,T3.PROCNAME		
		,T1.FAMILY	
		,T5.FAMILYNAME
		,T5.FAMILYDES	
		,T1.PARTSTAT	
		,T2.STATDES
		,T4.SPEC3
		,T4.SPEC4
		,T4.SPEC8
		,T4.SPEC10		
		,T4.SPEC19	
FROM [$(PriorityServer)].[$(PriorityDatabase)].dbo.PART			AS T1
JOIN [$(PriorityServer)].[$(PriorityDatabase)].dbo.PARTSTATS		AS T2 ON T2.PARTSTAT	= T1.PARTSTAT
JOIN [$(PriorityServer)].[$(PriorityDatabase)].dbo.PROCESS		AS T3 ON T3.T$PROC		= T1.T$PROC
LEFT JOIN [$(PriorityServer)].[$(PriorityDatabase)].dbo.PARTSPEC	AS T4 ON T4.PART		= T1.PART
JOIN [$(PriorityServer)].[$(PriorityDatabase)].dbo.FAMILY		AS T5 ON T5.FAMILY		= T1.FAMILY
JOIN [$(PriorityServer)].[$(PriorityDatabase)].dbo.PARTDES		AS T6 ON T6.PART		= T1.PART
WHERE  T1.UDATE>@LastDate AND T1.PART>0 ;
END;

GO