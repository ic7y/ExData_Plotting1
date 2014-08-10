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

#-----plot2 and save as png2.png ----

png("plot2.png",bg="transparent",type="cairo-png",units = 'px',width=480,height=480)

data2<-data[,c(1,2,3)]

data2$Date<-strptime(paste(data2$Date,data2$Time), "%d/%m/%Y %H:%M:%S")

plot(x= data2$Date , y=data2$Global_active_power,type="l",ylab="Global Active Power( kilowatt)")


dev.off()
