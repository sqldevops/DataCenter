INSERT INTO MKT.Clients
SELECT * 
FROM [$(DataCenterServer)].[$(DataCenterDatabase)].MKT.Clients;