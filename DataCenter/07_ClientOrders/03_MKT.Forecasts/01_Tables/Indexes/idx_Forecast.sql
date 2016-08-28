CREATE NONCLUSTERED			INDEX idx_Forecast	ON MKT.Forecasts(ForecastYear,ForecastMonth,PartID)
WHERE ForecastIsOpen=1