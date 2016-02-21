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

## open connection to png file
png(file = "plot4.png")
## setup layout
par(mfrow = c(2,2))
## plot 1st graph
plot(data$Time, data$Global_active_power, 
     type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowatts")
## plot 2nd graph
plot(data$Time, data$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
## plot 3rd graph
plot(data$Time, data$Sub_metering_1, 
     xlab = "", ylab = "Energy sub metering", "n")
lines(data$Time, data$Sub_metering_1)
lines(data$Time, data$Sub_metering_2, col = "red")
lines(data$Time, data$Sub_metering_3, col = "blue")
legend("topright", lty = c(1,1,1), 
       col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       cex = 0.5)
## plot 4th graph
plot(data$Time, data$Global_reactive_power, type = "l", 
     xlab = "datetime", ylab = "Global_reactive_power")
## close connection to file
dev.off()