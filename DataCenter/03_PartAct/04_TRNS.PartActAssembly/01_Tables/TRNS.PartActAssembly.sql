CREATE TABLE TRNS.PartActAssembly
(
	PartActAssemblyID		INT IDENTITY (10000,1)	NOT NULL,
	PartActID				INT						NOT NULL,
	PartAssemblyID			INT						NOT NULL,
	PartAssemblyBinPath		HIERARCHYID				NOT NULL	
	CONSTRAINT pk_PartActAssembly PRIMARY KEY CLUSTERED (PartActAssemblyID)
);