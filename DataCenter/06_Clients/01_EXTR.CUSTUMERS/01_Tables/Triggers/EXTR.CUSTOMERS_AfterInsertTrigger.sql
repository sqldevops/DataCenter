CREATE TRIGGER EXTR.CUSTOMERS_AfterInsertTrigger ON EXTR.CUSTOMERS 
AFTER INSERT
AS
BEGIN
MERGE MKT.Clients																	AS Target
USING	(
		SELECT	T1.CUST												AS ClientID			,								
				T1.CUSTNAME											AS Client			,
				IIF(T1.IVTYPE='F',REVERSE(T1.CUSTDES),T1.CUSTDES)	AS ClientDes		,
				(
					CASE
						WHEN		T1.CUST=841 
								OR  T1.CUST=911 
								OR  T1.CUST=1059 
								OR  T1.CUST=1242		THEN 1
						WHEN		T1.IVTYPE='F'		THEN 2
						WHEN		T1.CTYPE=13			THEN 4
						WHEN		T1.IVTYPE='C' 
								AND	T1.CTYPE<>13		THEN 3
						WHEN T1.CUST=937				THEN 5
					END
					)												AS ClientPriority	,
				T1.CUSTSTAT											AS ClientStatusID	,
				T1.STATDES											AS ClientStatus		,
				T1.COUNTRY											AS CountryID		,	
				T1.COUNTRYNAME										AS Country			,
				T1.CURRENCY											AS CurrencyID		,
				T1.CODE												AS Currency			,
				T1.SPEC1											AS Parameter01		,
				REVERSE(T1.SPEC2)									AS Parameter02		,
				REVERSE(T1.SPEC3)									AS Parameter03		,
				REVERSE(T1.SPEC6)									AS Parameter06		,
				T1.SPEC9											AS Parameter09	
		FROM	inserted											AS T1
		WHERE		T1.CUST<>940 
				AND T1.CUST<>1009 
				AND T1.CUST<>1141 
				AND T1.CUST>0 
				OR  T1.CUST=-4
		)																						AS Source
ON (Target.ClientID=Source.ClientID)
WHEN NOT MATCHED BY Target THEN
INSERT	(
			 ClientID
			,Client
			,ClientDes
			,ClientPriority
			,ClientStatusID
			,ClientStatus
			,CountryID
			,Country
			,CurrencyID
			,Currency
			,Parameter01
			,Parameter02
			,Parameter03
			,Parameter06
			,Parameter09
			,DateTimeStamp
		)
VALUES	(
			 Source.ClientID
			,Source.Client
			,Source.ClientDes
			,Source.ClientPriority
			,Source.ClientStatusID
			,Source.ClientStatus
			,Source.CountryID
			,Source.Country
			,Source.CurrencyID
			,Source.Currency
			,Source.Parameter01
			,Source.Parameter02
			,Source.Parameter03
			,Source.Parameter06
			,Source.Parameter09
			,GETDATE()
		)
WHEN MATCHED THEN
UPDATE SET 
					 Target.ClientID		= Source.ClientID 
					,Target.Client			= Source.Client 
					,Target.ClientDes		= Source.ClientDes
					,Target.ClientPriority	= Source.ClientPriority
					,Target.ClientStatusID	= Source.ClientStatusID
					,Target.ClientStatus	= Source.ClientStatus
					,Target.CountryID		= Source.CountryID
					,Target.Country			= Source.Country
					,Target.CurrencyID		= Source.CurrencyID
					,Target.Currency		= Source.Currency
					,Target.Parameter01		= Source.Parameter01
					,Target.Parameter02		= Source.Parameter02
					,Target.Parameter03		= Source.Parameter03
					,Target.Parameter06		= Source.Parameter06
					,Target.Parameter09		= Source.Parameter09
					,Target.DateTimeStamp	= GETDATE();
END;
GO