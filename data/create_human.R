
library(Matrix)
library(ggplot2)
library(dplyr)

#Reading the Data#

hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

#Checking the Structure and Dimension of the Data#

str(hd)
dim(hd)
str(gii)
dim(gii)
colnames(hd)
colnames(gii)

#Changing the names of the HDI Columns#

colnames(hd)[1] <- "HDI Rank"
colnames(hd)[2] <- "Country"
colnames(hd)[3] <- "HDI"
colnames(hd)[4] <- "Life"
colnames(hd)[5] <- "Exp"
colnames(hd)[6] <- "Mean"
colnames(hd)[7] <- "GNI"
colnames(hd)[8] <- "GNIminusHDI"
colnames(hd)

#Changing the names of the GII Columns#

colnames(gii)[1] <- "GII Rank"
colnames(gii)[2] <- "Country"
colnames(gii)[3] <- "GII"
colnames(gii)[4] <- "Life"
colnames(gii)[5] <- "Adol"
colnames(gii)[6] <- "Parl"
colnames(gii)[7] <- "FSecondary"
colnames(gii)[8] <- "MSecondary"
colnames(gii)[9] <- "FLabor"
colnames(gii)[10] <- "MLabor"
colnames(gii)

#Mutating Genger Inequality Variables#

gii <- mutate(gii, FMedu_ratio = FSecondary / MSecondary)
gii <- mutate(gii, FMlab_ratio = FLabor/MLabor)
colnames(gii)

#Joining the datasets#

join_by <- c("Country")


hdi_gii <- inner_join(hd, gii, by= join_by, suffix= c(".hd", ".gii"))
colnames(hdi_gii)

#Saving the Dataset#

write.csv(hdi_gii, file = "human.csv", row.names = FALSE)
human <- read.csv("human.csv", sep=",", header= T)
