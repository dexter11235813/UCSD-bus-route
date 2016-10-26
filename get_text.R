# Extract data from the UCSD Bus API and store the formatted data in a CSV

library(stringr)
setwd("~/UCSD-bus\ map/downloads")
dat = read.table("Route2092.txt",stringsAsFactors = F)


# Preparing dat for record
prep = function(temp.t)
{
# concatenate and clean the data
#temp = dat[1,]
temp = paste0(temp.t$V1,temp.t$V2,temp.t$V3)
temp = unlist(strsplit(temp,"},"))
temp = rbind(paste0(temp[1],temp[2]),paste0(temp[3],temp[4]))
temp = gsub("\\{","",temp)
return(as.data.frame(rbind(conv(temp[1]),conv(temp[2]))))
#sapply(temp,function(x) conv(x))
}




# clean and Convert into dataframe
conv =  function(temp)
{
temp1 = unlist(strsplit(temp,","))
temp1= gsub("([:.])|[[:punct:]]","\\1",temp1)
temp1 = gsub("Coordinate:","",temp1)
temp1[12] = gsub("Longitude:[0-9 \\.]+","",temp1[12])
temp2 = unlist(str_split(temp1,":",n = 2))
temp2[length(temp2)] = gsub("[a-z]","",temp2[length(temp2)])
record = matrix(0,nrow = 1,ncol = length(temp2))
record = temp2[seq(2,length(temp2),by = 2)]
names(record) = temp2[seq(1,length(temp2),by = 2)]
return(record)
}
record = prep(dat[1,])
for( i in 2:nrow(dat))
{
  record = rbind(record,prep(dat[i,]))
}
record$Latitude = NULL
write.csv(record,file = "Route2092.csv")
