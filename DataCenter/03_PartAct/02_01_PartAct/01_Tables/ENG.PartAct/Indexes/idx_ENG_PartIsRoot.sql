CREATE			NONCLUSTERED INDEX idx_ENG_PartIsRoot		ON ENG.PartAct (PartID,IsBranchRoot)INCLUDE (PartActID,ActID,Part,Act);
