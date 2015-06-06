# Plot1.R Source Code

# Lets open PNG device for writing plot1.png
png(filename = "plot1.png", width = 480, height = 480)

# Load sqldf library to use read.csv.sql to avoid high memory comsumption
library(sqldf)

# The assumption here is that the data set file is at the same directory of the script
epcds <- read.csv.sql(file = "household_power_consumption.txt", 
                      sql = "select * from file where Date = '2/2/2007' or Date = '1/2/2007'", 
                      colClasses = c("character", "character", "numeric", "numeric", "numeric",
                                     "numeric", "numeric", "numeric", "numeric"), sep = ";")

# Now that we have the data, lets plot!
hist(epcds$Global_active_power, col = "red")

# We need to assure that device is turned off after
# we finish our job!
dev.off()