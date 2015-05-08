## setting system locale into en
Sys.setlocale("LC_ALL", "en_US.UTF-8")
## including library
library(lubridate)
library(dplyr)
## reading data
dt <- read.table("household_power_consumption.txt", header = T, sep = ";", na.strings = "?")
## lubridating of Date
dt$Date <- dmy(dt$Date)
## extracting the date 2007-02-01 and 2007-01-02
exdt <- dt %>% filter(as.Date(Date) == as.Date("2007-02-01") | as.Date(Date) == as.Date("2007-02-02"))
## integrating Date and Time 
datetime <- as.POSIXlt(paste(exdt$Date, exdt$Time), tz = "America/Los_Angeles", format = "%Y-%m-%d %H:%M:%S")
## combining datetime and extractdata
plotdata <- data.frame(datetime = datetime, exdt)


## plot4
png("plot4.png", width = 400, height = 400)
par(mfcol = c(2,2))
## topleft same as plot2
plot(plotdata$datetime, plotdata$Global_active_power, main = "", type = "l", xlab = "", ylab = "Global Active Power")

## botom right same as plot3 without legend's frame border
plot3data <- plotdata %>% 
  select(datetime, Sub_metering_1:Sub_metering_3)
## designating colors
colors = c("black", "red", "blue")
## designating labels
labels = colnames(plot3data)[-1]
## drawing graph
plot(plot3data[, 1], plot3data[, 2], type = "l", main = "", xlab = "", ylab = "Enegy sub metering")
for (i in 3:4) {
  lines(plot3data[, 1], plot3data[, i], col = colors[i-1])
}
legend("topright", legend = labels, col = colors, cex = 0.5, lty = "solid", bty = "n")

## topright voltage
plot(plotdata$datetime, plotdata$Voltage, type = "l", main = "", xlab = "datetime", ylab = "Voltage")

## bottomright Global_reactive_power
plot(plotdata$datetime, plotdata$Global_reactive_power, type = "l", main = "", xlab = "datetime", ylab = "Global_reactive_power")
## close dev
dev.off()