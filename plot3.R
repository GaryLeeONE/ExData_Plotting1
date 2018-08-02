#Load the required packages
library(lubridate)

#Load the dataset and set appropriate formats, combine Date + Time, etc.
data <- read.csv("household_power_consumption.txt", sep = ";")
data$Date <- as.Date(as.character(data$Date), "%d/%m/%Y")
data$Time <- strptime(as.character(data$Time), format = "%H:%M:%S")
data$Time <- as.POSIXct(data$Time)
date(data$Time) <- data$Date
data$Global_active_power <- as.numeric(as.character(data$Global_active_power))
data$Global_reactive_power <- as.numeric(as.character(data$Global_reactive_power))
data$Voltage <- as.numeric(as.character(data$Voltage))
data$Global_intensity <- as.numeric(as.character(data$Global_intensity))
data$Sub_metering_1 <- as.numeric(as.character(data$Sub_metering_1))
data$Sub_metering_2 <- as.numeric(as.character(data$Sub_metering_2))
names(data)[2] <- "DateTime"
data <- data[,2:9]

#Filter out dates 2007-02-01 and 2007-02-02
lower <- as.POSIXct(strptime("2007-02-01 00:00:00", "%Y-%m-%d %H:%M:%S"))
upper <- as.POSIXct(strptime("2007-02-02 23:59:59", "%Y-%m-%d %H:%M:%S"))
data <- data[data$DateTime >= lower & data$DateTime <= upper,]

#Plot figure 3
par(mfrow = c(1,1))
plot(data$DateTime, data$Sub_metering_1,
     xlab = "", ylab = "Energy sub metering",
     type = "l")
lines(data$DateTime, data$Sub_metering_2, col = "red")
lines(data$DateTime, data$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = 1, col = c("black", "red", "blue"))

#Output to PNG file
dev.copy(png, file = "plot3.png", width = 480, height = 480, units = "px", bg = "white")
dev.off()
