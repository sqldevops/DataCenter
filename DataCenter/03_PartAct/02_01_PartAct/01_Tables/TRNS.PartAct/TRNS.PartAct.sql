CREATE TABLE TRNS.PartAct
(			
	 PartActID			INT IDENTITY (10000,1)	NOT NULL
	,PartActBin			AS CAST('/'+ CAST(PartActID AS VARCHAR(10))+ '/' AS HIERARCHYID) PERSISTED  
	,PartID				INT						NOT NULL
	,Part				VARCHAR(22)			
	,PartIsRoot			BIT	
	,PartIsActive		BIT	
	,ProcessID			INT						NOT NULL		
	,ActID				INT						NOT NULL
	,Act				VARCHAR(10)									
	,ActPos				INT											--POS column in Priority								
	,PrevActID			INT		
	,NextActID			INT				
	,ActIsLast			BIT 
	,ActDays			INT		
	,WorkCenterID		INT					
	,WorkCenter			VARCHAR(6)	
	,stdTimeEmployee	FLOAT 
	,stdTimeMachine		FLOAT
	CONSTRAINT pk_TRNS_PartAct PRIMARY KEY CLUSTERED (PartActID)
)