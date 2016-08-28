CREATE FUNCTION TRNS.PartActStdTime()
RETURNS @view TABLE
(
	PartID			INT		,
	ActID			INT		,
	stdTimeEmployee	FLOAT	,
	stdTimeMachine	FLOAT
)
AS
BEGIN
INSERT @view
SELECT	 P.PART			AS PartID
		,P.ACT			AS ActID
		,ISNULL(P.E,0)	AS stdTimeEmployee
		,ISNULL(P.T,0)	AS stdTimeMachine
FROM
(

	SELECT	 PART	
			,ACT	
			,PARAM	
			,SIZE	
	FROM [$(PriorityServer)].[$(PriorityDatabase)].dbo.PARTVAR
	WHERE VALID='Y' AND ACT>0

) AS S
PIVOT
(
	SUM (SIZE)
	FOR PARAM IN (E,T)
) AS P;
RETURN;
END;
GO