#Setting header type
ctype=rep("double",9)
ctype[1:2]="character"
header=as.character(unlist(read.table("household_power_consumption.txt",
                                      sep=";",nrows = 1)))

#reading table
# the numbers 66637, 2280 got from inspection in data file
# could have subsetted , but cat -n |grep  in prompt is easier
hpc=read.table("../household_power_consumption.txt", colClasses =ctype,
               col.names = header,sep=";",skip=66637,nrows = 2880)
hpc$Date=as.Date(hpc$Date,format="%d/%m/%Y")


#First I used strftime, but then I got only 3 x coordinates in graph
#some how it ignored the Time part when converting
#converting directly to factor works too
tempo=paste(hpc$Date,hpc$Time,sep=" ")

#opening png device
png(file = "plot4.png", width=480,height=480,bg = "white")

#defining plot function
splot=function(column,ylabel){
  
plot(as.integer(as.factor(tempo)),hpc[[column]] ,type="l",
     xaxt="n",xlab="",ylab=ylabel)
axis(1,at=c(1,1441,2880),labels=c("Thu","Fri","Sat"))
}

##setting plot layout
par(mfrow=c(2,2))
c="Global_active_power"
l="Global Active Power(kilowatts)"

#Plot Global Active Power 1
splot(c,l)

#Plot Voltage 2
c="Voltage"
splot(c,c)
title(xlab = "datetime")


#Was not able to doit in one plot call, saw some thing like this, but 
# could not fix the color using matrix : plot (x,y ...)
# plot(x, y,type="l",  yaxt="n",  xaxt="n",xlab="",ylab="",axes=FALSE,
#     col=cor,ylim = c(0,38)), leaves all lines black
cor=c("black","red","blue")
z=as.integer(as.factor(tempo))
x=matrix(c(z,z,z),nrow=2880)
y=matrix(c(hpc[,7],hpc[,8],hpc[,9]),ncol=3)
cor=matrix(c("black","red","blue"),ncol=3)


#Plot 3
plot(x,y,type="n",  yaxt="n",  xaxt="n",xlab="",ylab="Energy sub mettering",
     col=cor,ylim = c(0,38))
for(i in 1:3){
  par(new=T)
  plot(x[,i],y[,i],type="l",  yaxt="n",  xaxt="n",xlab="",ylab="",axes=FALSE,
       col=cor[i],ylim = c(0,38))
}

#setting axes
axis(1,at=c(1,1441,2880),labels=c("Thu","Fri","Sat"))
axis(2,at=c(0,10,20,30),labels=c(0,10,20,30))

#setting legend
leg=names(hpc)[7:9]
bty="n"
cex=0.7
legend("topright",legend=leg,lty=1,lwd=1,seg.len=2,col=cor,bty=bty
       ,cex=cex)


#Plot 4
c="Global_reactive_power"
splot(c,c)
title(xlab = "datetime")

dev.off()