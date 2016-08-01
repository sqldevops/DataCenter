CREATE TRIGGER EXTR.PART_AfterInsertTrigger ON EXTR.PART
--Because UDATE allways increases EXTR.PART allways grows (only Inserts, no updates) 
AFTER INSERT
AS
	MERGE ENG.Parts		AS Target
	USING	(
			SELECT	T1.PART			,
					T1.PARTNAME		,
					T1.PARTDES		,
					T1.EPARTDES		,
					T1.TYPE			,
					T1.T$PROC		,
					T1.PROCNAME		,
					T1.FAMILY		,
					T1.FAMILYNAME	,
					T1.FAMILYDES	,
					T1.PARTSTAT		,
					T1.STATDES		,
					T1.SPEC3		,
					T1.SPEC4		,
					T1.SPEC8		,
					T1.SPEC10		,
					T1.SPEC19	
			FROM inserted AS T1
			)						AS Source
	ON (Target.PartID=Source.PART)
	WHEN NOT MATCHED BY Target THEN
	INSERT	(
				 PartID
				,Part
				,PartHebDes
				,PartEngDes
				,PartType
				,ProcessID
				,Process
				,FamilyID
				,Family
				,FamilyDes
				,PartStatusID
				,PartStatus
				,Symbol
				,Package
				,Parameter08
				,Parameter10
				,Parameter19
				,RowDateTimeStamp
			)
	VALUES	(
				 Source.PART			
				,Source.PARTNAME		
				,Source.PARTDES	
				,Source.EPARTDES		
				,Source.TYPE			
				,Source.T$PROC		
				,Source.PROCNAME		
				,Source.FAMILY		
				,Source.FAMILYNAME	
				,Source.FAMILYDES	
				,Source.PARTSTAT		
				,Source.STATDES		
				,Source.SPEC3		
				,Source.SPEC4		
				,Source.SPEC8		
				,Source.SPEC10		
				,Source.SPEC19	
				,GETDATE()
			)
	WHEN MATCHED THEN
	UPDATE SET	 Target.PartID		= Source.PART			
				,Target.Part		= Source.PARTNAME		
				,Target.PartHebDes	= Source.PARTDES
				,Target.PartEngDes	= Source.EPARTDES	
				,Target.PartType	= Source.TYPE			
				,Target.ProcessID	= Source.T$PROC		
				,Target.Process		= Source.PROCNAME		
				,Target.FamilyID	= Source.FAMILY		
				,Target.Family		= Source.FAMILYNAME	
				,Target.FamilyDes	= Source.FAMILYDES	
				,Target.PartStatusID= Source.PARTSTAT		
				,Target.PartStatus	= Source.STATDES		
				,Target.Symbol		= Source.SPEC3		
				,Target.Package		= Source.SPEC4		
				,Target.Parameter08	= Source.SPEC8		
				,Target.Parameter10	= Source.SPEC10		
				,Target.Parameter19	= Source.SPEC19	
				,Target.RowDateTimeStamp= GETDATE()	;
GO