CREATE TABLE ENG.PartAct
(
	 PartActID			INT	IDENTITY(10000,1)		NOT NULL
	,PartActBin			AS CAST('/'+ CAST(PartActID AS VARCHAR(10))+ '/' AS HIERARCHYID) PERSISTED  
	,ProcessID			INT							NOT NULL				
	,PartID				INT							NOT NULL
	,Part				VARCHAR(22)					
	,ActID				INT							NOT NULL
	,Act				VARCHAR(10)					
	,PartIsActive		BIT							
	--,SonIsActive		BIT	
	--,PartIsValid		BIT							NOT NULL DEFAULT(1)			
	--,ActOrd				INT													--Act Row Number according to POS
	,ActPos				INT											--POS column in Priority					
	,WorkCenterID		INT					
	,WorkCenter			VARCHAR(6)				
	,PrevActID			INT		
	,NextActID			INT				
	,ActIsLast			BIT 
	,stdTimeEmployee	FLOAT 
	,stdTimeMachine		FLOAT
	,PartActDays		INT							
	,Branch				VARCHAR(10)		
	,BranchLevel		VARCHAR(15)		
	,IsBranchRoot		BIT							NOT NULL DEFAULT(0)
	,IsBranchEdge		BIT							NOT NULL DEFAULT(0)
	,DateTimeStamp		DATETIME
	,Originator			VARCHAR(50)	
	CONSTRAINT pk_PartAct PRIMARY KEY CLUSTERED (PartActID)
	 
);