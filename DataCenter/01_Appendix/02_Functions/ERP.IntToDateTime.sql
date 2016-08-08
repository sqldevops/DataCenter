﻿CREATE FUNCTION [ERP].[IntToDateTime] (@dateNum INT) RETURNS TABLE
AS 
	RETURN SELECT IIF(@dateNum=0,NULL, DATEADD(MINUTE,DATEDIFF(MINUTE,0,DATEADD(SECOND,30,CONVERT(DATETIME,CAST(@dateNum AS DECIMAL)/1440+32141))),0)) AS convDateTime;

GO
