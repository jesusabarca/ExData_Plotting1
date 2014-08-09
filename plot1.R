## This script downloads the data if it does not exist already and creates/stores the first plot from the Courser Project 1

## If the file does not exist, then downloads the file from the remote server.
destfile <- "./household_power_consumption.zip"
if(!file.exists(destfile)) {
    fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(fileUrl, destfile = destfile, method = "curl")
}

## Unzips dataset
unzip(destfile)

## Reads the whole dataset since it's not that big
data <- read.table("household_power_consumption.txt", sep = ";", header = T, na.strings = "?")

## Transforms the Date column into a usable date format dd/mm/yyyy
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

## Transforms the Time column into a usable time format hh:mm:ss. Note that the date parte of this variable was created automaticly 
## by the strptime function and thus, it has no meaning whatsoever.
data$Time <- strptime(data$Time, format = "%H:%M:%S")

## Subsets the data to only include from the dates 2007-02-01 (feb 1st 2007) and 2007-02-02 (feb 2nd 2007)
subData <- subset(data, Date == as.Date("2007-02-01") | Date == as.Date("2007-02-02"))

## Opens a png device and sets the width and height of the image.
png(filename="./plot1.png", width =  480, height = 480)

## Creates the actual plot.
hist(subData$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red")

## Closes the png device and saves the image to disk.
dev.off()