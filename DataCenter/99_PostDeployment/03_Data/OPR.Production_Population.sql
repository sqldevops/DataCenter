INSERT INTO OPR.Production
SELECT * 
FROM [$(DataCenterServer)].[$(DataCenterDatabase)].OPR.Production;