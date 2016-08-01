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
 ('Priority','cele'		,'dbo'	,'PART'			,'Engineering'	,'IncrementalAcc'	,'EXTR.ERP_PART'		,'A',1);
 GO
