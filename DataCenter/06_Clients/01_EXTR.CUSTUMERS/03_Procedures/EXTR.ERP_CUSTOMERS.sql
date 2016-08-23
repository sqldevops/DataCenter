CREATE PROCEDURE EXTR.ERP_CUSTOMERS
AS
BEGIN
--Fetch latest updates from ERP system
DECLARE @LastDate INT = ISNULL((SELECT TOP(1) UDATE FROM EXTR.CUSTOMERS ORDER BY UDATE DESC),0);

INSERT		INTO	EXTR.CUSTOMERS	(
													RowEffectiveDate
													,RowExpiryDate	
													,RowDateTimeStamp
													,CUST				
													,UDATE				
													,CUSTNAME			
													,CUSTDES			
													,CUSTSTAT			
													,STATDES			
													,COUNTRY			
													,COUNTRYNAME		
													,CURRENCY	
													,CODE		
													,CTYPE				
													,IVTYPE				
													,SPEC1				
													,SPEC2				
													,SPEC3				
													,SPEC6			
													,SPEC9	
												)
SELECT	ERP.calDateTime (T2.UDATE)
		,CAST ('99991231' AS DATETIME)
		,GETDATE()
		,T1.CUST
		,T2.UDATE
		,T1.CUSTNAME
		,T1.CUSTDES
		,T1.CUSTSTAT
		,T3.STATDES
		,T1.COUNTRY
		,T5.COUNTRYNAME
		,T1.CURRENCY
		,T6.CODE
		,T1.CTYPE
		,T1.IVTYPE
		,T4.SPEC1
		,T4.SPEC2
		,T4.SPEC3
		,T4.SPEC6
		,T4.SPEC9
FROM [$(PriorityServer)].[$(PriorityDatabase)].dbo.CUSTOMERS	AS T1
JOIN [$(PriorityServer)].[$(PriorityDatabase)].dbo.CUSTOMERSA	AS T2 ON T2.CUST=T1.CUST
JOIN [$(PriorityServer)].[$(PriorityDatabase)].dbo.CUSTSTATS	AS T3 ON T3.CUSTSTAT=T1.CUSTSTAT
JOIN [$(PriorityServer)].[$(PriorityDatabase)].dbo.CUSTSPEC		AS T4 ON T4.CUST=T1.CUST
JOIN [$(PriorityServer)].[$(PriorityDatabase)].dbo.COUNTRIES	AS T5 ON T5.COUNTRY=T1.COUNTRY
JOIN [$(PriorityServer)].[$(PriorityDatabase)].dbo.CURRENCIES	AS T6 ON T6.CURRENCY=T1.CURRENCY
WHERE  T2.UDATE>@LastDate AND T1.CUST>0;



END;
GO