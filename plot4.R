# Plot4.R Source Code

# Lets open PNG device for writing plot1.png
png(filename = "plot4.png", width = 480, height = 480)

# Load sqldf library to use read.csv.sql to avoid high memory comsumption.
library(sqldf)

# The assumption here is that the data set file is at the same directory of the script
epcds <- read.csv.sql(file = "household_power_consumption.txt", 
                      sql = "select * from file where Date = '1/2/2007' or Date = '2/2/2007'", 
                      colClasses = c("character", "character", "numeric", "numeric", "numeric",
                                     "numeric", "numeric", "numeric", "numeric"), sep = ";")


# Generate a timestamp that will serve as X axis on plot.
TSColumn <- strptime(x = paste(epcds$Date, epcds$Time, sep = " "), "%d/%m/%Y %H:%M")

# Get correct days of week. First day is Sunday and it is equals 0.
epcds$Date <- as.POSIXlt(as.Date(epcds$Date, "%d/%m/%Y"))

# Merge new column to original dataset
epcds <- cbind(TSColumn, epcds)

# Here we define how our plot image will look like (2 rows x 2 columns)
par(mfrow = c(2, 2), mar = c(5, 5, 5, 1))

# Plot #1 - Global Active Power
with(epcds, plot(epcds$TSColumn, epcds$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)"))

# Plot #2 - Voltage
with(epcds, plot(epcds$TSColumn, epcds$Voltage, type="l", xlab="datetime", ylab="Voltage"))

# Plot #3 - Energy Sub Metering
with(epcds, {plot(TSColumn, Sub_metering_1, type = "l", xlab = "", ylab = "Energy Sub Metering")
  lines(TSColumn, Sub_metering_2, col = "red")
  lines(TSColumn, Sub_metering_3, col = "blue")
  legend("topright", lty = c(1,1), lwd = c(1,1), col = c("black", "red", "blue"), 
         c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
})

# Plot #4 - Global Reactive Power
with(epcds, plot(epcds$TSColumn, epcds$Global_reactive_power, type="l", xlab="datetime", ylab = "Global_reactive_power"))

# We need to assure that device is turned off after
# we finish our job!
dev.off()