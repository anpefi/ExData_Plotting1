library(tidyverse)
library(lubridate)

variables <- read_lines("household_power_consumption.txt", n_max = 1) %>% 
  stringr::str_split(";") %>% 
  unlist
data <- read_delim("household_power_consumption.txt", delim = ";", 
                   skip = 66637, n_max = 2880,
                   col_names = variables)
data <- data %>% 
  mutate_at(vars(Date),funs(lubridate::dmy)) %>% 
  mutate(datetime=paste(Date,Time)) %>% 
  mutate_at(vars(datetime),funs(lubridate::ymd_hms))
  

png(filename = "plot4.png",width = 480, height = 480)

#Grid
par(mfrow=c(2,2))

#plot 1
plot(x=data$datetime, y=data$Global_active_power, type = "l", ylab="Global Active Power (kilowatts)", xlab="")

#plot 2
plot(x=data$datetime, y=data$Voltage, type = "l", ylab="Voltage", xlab="datetime")

#plot 3
plot(x=data$datetime, y=data$Sub_metering_1, type = "l", ylab="Energy sub metering", xlab="")
lines(x=data$datetime, y=data$Sub_metering_2,col="red")
lines(x=data$datetime, y=data$Sub_metering_3,col="blue")
legend(x = "topright",legend = variables[7:9], col = c("black","red","blue"),lwd = 2)

#plot4
plot(x=data$datetime, y=data$Global_reactive_power, type = "l", ylab="Global_reactive_power", xlab="datetime")

dev.off()
