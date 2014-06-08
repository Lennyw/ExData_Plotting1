## This first chunk separates the target data from the main data file and only keeps that subset in memory. 
## This assumes the wd is already set to the directory with household_power_consumptiton.txt.
## The data.table package is used for efficiency.
library(data.table)
data <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, 
                   colClasses=c("character", "character", "numeric", "numeric", "numeric", 
                                "numeric", "numeric", "numeric", "numeric"), na.strings = "?" )
data$Date <- as.Date(data$Date, "%d/%m/%Y")
data <- subset(data, data$Date >= "2007-02-01" & data$Date <= "2007-02-02")

## Second chunk is plot-specific.

## We create a combined time variable that we can plot our power usage against.
## Using as.POSIXct and strptime to convert the combined time to something better readable in script.
data$DateTime <- paste(data$Date, data$Time)
data$DateTime <- as.POSIXct(strptime(data$DateTime, "%Y-%m-%d %T"))

png(filename = "plot2.png", height = 480, width = 480)
## Our target graphic is a plot with lines with Global Active Power over our time frame.
plot(data$DateTime, data$Global_active_power, pch = NA, xlab = "", ylab = "Global Active Power (kilowatts)")
lines(data$DateTime, data$Global_active_power)
dev.off()