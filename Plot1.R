## Install dplyr package if not installed and load the package
if(("dplyr" %in% rownames(installed.packages())) == FALSE){
                install.packages(dplyr)
}

library(dplyr)

## Download the zip file into Data folder
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "./Data/file.zip")
unzip("./Data/file.zip", exdir = "./Data")
unlink("./Data/file.zip")

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

## Generate plot1
png("Plot1.png", width = 480, height = 480)
hist(data$Global_active_power, 
     main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", 
     col = "red")
dev.off()
