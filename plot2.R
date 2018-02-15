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
  mutate_at(vars(datetime),funs(lubridate::ymd_hms)) %>% 
  select(datetime,Global_active_power)

png(filename = "plot2.png",width = 480, height = 480)
plot(x=data$datetime, y=data$Global_active_power, type = "l", ylab="Global Active Power (kilowatts)", xlab="")
dev.off()
