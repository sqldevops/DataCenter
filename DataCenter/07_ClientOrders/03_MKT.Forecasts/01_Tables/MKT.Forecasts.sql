CREATE TABLE MKT.Forecasts
(	
	 ForecastID				INT IDENTITY (100000,1)		NOT NULL
	,ForecastRowID			INT							NOT NULL
	,ForecastYear			INT							NOT NULL
	,ForecastMonth			INT							NOT NULL
	,PartID					INT							NOT NULL
	,ForecastQuant			INT
	,ForecastIsOpen			BIT
	,ForecastUpdatedDate	DATETIME
	,DateTimeStamp			DATETIME					NOT NULL
	 CONSTRAINT pk_Forecasts PRIMARY KEY (ForecastID)	
);