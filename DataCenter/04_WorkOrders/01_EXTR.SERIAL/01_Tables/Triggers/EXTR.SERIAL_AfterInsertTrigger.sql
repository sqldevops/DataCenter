CREATE TRIGGER [EXTR].[SERIAL_AfterInsertTrigger] ON EXTR.SERIAL 
AFTER INSERT
AS
MERGE OPR.WorkOrders AS Target
USING	(

			SELECT	T1.SERIAL					AS WrkOrdID			,
					T1.SERIALNAME				AS WrkOrd			,
					T1.PART						AS PartID			,
					T1.SERIALSTATUS				AS WrkOrdStatID		,
					T1.SERIALSTATUSDES			AS WrkOrdStat		,
					T1.QUANT/10000				AS WrkOrdQuant		,
					F1.convDate					AS WrkOrdClosedDate	,
					F2.convDate					AS WrkOrdCreatedDate,
					F3.convDate					AS WrkOrdStartDate	,
					F4.convDate					AS WrkOrdEndDate	,
					IIF(
							T1.SERIALSTATUS=2 
						OR	T1.SERIALSTATUS=4 
						OR	T1.SERIALSTATUS=5 
						OR	T1.SERIALSTATUS=9
							,1
							,0
						)						AS WrkOrdIsActive

			FROM inserted								AS T1
			CROSS APPLY ERP.IntToDate(T1.CLOSEDATE) 	AS F1
			CROSS APPLY ERP.IntToDate(T1.[CURDATE]) 	AS F2
			CROSS APPLY ERP.IntToDate(T1.PSDATE) 		AS F3
			CROSS APPLY ERP.IntToDate(T1.PEDATE) 		AS F4
	)				AS Source
ON (Target.WrkOrdID=Source.WrkOrdID)
WHEN NOT MATCHED THEN
INSERT	(
			 WrkOrdID
			,WrkOrd
			,PartID
			,WrkOrdStatID
			,WrkOrdStat
			,WrkOrdQuant
			,WrkOrdClosedDate	
			,WrkOrdCreatedDate
			,WrkOrdStartDate
			,WrkOrdEndDate
			,WrkOrdIsActive
			,DateTimeStamp
		)
VALUES	(
			 Source.WrkOrdID
			,Source.WrkOrd
			,Source.PartID
			,Source.WrkOrdStatID
			,Source.WrkOrdStat
			,Source.WrkOrdQuant
			,Source.WrkOrdClosedDate	
			,Source.WrkOrdCreatedDate
			,Source.WrkOrdStartDate
			,Source.WrkOrdEndDate
			,Source.WrkOrdIsActive
			,GETDATE()
		)
WHEN MATCHED THEN
UPDATE SET	 Target.WrkOrdStatID		= Source.WrkOrdStatID
			,Target.WrkOrdStat			= Source.WrkOrdStat
			,Target.WrkOrdQuant			= Source.WrkOrdQuant
			,Target.WrkOrdClosedDate	= Source.WrkOrdClosedDate
			,Target.WrkOrdCreatedDate	= Source.WrkOrdCreatedDate
			,Target.WrkOrdStartDate		= Source.WrkOrdStartDate
			,Target.WrkOrdEndDate		= Source.WrkOrdEndDate
			,Target.WrkOrdIsActive		= Source.WrkOrdIsActive
			,Target.DateTimeStamp		= GETDATE();


GO