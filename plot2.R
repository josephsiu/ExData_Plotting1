#read the data file and extract it to a dataframe
#note that the file can be downloaded here: 
#https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
df <- read.table("household_power_consumption.txt", header=T, sep=";")

#adjusting the datatypes and merging the date/time
df$Datetime <- paste(df$Date, df$Time)
df$Datetime <- strptime(df$Datetime, "%d/%m/%Y %H:%M:%S")
df$Date <- as.Date(df$Date, "%d/%m/%Y")

#subsetting the data that we need
df_small <- subset(df, Date == as.Date("2007-02-01") | Date == as.Date("2007-02-02"))

#create a function to convert factors to numeric
as.numeric.factor <- function(x) {as.numeric(levels(x))[x]}

#adjusting the data some more
df_small$Global_active_power <- as.numeric.factor(df_small$Global_active_power)
df_small$Global_reactive_power <- as.numeric.factor(df_small$Global_reactive_power)
df_small$Voltage <- as.numeric.factor(df_small$Voltage)
df_small$Global_intensity <- as.numeric.factor(df_small$Global_intensity)
df_small$Sub_metering_1 <- as.numeric.factor(df_small$Sub_metering_1)
df_small$Sub_metering_2 <- as.numeric.factor(df_small$Sub_metering_2)
df_small$Sub_metering_3 <- as.numeric.factor(df_small$Sub_metering_3)

#plotting below
#----------
png(file="plot2.png")
with(df_small, plot(Datetime, Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatt)"))
dev.off()