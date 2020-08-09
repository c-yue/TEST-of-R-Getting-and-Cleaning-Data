#T1 data.table

library("openxlsx")
library(dplyr)
library(sqldf)
library(ggplot2)

read.csv("getdata_data_ss06hid.csv")

dt <- tbl_df(read.csv("getdata_data_ss06hid.csv"))
dt %>%
        select(VAL) %>%
        filter(VAL == 24)
dt %>%
        select(FES)



#T3 xlsx reading
library("openxlsx")

df2 <- read.xlsx("getdata_data_DATA.gov_NGAP.xlsx")
dt2 <- as.data.table(read.xlsx("getdata_data_DATA.gov_NGAP.xlsx"))

dat <- dt2[18:23,7:15]
sum(dat$Zip*dat$Ext,na.rm=T)



#T4 processing XML

install.packages('XML')
library(XML)
library(sqldf)

#sample
tt = '<x>
<a>text</a>
<b foo="1"/>
<c bar="me">
<d>a phrase</d>
</c>
</x>'

doc = xmlParse(tt)
doc = xmlTreeParse(tt)
xmlToList(doc)

#applying and processing
setwd('C:/Users/Administrator/Desktop/Test 1')
fileURL <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml" #记得移除https里面的S
doc <- xmlTreeParse(fileURL,useInternal = TRUE)
rootNode <- xmlRoot(doc)

xmlName(rootNode)
names(rootNode)
rootNode[[1]]
xmlSApply(rootNode[[1]],xmlValue)
xpathSApply(rootNode,'//zipcode',xmlValue)

zip_list <- xpathSApply(rootNode,'//zipcode',xmlValue)
zip_list <- lapply(zip_list, as.numeric)
zip_vec <- as.vector(unlist(zip_list))
matrix(zip_vec, ncol = 1)
zip_df <- data.frame(zip_code = zip_vec)

sqldf("select count(zip_code) from zip_df where zip_code = 21231")




#T5 Check the time of diff function
library(dplyr)
install.packages("data.table") 
library(data.table)

tmp <- tempfile()
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
destination_file <- 'C:/Users/Administrator/Desktop/Test 1'
download.file( fileURL, destfile = tmp)
list.files('tmp')
unzip('tmp')
unlink(tmp)

dt <- read.csv('getdata_data_ss06pid.csv')
DT <- tbl_df(dt)
DT <- as.data.table(dt,keep.rownames=TRUE)

system.time()
mean(DT$pwgtp15,by=DT$SEX) 0
sapply(split(DT$pwgtp15,DT$SEX),mean) 0
tapply(DT$pwgtp15,DT$SEX,mean) 0
rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2]
mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15)
DT[,mean(pwgtp15),by=SEX]





















