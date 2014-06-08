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
histdata<-subset(data,data$Date %in% dates)

#Open PNG Device
png(filename="plot1.png",width=480,height=480,units="px")

hist(histdata$Global_active_power,
     main="Global Active Power",
     xlab="Global Active Power (kilowatts)",
     ylab="Frequency",
     col="red")

#Close Device
dev.off()

