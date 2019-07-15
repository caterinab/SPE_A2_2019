f1 <- read.csv("base/throughput.csv",header=FALSE, sep=",")
f2 <- read.csv("carrier_sensing_1/throughput.csv",header=FALSE, sep=",")
f3 <- read.csv("carrier_sensing_1_prob/throughput.csv",header=FALSE, sep=",")
f4 <- read.csv("base_prob/throughput.csv",header=FALSE, sep=",")

pdf("t.pdf")
plot(f2[[5]], f2[[2]], col="green", type='l', xlab="Total offered load (Mbps)", ylab="Throughput (Mbps)", xlim=c(0, 11.5), ylim=c(0,3), xaxs="i", yaxs="i")
lines(f3[[5]], f3[[2]],col="blue")
lines(f1[[5]], f1[[2]],col="red")
lines(f4[[5]], f4[[2]],col="orange")
legend(5, 2.75, legend=c("Base", "Carrier sensing", "Base probabilistic", "Carrier sensing probabilistic"),
       col=c("red", "green", "orange", "blue"), lty=1)
dev.off()

pdf("c.pdf")
plot(f4[[5]], f4[[3]], col="orange", type='l', xlab="Total offered load (Mbps)", ylab="Collision rate", xlim=c(0, 11.5), ylim=c(0,1), xaxs="i", yaxs="i")
lines(f2[[5]], f2[[3]],col="green")
lines(f3[[5]], f3[[3]],col="blue")
lines(f1[[5]], f1[[3]],col="red")
legend(5, 0.4, legend=c("Base", "Carrier sensing", "Base probabilistic", "Carrier sensing probabilistic"),
       col=c("red", "green", "orange", "blue"), lty=1)
dev.off()

pdf("d.pdf")
plot(f1[[5]], f1[[4]], col="red", type='l', xlab="Total offered load (Mbps)", ylab="Drop rate", xlim=c(0, 11.5), ylim=c(0,0.5), xaxs="i", yaxs="i")
lines(f2[[5]], f2[[4]],col="green")
lines(f3[[5]], f3[[4]],col="blue")
lines(f4[[5]], f4[[4]],col="orange")
legend(1, 0.45, legend=c("Base", "Carrier sensing", "Base probabilistic", "Carrier sensing probabilistic"),
       col=c("red", "green", "orange", "blue"), lty=1)
dev.off()
