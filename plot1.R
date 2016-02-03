ctype=rep("double",9)
ctype[1:2]="character"
header=as.character(unlist(read.table("household_power_consumption.txt",
                                      sep=";",nrows = 1)))
hpc=read.table("household_power_consumption.txt", colClasses =ctype,
               col.names = header,sep=";",skip=66637,nrows = 2880)
png(file = "plot1.png", width=480,height=480,bg = "white")
hist(hpc$Global_active_power,main="Global Active Power",col="Red", 
     xlab="Global Active Power (kilowatts)")
dev.off()
