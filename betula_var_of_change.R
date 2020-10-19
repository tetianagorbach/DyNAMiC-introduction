# Here, the fraction of the variance of change to variance of baseline is estimated using the data from The Betula imaging study.
library(xlsx)
library(tidyverse)


## reading cognition data ##
ReadCognitionT56<- function(file.cognition = "Betula behavioral data to Tanya update8.xlsx"){ 
        print(paste("T5-T6 Cognition data is read from: ", file.cognition))
        suppressMessages(require("xlsx", lib.loc="/Library/Frameworks/R.framework/Versions/3.1/Resources/library") )
        data.cognition <- read.xlsx2(file=file.cognition,
                                     1, startRow=2,endRow=378, stringsAsFactors=F) 
        data.cognition <- data.cognition[,-2]
        data.cognition[,c(2,4:ncol(data.cognition))] <- sapply(data.cognition[, c(2,4:ncol(data.cognition))], as.numeric)
        data.cognition$Sex <- data.cognition$Sex-1
        data.cognition
}

ReadExclusions <- function(file.exclusions = "Availability of data and health status 2015-10-01.xlsx"){
        print(paste("Exclusions are read from:", file.exclusions))
        excl <- read.xlsx2(file=file.exclusions,
                           1, startRow=2, endRow=378, stringsAsFactors=F,colIndex=2:8) 
        excl[,2:ncol(excl)]<- sapply(excl[,2:ncol(excl)], as.numeric)
        names(excl) <- gsub("Unique","Unique.number",gsub("MR.id","MR.subject.ID",names(excl)))
        excl
}
data <- merge(ReadExclusions(), 
              ReadCognitionT56(), by="MR.subject.ID", all=T)


# define T5 and T6 scores
mean.st.em <- apply(data[,c("T5.SPT","T5.SPT.crc","T5.VT","T5.VT.crc","T5.Wrk00")], 2, mean, na.rm=T)
sd.st.em <-   apply(data[,c("T5.SPT","T5.SPT.crc","T5.VT","T5.VT.crc","T5.Wrk00")], 2, sd, na.rm=T)
data$T5.EM.comp <-apply(scale(data[,c("T5.SPT","T5.SPT.crc","T5.VT","T5.VT.crc","T5.Wrk00")], center=mean.st.em, scale=sd.st.em),1,sum)
data$T6.EM.comp <- apply(scale(data[,c("T6.SPT","T6.SPT.crc","T6.VT","T6.VT.crc","X.T6.Wrk00")], center=mean.st.em, scale=sd.st.em),1,sum)
                         
# variance of change in % of variance of initial level
var(data$T5.EM.comp, na.rm=T)
var(data$T6.EM.comp-data$T5.EM.comp, na.rm=T)/var(data$T5.EM.comp, na.rm=T)*100 # 42%
sd(data$T6.EM.comp-data$T5.EM.comp, na.rm=T)/sd(data$T5.EM.comp, na.rm=T)*100 # 64%

# for those with T6 data
d <- data%>%filter(!is.na(T6.EM.comp) & !is.na(T5.EM.comp))
var(d$T6.EM.comp-d$T5.EM.comp)/var(d$T5.EM.comp)*100 # 46%


# healthy at T5 nd T6
data.healthy <- data%>%filter(!is.na(Healthy.T5) & !is.na(Healthy.T6) & Healthy.T5==1 & Healthy.T6==1)
var(data.healthy$T6.EM.comp-data.healthy$T5.EM.comp, na.rm=T)/var(data.healthy$T5.EM.comp, na.rm=T)*100 # 50% 

