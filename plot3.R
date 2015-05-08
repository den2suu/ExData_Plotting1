## plot3
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

## plot 3
## selecting datetime, Sub_metering1:3
plot3data <- plotdata %>% select(datetime, Sub_metering_1:Sub_metering_3)
## designating colors
colors = c("black", "red", "blue")
## labels
labels = colnames(plot3data)[-1]
## drawing graph
png("plot3.png", width = 400, height = 400)
plot(plot3data[,1], plot3data[,2], type = "l", main = "", xlab = "", ylab = "Energy sub metering", col = colors[1])
for ( i in 3:4) {
  lines(plot3data[, 1], plot3data[, i], col = colors[i-1])
}
## legend
legend("topright", legend = labels, col = colors, lty = "solid")
## close dev
dev.off()