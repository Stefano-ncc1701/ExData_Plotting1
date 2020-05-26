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
# Plot number 1
#*****************************************************************
hist(newplotdata$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red", cex.sub=0.8)

#*****************************************************************
# export file
#*****************************************************************
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()