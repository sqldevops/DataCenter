CREATE TRIGGER EXTR.CUSTOMERS_InsteadOfTrigger ON EXTR.CUSTOMERS 
INSTEAD OF INSERT
AS
BEGIN
--1. Update expiry date for exsisting rows
WITH cte AS
(
	SELECT T1.* 
	FROM EXTR.CUSTOMERS	AS T1
	JOIN inserted	AS T2 ON T2.CUST=T1.CUST
	CROSS APPLY
	(
		SELECT TOP(1)	 RowID	AS ExpiredRowID
						,UDATE	AS ExpiredRowDate
		FROM	EXTR.CUSTOMERS 
		WHERE	CUST=T1.CUST 
		ORDER BY UDATE DESC
	)							AS T3
	WHERE T1.RowID=T3.ExpiredRowID
)
UPDATE EXTR.CUSTOMERS 
SET RowExpiryDate=cte.RowDateTimeStamp,RowDateTimeStamp=GETDATE()
FROM cte 
WHERE EXTR.CUSTOMERS.RowID=cte.RowID;

--2.  Inserting new rows
INSERT	INTO EXTR.CUSTOMERS	(	
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
SELECT				 ERP.calDateTime (T1.UDATE)
					,CAST ('99991231' AS DATETIME)
					,GETDATE()
					,T1.CUST				
					,T1.UDATE				
					,T1.CUSTNAME			
					,T1.CUSTDES			
					,T1.CUSTSTAT			
					,T1.STATDES			
					,T1.COUNTRY			
					,T1.COUNTRYNAME		
					,T1.CURRENCY
					,T1.CODE			
					,T1.CTYPE				
					,T1.IVTYPE				
					,T1.SPEC1				
					,T1.SPEC2				
					,T1.SPEC3				
					,T1.SPEC6	
					,T1.SPEC9	
FROM inserted AS T1;
END;
GO