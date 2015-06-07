# Plot2.R Source Code

# Lets open PNG device for writing plot1.png
png(filename = "plot2.png", width = 480, height = 480)

# Load sqldf library to use read.csv.sql to avoid high memory comsumption
library(sqldf)

# Load GGPlot2 library to plot #2 image.
library(ggplot2)

# Sorry but I need this as my locale is pt_BR
daysinweek <- c("Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat")

# The assumption here is that the data set file is at the same directory of the script
epcds <- read.csv.sql(file = "household_power_consumption.txt", 
                      sql = "select * from file where Date = '1/2/2007' or Date = '2/2/2007'", 
                      colClasses = c("character", "character", "numeric", "numeric", "numeric",
                                     "numeric", "numeric", "numeric", "numeric"), sep = ";")


# Get correct days of week. First day is Sunday and it is equals 0.
daycolumn <- daysinweek[as.POSIXlt(as.Date(epcds$Date, "%d/%m/%Y"))$wday + 1]

# Now just get a correct set with correct columns
sset <- cbind(daycolumn, epcds[,c(2:9)])

# Now that we have the data, lets plot!
hist(epcds$Global_active_power, col = "red")

# We need to assure that device is turned off after
# we finish our job!
dev.off()