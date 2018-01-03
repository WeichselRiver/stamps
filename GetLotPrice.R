# make estimators for ebay multiple bids
# build hierarachy

library(tidyverse)
dta <- readxl::read_xlsx("EbayWertSerien.xlsx") 

# test


# select one of these topics: x = ...
# x = "Ziffernserie"
# x = "Wiederaufbau"




eval_wert <- function() {
  dta_check <- readxl::read_xlsx("ChecklList.xlsx") 
  
  
  get_wert <- function(satz, anzahl, vollst) {
    dta_sel <- dta %>% dplyr::filter(Set == satz) %>% arrange(Wert)
    
    anzMarken <- anzahl
    vollstaendigkeit = vollst
    
    prizes = dta_sel$Wert
    
    prizes_sel <- prizes[1:ceiling(nrow(dta_sel)*vollstaendigkeit)]
    
    
    flr = anzMarken  %/% length(prizes_sel) 
    mod = anzMarken  %% length(prizes_sel)
    
    flr * sum(prizes_sel) + ifelse(mod == 0, 0, sum(prizes_sel[1:mod]))
  }
  
  
  # get_wert("Ziffernserie", 50, 1)
  
  dta_check <- dta_check %>% 
    rowwise %>%
    mutate(wert = get_wert(set, anzahl, vollstaendigkeit))
  
  print(dta_check)
  
  print(sum(dta_check$wert)*0.10)
}



# ------------

dta_sel <- dta %>% dplyr::filter(Set == x)

anzMarken <- 50
vollstaendigkeit = 1

prizes = dta_sel$Wert

prizes_sel <- prizes[1:ceiling(nrow(dta_sel)*vollstaendigkeit)]


flr = anzMarken  %/% length(prizes_sel) 
mod = anzMarken  %% length(prizes_sel)

wert = flr * sum(prizes_sel) + ifelse(mod == 0, 0, sum(prizes_sel[1:mod]))
   










dta_ostsachsen <- dta %>% 
  dplyr::filter(Gebiet == "Ost-Sachsen") %>% 
  group_by(Set) %>% 
  arrange(Wert) %>% 
  mutate(WertSum = cumsum(Wert)) %>%
  mutate(index = )
dta_ostsachsen$index = 1:nrow(dta_ostsachsen)



ggplot(data = dta_ostsachsen,mapping = aes(y= WertSum, color = Set)) + geom_line()

