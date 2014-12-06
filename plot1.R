## this code uses functions from the R.utils, dplyr, lubridate, taRifx and datasets packages. 
library(R.utils)
library(dplyr)
library(lubridate)
library(taRifx)
library(datasets)

## ensure that the household_power_consumption.txt file is in the working directory
data <- readTable("./household_power_consumption.txt", header=TRUE, sep=";", rows=seq(from=65000, to=70000), colClasses = c(rep("character", 9)))
data <- filter(data, Date =="1/2/2007" | Date=="2/2/2007")

## Converting the date and time columns to the correct format
data$Date = dmy(data$Date)
data$Time = hms(data$Time)

## Converting all other columns to numeric
data <- japply(data, which(sapply(data, class)=="character"), as.numeric)

## Plot 1
png(file="plot1.png")
par(mar = c(5,5,4,1))
hist(data$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
dev.off()