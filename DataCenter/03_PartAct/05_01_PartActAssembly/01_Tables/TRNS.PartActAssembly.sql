CREATE TABLE TRNS.PartActAssembly
(
	AssemblyPartActID		INT IDENTITY (10000,1)	NOT NULL,
	PartActID				INT						NOT NULL,
	AssemblyPartID			INT						NOT NULL,
	AssemblyBinPath			HIERARCHYID				NOT NULL	
	CONSTRAINT pk_PartActAssembly PRIMARY KEY CLUSTERED (AssemblyPartActID)
);
GO