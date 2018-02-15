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
  

png(filename = "plot3.png",width = 480, height = 480)


plot(x=data$datetime, y=data$Sub_metering_1, type = "l", ylab="Energy sub metering", xlab="")
lines(x=data$datetime, y=data$Sub_metering_2,col="red")
lines(x=data$datetime, y=data$Sub_metering_3,col="blue")
legend(x = "topright",legend = variables[7:9], col = c("black","red","blue"),lwd = 2)

dev.off()
