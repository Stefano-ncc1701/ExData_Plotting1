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
#plot2
#*****************************************************************
plot(newplotdata$Global_active_power~newplotdata$DateTime, type="l", ylab="Global Active Power (kilowatts)", xlab="")
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()
