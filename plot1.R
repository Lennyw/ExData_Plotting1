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

png(filename = "plot1.png", height = 480, width = 480)
hist(data$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()