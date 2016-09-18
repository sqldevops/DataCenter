INSERT INTO ENG.Parts
SELECT * 
FROM [$(DataCenterServer)].[$(DataCenterDatabase)].ENG.Parts;
GO