CREATE PROCEDURE LOAD.PartActAdjacency
AS
BEGIN
TRUNCATE TABLE ENG.PartActAdjacency;
INSERT INTO ENG.PartActAdjacency	( 
												ParentPartActID	,
												SonPartActID	,
												SonRowNum		,
												SonPartActCoef	,
												SonPartActDays	
											)
SELECT	ParentPartActID	,
		SonPartActID	,
		SonRowNum		,
		SonPartActCoef	,
		SonPartActDays	
FROM TRNS.PartActAdjacency;
END;
GO