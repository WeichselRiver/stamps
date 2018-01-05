# functions to select colors
# Select different colours on a an image by mouseclick# Then do cluster analysis to separate components
# init --------------------library(tidyverse)library(vec2dtransf)library(imager)
# load and display image --------
img <- load.image("picturesWtmb/13_1_b.JPG")plot(img)
# Click on different colors -----------n_of_diff_colors <- 4
col.list = list()
# function to pick single colorget.col <- function(counter) {  cat(counter)  return(grabPoint(img, output = "value"))}
for(i in 1: n_of_diff_colors){  cat("Click five times color", i, "\n")  col.list[[i]] <- plyr::ldply(1:5, get.col)  cat("\n")}
# cluster analysis of points ---------------
## convert img to dataframe with RGB
R.m <- R(img)  %>% as.vector()G.m <- G(img)  %>% as.vector()

# try also knn 
# draw pictures of separated colors
