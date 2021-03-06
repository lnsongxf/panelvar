# Clear Memory
rm(list=ls(all=TRUE))

fload.csv <- function(Z)
{
  xe <- as.matrix(read.csv(Z, header=TRUE))
  xed <- as.character(xe[,1])
  xe <- apply(xe[,2:NCOL(xe)], 2, as.numeric)
  rownames(xe) <- xed
  return(xe)
}

print.stats <- function(h1n, h1s, h1nsav, h, ibench)
{
  e1 <- fload.csv(h1n[1])
  e2 <- fload.csv(h1n[2])
  e <- cbind(e1, e2)
  
  s1 <- colMeans(abs(e), na.rm=TRUE)
  s2 <- sqrt(colMeans(e^2, na.rm=TRUE))
  
  ibn <- which(colnames(e)==ibench)
  
  DM <- matrix(NA, NROW(s1), 2)
  for(j in 1:NCOL(e))
  {
    if(j!=ibn){
      DM[j,1] <- dm.test(e[,j], e[,ibn], alternative = c("two.sided"), h, power=1)$p.value
      DM[j,2] <- dm.test(e[,j], e[,ibn], alternative = c("two.sided"), h, power=2)$p.value
    }
  }
  
  ssr1 <- fload.csv(h1s[1]); ssr1 <- ssr1[,NCOL(ssr1)]
  ssr1 <- as.matrix(ssr1); ssr1n <- rownames(ssr1)
  ssr2 <- as.matrix(read.csv(h1s[2]))
  ssr2n <- ssr2[,1]
  ssr2 <- as.numeric(ssr2[,2])
  
  ssr <- c(ssr1, ssr2)
  
  mnamsall <- c(ssr1n, ssr2n)
  stt <- cbind(s1/s1[ibn], s2/s2[ibn], ssr, DM)
  rownames(stt) <- mnamsall
  colnames(stt) <- c("MAE", "RMSFE", "SSR", "DM1", "DM2")
  
  # setwd("../data/tables/")  
  # write.csv(stt[1:37,], h1nsav)
  return(stt)
}

library("zoo"); library("lubridate"); library("forecast")
library("imputeTS"); library("panelvar"); library("moments")
library("R.utils")

iibench <- "AR.1."

setwd("../data/output")

wdd <- "../output/" # relative path
wds <- "../tables/"

hh <- 1
hh1n <- c("DE-M-itarg3453-h1-error.csv", "PVAR-M-itarg3453-h1DE-error.csv")
hh1s <- c("DE-M-itarg3453-h1-stats2.csv", "PVAR-M-itarg3453-h1DE-SSR.csv")
hh1nsav <- "DE-IP-h1-stats.csv"
#setwd(wdd)
a <- print.stats(h1n=hh1n, h1s=hh1s, h1nsav=hh1nsav, h=hh, ibench=iibench)

hh <- 3
hh1n <- c("DE-M-itarg3453-h3-error.csv", "PVAR-M-itarg3453-h3DE-error.csv")
hh1s <- c("DE-M-itarg3453-h3-stats2.csv", "PVAR-M-itarg3453-h3DE-SSR.csv")
hh1nsav <- "DE-IP-h3-stats.csv"
#setwd(wdd)
b <- print.stats(h1n=hh1n, h1s=hh1s, h1nsav=hh1nsav, h=hh, ibench=iibench)

hh <- 6
hh1n <- c("DE-M-itarg3453-h6-error.csv", "PVAR-M-itarg3453-h6DE-error.csv")
hh1s <- c("DE-M-itarg3453-h6-stats2.csv", "PVAR-M-itarg3453-h6DE-SSR.csv")
hh1nsav <- "DE-IP-h6-stats.csv"
#setwd(wdd)
c <- print.stats(h1n=hh1n, h1s=hh1s, h1nsav=hh1nsav, h=hh, ibench=iibench)

hh <- 12
hh1n <- c("DE-M-itarg3453-h12-error.csv", "PVAR-M-itarg3453-h12DE-error.csv")
hh1s <- c("DE-M-itarg3453-h12-stats2.csv", "PVAR-M-itarg3453-h12DE-SSR.csv")
hh1nsav <- "DE-IP-h12-stats.csv"
#setwd(wdd)
d <- print.stats(h1n=hh1n, h1s=hh1s, h1nsav=hh1nsav, h=hh, ibench=iibench)

setwd(wds)
write.csv(cbind(a, b, c, d), hh1nsav)

setwd(wdd)

hh <- 1
hh1n <- c("FR-M-itarg3453-h1-error.csv", "PVAR-M-itarg3453-h1FR-error.csv")
hh1s <- c("FR-M-itarg3453-h1-stats2.csv", "PVAR-M-itarg3453-h1FR-SSR.csv")
hh1nsav <- "FR-IP-h1-stats.csv"
#setwd(wdd)
a <- print.stats(h1n=hh1n, h1s=hh1s, h1nsav=hh1nsav, h=hh, ibench=iibench)

hh <- 3
hh1n <- c("FR-M-itarg3453-h3-error.csv", "PVAR-M-itarg3453-h3FR-error.csv")
hh1s <- c("FR-M-itarg3453-h3-stats2.csv", "PVAR-M-itarg3453-h3FR-SSR.csv")
hh1nsav <- "FR-IP-h3-stats.csv"
#setwd(wdd)
b <- print.stats(h1n=hh1n, h1s=hh1s, h1nsav=hh1nsav, h=hh, ibench=iibench)

hh <- 6
hh1n <- c("FR-M-itarg3453-h6-error.csv", "PVAR-M-itarg3453-h6FR-error.csv")
hh1s <- c("FR-M-itarg3453-h6-stats2.csv", "PVAR-M-itarg3453-h6FR-SSR.csv")
hh1nsav <- "FR-IP-h6-stats.csv"
#setwd(wdd)
c <- print.stats(h1n=hh1n, h1s=hh1s, h1nsav=hh1nsav, h=hh, ibench=iibench)

hh <- 12
hh1n <- c("FR-M-itarg3453-h12-error.csv", "PVAR-M-itarg3453-h12FR-error.csv")
hh1s <- c("FR-M-itarg3453-h12-stats2.csv", "PVAR-M-itarg3453-h12FR-SSR.csv")
hh1nsav <- "FR-IP-h12-stats.csv"
#setwd(wdd)
d <- print.stats(h1n=hh1n, h1s=hh1s, h1nsav=hh1nsav, h=hh, ibench=iibench)

setwd(wds)
write.csv(cbind(a, b, c, d), hh1nsav)

setwd(wdd)

hh <- 1
hh1n <- c("IT-M-itarg3453-h1-error.csv", "PVAR-M-itarg3453-h1IT-error.csv")
hh1s <- c("IT-M-itarg3453-h1-stats2.csv", "PVAR-M-itarg3453-h1IT-SSR.csv")
hh1nsav <- "IT-IP-h1-stats.csv"
#setwd(wdd)
a <- print.stats(h1n=hh1n, h1s=hh1s, h1nsav=hh1nsav, h=hh, ibench=iibench)

hh <- 3
hh1n <- c("IT-M-itarg3453-h3-error.csv", "PVAR-M-itarg3453-h3IT-error.csv")
hh1s <- c("IT-M-itarg3453-h3-stats2.csv", "PVAR-M-itarg3453-h3IT-SSR.csv")
hh1nsav <- "IT-IP-h3-stats.csv"
#setwd(wdd)
b <- print.stats(h1n=hh1n, h1s=hh1s, h1nsav=hh1nsav, h=hh, ibench=iibench)

hh <- 6
hh1n <- c("IT-M-itarg3453-h6-error.csv", "PVAR-M-itarg3453-h6IT-error.csv")
hh1s <- c("IT-M-itarg3453-h6-stats2.csv", "PVAR-M-itarg3453-h6IT-SSR.csv")
hh1nsav <- "IT-IP-h6-stats.csv"
#setwd(wdd)
c <- print.stats(h1n=hh1n, h1s=hh1s, h1nsav=hh1nsav, h=hh, ibench=iibench)

hh <- 12
hh1n <- c("IT-M-itarg3453-h12-error.csv", "PVAR-M-itarg3453-h12IT-error.csv")
hh1s <- c("IT-M-itarg3453-h12-stats2.csv", "PVAR-M-itarg3453-h12IT-SSR.csv")
hh1nsav <- "IT-IP-h12-stats.csv"
#setwd(wdd)
d <- print.stats(h1n=hh1n, h1s=hh1s, h1nsav=hh1nsav, h=hh, ibench=iibench)

setwd(wds)
write.csv(cbind(a, b, c, d), hh1nsav)

setwd(wdd)

hh <- 1
hh1n <- c("UK-M-itarg3453-h1-error.csv", "PVAR-M-itarg3453-h1UK-error.csv")
hh1s <- c("UK-M-itarg3453-h1-stats2.csv", "PVAR-M-itarg3453-h1UK-SSR.csv")
hh1nsav <- "UK-IP-h1-stats.csv"
#setwd(wdd)
a <- print.stats(h1n=hh1n, h1s=hh1s, h1nsav=hh1nsav, h=hh, ibench=iibench)

hh <- 3
hh1n <- c("UK-M-itarg3453-h3-error.csv", "PVAR-M-itarg3453-h3UK-error.csv")
hh1s <- c("UK-M-itarg3453-h3-stats2.csv", "PVAR-M-itarg3453-h3UK-SSR.csv")
hh1nsav <- "UK-IP-h3-stats.csv"
#setwd(wdd)
b <- print.stats(h1n=hh1n, h1s=hh1s, h1nsav=hh1nsav, h=hh, ibench=iibench)

hh <- 6
hh1n <- c("UK-M-itarg3453-h6-error.csv", "PVAR-M-itarg3453-h6UK-error.csv")
hh1s <- c("UK-M-itarg3453-h6-stats2.csv", "PVAR-M-itarg3453-h6UK-SSR.csv")
hh1nsav <- "UK-IP-h6-stats.csv"
#setwd(wdd)
c <- print.stats(h1n=hh1n, h1s=hh1s, h1nsav=hh1nsav, h=hh, ibench=iibench)

hh <- 12
hh1n <- c("UK-M-itarg3453-h12-error.csv", "PVAR-M-itarg3453-h12UK-error.csv")
hh1s <- c("UK-M-itarg3453-h12-stats2.csv", "PVAR-M-itarg3453-h12UK-SSR.csv")
hh1nsav <- "UK-IP-h12-stats.csv"
#setwd(wdd)
d <- print.stats(h1n=hh1n, h1s=hh1s, h1nsav=hh1nsav, h=hh, ibench=iibench)

setwd(wds)
write.csv(cbind(a, b, c, d), hh1nsav)
