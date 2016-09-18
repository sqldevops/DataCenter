DISABLE TRIGGER [EXTR].[CUSTOMERS_AfterInsertTrigger] ON [EXTR].[CUSTOMERS] ;
DISABLE TRIGGER [EXTR].[CUSTOMERS_InsteadOfTrigger] ON [EXTR].[CUSTOMERS] ;
GO
INSERT INTO EXTR.CUSTOMERS	(
								RowEffectiveDate	,	
								RowExpiryDate		,
								RowDateTimeStamp	,
								CUST				,
								UDATE				,
								CUSTNAME			,
								CUSTDES				,
								CUSTSTAT			,
								STATDES				,
								COUNTRY				,
								COUNTRYNAME			,
								CURRENCY			,
								CODE				,
								CTYPE				,
								IVTYPE				,
								SPEC1				,
								SPEC2				,
								SPEC3				,
								SPEC6				,
								SPEC9			
							)
SELECT RowEffectiveDate		,	
	   RowExpiryDate		,
	   RowDateTimeStamp		,
	   CUST					,
	   UDATE				,
	   CUSTNAME				,
	   CUSTDES				,
	   CUSTSTAT				,
	   STATDES				,
	   COUNTRY				,
	   COUNTRYNAME			,
	   CURRENCY				,
	   CODE					,
	   CTYPE				,
	   IVTYPE				,
	   SPEC1				,
	   SPEC2				,
	   SPEC3				,
	   SPEC6				,
	   SPEC9		
FROM [$(ETL_Server)].[$(ETL_Database)].EXTR.CUSTOMERS;	
GO
ENABLE TRIGGER [EXTR].[CUSTOMERS_AfterInsertTrigger] ON [EXTR].[CUSTOMERS] ;
ENABLE TRIGGER [EXTR].[CUSTOMERS_InsteadOfTrigger] ON [EXTR].[CUSTOMERS] ;	
GO