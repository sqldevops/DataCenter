﻿CREATE FUNCTION ERP.calDateTime (@dateNum INT) 
RETURNS DATETIME
AS 
BEGIN
	DECLARE @prodDate DATETIME;
	SET @prodDate=IIF(@dateNum=0,NULL, DATEADD(MINUTE,DATEDIFF(MINUTE,0,DATEADD(SECOND,30,CONVERT(DATETIME,CAST(@dateNum AS DECIMAL)/1440+32141))),0));
	RETURN (@prodDate);
END;

