#Code for Plot 3
#Make sure to have the household_power_consumption.txt in your workingdirectory before you start!

#Loading data form working directory into R
data <- read.table("household_power_consumption.txt", sep=";", na.strings="?",header=TRUE)

#Subsetting based on the two days creating two datasets
dag1 <- subset(data, Date == "1/2/2007")
dag2 <- subset(data, Date == "2/2/2007")

#Combining the two datasets
alla_dagar <- bind_rows(dag1,dag2)

#Subsetting Date and Time
date <- alla_dagar[,1]
time <- alla_dagar[,2]


#Converting to character
newdate <- apply(date,c(1,2),as.character)
newtime <- apply(time,2,as.character)

#Mergning date and time to one data set
datetime <- paste(newdate,newtime)

#Converting formats
newdatetime <- strptime(datetime, format="%d/%m/%Y %H:%M:%S")
newdatetime <- as.data.frame(newdatetime)

#Adding new data to the first (subsetted) data set
newdata <- bind_cols(alla_dagar,newdatetime)

#Buliding up the Plot
plot(newdata$newdatetime,y=newdata$Sub_metering_1,type="l",ylab="Energy sub metering",xlab="",ylim=c(0,40))
par(new=T)
plot(newdata$newdatetime,y=newdata$Sub_metering_2,type="l",ylab="",xlab="",col="red",axes=F,ylim=c(0,40))
par(new=T)
plot(newdata$newdatetime,y=newdata$Sub_metering_3,type="l",ylab="",xlab="",col="blue",axes=F,ylim=c(0,40))
legend("topright",pch=c("-","-","-"),col=c("black","red","blue"),legend=c("Sub_metering_1 ","Sub_metering_2 ","Sub_metering_3 "))


#Saving the plot
dev.copy(png,file="plot3.png")
dev.off()
