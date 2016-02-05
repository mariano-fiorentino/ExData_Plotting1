## Creates a plot form household_power_consumption.txt data set
##
## @author Fiorentino
##
## @examples
## source("plot1.R")

plot1 <- function ()
{
    library(dplyr)
    library(lubridate)
    dt <- read.csv("household_power_consumption.txt",sep = ";")
    dt %>% mutate(nDate = dmy(as.character(Date))) %>% 
        filter(nDate >= '2007-02-01' & nDate <= '2007-02-02' ) %>% 
        mutate(Global_active_power_num = as.numeric(as.character(Global_active_power))) -> dt
    
    png(filename = "plot1.png")
    with(dt, hist(Global_active_power_num, 
                  col = "red", 
                  main="Global active power",
                  xlab="Global active power (kilowatts)"))
    dev.off()
}
plot1()