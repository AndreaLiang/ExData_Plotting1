## this code uses functions from the R.utils, dplyr, lubridate, taRifx and datasets packages. 
library(R.utils)
library(dplyr)
library(lubridate)
library(taRifx)
library(datasets)

## ensure that the household_power_consumption.txt file is in the working directory
data <- readTable("./household_power_consumption.txt", header=TRUE, sep=";", rows=seq(from=65000, to=70000), colClasses = c(rep("character", 9)))
data <- filter(data, Date =="1/2/2007" | Date=="2/2/2007")

## Merging the date and time columns and converting them to the correct format
data <- mutate(data, datetime = paste(Date, Time))
data$datetime = dmy_hms(data$datetime)
data <- select(data, -Date, -Time)

## Converting all other columns to numeric
data <- japply(data, which(sapply(data, class)=="character"), as.numeric)

## Plot 3
png(file="plot3.png")
par(mar = c(5,5,4,1))
with(data, plot(datetime, Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering"))
with(data, lines(datetime, Sub_metering_2, col = "red"))
with(data, lines(datetime, Sub_metering_3, col = "blue"))
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()
