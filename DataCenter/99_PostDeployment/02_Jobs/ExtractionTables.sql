IF OBJECT_ID('ETL.ExtractionTables') IS NOT NULL DROP TABLE ETL.ExtractionTables;
GO
-------------------------------------------------------------------------------------------
CREATE TABLE ETL.ExtractionTables
(
	 ExtractionTableID			INT IDENTITY (1000,1)	NOT NULL
	,ExtractionTableServer		VARCHAR(25)				NOT NULL
	,ExtractionTableDatabase	VARCHAR(25)				NOT NULL
	,ExtractionTableSchema		VARCHAR(15)				NOT NULL
	,ExtractionTableName		VARCHAR(25)				NOT NULL
	,ExtractionCategory			VARCHAR(25)				NOT NULL
	,ExtractionType				VARCHAR(15)				NOT NULL
	,ExtractionAgent			VARCHAR(25)				NOT NULL
	,ExtractionPolicy			CHAR(1)					NOT NULL
	,ExtractionTableIsActive	BIT						NOT NULL
	 CONSTRAINT pk_ExtractionTables PRIMARY KEY CLUSTERED (ExtractionTableID)
);
GO
-------------------------------------------------------------------------------------------

INSERT INTO ETL.ExtractionTables VALUES
 ('Priority','cele'		,'dbo'	,'PART'			,'Engineering'	,'Incremental'	,'EXTR.ERP_PART'		,'A',1)
--,('Priority','cele'		,'dbo'	,'PROCACT'		,'Engineering'	,'Incremental'		,'EXTR.ERP_PROCACT'		,'E',1)
,('Priority','cele'		,'dbo'	,'ORDERITEMS'	,'Marketing'	,'Incremental'	,'EXTR.ERP_ORDERITEMS'	,'A',1)
,('Priority','cele'		,'dbo'	,'ALINE'		,'Operations'	,'Incremental'	,'EXTR.ERP_ALINE'		,'A',1)
--,('Priority','cele'		,'dbo'	,'SERACT'		,'Operations'	,'Incremental'		,'EXTR.ERP_SERACT'		,'E',1)
,('Priority','cele'		,'dbo'	,'SERIAL'		,'Operations'	,'Incremental'	,'EXTR.ERP_SERIAL'		,'A',1)
--,('Priority','system'	,'dbo'	,'USERSB'		,'General'		,'Bulk'				,'EXTR.ERP_USERSB'		,'E',1)
--,('Priority','cele'		,'dbo'	,'WAREHOUSES'	,'Logistics'	,'Bulk'				,'EXTR.ERP_WAREHOUSES'	,'E',1)
,('Priority','cele'		,'dbo'	,'CUSTOMERS'	,'Marketing'	,'Bulk'			,'EXTR.ERP_CUSTOMERS'	,'A',1)
,('Priority','cele'		,'dbo'	,'PARTARC'		,'Engineering'	,'Incremental'	,'EXTR.ERP_PROCACT'		,'A',1);
 GO
