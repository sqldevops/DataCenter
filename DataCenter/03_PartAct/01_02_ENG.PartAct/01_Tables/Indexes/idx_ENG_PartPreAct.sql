CREATE			NONCLUSTERED INDEX idx_ENG_PartPreAct		ON ENG.PartAct (PartID,PrevActID)	INCLUDE (PartActID,Act,ActID,ActPos,ActIsLast);
