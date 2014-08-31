#link to cran package website
#http://cran.r-project.org/web/packages/available_packages_by_date.html

'scrape_ratings' <- function(url)
{
  require(XML)
  # get HTML of url
  doc <- htmlParse(url)
  
  # find all tables in webpage
  tables <- readHTMLTable(doc)
  
  # find largest table and return as dataframe
  nrows <- unlist(lapply(tables, function(t) dim(t)[1]))
  table <- tables[[which.max(nrows)]]
  
  return(table)
}

url<-'http://cran.r-project.org/web/packages/available_packages_by_date.html'
film<- scrape_ratings(url)
dates<-film
colnames(dates)<-c("Date","Package","Title")
dates$Date<-as.POSIXct(paste(dates$Date), format="%Y-%m-%d" )

ggplot(dates, aes(Date))+ylab("Paper Published")+
  geom_histogram(aes(fill = ..count..))+
  geom_segment(x = as.numeric(ymd(20070919)), xend = as.numeric(ymd(20070919)),
               y = 0, yend=Inf,col="yellow")+
  geom_segment(x = as.numeric(ymd(20080410)), xend = as.numeric(ymd(20080410)), 
               y = 0, yend=Inf,col="green")
