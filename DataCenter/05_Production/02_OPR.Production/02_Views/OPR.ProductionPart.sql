CREATE VIEW OPR.ProductionPart
AS
SELECT	 PartID			
		,SUM(ProductionPass)	AS ProductionPass
		,SUM(ProductionFail)	AS ProductionFail	
		,ProductionDateID		
		,ProductionDate		
		,SUM(ProdTime)				AS ProdTime				
		,WorkCenterID				
FROM  OPR.Production	AS T1
CROSS APPLY	(
				SELECT ProductionRowID
				WHERE WrkOrdID=T1.WrkOrdID AND ActID=T1.ActID AND ActIsLast=1
			)				AS T2
WHERE T1.ProductionRowID=T2.ProductionRowID 
GROUP BY PartID		
		,ProductionDateID		
		,ProductionDate
		,WorkCenterID;
GO