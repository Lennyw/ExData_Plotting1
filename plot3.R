## This first chunk separates the target data from the main data file and only keeps that subset in memory. 
## This assumes the wd is already set to the directory with household_power_consumptiton.txt.
## The data.table package is used for efficiency.
library(data.table)
data <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, 
                   colClasses=c("character", "character", "numeric", "numeric", "numeric", 
                                "numeric", "numeric", "numeric", "numeric"), na.strings = "?" )
data$Date <- as.Date(data$Date, "%d/%m/%Y")
data <- subset(data, data$Date >= "2007-02-01" & data$Date <= "2007-02-02")

## Second chunk can be reused from plot2 as we will be using these combined date/times for plots 3 and 4.

## We create a combined time variable that we can plot our power usage against.
## Using as.POSIXct and strptime to convert the combined time to something better readable in script.
data$DateTime <- paste(data$Date, data$Time)
data$DateTime <- as.POSIXct(strptime(data$DateTime, "%Y-%m-%d %T"))

## Different than plot2, we want a legend and colors to describe the sub measurements

png(filename = "plot3.png", height = 480, width = 480)

## We use Sub_metering_1 to set the scale for the y-axis where all the values for the line plots of 
## the 3 series will be visible. 
plot(data$DateTime, data$Sub_metering_1, pch = NA, xlab = "", ylab = "Energy sub metering")
lines(data$DateTime, data$Sub_metering_1)
lines(data$DateTime, data$Sub_metering_2, col = "red")
lines(data$DateTime, data$Sub_metering_3, col = "blue")

legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lwd = c(1, 1, 1), col = c("black", "red", "blue"))
dev.off()
