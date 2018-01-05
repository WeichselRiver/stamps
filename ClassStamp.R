source("colorPicker.R")



Stamp <- function(path_to_image = NA){
  rtn <- list(
    path_to_image = path_to_image,
    MichNr = NA,
    MichWert = NA_real_,
    Set = NA,
    Entwertung = NA
  )
  rtn <- list2env(rtn)
  class(rtn) <- "Stamp"
  return(rtn)
}


s1 <- Stamp(path_to_image = "E:\\Stamp_Pictures\\Original\\256_1_2.jpg")
s1
