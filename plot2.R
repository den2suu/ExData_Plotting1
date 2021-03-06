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

## plot 2
plot(plotdata$datetime, plotdata$Global_active_power, main = "", type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.copy(png, file = "plot2.png", width = 480, height = 480)
dev.off()