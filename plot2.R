# load library downloader so I can get https files and set the working directory
library("downloader", lib.loc="/Library/Frameworks/R.framework/Versions/3.0/Resources/library")
setwd("~/Documents/Coursera/Exploratory/Project 1/ExData_Plotting1")

# First download the file
thefile <- tempfile()
download("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", thefile)
power_data <- read.table(unz(thefile, "household_power_consumption.txt"), header = TRUE, sep=";")
unlink(thefile)

# convert the dates
power_data$Date <- as.Date(power_data$Date, "%d/%m/%Y")
power_data$Time <- strptime(paste(power_data$Date, power_data$Time), "%Y-%m-%d %H:%M:%S")


# Then subset it and remove the old frame
feb_data <- power_data[(power_data$Date >= as.Date("2007-02-01", "%Y-%m-%d") & power_data$Date <= as.Date("2007-02-02", "%Y-%m-%d")),]
rm(power_data)

# redo the fields
feb_data$Global_active_power <- as.numeric(as.character(feb_data$Global_active_power))
feb_data$Sub_metering_1 <- as.numeric(as.character(feb_data$Sub_metering_1))
feb_data$Sub_metering_2 <- as.numeric(as.character(feb_data$Sub_metering_2))
feb_data$Sub_metering_3 <- as.numeric(as.character(feb_data$Sub_metering_3))
feb_data$Voltage <- as.numeric(as.character(feb_data$Voltage))
feb_data$Global_reactive_power <- as.numeric(as.character(feb_data$Global_reactive_power))

# Plot 2
png('plot2.png')
plot(feb_data$Time, feb_data$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")
dev.off()