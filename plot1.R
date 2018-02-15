library(tidyverse)
library(lubridate)

variables <- read_lines("household_power_consumption.txt", n_max = 1) %>% 
  stringr::str_split(";") %>% 
  unlist
data <- read_delim("household_power_consumption.txt", delim = ";", 
                   skip = 66637, n_max = 2880,
                   col_names = variables)
data <- data %>% mutate_at(vars(Date),funs(lubridate::dmy))

png(filename = "plot1.png",width = 480, height = 480)
hist(data$Global_active_power, col = "red", xlab="Global Active Power (kilowatts)", main= "Global Active Power")
dev.off()
