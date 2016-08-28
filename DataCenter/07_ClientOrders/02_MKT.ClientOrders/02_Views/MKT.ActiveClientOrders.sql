CREATE VIEW MKT.ActiveClientOrders
AS
SELECT	 ClientOrderID
		,ClientOrder
		,ClientOrderStatusID
		,ClientOrderStatus
		,ClientID
		,PartID
		,SUM(ClientOrderBalance) AS ClientOrderBalance
		,ClientOrderDueDateID
FROM MKT.ClientOrders
WHERE ClientID <>-4 AND ClientOrderIsOpen=1
GROUP BY ClientOrderID					
		,ClientOrder				
		,ClientOrderStatusID				
		,ClientOrderStatus			
		,ClientID					
		,PartID				
		,ClientOrderDueDateID;
GO