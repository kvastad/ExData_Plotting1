#Code for Plot 2
#Make sure to have the household_power_consumption.txt in your workingdirectory before you start!

#Loading data form working directory into R
data <- read.table("household_power_consumption.txt", sep=";", na.strings="?",header=TRUE)

#Subsetting based on the two days creating two datasets
dag1 <- subset(data, Date == "1/2/2007")
dag2 <- subset(data, Date == "2/2/2007")

#Combining the two datasets
alla_dagar <- bind_rows(dag1,dag2)

#Subsetting Date, Time and Global_active_power (gap)
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

#Making the plot
plot(newdata$newdatetime,newdata$Global_active_power,type="l",ylab="Global Active Power (kilowatts)",xlab="")
#OBS!!! It's Swedish time: Thu=Tor, Fri=Fre and Lör=Sat.

#Saving the plot
dev.copy(png,file="plot2.png")
dev.off()
