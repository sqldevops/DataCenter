CREATE TRIGGER EXTR.ALINE_AfterInsertTrigger ON EXTR.ALINE 
AFTER INSERT
AS
MERGE OPR.Production			AS Target
USING	(
		SELECT	AL					AS ProductionRowID		,
				FORM				AS ProductionFormID		,	
				FORMNAME			AS ProductionForm		,	
				SERIAL				AS WrkOrdID				,	
				PART				AS PartID				,
				ACT					AS ActID				,
				IIF(T1.SERCANCEL='Y',1,0) AS ActIsLast		,
				QUANT/10000			AS ProductionPass		,	
				SQUANT/10000		AS ProductionFail		,	
				CURDATE/1440+32141	AS ProductionDateID		,	
				F2.convDateTime		AS ProductionDate		,	
				F3.convDateTime		AS ProductionStartDate	,	
				F4.convDateTime		AS ProductionEndDate	,	
				F1.convDateTime		AS ReportingDateTime	,	
				EMPASPAN			AS ProdTime				,
				WORKC				AS WorkCenterID			,
				SERN				AS UserID									
		FROM inserted			AS T1
		CROSS APPLY ERP.IntToDateTime(T1.UDATE)				AS F1
		CROSS APPLY ERP.IntToDateTime(T1.CURDATE)			AS F2
		CROSS APPLY ERP.IntToDateTime(T1.EMPSDATE)			AS F3
		CROSS APPLY ERP.IntToDateTime(T1.EMPEDATE)			AS F4
		)											AS Source
ON (Target.ProductionRowID=Source.ProductionRowID)
WHEN NOT MATCHED BY Target THEN
INSERT	(
			ProductionRowID		,
			ProductionFormID	,
			ProductionForm		,	
			WrkOrdID			,	
			PartID				,	
			ActID				,
			ActIsLast			,
			ProductionPass		,
			ProductionFail		,	
			ProductionDateID	,	
			ProductionDate		,	
			ProductionStartDate	,	
			ProductionEndDate	,	
			ReportingDateTime	,	
			ProdTime			,	
			WorkCenterID		,	
			UserID				,
			DateTimeStamp			
		)
VALUES	(
			Source.ProductionRowID		,
			Source.ProductionFormID		,	
			Source.ProductionForm		,
			Source.WrkOrdID				,	
			Source.PartID				,	
			Source.ActID				,
			Source.ActIsLast			,
			Source.ProductionPass		,
			Source.ProductionFail		,
			Source.ProductionDateID		,		
			Source.ProductionDate		,	
			Source.ProductionStartDate	,	
			Source.ProductionEndDate	,	
			Source.ReportingDateTime	,	
			Source.ProdTime				,		
			Source.WorkCenterID			,	
			Source.UserID				,
			GETDATE()			
		)
WHEN MATCHED THEN
UPDATE SET	Target.ProductionRowID		= Source.ProductionRowID	,		
			Target.ProductionFormID		= Source.ProductionFormID	,			
			Target.ProductionForm		= Source.ProductionForm		,	
			Target.WrkOrdID				= Source.WrkOrdID			,	
			Target.PartID				= Source.PartID				,		
			Target.ActID				= Source.ActID				,		
			Target.ActIsLast			= Source.ActIsLast			,		
			Target.ProductionPass		= Source.ProductionPass		,	
			Target.ProductionFail		= Source.ProductionFail		,	
			Target.ProductionDateID		= Source.ProductionDateID	,	
			Target.ProductionDate		= Source.ProductionDate		,
			Target.ProductionStartDate	= Source.ProductionStartDate,	
			Target.ProductionEndDate	= Source.ProductionEndDate	,
			Target.ReportingDateTime	= Source.ReportingDateTime	,
			Target.ProdTime				= Source.ProdTime			,	
			Target.WorkCenterID			= Source.WorkCenterID		,	
			Target.UserID				= Source.UserID				,
			Target.DateTimeStamp		= GETDATE()					;
GO