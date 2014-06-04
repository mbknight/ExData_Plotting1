# load library downloader so I can get https files
library("downloader", lib.loc="/Library/Frameworks/R.framework/Versions/3.0/Resources/library")

# First download the file
thefile <- tempfile()
download("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", thefile)
power_data <- read.table(unz(thefile, "household_power_consumption.txt"), header = TRUE, sep=";")
unlink(thefile)

# convert the dates
power_data$Date <- as.Date(power_data$Date, "%d/%m/%Y")
power_data$Time <- strptime(paste(power_data$Date, power_data$Time), "%Y-%m-%d %H:%M:%S")

# Then subset it and remove the old frame
feb_data <- power_data[power_data$Date >= as.Date("2007-02-01") & power_data$Date <= as.Date("2007-02-02"),]
rm(power_data)