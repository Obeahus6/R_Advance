rm(list = ls(all.names = TRUE)) #will clear all objects includes hidden objects.
gc() #free up memrory and report the memory usage.
getwd()
setwd("/Users/adriandinca/Documents/Personal/Learning/Software/R/R Advanced")
# Basic: fin <- read.csv("/Users/adriandinca/Documents/Personal/Learning/Software/R/R Advanced/Section2/P3-Future-500-The-Dataset.csv")
fin<-read.csv("/Users/adriandinca/Documents/Personal/Learning/Software/R/R Advanced/Section2/P3-Future-500-The-Dataset.csv",na.strings = c(""))
head(fin,10)
tail(fin)
str(fin)
summary(fin)
# factors recap and example
# factor is a categorical variable with levels
# changing from non factor to factor

fin$ID <- factor(fin$ID)
fin$Inception <- factor(fin$Inception)

# factor variable trap (FVT)
#for character
a<- c("12","13","14","12","12")
a
typeof(a)
b<-as.numeric(a)
b
typeof(b)
#converting factor in to numeric

z <-factor(c("12","13","14","12","12"))
z
y<-as.numeric(z)#FVT
y
typeof(y)
typeof(z)
#-----Correct way:

x<- as.numeric(as.character(z))
x

# FVT Example:

head(fin)
summary(fin)
str(fin)

fin$Profit<-factor(fin$Profit)
str(fin)
fin$Profit<-as.numeric(as.character(fin$Profit))
str(fin)

#sub and gsub
?sub
head(fin)
fin$Expenses<- gsub(" Dollars","",fin$Expenses)
fin$Expenses<- gsub(",","",fin$Expenses)

head(fin)
str(fin)
fin$Revenue<-gsub("\\$","",fin$Revenue)
fin$Revenue<-gsub(",","",fin$Revenue)
fin$Growth<-gsub("%","",fin$Growth)
head(fin)
str(fin)
fin$Expenses<-as.numeric(fin$Expenses)
fin$Revenue<-as.numeric(fin$Revenue)
fin$Growth<-as.numeric(fin$Growth)
str(fin)

# Mising data

#Predict 100%
#Leave as it is
#Remove entire record
#Replace with the mean or median
#Fill in by exploring correlations and similarities
#Introduce dummy variable for "Missingness"

# What is NA : is a logical constanst that means

complete.cases(fin)

fin[!complete.cases(fin),]
str(fin)

# data filters: using which() for non-mossing 

head(fin)
fin[fin$Revenue == 9746272,]

fin[which(fin$Revenue==9746272),]

#filtering: using is.na for missing data


fin[is.na(fin$Expenses),]

#filtering: removing records with missing data

fin<-fin[!is.na(fin$Industry),]

#Reseting the dataframe index

rownames(fin) <- 1:nrow(fin)
rownames(fin) <- NULL 
typeof(fin)
?nrow

#Replacing Missing Data: Factual Analysis:

fin[!complete.cases(fin),]

fin[is.na(fin$State),]

fin[is.na(fin$State)&fin$City=="New York","State"]<-"NY"
fin[is.na(fin$State)&fin$City=="San Francisco","State"]<-"CA"
#check:

fin[c(11,377,82,265),]

#Replacing Missing Data: using average

mean(fin[,"Employees"],na.rm=TRUE)
med_emp_retail<-median(fin[fin$Industry =="Retail","Employees"],na.rm=TRUE)
med_emp_retail

fin[is.na(fin$Employees) & fin$Industry == "Retail","Employees"] <-med_emp_retail

fin[3,]

fin[ fin$Industry =="Retail",]



#Replacing Missing Data: using Median Imputation Method(Part 2)
fin[!complete.cases(fin),]
med_growth_constr<-median(fin[fin$Industry =="Construction","Growth"],na.rm=TRUE)
med_growth_constr

fin[is.na(fin$Growth) & fin$Industry == "Construction","Growth"] <-med_growth_constr

fin[8,]


med_rev_constr<- median(fin[!is.na(fin$Revenue) & fin$Industry=="Construction","Revenue"])
med_rev_constr

fin[is.na(fin$Revenue) & fin$Industry=="Construction","Revenue"]<-med_rev_constr
fin[c(8,42),]
median(fin[fin$Industry =="Construction","Revenue"],na.rm=TRUE)

fin[!complete.cases(fin),]

med_exp_const <- median(fin[fin$Industry =="Construction","Expenses"],na.rm =TRUE) 
med_exp_const
fin[is.na(fin$Expenses) & fin$Industry=="Construction"&is.na(fin$Profit),"Expenses"]<-med_exp_const
fin[c(8,42),]

#Replacing Missing Data: Deriving missing data


fin[is.na(fin$Profit),"Profit"]<-fin[is.na(fin$Profit),"Revenue"]-fin[is.na(fin$Profit),"Expenses"]

fin[c(8,42),]

fin[is.na(fin$Profit),"Expenses"]<-fin[is.na(fin$Profit),"Revenue"]-fin[is.na(fin$Profit),"Profit"]
fin[15,]

