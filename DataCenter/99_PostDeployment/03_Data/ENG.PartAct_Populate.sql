/*
After this table is populated, triggers are fired and these tables are also populated :

ENG.PartAdjacency
ENG.PartActHierarchy
ENG.PartActAssembly
ENG.AssemblyHierarchy 

*/
INSERT INTO ENG.PartAct	(
							ProcessID		,
							PartID			,
							Part			,
							PartIsRoot		,
							PartIsActive	,
							ActID			,
							Act				,
							ActPos			,
							PrevActID		,
							NextActID		,
							ActIsLast		,
							ActDays			,
							WorkCenterID	,
							WorkCenter		,
							stdTimeEmployee	,
							stdTimeMachine	,
							Branch			,
							BranchLevel		,
							IsBranchRoot	,
							IsBranchEdge	,
							DateTimeStamp	,
							Source			
						)
SELECT	ProcessID		,
		PartID			,
		Part			,
		IsBranchRoot	,			--different name
		PartIsActive	,
		ActID			,
		Act				,
		ActPos			,
		PrevActID		,
		NextActID		,
		ActIsLast		,
		PartActDays		,		--different name	
		WorkCenterID	,
		WorkCenter		,
		stdTimeEmployee	,
		stdTimeMachine	,
		Branch			,
		BranchLevel		,
		IsBranchRoot	,
		IsBranchEdge	,
		DateTimeStamp	,
		Originator					--different name		
FROM [$(DataCenterServer)].[$(DataCenterDatabase)].ENG.PartAct