INSERT INTO OPR.WorkOrders
SELECT * FROM [$(DataCenterServer)].[$(DataCenterDatabase)].OPR.WorkOrders;
GO