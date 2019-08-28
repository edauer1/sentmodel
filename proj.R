library(tidyverse)
library(tidytext)

#read in the sentence list
temp <-read_csv('3gsent.csv',col_names = FALSE, col_types = cols("c","i","c"))

#transform to word level tokens in tidytext where word is the unit of observation
temp2<- unnest_tokens(temp, word, X3)


# create a new environment for holding a hash table 
subtl <- new.env(hash = TRUE, parent = emptyenv())




templ <-read_csv('gvpinsurfphlex2016.csv', col_names= c("Orth","KFr","Phon","GVLEC","GVLECsz"),  col_types = cols("c","n","c","c","n"))


# read in a paired list file and create a hash for lookup




tempf <-read_csv('SUBTLus.csv',col_names = FALSE, col_types = cols("c","n"))
ltempf = nrow(tempf)
for(i in 1:ltempf)
{
  subtl[[ tolower(tempf$X1[i]) ]]<- tempf$X2[i]
}
rm(tempf)

# end read in a paired list file and create a hash for lookup

templex <-read_csv('.csv',col_names = FALSE, col_types = cols("c","n"))



f <- function(x){
  if(exists_subtl(tolower(x[3]),subtl)){
    get_subtl(tolower(x[3]),subtl)
  }
  else{return("NA")}
}

exists_subtl <- Vectorize(exists, vectorize.args = "x")


get_subtl <- Vectorize(get,vectorize.args="x")

temp2$test <-as.numeric(apply(temp2,1,f))



foo <- temp2 %>% 
  group_by(X2) %>% 
  summarize(text = str_c(word, collapse = " "),mnfrq = mean(test,na.rm = TRUE)) %>%
  ungroup()

