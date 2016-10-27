library(rvest)

route_id = c('2092','312','314','1263','1264','1114','1113','3442','3440','3159','1098','2399','1434','313','3849')
  
get_data = function(route_id)
{
url = paste0('https://ucsdbus.com/Route/',route_id[1],"/Vehicles")
i = 0
while(T)
{
data = read_html(url) %>% html_text()
print(paste0("getting infromation ",i))
i = i + 1
write(data,paste0("Route",route_id,".txt"),append = T)
Sys.sleep(5)
}
}
get_data(route_id[1])


