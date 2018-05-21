library(dplyr)
library(lubridate)

setwd('H:\\Courses\\Coursera\\EDA\\Week1')

temp <- read.delim('household_power_consumption.txt',
                   sep = ';',
                   stringsAsFactors = F,
                   nrows=10)

classes <- sapply(temp, class)

power.data <- read.delim('household_power_consumption.txt',
                         sep = ';',
                         na.strings = '?',
                         colClasses = classes)

power.data$DateTime <- with(power.data, paste(Date, Time))
power.data$DateTime <- strptime(power.data$DateTime, format = "%d/%m/%Y %H:%M:%S")
power.data.feb <- subset(power.data, as.Date(DateTime) %in% c(ymd("2007-02-01"), ymd("2007-02-02")))



png(file = 'repo\\plot1.png',
    width = 480,
    height = 480)

with(power.data.feb, hist(Global_active_power,
                          col = "red",
                          main = "Global Active Power",
                          xlab = "Global Active Power (kilowatts)"))

dev.off()