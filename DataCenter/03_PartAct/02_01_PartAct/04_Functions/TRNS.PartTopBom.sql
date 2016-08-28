/*
Identify the head of hierarchy by parameter. 
Part that dont hold this parameter will not be included in hierarchy.
Updated by Rafi Yedidya engineering dept at פרמטרים < קטגוריה
*/
CREATE FUNCTION TRNS.PartTopBom()
RETURNS @view TABLE
(
	PART		INT	,
	PARTNAME	VARCHAR(22)
)
AS
BEGIN
INSERT @view
SELECT DISTINCT		 T2.PART
					,T2.PARTNAME 
FROM [$(PriorityServer)].[$(PriorityDatabase)].dbo.PARTARC		AS T1
JOIN [$(PriorityServer)].[$(PriorityDatabase)].dbo.PART			AS T2 ON T2.PART=T1.PART
LEFT JOIN [$(PriorityServer)].[$(PriorityDatabase)].dbo.PARTARC	AS T3 ON T3.SON=T1.PART
JOIN [$(PriorityServer)].[$(PriorityDatabase)].dbo.PARTSPEC		AS T4 ON T4.PART=T2.PART
WHERE	T3.PART		IS NULL 
	AND (T4.SPEC19	= 'מלאי תוצג' OR T4.SPEC19	= 'תוצ"ג קבל"ש');

RETURN;
END;
GO