library(forecast)
library(prophet)
library(plyr)


# Parameters
horizon = 50

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

#Compute context
cstr <- settings$dbConnection
sql <- RxInSqlServer(connectionString = cstr)
local <- RxLocalSeq()

#Set compute context
RxComputeContext(local)

#Import data from SQL Server
airPax_table <- RxSqlServerData(table = "air_passengers", connectionString = cstr)
data <- rxImport(airPax_table)

#Get summary 
rxSummary(~ value, data)

#Transform dataframe to time series object
train.ts <- ts(data$value, frequency = 12, start = date.info(data))
plot(decompose(train.ts))

#Train models
arima.model <- auto.arima(train.ts)
ets.model <- ets(train.ts)
naive.model <- snaive(train.ts)

#Visualize
plot(forecast(arima.model, h = horizon))
plot(forecast(ets.model, h = horizon))

