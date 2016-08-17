CREATE			NONCLUSTERED INDEX idx_ENG_PartActBin		ON ENG.PartAct (PartActBin)			INCLUDE (PartActID,Part,ActID,Act,ActIsLast);
