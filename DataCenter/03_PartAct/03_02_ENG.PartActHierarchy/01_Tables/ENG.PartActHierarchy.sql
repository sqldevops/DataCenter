CREATE TABLE ENG.PartActHierarchy
(
	 PartActID			INT 
	,PartActBinPath		HIERARCHYID NOT NULL
	,PartActLev			INT			NOT NULL
	,PartActBinRoot		HIERARCHYID	NOT NULL	
	,PartActCoef		FLOAT
	,PartActDays		INT
	,DateTimeStamp		DATETIME	NOT NULL
	CONSTRAINT pk_PartActBom PRIMARY KEY CLUSTERED (PartActBinPath)
);