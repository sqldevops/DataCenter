INSERT INTO MKT.Forecasts	(
								ForecastRowID		,
								ForecastYear		,
								ForecastMonth		,
								PartID				,
								ForecastQuant		,
								ForecastIsOpen		,
								ForecastUpdatedDate	,
								DateTimeStamp		
							)
SELECT							ForecastRowID		,
								ForecastYear		,
								ForecastMonth		,
								PartID				,
								ForecastQuant		,
								ForecastIsOpen		,
								ForecastUpdatedDate	,
								DateTimeStamp	
FROM DataCenter.MKT.Forecasts;	