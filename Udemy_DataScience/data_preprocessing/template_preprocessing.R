#importing dataset
dataset= read.csv("Data.csv")
#dataset= dataset[:, 2:3]

#taking care of missing data
#ifelse, 3 parameters:
#the first one is a condition 
#second one if true
#third one if false

#Create training set and test set
library(caTools)
set.seed(123)
split = sample.split(dataset$Purchased, SplitRatio = 0.80)
training_set = subset(dataset, split = TRUE)
test_set = subset(dataset, split == FALSE)



















#end