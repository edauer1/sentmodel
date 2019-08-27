

library(tidyverse)
library(tidytext)

temp <-read_csv('3gsent.csv',col_names = FALSE, col_types = cols("c","i","c"))
#reset to sentences

#transform to word level tokens

temp2<- unnest_tokens(temp, word, X3)

foo<-group_by(temp2, X2) %>% 
  +     summarize(text = str_c(word, collapse = " ")) %>%
  +     ungroup()