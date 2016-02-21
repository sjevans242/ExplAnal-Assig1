## delimited with ";"
## need data rows 66638 to 69517
## reader header only
header <- read.table("household_power_consumption.txt", nrows = 1, header = FALSE, sep =';', stringsAsFactors = FALSE)
## read needed lines and add header
data <- read.table("household_power_consumption.txt", skip = 66637, nrows = 2880, sep = ";",
    col.names = header, na.strings = "?")
## convert Date and Time columns to class 'Date' and 'POSIXt'
data$Time <- paste(data$Date, data$Time, sep = " ")
data$Date <- as.Date(data$Date, "%d/%m/%Y")
data$Time <- strptime(data$Time, "%d/%m/%Y %H:%M:%S")

## create png file
png(file = "plot1.png")
hist(data$Global_active_power, 
     col = "red", 
     xlab = "Global Active Power (kilowatts)", 
     main = "Global Active Power")
## close connection to file
dev.off()


