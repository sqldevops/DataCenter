CREATE TRIGGER EXTR.ALINE_InsteadOfTrigger ON EXTR.ALINE 
INSTEAD OF INSERT
AS
BEGIN
--1. Updating expiry date for existing rows before inserting new ones
WITH cte AS
(
	SELECT T1.* 
	FROM EXTR.ALINE	AS T1
	JOIN inserted	AS T2 ON T2.AL=T1.AL
	CROSS APPLY
	(
		SELECT TOP(1)	 RowID	AS ExpiredRowID
						,UDATE	AS ExpiredRowDate
		FROM	EXTR.ALINE 
		WHERE	AL=T1.AL 
		ORDER BY UDATE DESC
	)							AS T3
	WHERE T1.RowID=T3.ExpiredRowID
)
UPDATE EXTR.ALINE 
SET RowExpiryDate=cte.RowDateTimeStamp,RowDateTimeStamp=GETDATE()
FROM cte 
WHERE EXTR.ALINE.RowID=cte.RowID;

--2. Inserting new rows
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
SELECT			ERP.calDateTime (T1.UDATE)		,
				CAST ('99991231' AS DATETIME)	,
				GETDATE()						,
			 	T1.AL							,
				T1.UDATE						,
				T1.FORM							,
				T1.FORMNAME						,
				T1.SERIAL						,
				T1.PART							,
				T1.ACT							,
				T1.SERCANCEL					,
				T1.CURDATE						,
				T1.QUANT						,
				T1.SQUANT						,
				T1.EMPEDATE						,
				T1.EMPSDATE						,
				T1.EMPASPAN						,
				T1.WORKC						,
				T1.SERN				
FROM inserted AS T1;
END;
GO

GO