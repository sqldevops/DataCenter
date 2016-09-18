--Disable triggers on EXTR.PART table
DISABLE TRIGGER EXTR.PART_AfterInsertTrigger ON EXTR.PART;
DISABLE TRIGGER EXTR.PART_InsteadOfTrigger ON EXTR.PART;

--Load data into EXTR.PART (RowID is identity)
INSERT INTO EXTR.PART	(
							RowEffectiveDate	,	
							RowExpiryDate	,	
							RowDateTimeStamp	,
							PART				,
							UDATE			,	
							PARTNAME			,
							PARTDES			,
							EPARTDES			,
							TYPE				,
							T$PROC			,	
							PROCNAME			,
							FAMILY			,	
							FAMILYNAME		,	
							FAMILYDES		,	
							PARTSTAT			,
							STATDES			,
							SPEC3			,	
							SPEC4			,	
							SPEC8			,	
							SPEC10			,	
							SPEC19			
						)
SELECT RowEffectiveDate	,	
	   RowExpiryDate	,	
	   RowDateTimeStamp	,
	   PART				,
	   UDATE			,	
	   PARTNAME			,
	   PARTDES			,
	   EPARTDES			,
	   TYPE				,
	   T$PROC			,	
	   PROCNAME			,
	   FAMILY			,	
	   FAMILYNAME		,	
	   FAMILYDES		,	
	   PARTSTAT			,
	   STATDES			,
	   SPEC3			,	
	   SPEC4			,	
	   SPEC8			,	
	   SPEC10			,	
	   SPEC19			
FROM [$(ETL_Server)].[$(ETL_Database)].EXTR.PART	;


--Enable triggers on EXTR.PART table
ENABLE TRIGGER EXTR.PART_AfterInsertTrigger ON EXTR.PART;
ENABLE TRIGGER EXTR.PART_InsteadOfTrigger ON EXTR.PART;
GO