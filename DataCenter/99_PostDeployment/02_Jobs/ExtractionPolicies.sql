IF OBJECT_ID('ETL.ExtractionPolicies') IS NOT NULL DROP TABLE ETL.ExtractionPolicies;
GO
CREATE TABLE ETL.ExtractionPolicies
(	
	 ExtractionPolicyID			INT IDENTITY (10,1)	NOT NULL	
	,ExtractionPolicy				CHAR(1)
	,ExtractionPolicyType			VARCHAR(25)
	,ExtractionPolicyFrequency		VARCHAR(10)
	,ExtractionPolicyOccureEvery	INT		
	,ExtractionPolicyStartTime		TIME
	,ExtractionPolicyEndTime		TIME
	 CONSTRAINT pk_ExtractionPolicies PRIMARY KEY CLUSTERED (ExtractionPolicyID)
);
GO

-------------------------------------------------------------------------------------------

INSERT INTO ETL.ExtractionPolicies VALUES
 ('A','Automated'	,'Daily'	,1		,'06:00:00'	,'20:00:00')
,('B','Automated'	,'Daily'	,15		,'06:00:00'	,'20:00:00')
,('C','Automated'	,'Daily'	,60		,'06:00:00'	,'20:00:00')
,('D','Automated'	,'Once'		,NULL	,'00:00:00'	,NULL)
,('E','Manual'		,NULL		,NULL	,NULL		,NULL);

GO

