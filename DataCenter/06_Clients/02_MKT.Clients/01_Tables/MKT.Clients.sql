CREATE TABLE MKT.Clients
(
	 ClientID		INT			NOT NULL 
	,Client			VARCHAR(16)	NOT NULL
	,ClientDes		VARCHAR(48)	NOT NULL
	,ClientPriority	INT 
	,ClientStatusID	INT			NOT NULL
	,ClientStatus	VARCHAR(12)	NOT NULL
	,CountryID		INT
	,Country		VARCHAR(18)
	,CurrencyID		INT			NOT NULL
	,Currency		VARCHAR(3)	NOT NULL
	,Parameter01	VARCHAR(32)	
	,Parameter02	VARCHAR(32)	
	,Parameter03	VARCHAR(32)	
	,Parameter06	VARCHAR(32)	
	,Parameter09	VARCHAR(32)	
	,DateTimeStamp	DATETIME	NOT NULL
	CONSTRAINT pk_Clients PRIMARY KEY (ClientID)
);
GO