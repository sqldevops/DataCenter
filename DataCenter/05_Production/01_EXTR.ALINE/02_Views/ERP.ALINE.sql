﻿CREATE VIEW ERP.ALINE
AS
SELECT	 RowID
		,AL			
		,UDATE		
		,FORM	
		,FORMNAME		
		,SERIAL			
		,PART			
		,ACT	
		,SERCANCEL						
		,QUANT
		,SQUANT	
		,CURDATE	
		,EMPEDATE	
		,EMPSDATE	
		,EMPASPAN
		,WORKC		
		,SERN	
FROM EXTR.ALINE	
WHERE RowExpiryDate>GETDATE();
GO