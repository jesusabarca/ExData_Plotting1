## This script downloads the data if it does not exist already and creates/stores the second plot from the Courser Project 1

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
png(filename="./plot2.png", width =  480, height = 480)

## Creates the actual plot.
plot(subData$Date, subData$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")

## Closes the png device and saves the image to disk.
dev.off()
