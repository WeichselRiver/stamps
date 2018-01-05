Stamp <- function(path_to_image = NA){
  rtn <- list(
    path_to_image = path_to_image,
    MichNr = NA,
    MichWert = NA,
    Set = NA,
    Entwertung = NA
  )
  rtn$split_color = function(){
    return(rtn$MichNr)
  }
  class(rtn) <- "Stamp"
  return(rtn)
}

