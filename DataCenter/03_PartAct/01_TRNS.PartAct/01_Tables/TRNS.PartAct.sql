CREATE TABLE TRNS.PartAct
(
	 PartActID			INT IDENTITY (10000,1)	NOT NULL
	,PartActBin			AS CAST('/'+ CAST(PartActID AS VARCHAR(10))+ '/' AS HIERARCHYID) PERSISTED  
	,PartID				INT						NOT NULL
	,Part				VARCHAR(22)				NOT NULL
	,ProcessID			INT						NOT NULL
	,ActID				INT						NOT NULL
	,Act				VARCHAR(10)				NOT NULL
	,ActPos				INT						NOT NULL
	,WorkCenterID		INT						
	,WorkCenter			VARCHAR(6)				
	,PreActID			INT						
	,ActIsLast			BIT 
	,stdTimeEmployee	FLOAT 
	,stdTimeMachine		FLOAT
	,PartActDays		INT						NOT NULL
	,IsRoot				BIT						NOT NULL
	 CONSTRAINT pk_PartAct PRIMARY KEY CLUSTERED (PartActID)
	 
);