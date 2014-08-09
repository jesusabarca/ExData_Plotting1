## This script downloads the data if it does not exist already and creates/stores the fourth plot from the Courser Project 1

## If the file does not exist, then downloads the file from the remote server.
destfile <- "./household_power_consumption.zip"
if(!file.exists(destfile)) {
    fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(fileUrl, destfile = destfile, method = "curl")
}

## Unzips dataset
unzipedFile <- "./household_power_consumption.txt"
if(!file.exists(destfile)) {
    unzip(destfile)
}

## Reads the whole dataset since it's not that big
data <- read.table(unzipedFile, sep = ";", header = T, na.strings = "?")

## Transforms the Date column into a usable date format dd/mm/yyyy HH:MM:SS
data$Date <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")

## Transforms the Time column into a usable time format hh:mm:ss. Note that the date parte of this variable was created automaticly 
## by the strptime function and thus, it has no meaning whatsoever.
data$Time <- strptime(data$Time, format = "%H:%M:%S")

## Subsets the data to only include from the dates 2007-02-01 (feb 1st 2007) and 2007-02-02 (feb 2nd 2007)
subData <- subset(data, Date > strptime("2007-02-01", "%Y-%m-%d") & Date < strptime("2007-02-03", "%Y-%m-%d"))

## Opens a png device and sets the width and height of the image.
png(filename="./plot4.png", width =  480, height = 480)

## Creates a 2x2 grid for placing the four plots.
par(mfrow = c(2, 2))

## Creates the first plot in (1, 1)
plot(subData$Date, subData$Global_active_power, type = "l", ylab = "Global Active Power", xlab = "")

## Creates the second plot in (1, 2)
plot(subData$Date, subData$Voltage, type = "l", ylab = "Voltage", xlab = "datetime", col = "black")

## Creates the third plot in (2, 1)
plot(subData$Date, subData$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "", col = "black")
lines(subData$Date, subData$Sub_metering_2, col = "red")
lines(subData$Date, subData$Sub_metering_3, col = "blue")
legend("topright", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd = 1, bty = "n")

## Creates the fourth plot in (2, 2)
plot(subData$Date, subData$Global_reactive_power, type = "l", ylab = "Global_reactive_power", xlab = "datetime")

## Closes the png device and saves the image to disk.
dev.off()
