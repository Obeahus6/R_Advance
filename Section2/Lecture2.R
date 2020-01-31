rm(list = ls(all.names = TRUE)) #will clear all objects includes hidden objects.
gc() #free up memrory and report the memory usage.
getwd()
setwd("/Users/adriandinca/Documents/Personal/Learning/Software/R/R Advanced")
fin <- read.csv("/Users/adriandinca/Documents/Personal/Learning/Software/R/R Advanced/Section2/P3-Future-500-The-Dataset.csv")
head(fin,10)
tail(fin)
str(fin)
summary(fin)
