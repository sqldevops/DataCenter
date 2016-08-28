CREATE TABLE MKT.ClientOrders
(	
	 RowID						INT IDENTITY (100000,1)		NOT NULL
	,ClientOrderRowID			INT							NOT NULL
	,ClientOrderID				INT							NOT NULL
	,ClientOrder				VARCHAR(16)					NOT NULL
	,ClientOrderStatusID		INT							NOT NULL
	,ClientOrderStatus			VARCHAR(12)					NOT NULL
	,ClientID					INT							NOT NULL
	,PartID						INT							NOT NULL
	,ClientOrderQuant			INT
	,ClientOrderBalance			INT
	,ClientOrderDueDateID		INT 
	,UserID						INT
	,ClientOrderIsOpen			BIT
	,DateTimeStamp				DATETIME					NOT NULL
	CONSTRAINT pk_ClientOrders PRIMARY KEY (RowID)
);