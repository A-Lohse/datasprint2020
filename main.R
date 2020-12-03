
#main data sprint 2020 script 
setwd("C:\\Users\\augus\\OneDrive - Københavns Universitet\\Documents\\Data sprint 2020")


library(ggplot2)
library(tidyverse)

links <- read.csv("datasprint2020\\data\\newspaper_retrieve_links_1800c.csv")



national_ord <- list("krig", "grænse", "vikinger", "nation", "fædreland", "folk", "danmark", "tyskland", "slægt", "arv", "blod", "fordums tid")
sprog_stavelser <- list("sprog","srrog","sdrog","srog","sproj","sprug")
years <- 1800:1877
#table_df <- data.frame()
#year <- 1840
final_data <- NULL

for(year in years){
  
   link_year <- paste("Newspapers from", year)
   filename <- paste0("data\\",link_year,".csv")
   
   df <- read.csv(filename)
   
   #til lille
   df$fulltext_org <- tolower(df$fulltext_org)
   
   #check for alle stavelser af sprog og tildel til data 
   sprog_df <- NULL
   for(stavemaade in sprog_stavelser){
    sprog_df <- rbind(sprog_df,df[grepl(stavemaade, df$fulltext_org),])
   }
   for( i in 1:nrow(sprog_df)){
     
     for(word in national_ord){
       natio = grepl(word,sprog_df[i,"fulltext_org"])
       #print(word)
       if(natio == TRUE){
         sprog_df$national[i] <- 1
         #print(paste("found a:",word))
         break
       }else{sprog_df$national[i] <- 0}
       
       
     }
   }
   #print(year)
   #print(table(sprog_df$national))
   final_data <- rbind(data.frame(final_data),sprog_df)
}

#udskriv data til lokal maskine og print antal rækker 
print(nrow(final_data))

write.csv(final_data,"sprog_final_df.csv")


