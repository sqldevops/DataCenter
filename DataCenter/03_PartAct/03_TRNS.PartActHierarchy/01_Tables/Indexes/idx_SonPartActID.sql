CREATE NONCLUSTERED INDEX idx_SonPartActID ON TRNS.PartActHierarchy (PartActID)		INCLUDE (PartActLev,PartActCoef,PartActDays,PartActBinRoot);
