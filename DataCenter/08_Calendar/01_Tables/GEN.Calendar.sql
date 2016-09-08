CREATE TABLE GEN.Calendar
(
	[DateInt]	INT			NOT NULL,
	[DateStr]	VARCHAR(20)	NOT NULL,
	[Year]		INT			NOT NULL,
	[YrNN]		INT			NOT NULL,
	[YYYYMM]	INT			NOT NULL,
	[Month]		INT			NOT NULL,
	[Day]		INT			NOT NULL,
	[WkDNo]		INT			,
	[workDay]	INT			NOT NULL,
	[WkDName]	NCHAR(9),
	[WkDName2]	NCHAR(2),
	[WkDName3]	NCHAR(3),
	[JulDay]	INT,
	[Week]		INT,
	[WkNo]		INT,
	[Qtr]		INT,
	[Last]		INT,
	[LdOfMo]	INT,
	[LDtOfMo]	DATE		NOT NULL
	CONSTRAINT pk_Calendar PRIMARY KEY CLUSTERED (DateInt)
);