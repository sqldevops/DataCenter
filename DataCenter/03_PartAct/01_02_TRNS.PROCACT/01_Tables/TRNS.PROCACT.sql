/*
This table is populted with parts and processed thad had benn changed.
The table is populated  by EXTR.ERP_PROCACT, EXTR.ERP_PART procedure.
The table fires trigger to execute TRNS.PROCACT_ActPos or LOAD.PART_PartAct procedures.
*/
CREATE TABLE TRNS.PROCACT
(
	PART		INT	NOT NULL,		
	T$PROC		INT	NOT NULL,
	Source		VARCHAR(10)
	CONSTRAINT pk_EXTR_PartProcess PRIMARY KEY CLUSTERED (PART)
);
GO