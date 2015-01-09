# Course Project 1
# plot 3

# get current working directory

getwd()  
dir()

# code for reading the data so that the plot can be fully reproduced

if (!file.exists("mydata")){
  dir.create("mydata")
  message("Downloading data")
  fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileUrl, destfile = "./mydata/household_power_consumption.zip")
  unzip("./mydata/household_power_consumption.zip")
}

dataFile <- "household_power_consumption.txt"

tdf <- system.time({
  DF <- read.csv(
    dataFile, sep=";",
    stringsAsFactors=FALSE,
    na.strings = c("?", ""))
  # sub-set the 2-day period in February, 2007
  DF <- DF[DF$Date %in% c("1/2/2007","2/2/2007"), ]
})
print("read.csv")
print(tdf)

summary(DF)

changedate <- as.Date(DF$Date, "%d/%m/%Y")
changetime <- strptime(DF$Time, "%H:%M:%S")
DF$DateTime <- as.POSIXct(paste(DF$Date, DF$Time), format = "%d/%m/%Y %H:%M:%S")

View(DF$DateTime)

head(DF)
tail(DF)
dim(DF)

View(DF)
View(DF$Global_active_power)
length(DF$Global_active_power)
View(DF$DateTime)
length(DF$DateTime)

# plot 3
# code to construct the third plot
# code to save the plot to a PNG file with a width of 480 pixels and a height of 480 pixels

Sys.setlocale("LC_TIME", "English")

data3 <- data.frame(DF$DateTime, DF$Sub_metering_1, DF$Sub_metering_2, DF$Sub_metering_3)
View(data3)

png(file = "plot3.png", bg = "transparent", width = 480, height = 480)
# construct plot und draw first line with plot()
plot(DF$DateTime, DF$Sub_metering_1, col = "black", type = "l", lty = 1, xlab = "", ylab = "Energy sub metering")
# add additional lines with lines()
lines(DF$DateTime, DF$Sub_metering_2, col = "red")
lines(DF$DateTime, DF$Sub_metering_3, col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()