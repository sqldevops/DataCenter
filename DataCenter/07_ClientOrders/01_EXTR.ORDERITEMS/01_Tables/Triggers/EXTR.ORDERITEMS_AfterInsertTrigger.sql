CREATE TRIGGER EXTR.ORDERITEMS_AfterInsertTrigger ON EXTR.ORDERITEMS 
FOR INSERT
AS
BEGIN
IF (SELECT COUNT(*) FROM inserted WHERE CUST<>-4) IS NOT NULL
	BEGIN
	MERGE MKT.ClientOrders									AS Target
	USING	(
				SELECT	ORDI				AS ClientOrderRowID		,
						ORD					AS ClientOrderID		,
						ORDNAME				AS ClientOrder			,
						ORDSTATUS			AS ClientOrderStatusID	,
						ORDSTATUSDES		AS ClientOrderStatus	,
						CUST				AS ClientID				,
						PART				AS PartID				,
						QUANT/10000			AS ClientOrderQuant		,
						ABALANCE/10000		AS ClientOrderBalance	,
						DUEDATE/1440+32141	AS ClientOrderDueDateID	,
						T$USER				AS UserID				,
						IIF(CLOSED='C',0,1)	AS ClientOrderIsOpen	
				FROM inserted
				WHERE CUST <>-4
			)															AS Source
	ON (Target.ClientOrderRowID=Source.ClientOrderRowID)
	WHEN NOT MATCHED BY Target THEN
		INSERT	(
					 ClientOrderRowID
					,ClientOrderID
					,ClientOrder
					,ClientOrderStatusID
					,ClientOrderStatus
					,ClientID
					,PartID
					,ClientOrderQuant
					,ClientOrderBalance
					,ClientOrderDueDateID
					,UserID
					,ClientOrderIsOpen
					,DateTimeStamp
				)
		VALUES	(
					 Source.ClientOrderRowID
					,Source.ClientOrderID
					,Source.ClientOrder
					,Source.ClientOrderStatusID
					,Source.ClientOrderStatus
					,Source.ClientID
					,Source.PartID
					,Source.ClientOrderQuant
					,Source.ClientOrderBalance
					,Source.ClientOrderDueDateID
					,Source.UserID
					,Source.ClientOrderIsOpen
					,GETDATE()
				)
		WHEN MATCHED THEN 
		UPDATE SET	 Target.ClientOrderID		=Source.ClientOrderID
					,Target.ClientOrder			=Source.ClientOrder
					,Target.ClientOrderStatusID	=Source.ClientOrderStatusID
					,Target.ClientOrderStatus	=Source.ClientOrderStatus
					,Target.ClientID			=Source.ClientID
					,Target.PartID				=Source.PartID
					,Target.ClientOrderQuant	=Source.ClientOrderQuant
					,Target.ClientOrderBalance	=Source.ClientOrderBalance
					,Target.ClientOrderDueDateID=Source.ClientOrderDueDateID
					,Target.UserID				=Source.UserID
					,Target.ClientOrderIsOpen	=Source.ClientOrderIsOpen
					,Target.DateTimeStamp		= GETDATE()	;

		END;

	IF (SELECT COUNT(*) FROM inserted WHERE CUST=-4) IS NOT NULL
		BEGIN
			DECLARE @forecasts TABLE	(
											ForecastRowID		INT ,
											ForecastYear		INT	,
											ForecastMonth		INT	,
											PartID				INT	,
											ForecastQuant		INT	,
											ForecastIsOpen		BIT	,
											ForecastUpdatedDate	DATETIME
										);	
			INSERT INTO @forecasts	(
										ForecastRowID	,	
										ForecastYear	,	
										ForecastMonth	,	
										PartID			,	
										ForecastQuant	,	
										ForecastIsOpen	,	
										ForecastUpdatedDate
									)
			SELECT	ORDI				AS ForecastRowID		,
					YEAR(F1.convDate)	AS ForecastYear			,
					MONTH(F1.convDate)	AS ForecastMonth		,
					PART				AS PartID				,		
					QUANT/10000			AS ForecastQuant		,
					IIF(CLOSED='C',0,1)	AS ForecastIsOpen		,
					F2.convDate			AS ForecastUpdatedDate
			FROM inserted
			CROSS APPLY ERP.IntToDate(DUEDATE)	AS F1
			CROSS APPLY	ERP.IntToDate(UDATE)	AS F2
			WHERE CUST =-4 AND DUEDATE >0 ;



			MERGE MKT.Forecasts										AS Target
			USING	(
					SELECT T1.*
					FROM @forecasts AS T1
					CROSS APPLY (
									SELECT TOP (1) ForecastRowID
									FROM @forecasts
									WHERE	ForecastYear	= T1.ForecastYear 
										AND ForecastMonth	= T1.ForecastMonth 
										AND PartID			= T1.PartID
									ORDER BY ForecastUpdatedDate DESC
								) AS T2
					WHERE T1.ForecastRowID=T2.ForecastRowID
					)															AS Source
			ON (Target.ForecastRowID=Source.ForecastRowID)
			WHEN NOT MATCHED BY Target THEN
			INSERT	(
						 ForecastRowID
						,ForecastYear
						,ForecastMonth
						,PartID
						,ForecastQuant
						,ForecastIsOpen
						,ForecastUpdatedDate
						,DateTimeStamp
					)
			VALUES	(
						 Source.ForecastRowID
						,Source.ForecastYear
						,Source.ForecastMonth
						,Source.PartID
						,Source.ForecastQuant
						,Source.ForecastIsOpen
						,Source.ForecastUpdatedDate
						,GETDATE()
					)
			WHEN MATCHED THEN 
			UPDATE SET	 Target.ForecastRowID		=Source.ForecastRowID
						,Target.ForecastYear		=Source.ForecastYear
						,Target.ForecastMonth		=Source.ForecastMonth
						,Target.PartID				=Source.PartID
						,Target.ForecastQuant		=Source.ForecastQuant
						,Target.ForecastIsOpen		=Source.ForecastIsOpen
						,Target.ForecastUpdatedDate	=Source.ForecastUpdatedDate
						,Target.DateTimeStamp		= GETDATE();
		END;
END;
GO