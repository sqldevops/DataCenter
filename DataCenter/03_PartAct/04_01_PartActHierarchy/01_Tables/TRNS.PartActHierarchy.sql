CREATE TABLE TRNS.PartActHierarchy
(
	PartActID		INT										,		
	PartActBinPath	HIERARCHYID NOT NULL					,
	PartActLev		AS PartActBinPath.GetLevel() PERSISTED	,
	PartActBinRoot	HIERARCHYID	NOT NULL 					,
	PartActCoef		FLOAT									,
	ActDays			INT
	 CONSTRAINT pk_PartActBom PRIMARY KEY CLUSTERED (PartActBinPath)
);
GO