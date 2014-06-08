# Load dataset into R
filename <- "household_power_consumption.txt"

data<-read.table(filename,
                 header=TRUE,
                 sep=";",
                 colClasses=c("character", "character", rep("numeric",7)),
                 na="?")

#Formatting Date & Time
data$Time=strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")
data$Date=as.Date(data$Date,"%d/%m/%Y")

dates <- as.Date(c("2007-02-01", "2007-02-02"), "%Y-%m-%d")

#Subset Dataset for given dates
plotdata<-subset(data,data$Date %in% dates)

#Open PNG Device
png(filename="plot4.png",width=480,height=480,units="px")

#Build block of 4
par(mfrow=c(2,2))

plot(plotdata$Time, plotdata$Global_active_power,
     type="l",
     xlab="",
     ylab="Global Active Power")

plot(plotdata$Time, plotdata$Voltage,
     type="l",
     xlab="datetime",
     ylab="Voltage")

plot(plotdata$Time, plotdata$Sub_metering_1,
     type="l",
     xlab="",
     ylab="Energy sub metering",
     col="black")
lines(plotdata$Time,plotdata$Sub_metering_2,col="red")
lines(plotdata$Time,plotdata$Sub_metering_3,col="blue")
legend("topright",
       col=c("black", "red", "blue"),
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       bty="n",
       lty=1)

plot(plotdata$Time, plotdata$Global_reactive_power,
     type="n",
     xlab="datetime",
     ylab="Global_reactive_power")
lines(plotdata$Time, plotdata$Global_reactive_power)
#Close Device
dev.off()