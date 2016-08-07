CREATE TRIGGER [EXTR].[SERIAL_InsteadOfTrigger] ON EXTR.SERIAL 
INSTEAD OF INSERT
AS
BEGIN

--1.Update expiry date for exsisting rows (before insert)
WITH cte AS
(
	SELECT T1.* 
	FROM EXTR.SERIAL	AS T1
	JOIN inserted		AS T2 ON T2.SERIAL=T1.SERIAL
	CROSS APPLY
	(
		SELECT	RowID				AS ExpiredRowID		,
				T4.ExpiredRowDate
		FROM	EXTR.SERIAL 
		CROSS APPLY	
		(
			SELECT TOP(1)	UDATE	AS ExpiredRowDate
			FROM	EXTR.SERIAL 
			WHERE	SERIAL=T1.SERIAL 
			ORDER BY UDATE DESC
		)															AS T4
		WHERE	SERIAL=T1.SERIAL AND UDATE=T4.ExpiredRowDate
	)																AS T3
	WHERE T1.RowID=T3.ExpiredRowID
)
UPDATE EXTR.SERIAL 
SET RowExpiryDate=cte.RowDateTimeStamp,RowDateTimeStamp=GETDATE()
FROM cte 
WHERE EXTR.SERIAL.RowID=cte.RowID;

--2. Insert new rows: 
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
		,T1.SERIALSTATUS
		,T1.SERIALSTATUSDES
		,T1.PSDATE
		,T1.PART
		,T1.CLOSED
		,T1.PEDATE
		,T1.QUANT
		,T1.CURDATE
		,T1.CLOSEDATE
		,T1.T$USER
FROM inserted		AS T1
END;
GO