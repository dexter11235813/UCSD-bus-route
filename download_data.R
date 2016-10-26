library(rvest)

route_id = c('2092','312','314','1263','1264','1114','1113','3442','3440','3159','1098','2399','1434','313','3849')
  
  
url = paste0('https://ucsdbus.com/Route/',route_id[1])
data = read_html(url) %>% html_text()
