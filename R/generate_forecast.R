# @InputDataSet: input data frame, result of SQL query execution
# @OutputDataSet: data frame to pass back to SQL

# Test code
# library(RODBC)
# channel <- odbcDriverConnect(dbConnection)
# InputDataSet <- sqlQuery(channel, )
# odbcClose(channel)

# Libraries 
library(forecast)
library(zoo)

# Parameters
horizon <- 50

ad_df <- InputDataSet

# Helper functions extracting date-related information
# forecast ts format (year, weeknum)
date.info <- function(df) {
    weeknum <- function(date) {
        date <- as.Date(date)
        as.numeric(format(date, "%U"))
    }
    year <- function(date) {
        date <- as.Date(date)
        as.numeric(format(date, "%Y"))
    }

    date <- df$time[1]
    c(year(date), weeknum(date))
}

train.ts <- ts(ad_df$value, frequency = 12, start = date.info(ad_df))

arima.model <- auto.arima(train.ts)
arima.forecast <- forecast(arima.model, h = horizon)

actual <- arima.forecast$fitted
forecast <- arima.forecast$mean
lo95 <- arima.forecast$lower[, 1]
hi95 <- arima.forecast$upper[, 1]
final.ts <- ts.union(actual, forecast, lo95, hi95)

output <- data.frame(value = as.matrix(final.ts), time = as.character(as.Date(as.yearmon(time(final.ts)))))
colnames(output) <- c("actual", "forecast", "lo95", "hi95", "time")
OutputDataSet <- output