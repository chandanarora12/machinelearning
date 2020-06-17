t <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))


## Formating
t$Date <- as.Date(t$Date, "%d/%m/%Y")

t <- subset(t,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

t <- t[complete.cases(t),]

## Combine 
dateTime <- paste(t$Date, t$Time)

dateTime <- setNames(dateTime, "DateTime")


t <- t[ ,!(names(t) %in% c("Date","Time"))]


t <- cbind(dateTime, t)

## Format
t$dateTime <- as.POSIXct(dateTime)

## Create the histogram
hist(t$Global_active_power, main="Global Active Power", xlab = "Global Active Power (kilowatts)", col="red")

dev.copy(png,"plot1.png", width=480, height=480)

plot(t$Global_active_power~t$dateTime, type="l", ylab="Global Active Power (kilowatts)", xlab="")

dev.copy(png,"plot8.png", width=480, height=480)

with(t, {
  plot(Sub_metering_1~dateTime, type="l",
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~dateTime,col='Red')
  lines(Sub_metering_3~dateTime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.copy(png, file="plot3.png", height=480, width=480)
