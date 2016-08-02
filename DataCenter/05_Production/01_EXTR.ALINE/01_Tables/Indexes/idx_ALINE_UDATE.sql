CREATE NONCLUSTERED INDEX idx_ALINE_UDATE	ON EXTR.ALINE (UDATE)
INCLUDE		(
				[AL]	,
				[FORM]	,
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
