CREATE NONCLUSTERED INDEX idx_ALINE_AL ON EXTR.ALINE (AL,UDATE)
INCLUDE		(
				[RowID],
				[RowEffectiveDate],
				[RowExpiryDate],
				[RowDateTimeStamp],
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