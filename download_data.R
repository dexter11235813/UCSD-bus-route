library(rvest)
library(stringr)
source("~/UCSD-bus\ map/get_text.R")
route_id = c('2092','312','314','1263','1264','1114','1113','3442','3440','3159','1098','2399','1434','313','3849')
route = route_id[8]

##### Data Scraping 
get_data = function(route_id)
{
url = paste0('https://ucsdbus.com/Route/',route_id[1],"/Vehicles")
i = 0
while(T)
{
data = read_html(url) %>% html_text()
print(paste0("getting infromation ",i))
i = i + 1
write(data,paste0("Route",route,".txt"),append = T)
Sys.sleep(5)
}
}
get_data(route)
######### Data Processing 
dat = read.table(paste0("Route",route,".txt"),stringsAsFactors = F,fill = T)


record = prep(dat[1,])
for( i in 2:nrow(dat))
{
  record = rbind(record,prep(dat[i,]))
}
record$Latitude = NULL
write.csv(record,file = paste0("Route",route,".csv"))


##### Data Plotting


library(ggmap)
library(ggplot2)
data = read.csv(paste0("Route",route,".csv"))
data = data[,-1]
temp = data[,c("Name","Longitude","Latitude")]
temp$Name = as.factor(temp$Name)
temp$Longitude = -temp$Longitude
map = get_map(location = c(lon = median(temp$Longitude),lat = median(temp$Latitude)),zoom = 14)
map_plot = ggmap(map) + 
  geom_point(data = temp,aes(x = Longitude,y = Latitude,colour = Name)) #+ 
#geom_line(data = temp,aes(x = Longitude,y = Latitude,colour = Name))
map_plot

