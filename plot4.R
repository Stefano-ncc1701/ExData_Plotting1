library(plyr)

#*****************************************************************
#Download data
#*****************************************************************

if(!file.exists("./mydata")){dir.create("./mydata")}

fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl,destfile="./mydata/mydataset.zip")

# Unzip dataSet in my directory
unzip(zipfile="./mydata/mydataset.zip",exdir="./mydata")


#*****************************************************************
#only using data from the dates 2007-02-01 and 2007-02-02
#*****************************************************************

plotdata <-read.table("./mydata/household_power_consumption.txt", sep = ";",na.strings = "?",header = TRUE)

newplotdata <- plotdata[(plotdata$Date=="1/2/2007" | plotdata$Date=="2/2/2007" ), ]

#*****************************************************************
#format date and time in a more convenient way
#*****************************************************************
newplotdata$Date <- as.Date(newplotdata$Date, format="%d/%m/%Y")
dateTime <- paste(newplotdata$Date, newplotdata$Time)
newplotdata$DateTime <- as.POSIXct(dateTime)

#*****************************************************************
#plot4
#*****************************************************************
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))

with(newplotdata, {
  plot(Global_active_power~DateTime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="", cex=0.8)
  plot(Voltage~DateTime, type="l", 
       ylab="Voltage (volt)", xlab="", cex=0.8)
  plot(Sub_metering_1~DateTime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="", cex=0.8)
  lines(Sub_metering_2~DateTime,col='Red')
  lines(Sub_metering_3~DateTime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex=0.5)
  plot(Global_reactive_power~DateTime, type="l", 
       ylab="Global Rective Power (kilowatts)",xlab="", cex=0.8)
})

dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()