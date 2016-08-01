CREATE TABLE ENG.Parts
(
	 PartID			INT							NOT NULL
	,Part			VARCHAR(22)					NOT NULL
	,PartHebDes		VARCHAR(48)					NOT NULL
	,PartEngDes		VARCHAR(48)					NOT NULL
	,PartType		CHAR(1)						NOT NULL
	,ProcessID		INT							NOT NULL
	,Process		VARCHAR(6)					NOT NULL
	,FamilyID		INT							NOT NULL
	,Family			VARCHAR(8)					NOT NULL
	,FamilyDes		VARCHAR(32)					NOT NULL
	,PartStatusID	INT							NOT NULL
	,PartStatus		VARCHAR(12)					NOT NULL
	,Symbol			VARCHAR(20)		--SPEC3			
	,Package		VARCHAR(20)		--SPEC4
	,Parameter08	VARCHAR(12)		--SPEC8	
	,Parameter10	VARCHAR(12)		--SPEC10	
	,Parameter19	VARCHAR(12)		--SPEC19	
	,RowDateTimeStamp DATETIME					NOT NULL				
);
GO
CREATE CLUSTERED INDEX idx_Parts ON ENG.Parts (PartID);
GO