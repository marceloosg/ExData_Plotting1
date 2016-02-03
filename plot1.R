#Setting header type
ctype=rep("double",9)
ctype[1:2]="character"

header=as.character(unlist(read.table("household_power_consumption.txt",
                                      sep=";",nrows = 1)))

#reading table
# the numbers 66637, 2280 got from inspection in data file
# could have subsetted , but cat -n |grep  in prompt is easier
hpc=read.table("household_power_consumption.txt", colClasses =ctype,
               col.names = header,sep=";",skip=66637,nrows = 2880)

#opening png device
png(file = "plot1.png", width=480,height=480,bg = "white")

#plotting histogram
hist(hpc$Global_active_power,main="Global Active Power",col="Red", 
     xlab="Global Active Power (kilowatts)")
dev.off()
