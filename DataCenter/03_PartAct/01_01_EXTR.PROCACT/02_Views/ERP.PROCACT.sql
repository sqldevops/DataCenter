﻿CREATE VIEW ERP.PROCACT
AS
SELECT	 T1.RowID
		,T1.RowEffectiveDate
		,T1.RowExpiryDate
		,T1.T$PROC
		,T1.ACT
		,T1.POS
		,T1.ActPos
FROM EXTR.PROCACT	AS T1
WHERE T1.RowExpiryDate>GETDATE();
GO