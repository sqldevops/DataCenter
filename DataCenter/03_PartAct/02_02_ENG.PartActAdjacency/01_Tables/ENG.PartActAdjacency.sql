CREATE TABLE ENG.PartActAdjacency
(
	ParentPartActID	INT		,
	SonPartActID	INT		, 
	SonRowNum		INT		,
	SonPartActCoef	FLOAT	,
	SonPartActDays	INT		,
	RowDateTimeStamp DATETIME						
);
GO