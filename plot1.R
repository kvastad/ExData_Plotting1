#Code for Plot 1
#Make sure to have the household_power_consumption.txt in your workingdirectory before you start!

#Loading data form working directory into R
data <- read.table("household_power_consumption.txt", sep=";", na.strings="?")

#Making new names vector
nn <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")

#Adding new names (nn) to data
colnames(data) <- nn

#Subsetting based on the two days creating two datasets
dag1 <- subset(data, Date == "1/2/2007")
dag2 <- subset(data, Date == "2/2/2007")

#Combining the two datasets
alla_dagar <- bind_rows(dag1,dag2)

#Subsetting the values needed for Plot1
gap <- alla_dagar[,3]

#Converting from factor/data.frame to numeric values
newgap <- apply(gap,c(1,2),as.character)
newgap <- apply(gap,c(1,2),as.numeric)

#Making the plot
hist(newgap, main="Global Active Power",xlab="Global Active Power (kilowatts)",col="red")

#Saving the plot
dev.copy(png,file="plot1.png")
dev.off()