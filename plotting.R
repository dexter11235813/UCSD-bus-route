library(ggmap)
library(ggplot2)
dat = read.csv("Route1098.csv")
dat = dat[,-1]
temp = dat[,c("Name","Longitude","Latitude")]
temp$Name = as.factor(temp$Name)
temp$Longitude = -temp$Longitude
map = get_map(location = c(lon = -117.23,lat = median(temp$Latitude)),zoom = 14)
map_plot = ggmap(map) + 
  geom_point(data = temp,aes(x = Longitude,y = Latitude,colour = Name)) #+ 
  #geom_line(data = temp,aes(x = Longitude,y = Latitude,colour = Name))
map_plot
