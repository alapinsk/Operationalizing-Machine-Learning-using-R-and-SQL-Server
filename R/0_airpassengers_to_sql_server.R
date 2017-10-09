library(forecast)
library(zoo)

data(AirPassengers)
ap <- AirPassengers
ap_df <- data.frame(value = as.matrix(ap), time = as.character(as.Date(as.yearmon(time(ap)))))

ap_table <- RxOdbcData(table = "air_passengers", connectionString = settings$dbConnection)
rxOpen(ap_table, "w")

rxDataStep(inData = ap_df,
           outFile = ap_table,
           overwrite = TRUE)

rxExecuteSQLDDL(ap_table, sSQLString = paste("ALTER TABLE air_passengers ALTER COLUMN time date NOT NULL", sep = ""))






