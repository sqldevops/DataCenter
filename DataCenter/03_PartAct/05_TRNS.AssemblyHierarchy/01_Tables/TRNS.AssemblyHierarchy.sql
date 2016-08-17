CREATE TABLE TRNS.AssemblyHierarchy
(
	 PartID				INT  
	,AssemblyBinPath	HIERARCHYID NOT NULL
	--CONSTRAINT pk_PartAssembly PRIMARY KEY CLUSTERED (AssemblyBinPath)
);
GO