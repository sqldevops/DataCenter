CREATE PROCEDURE LOAD.PartAct
AS
BEGIN
TRUNCATE TABLE ENG.PartAct;
INSERT INTO ENG.PartAct	(
										 --PartActID
										--,PartActBin
										PartID				
										,Part	
										,ProcessID			
										,ActID				
										,Act	
										,ActPos			
										,WorkCenterID		
										,WorkCenter		
										,PrevActID			
										,ActIsLast				
										,stdTimeEmployee
										,stdTimeMachine
										,PartActDays
										,IsBranchRoot
										,DateTimeStamp
									)
SELECT	-- PartActID
		--,PartActBin
		PartID				
		,Part	
		,ProcessID			
		,ActID				
		,Act	
		,ActPos			
		,WorkCenterID		
		,WorkCenter		
		,PreActID			
		,ActIsLast				
		,stdTimeEmployee
		,stdTimeMachine
		,PartActDays
		,IsRoot
		,GETDATE()
FROM TRNS.PartAct;
END;
GO