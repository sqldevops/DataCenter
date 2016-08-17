CREATE PROCEDURE LOAD.PartActHierarchy
AS
BEGIN
TRUNCATE TABLE ENG.PartActHierarchy;
INSERT INTO ENG.PartActHierarchy	( 
												 PartActID		
												,PartActBinPath	
												,PartActLev		
												,PartActBinRoot	
												,PartActCoef	
												,PartActDays	
												,DateTimeStamp
											)
SELECT	 PartActID		
		,PartActBinPath	
		,PartActLev		
		,PartActBinRoot	
		,PartActCoef	
		,PartActDays
		,GETDATE()	
FROM TRNS.PartActHierarchy;
END;
GO