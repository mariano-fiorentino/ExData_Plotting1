## Creates a plot form household_power_consumption.txt data set
##
## @author Fiorentino
##
## @examples
## source("plot2.R")

plot2 <- function ()
{
    library(dplyr)
    library(lubridate)
    dt <- read.csv("household_power_consumption.txt",sep = ";")
    dt %>% mutate(
        DateTime = parse_date_time(
            sprintf('%s %s',as.character(Date), as.character(Time)), 
            "dmy HMS", tz="Europe/Rome"
        )) %>% 
        filter(DateTime >= '2007-02-01 00:00:00' & DateTime <= '2007-02-02 23:59:59' ) %>% 
        mutate(Global_active_power_num = as.numeric(as.character(Global_active_power))) -> dt
    
    png(filename = "plot2.png")
    with(dt, plot(DateTime,Global_active_power_num, 
                  type="l",
                  xlab = "",
                  ylab="Global active power (kilowatts)"))
    dev.off()
}
plot2()