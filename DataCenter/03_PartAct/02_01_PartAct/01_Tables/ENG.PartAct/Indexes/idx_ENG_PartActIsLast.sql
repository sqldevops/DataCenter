﻿CREATE			NONCLUSTERED INDEX idx_ENG_PartActIsLast	ON ENG.PartAct (PartID,ActIsLast)	INCLUDE (PartActID,ActID,Act);
