﻿CREATE			NONCLUSTERED INDEX idx_TRNS_PartActBin		ON TRNS.PartAct (PartActBin)		INCLUDE (PartActID,Part,ActID,Act,ActIsLast);
