ctype=rep("double",9)
ctype[1:2]="character"
header=as.character(unlist(read.table("household_power_consumption.txt",
                                      sep=";",nrows = 1)))
hpc=read.table("../household_power_consumption.txt", colClasses =ctype,
               col.names = header,sep=";",skip=66637,nrows = 2880)
hpc$Date=as.Date(hpc$Date,format="%d/%m/%Y")
tempo=paste(hpc$Date,hpc$Time,sep=" ")
png(file = "plot4.png", width=480,height=480,bg = "white")
splot=function(column,ylabel){
  
plot(as.integer(as.factor(tempo)),hpc[[column]] ,type="l",
     xaxt="n",xlab="",ylab=ylabel)
axis(1,at=c(1,1441,2880),labels=c("Thu","Fri","Sat"))
}
par(mfrow=c(2,2))
c="Global_active_power"
l="Global Active Power(kilowatts)"
splot(c,l)
c="Voltage"
splot(c,c)
title(xlab = "datetime")
bty="n"
cex=0.7

cor=c("black","red","blue")
z=as.integer(as.factor(tempo))
x=matrix(c(z,z,z),nrow=2880)
y=matrix(c(hpc[,7],hpc[,8],hpc[,9]),ncol=3)
cor=matrix(c("black","red","blue"),ncol=3)

plot(x,y,type="n",  yaxt="n",  xaxt="n",xlab="",ylab="Energy sub mettering",
     col=cor,ylim = c(0,38))
for(i in 1:3){
  par(new=T)
  plot(x[,i],y[,i],type="l",  yaxt="n",  xaxt="n",xlab="",ylab="",axes=FALSE,
       col=cor[i],ylim = c(0,38))
}

axis(1,at=c(1,1441,2880),labels=c("Thu","Fri","Sat"))
axis(2,at=c(0,10,20,30),labels=c(0,10,20,30))
leg=names(hpc)[7:9]
legend("topright",legend=leg,lty=1,lwd=1,seg.len=2,col=cor,bty=bty
       ,cex=cex)


c="Global_reactive_power"
splot(c,c)
title(xlab = "datetime")


dev.off()