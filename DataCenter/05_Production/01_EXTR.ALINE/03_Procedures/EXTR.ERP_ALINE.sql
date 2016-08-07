CREATE PROCEDURE EXTR.ERP_ALINE
AS
BEGIN
DECLARE @LastDate INT = ISNULL((SELECT TOP(1) UDATE FROM EXTR.ALINE ORDER BY UDATE DESC),0);

--Insert new rows into target table
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
SELECT
				 ERP.calDateTime (T1.UDATE)
				,CAST ('99991231' AS DATETIME)
				,GETDATE()
			 	,T1.AL			
				,T1.UDATE		
				,T1.FORM	
				,T2.FORMNAME		
				,T1.SERIAL			
				,T1.PART			
				,T1.ACT	
				,T1.SERCANCEL
				,T1.CURDATE	
				,T1.QUANT
				,T1.SQUANT	
				,T1.EMPEDATE	
				,T1.EMPSDATE	
				,T1.EMPASPAN
				,T1.WORKC		
				,T1.SERN	 
FROM [$(PriorityServer)].[$(PriorityDatabase)].dbo.ALINE	AS T1 
JOIN [$(PriorityServer)].[$(PriorityDatabase)].dbo.AFORM	AS T2 ON T2.FORM=T1.FORM 
WHERE  T1.UDATE>@LastDate;
END;
GO