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


png(file = 'repo\\plot4.png',
    width = 480,
    height = 480)

par(mfrow = c(2,2),
    oma = c(0,0,0,0),
    mar = c(5,4,2,2))

# top left plot
with(power.data.feb, plot(DateTime,
                          Global_active_power,
                          type='l',
                          lwd = 2,
                          ylab = 'Global Active Power',
                          xlab = ''))


# top right plot
with(power.data.feb, plot(DateTime,
                          Voltage,
                          type='l',
                          lwd = 2,
                          ylab = 'Voltage',
                          xlab = ''))



# bottom left plot
with(power.data.feb, plot(DateTime,
                          Sub_metering_1,
                          type='l',
                          lwd = 1,
                          ylab = 'Energy sub metering',
                          xlab = ''))
with(power.data.feb, lines(DateTime,
                           Sub_metering_2,
                           col = "red"))
with(power.data.feb, lines(DateTime,
                           Sub_metering_3,
                           col = "blue"))

legend("topright",
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black","red","blue"),
       lty = 1,
       bty = 'n')


# bottom right plot
with(power.data.feb, plot(DateTime,
                          Global_reactive_power,
                          type='l',
                          lwd = 1,
                          ylab = 'Global Reactive Power',
                          xlab = ''))


dev.off()