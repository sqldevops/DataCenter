CREATE VIEW OPR.ProductionAct
AS
SELECT	 ProductionFormID	
		,ProductionForm			
		,WrkOrdID				
		,PartID					
		,ActID				
		,ActIsLast			
		,SUM(ProductionPass)	AS ProductionPassQuant
		,SUM(ProductionFail)	AS ProductionFailQuant	
		,ProductionDateID		
		,ProductionDate		
		,SUM(ProdTime)				AS ProdTime				
		,WorkCenterID				
FROM  OPR.Production	
GROUP BY ProductionFormID	
		,ProductionForm			
		,WrkOrdID				
		,PartID					
		,ActID				
		,ActIsLast
		,ProductionDateID		
		,ProductionDate
		,WorkCenterID	;
GO