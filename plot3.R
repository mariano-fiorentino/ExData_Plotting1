## Creates a plot form household_power_consumption.txt data set
##
## @author Fiorentino
##
## @examples
## source("plot3.R")

plot3 <- function()
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
        mutate(Sub_metering_1_num = as.numeric(as.character(Sub_metering_1)),
               Sub_metering_2_num = as.numeric(as.character(Sub_metering_2)),
               Sub_metering_3_num = as.numeric(as.character(Sub_metering_3)))-> dt
    
    png(filename = "plot3.png")
    with(dt, {
        plot(DateTime, Sub_metering_1_num, 
             type="l",
             xlab = "",
             ylab="Energy sub metering")
        lines(DateTime, Sub_metering_2_num,  col = "red")
        lines(DateTime, Sub_metering_3_num,  col = "blue")
        legend("topright", pch = 1, col = c("black","blue", "red"), 
               legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        
    })    
    dev.off()
}
plot3()