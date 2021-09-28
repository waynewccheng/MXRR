source("http://bioconductor.org/biocLite.R")
biocLite("EBImage")
library(EBImage)

#set the working directory from which the files will be read from
setwd('D:/spatiotemporal/FST_analysis')

#create a list of the files from your target directory
file_list <- list.files(path='D:/spatiotemporal/FST_analysis')

testImage1 <- readImage(file_list[1])
display(testImage1)

#-------------------------------------------------------------------------------ATTEMPT 1
#take average of each row and column from green channel
avgRow_G = rowMeans(testImage1[,,2])
avgCol_G = colMeans(testImage1[,,2])

#find value where addition of green is highest
testX <- which.max(avgRow_G)
testY <- which.max(avgCol_G)

#from that x,y coordinate, crop a box the size of the green box
croppedImg <- testImage1[testX:400, testY:400,]
display(croppedImg)

#the problem I get here is that the highest returned value for Y is center of the line of stationary signals, not the green line
#also for X value, I got the right edge of the green box, not the left edge
croppedImg2 <- testImage1[(testX-400):testX,,]
display(croppedImg2)

#add condition where R and B is low

#find value where addition of green is highest above the center line
testnewY <- which.max(avgCol_G[1:900])
croppedImg3 <- testImage1[(testX-400):testX, testnewY:(testnewY+400),]
display(croppedImg3)

#write this cropped image out
writeImage(croppedImg3, "testImgCropped.tiff",)
#------------------------------------------------------------------------------




#initiate a blank data frame, each iteration of the loop will append the data from the given file to this variable
dataset <- data.frame()

# read images
for (i in 1:length(file_list)) {
  temp_data <- readImage(file_list[i])
  #for each iteration, bind the new data to the building dataset
  dataset <- rbind(dataset, temp_data)
}
