CREATE TABLE OPR.WorkOrders
(
	 WrkOrdID			INT			NOT NULL
	,WrkOrd				VARCHAR(22)
	,PartID				INT
	,WrkOrdStatID		INT
	,WrkOrdStat			VARCHAR(12)
	,WrkOrdQuant		INT
	,WrkOrdClosedDate	DATETIME
	,WrkOrdCreatedDate	DATETIME
	,WrkOrdStartDate	DATE
	,WrkOrdEndDate		DATE	
	,WrkOrdIsActive		BIT
	,DateTimeStamp		DATETIME
	 CONSTRAINT pk_OPR_WorkOrders PRIMARY KEY CLUSTERED (WrkOrdID)
);

GO