CREATE TRIGGER EXTR.ORDERITEMS_InsteadOfTrigger ON EXTR.ORDERITEMS 
INSTEAD OF INSERT
AS
BEGIN
--1. Update expiry date for exsisting rows
WITH cte AS
(
	SELECT T1.* 
	FROM EXTR.ORDERITEMS	AS T1
	JOIN inserted			AS T2 ON T2.ORDI=T1.ORDI
	CROSS APPLY
	(
		SELECT TOP(1)	 RowID	AS ExpiredRowID
						,UDATE	AS ExpiredRowDate
		FROM	EXTR.ORDERITEMS 
		WHERE	ORDI=T1.ORDI 
		ORDER BY UDATE DESC
	)							AS T3
	WHERE T1.RowID=T3.ExpiredRowID
)
UPDATE EXTR.ORDERITEMS 
SET RowExpiryDate=cte.RowDateTimeStamp,RowDateTimeStamp=GETDATE()
FROM cte 
WHERE EXTR.ORDERITEMS.RowID=cte.RowID;

--2. Insert new rows into target table
INSERT INTO EXTR.ORDERITEMS	(
								 RowEffectiveDate	
								,RowExpiryDate
								,RowDateTimeStamp	
								,ORDI
								,UDATE
								,ORD
								,ORDNAME
								,ORDSTATUS
								,ORDSTATUSDES
								,CUST
								,PART
								,QUANT
								,ABALANCE
								,DUEDATE
								,T$USER
								,CLOSED
							)
SELECT	 ERP.calDateTime (T1.UDATE)
		,CAST ('99991231' AS DATETIME)
		,GETDATE()
		,T1.ORDI
		,T1.UDATE
		,T1.ORD
		,T1.ORDNAME
		,T1.ORDSTATUS
		,T1.ORDSTATUSDES
		,T1.CUST
		,T1.PART
		,T1.QUANT
		,T1.ABALANCE
		,T1.DUEDATE
		,T1.T$USER
		,T1.CLOSED
FROM inserted	AS T1;
END;
GO