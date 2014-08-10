library(sqldf)
library(tcltk)

unzip("exdata-data-household_power_consumption.zip")

# ----------- read data ------------------
filename="household_power_consumption.txt"
data<-read.csv.sql(filename,sep=";",sql='select * from file where Date="2/2/2007" OR Date="1/2/2007"')
# ---- convert Date to Date+time 
data$Date<-strptime(paste(data$Date,data$Time), "%d/%m/%Y %H:%M:%S")

#------- change locale to English ------
Sys.setlocale("LC_TIME", "English")

png("plot4.png",bg="transparent",type="cairo-png",units = 'px',width=480,height=480)
par(mfrow=c(2,2))
with(data,{  
  plot(Date ,Global_active_power,type="l",ylab="Global Active Power");  
  plot(Date,Voltage,type="l",xlab="datetime",ylab="Voltage");
  plot(Date,Sub_metering_1,type="l",ylab="Energy sub metering",xlab="");
  lines(Date,Sub_metering_2,type="l",col="red");  
  lines(Date,Sub_metering_3,type="l",col="blue");
  legend("topright",col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1,lwd=1,box.lty=0);
  plot(Date ,Global_reactive_power,type="l",ylab="Global Active Power",xlab="datetime") })

dev.off()
