plot1<-function(){
  library(sqldf)
  library(tcltk)

  unzip("exdata-data-household_power_consumption.zip")

  # ----------- read data ------------------
  filename="household_power_consumption.txt"
  data<-read.csv.sql(filename,sep=";",sql='select * from file where Date="2/2/2007" OR Date="1/2/2007"')
  # ---- convert Date to Date+time --
  data$Date<-strptime(paste(data$Date,data$Time), "%d/%m/%Y %H:%M:%S")

  #------- change locale to English ------
  Sys.setlocale("LC_TIME", "English")

  # ---- plot and save as png1.png  ------

  png("plot1.png",bg="transparent",type="cairo-png",units = 'px',width=480,height=480)

  hist(data$Global_active_power,main="Global Active Power",xlab="Global Active Power( kilowatt)",col="red",xlim=c(0,6),ylim=c(0,1200))

  axis(side=1, at=seq(0, 6, by=2))
  axis(side=2, at=seq(0, 1200, by=200))
  dev.off()
}
