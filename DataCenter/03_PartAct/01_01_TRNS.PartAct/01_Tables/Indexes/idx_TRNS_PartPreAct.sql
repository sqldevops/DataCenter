﻿CREATE			NONCLUSTERED INDEX idx_TRNS_PartPreAct		ON TRNS.PartAct (PartID,PreActID)	INCLUDE (PartActID,Act,ActID,ActPos,ActIsLast);
