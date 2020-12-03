setwd("C:\\Users\\augus\\OneDrive - Københavns Universitet\\Documents\\Data sprint 2020")


library(ggplot2)
library(tidyverse)

links <- read.csv("datasprint2020\\data\\newspaper_retrieve_links_1800c.csv")
years = 1800:1877


for(year in years){
  
  link_year <- paste("Newspapers from", year)
  #print(link_year)
  link <-  as.character(links[links['name'] == link_year, "csvLink"])
  df <- read_delim(link,delim = ",")
  
  filename <- paste0("data\\",link_year,".csv")
  write.csv(df, file= filename, fileEncoding = "UTF-8")
  
}