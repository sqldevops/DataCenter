CREATE TABLE TRNS.AssemblyHierarchy
(
	AssemblyPartID	INT			NULL	,
	AssemblyPart	VARCHAR(22)	NULL	,
	AssemblyBinPath HIERARCHYID	NOT NULL
	CONSTRAINT pk_AssemblyHierarchy PRIMARY KEY CLUSTERED (AssemblyBinPath)
);
GO