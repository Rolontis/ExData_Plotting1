## Install dplyr package if not installed and load the package
if(("dplyr" %in% rownames(installed.packages())) == FALSE){
        install.packages(dplyr)
}

library(dplyr)

## Download the zip file if not present
if(!file.exists("./Data/household_power_consumption.txt")){
        download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "./Data/file.zip")
        unzip("./Data/file.zip", exdir = "./Data")
        unlink("./Data/file.zip")
}

## Load the data into R
data <- read.table("./data/household_power_consumption.txt", 
                   header = TRUE, 
                   sep = ";")

## Add a new column "t" which stores time data
data <- data %>% 
        filter(Date == "1/2/2007" | Date == "2/2/2007") %>% 
        mutate(t = paste(Date, Time)) %>%
        mutate(t = strptime(t, format = "%d/%m/%Y %H:%M:%S"))

## Set other variables as numeric before exploratory analysis
data[ , 3:9] = apply(data[ , 3:9], 2, as.numeric)

## Generate plot4
png("Plot4.png", width = 480, height = 480)
par(mfcol = c(2, 2))
with(data, {
        ## Top left
        plot(t, Global_active_power, 
             type = "l", 
             xlab = "", 
             ylab = "Global Active Power")
        ## Bottom left
        plot(t, Sub_metering_1, type = "n", xlab = "", ylab = "")
        points(t, Sub_metering_1, type = "l", col = "black")
        points(t, Sub_metering_2, type = "l", col = "red")
        points(t, Sub_metering_3, type = "l", col = "blue")
        title(xlab = "", ylab = "Energy sub metering")
        legend("topright", lty = 1, 
               box.lty = 0,
               col = c("black", "red", "blue"), 
               legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
               cex = 0.9,
               bty = "n"
               )
        ## Upper right
        plot(t, Voltage, 
             type = "l", 
             xlab = "datetime", 
             ylab = "Voltage"
        )
        ## Bottom right
        plot(t, 
             Global_reactive_power, 
             type = "l", 
             xlab = "datetime"
        )
})
dev.off()