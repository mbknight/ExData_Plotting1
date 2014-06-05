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

# Plot 4
png('plot4.png')
par(mfrow=c(2,2))
#4.1
plot(feb_data$Time, feb_data$Global_active_power, type = "l", ylab = "Global Active Power", xlab = "")
#4.2
plot(feb_data$Time, feb_data$Voltage, type = "l", ylab = "Voltage", xlab = "datetime")
#4.3
plot(feb_data$Time, feb_data$Sub_metering_1, type = "n", ylab = "Energy sub metering", xlab = "")
lines(feb_data$Time, feb_data$Sub_metering_1)
lines(feb_data$Time, feb_data$Sub_metering_2, col = "red")
lines(feb_data$Time, feb_data$Sub_metering_3, col = "blue")
legend("topright", bty = "n", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, col = c("black", "red", "blue"))
#4.4
plot(feb_data$Time, feb_data$Global_reactive_power, type = "l", ylab = "Global_reactive_power", xlab = "datetime")
dev.off()