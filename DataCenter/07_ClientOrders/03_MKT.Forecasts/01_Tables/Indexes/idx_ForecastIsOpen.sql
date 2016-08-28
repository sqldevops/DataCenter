CREATE NONCLUSTERED			INDEX idx_ForecastIsOpen	ON MKT.Forecasts (ForecastIsOpen)
INCLUDE ([ForecastID],[ForecastRowID],[ForecastYear],[ForecastMonth],[PartID],[ForecastQuant],[ForecastUpdatedDate]);