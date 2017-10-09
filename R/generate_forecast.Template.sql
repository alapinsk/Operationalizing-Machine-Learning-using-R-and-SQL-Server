CREATE PROCEDURE [generate_forecast]
AS
BEGIN

EXEC sp_execute_external_script @language = N'R'
    , @script = N'_RCODE_'
    , @input_data_1 = N'_INPUT_QUERY_'
    WITH RESULT SETS (([actual] float NULL,
					   [forecast] float NULL,
					   [lo95] float NULL,
					   [hi95] float NULL,
					   [time] date NOT NULL));
END;
