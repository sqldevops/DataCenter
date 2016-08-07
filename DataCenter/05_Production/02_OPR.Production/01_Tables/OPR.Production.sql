CREATE TABLE OPR.Production
(	
	 ProductionRowID		INT			NOT NULL
	,ProductionFormID		INT			NOT NULL
	,ProductionForm			VARCHAR(16)	NOT NULL
	,WrkOrdID				INT			NOT NULL
	,PartID					INT			NOT NULL
	,ActID					INT			NOT NULL
	,ActIsLast				BIT			NOT NULL
	,ProductionPass			INT			NOT NULL
	,ProductionFail			INT			NOT NULL
	,ProductionDateID		INT			NOT NULL
	,ProductionDate			DATE		NOT NULL
	,ProductionStartDate	DATE		
	,ProductionEndDate		DATE		
	,ReportingDateTime		DATETIME	NOT NULL	
	,ProdTime				INT			NOT NULL
	,WorkCenterID			INT			NOT NULL
	,UserID					INT			NOT NULL
	,DateTimeStamp			DATETIME	NOT NULL
	 CONSTRAINT pk_ProductionReport PRIMARY KEY (ProductionRowID)
);
GO
