CREATE			NONCLUSTERED INDEX idx_ENG_PartActPos		ON ENG.PartAct (PartID,ActPos)		INCLUDE (PartActID,Part,ActID,Act,ActIsLast);
