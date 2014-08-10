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

data3<-data

png("plot32.png",bg="transparent",type="cairo",width=480,height=480)
plot(x=data3$Date,y=data3$Sub_metering_1,type="l",ylab="Energy sub metering",xlab="")
lines(x=data3$Date,y=data3$Sub_metering_2,type="l",col="red")
lines(x=data3$Date,y=data3$Sub_metering_3,type="l",col="blue")
legend("topright",lty=1,col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()
