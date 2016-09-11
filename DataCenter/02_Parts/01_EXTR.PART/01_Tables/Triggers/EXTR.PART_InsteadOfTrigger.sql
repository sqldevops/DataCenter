CREATE TRIGGER EXTR.PART_InsteadOfTrigger ON [EXTR].[PART] 
--Because UDATE allways increases EXTR.PART allways grows (only Inserts, no updates) 
INSTEAD OF INSERT
AS
BEGIN
	TRUNCATE TABLE TRNS.PROCACT;
	--Save all changes in Process of existing part or of a new part
	DECLARE @Processes	TABLE	(PART INT, T$PROC INT);

	INSERT INTO @Processes (PART,T$PROC)
	SELECT DISTINCT T1.PART,T1.T$PROC
	FROM inserted		AS T1
	LEFT JOIN ERP.PART	AS T2 ON T2.PART=T1.PART
	WHERE T1.T$PROC<>ISNULL(T2.T$PROC,0);

	--Updating expiry date for existing rows before inserting new ones:
	WITH cte AS
	(
		SELECT T1.* 
		FROM EXTR.PART	AS T1
		JOIN inserted	AS T2 ON T2.PART=T1.PART
		CROSS APPLY
		(
			SELECT TOP(1)	 RowID	AS ExpiredRowID
							,UDATE	AS ExpiredRowDate
			FROM	EXTR.PART 
			WHERE	PART=T1.PART 
			ORDER BY UDATE DESC
		)							AS T3
		WHERE T1.RowID=T3.ExpiredRowID
	)
	UPDATE EXTR.PART 
	SET RowExpiryDate=cte.RowDateTimeStamp,RowDateTimeStamp=GETDATE()
	FROM cte 
	WHERE EXTR.PART.RowID=cte.RowID;

	--Inserting new rows: 
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
			,T1.EPARTDES			
			,T1.TYPE				
			,T1.T$PROC
			,T1.PROCNAME				
			,T1.FAMILY
			,T1.FAMILYNAME
			,T1.FAMILYDES	
			,T1.PARTSTAT
			,T1.STATDES
			,T1.SPEC3
			,T1.SPEC4
			,T1.SPEC8
			,T1.SPEC10
			,T1.SPEC19
	FROM inserted	 AS T1;

	--Populate TRNS.PartProcess trigger table
	INSERT INTO TRNS.PROCACT(PART,T$PROC,Source)
	SELECT DISTINCT T1.PART,T1.T$PROC,'PART'
	FROM @Processes		AS T1;
END;