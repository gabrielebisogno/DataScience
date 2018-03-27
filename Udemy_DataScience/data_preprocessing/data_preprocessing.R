#importing dataset
dataset= read.csv("Data.csv")

#taking care of missing data
#ifelse, 3 parameters:
#the first one is a condition 
#second one if true
#third one if false

#is.na is telling if the value in column age is missing or not
#ave compute the average
dataset$Age = ifelse(is.na(dataset$Age), 
                      ave(dataset$Age, FUN = function(x) mean(x, na.rm = TRUE)),
                      dataset$Age)

dataset$Salary = ifelse(is.na(dataset$Salary), 
                     ave(dataset$Salary, FUN = function(x) mean(x, na.rm = TRUE)),
                     dataset$Salary)

#Encoding Categorical Data
dataset$Country = factor(dataset$Country, 
                         levels = c("France","Spain","Germany"),
                         labels = c(1,2,3))

dataset$Purchased = factor(dataset$Purchased, 
                         levels = c("Yes","No"),
                         labels = c(0,1))

#Create training set and test set
library(caTools)
set.seed(123)
split = sample.split(dataset$Purchased, SplitRatio = 0.80)
training_set = subset(dataset, split = TRUE)
test_set = subset(dataset, split == FALSE)

#Feature Scaling
#we need to esclude the factors column, because they are not numeric
training_set[, 2:3] = scale(training_set[, 2:3])
training_set[, 2:3] = scale(training_set[, 2:3])



#end

















