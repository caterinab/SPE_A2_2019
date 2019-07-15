
node.legend <- function(x, y, i) {
	cex <- 1

	## Background rectangle:
	textHeight <- graphics::strheight(i, cex = cex)
	textWidth <- graphics::strwidth(i, cex = cex)
	pad <- textHeight*0.3
	rect(xleft = x - textWidth/2 - pad,
			ybottom = y - textHeight/2 - pad,
			xright = x + textWidth/2 + pad,
			ytop = y + textHeight/2 + pad,
			col = rgb(1, 1, 1, 0.8), border = NA)

	## Place text:
	text(x, y, i, cex = cex)
}


args <- commandArgs(trailingOnly = T)

if (length(args) < 1) {
	stop("please specify the csv file as input parameter")
}
infile  <- args[1]
if (!endsWith(infile, ".csv")) {
	stop("the input must be the csv file of the topology")
}

d <- read.csv(infile)

pdf("topology.pdf")
plot(d$x, d$y, xlab="x (m)", ylab="y (m)")

circle <- function(x, y, r, n=100) {
	p <- data.frame()
	for (a in seq(0, 2*pi, length.out=n)) {
		p <- rbind(p, data.frame(x = x + r*cos(a), y = y + r*sin(a)))
	}
	p <- rbind(p, p[1,])
	lines(p$x, p$y)
}

for (i in 0:8) {

	ni <- as.numeric(d[d$node == i,c('x', 'y')])
	#circle(ni[1], ni[2], r=10)
	for (j in (i+1):9) {
		nj <- as.numeric(d[d$node == j,c('x', 'y')])
		if (sqrt(sum((ni - nj) ^ 2)) < 10)
			lines(c(ni[1], nj[1]), c(ni[2], nj[2]))
	}

}
for (i in 1:nrow(d)) {
	node.legend(d[i,]$x, d[i,]$y, i)
}
dev.off()
