## Creates a plot form household_power_consumption.txt data set
##
## @author Fiorentino
##
## @examples
## source("plot4.R")

plot4 <- function()
{
    library(dplyr)
    library(lubridate)
    dt <- read.csv("household_power_consumption.txt",sep = ";")
    dt %>% mutate(
        DateTime = parse_date_time(
            sprintf('%s %s',as.character(Date), as.character(Time)), 
            "dmy HMS"
        )) %>% 
        filter(DateTime >= '2007-02-01 00:00:00' & DateTime <= '2007-02-02 23:59:59' ) %>% 
        mutate(Global_active_power_num = as.numeric(as.character(Global_active_power)),
               Global_reactive_power_num = as.numeric(as.character(Global_reactive_power)),
               Voltage_num = as.numeric(as.character(Voltage)),
               Sub_metering_1_num = as.numeric(as.character(Sub_metering_1)),
               Sub_metering_2_num = as.numeric(as.character(Sub_metering_2)),
               Sub_metering_3_num = as.numeric(as.character(Sub_metering_3)))-> dt
    
    png(filename = "plot4.png")   
    par(mfrow = c(2, 2))
    with(dt, {
        plot(DateTime, Global_active_power_num, 
             type="l",
             xlab = "",
             ylab="Global active power")
        plot(DateTime, Voltage_num, 
             type="l",
             xlab = "datetime",
             ylab="Voltage")
        plot(DateTime, Sub_metering_1_num, 
             type="l",
             xlab = "",
             ylab="Energy sub metering")
        lines(DateTime, Sub_metering_2_num,  col = "red")
        lines(DateTime, Sub_metering_3_num,  col = "blue")
        legend("topright", pch = 1, col = c("black","blue", "red"), 
               legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        plot(DateTime, Global_reactive_power_num, 
             type="l",
             xlab = "datetime",
             ylab="Global reactive power")
    })
    dev.off()
}
plot4()