ctype=rep("double",9)
ctype[1:2]="character"
header=as.character(unlist(read.table("household_power_consumption.txt",
                                      sep=";",nrows = 1)))
hpc=read.table("household_power_consumption.txt", colClasses =ctype,
               col.names = header,sep=";",skip=66637,nrows = 2880)
hpc$Date=as.Date(hpc$Date,format="%d/%m/%Y")
tempo=paste(hpc$Date,hpc$Time,sep=" ")
png(file = "plot2.png", width=480,height=480,bg = "white")
plot(as.integer(as.factor(tempo)),hpc$Global_active_power,type="l",
    xaxt="n",xlab="",ylab="Global Active Power(kilowatts)")
axis(1,at=c(1,1441,2880),labels=c("Thu","Fri","Sat"))
dev.off()
