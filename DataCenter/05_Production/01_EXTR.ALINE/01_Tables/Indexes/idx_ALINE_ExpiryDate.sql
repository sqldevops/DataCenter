CREATE NONCLUSTERED INDEX idx_ALINE_ExpiryDate	ON EXTR.ALINE (RowExpiryDate)
INCLUDE		(
				[RowID],
				[AL],
				[UDATE],
				[FORM],
				[FORMNAME],
				[SERIAL],
				[PART],
				[ACT],
				[SERCANCEL],
				[CURDATE],
				[QUANT],
				[SQUANT],
				[EMPEDATE],
				[EMPSDATE],
				[EMPASPAN],
				[WORKC],
				[SERN]
			);
GO