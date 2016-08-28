CREATE NONCLUSTERED	 INDEX idx_Forecast1 ON MKT.Forecasts(ForecastIsOpen,ForecastYear,ForecastMonth,PartID)
INCLUDE ([ForecastID],[ForecastRowID],[ForecastQuant],[ForecastUpdatedDate]);