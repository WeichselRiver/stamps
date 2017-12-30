# Stamp Recognition using PCA

#.libPaths(c("C:/Daten/RStudio/R-3.3.2/library", "C:/Daten/R-3.1.2/library" ))
library(EBImage)
library(dplyr)
library(readxl)

t1 = read_excel("StampList.xlsx") %>%
  dplyr::filter(bild == "Ziffern im Kreis")

pic_prep = function(x) {
  x1 = EBImage::readImage(x) %>%
    resize(w = 100, h = 100)
  colorMode(x1) = "Grayscale"
  as.vector(imageData(x1[,,1]))
}

# get data.frame of all pictures
pics_array = plyr::laply(t1$file, pic_prep) %>% t %>% data.frame




pca = princomp(pics_array)

# rescale function
linMap <- function(x, from = 0, to = 1)
  (x - min(x)) / max(x - min(x)) * (to - from) + from


pca_pic = pca$scores[,1] %>% 
  linMap %>% 
  Image(dim = c(100,100), colormode = "Grayscale")

display(pca_pic, method = "raster")



# find features
bwlabel(pca_pic)
computeFeatures.shape(pca_pic)

## load and segment nucleus
y = pca_pic
x = thresh(y, 10, 10, 0.05)
# x = opening(x, makeBrush(5, shape='disc'))
x = bwlabel(x)
display(y, title="Cell nuclei", method = "raster")
display(x, title="Segmented nuclei", method = "raster")

## compute shape features
fts = computeFeatures.shape(x)
data.frame(fts) %>% dplyr::arrange(desc(s.area))

## compute features
ft = computeFeatures(x, y, xname="nucleus")
cat("median features are:\n")
apply(ft, 2, median)

## compute feature properties
ftp = computeFeatures(x, y, properties=TRUE, xname="nucleus")
ftp

cx = colorLabels(x)
display(cx, method = "raster")

