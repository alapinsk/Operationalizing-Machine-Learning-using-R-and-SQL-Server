CREATE PROCEDURE [get_forecast]
	@date date = NULL
AS
BEGIN


DECLARE @forecast_table TABLE ([actual] float NULL, [forecast] float NULL, [lo95] float NULL, [hi95] float NULL, [time] date NOT NULL)
INSERT @forecast_table
EXEC generate_forecast

SELECT * FROM @forecast_table WHERE [time] = @date
OR
ISNULL(@date, '1900-01-01') = '1900-01-01'

END;
