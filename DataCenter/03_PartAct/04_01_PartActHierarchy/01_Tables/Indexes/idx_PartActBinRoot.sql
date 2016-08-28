CREATE NONCLUSTERED INDEX idx_PartActBinRoot ON TRNS.PartActHierarchy (PartActBinRoot) INCLUDE (
																									PartActID,
																									PartActLev,
																									PartActCoef,
																									ActDays
																								);
