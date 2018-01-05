# functions to select colors
# Select different colours on a an image by mouseclick
# Then do cluster analysis to separate components
# init --------------------
library(tidyverse)
library(vec2dtransf)
library(imager)


PickColor <- function(StampObject) {
  
  if(class(StampObject) != "Stamp") stop()
  
  # load and display image --------
  img <- load.image(StampObject$path_to_image)
  
  # Click on different colors -----------
  
  n_of_diff_colors <- readline("How many colors present? > ") %>% as.numeric
  
  col.list = list()

  
  
  # function to pick single color
  get.col <- function(counter) {
    cat(counter)
    return(grabPoint(img, output = "value"))}
  
  for(i in 1: n_of_diff_colors){
    cat("Click five times color", i, "\n")
    col.list[[i]] <- plyr::ldply(1:5, get.col)
    cat("\n")}
  
  
  df_train <- plyr::ldply(col.list)
  
  # cluster analysis of points ---------------
  ## convert img to dataframe with RGB
  df_test <- data.frame(
    as.vector(R(img)),
    as.vector(G(img)),
    as.vector(B(img))
  )
  
  # knn to classify each point
  library(class)
  res <- knn(train = df_train, test = df_test, cl = rep(1:n_of_diff_colors, each = 5), k = 3)
  return(as.numeric(res))
  
}



PickColor(s1)
# plot.layer <- function(knn.res, img) {
#   
# }
# 
# 
# 
# 
# 
# 
# 
# 
# 
# # draw pictures of separated colors
# 
# res <- 
# 
# res1 <- res == 2
# 
# # plot layer 1
# as.cimg(as.numeric(res == 2), x= width(img), y = height(img)) %>% plot
