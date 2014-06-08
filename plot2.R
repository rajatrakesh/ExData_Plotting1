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
png(filename="plot2.png",width=480,height=480,units="px")

plot(plotdata$Time, plotdata$Global_active_power,
     type="l",
     xlab="",
     ylab="Global Active Power (kilowatts)")

#Close Device
dev.off()