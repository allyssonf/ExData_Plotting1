# Plot2.R Source Code

# Lets open PNG device for writing plot1.png
png(filename = "plot2.png", width = 480, height = 480)

# Load sqldf library to use read.csv.sql to avoid high memory comsumption
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

# Now that we have the data, lets plot!
plot(epcds$TSColumn, epcds$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")

# We need to assure that device is turned off after
# we finish our job!
dev.off()