﻿CREATE			NONCLUSTERED INDEX idx_TRNS_PartIsRoot		ON TRNS.PartAct (IsRoot)		INCLUDE ([PartActID],[PartActDays],PartID);
