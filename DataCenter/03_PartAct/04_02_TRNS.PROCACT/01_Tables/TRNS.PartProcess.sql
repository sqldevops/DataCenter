﻿CREATE TABLE TRNS.PartProcess
(
	PART		INT	NOT NULL,		
	T$PROC		INT	NOT NULL,
	Source		VARCHAR(10)
	CONSTRAINT pk_EXTR_PartProcess PRIMARY KEY CLUSTERED (PART)
);
GO