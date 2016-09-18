INSERT INTO MKT.ClientOrders	(
									ClientOrderRowID		,	
									ClientOrderID			,	
									ClientOrder				,
									ClientOrderStatusID		,
									ClientOrderStatus		,	
									ClientID				,	
									PartID					,	
									ClientOrderQuant		,	
									ClientOrderBalance		,	
									ClientOrderDueDateID	,	
									UserID					,	
									ClientOrderIsOpen		,	
									DateTimeStamp	
								)		
SELECT								ClientOrderRowID		,	
									ClientOrderID			,	
									ClientOrder				,
									ClientOrderStatusID		,
									ClientOrderStatus		,	
									ClientID				,	
									PartID					,	
									ClientOrderQuant		,	
									ClientOrderBalance		,	
									ClientOrderDueDateID	,	
									UserID					,	
									ClientOrderIsOpen		,	
									DateTimeStamp			
FROM [$(DataCenterServer)].[$(DataCenterDatabase)].MKT.ClientOrders;	