## This script downloads the data if it does not exist already and creates/stores the first plot from the Courser Project 1

## If the file does not exist, then downloads the file from the remote server.
destfile <- "./household_power_consumption.zip"
if(!file.exists(destfile)) {
    fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(fileUrl, destfile = destfile, method = "curl")
}

## Unzips dataset
unzip(destfile)