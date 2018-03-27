#Simple Linear Regression

#importing dataset
dataset= read.csv("Salary_Data.csv")
#dataset= dataset[:, 2:3]

#taking care of missing data
#ifelse, 3 parameters:
#the first one is a condition 
#second one if true
#third one if false

#Create training set and test set
library(caTools)
set.seed(123)
split = sample.split(dataset$Salary, SplitRatio = 2/3)
training_set = subset(dataset, split = TRUE)
test_set = subset(dataset, split == FALSE)

#Fitting Simple Linear Regression to the Training Set
regressor = lm(formula = Salary ~ YearsExperience,
               data = training_set)

summary(regressor)

#Predicting the Test set results
y_pred = predict(regressor, newdata = test_set)

#Visualazing the Training set results
#install.packages("ggplot2")
library(ggplot2)
ggplot() + 
  geom_point(aes(x = test_set$YearsExperience, y = test_set$Salary),
             colour = "red") + 
  geom_line(aes(x = training_set$YearsExperience, y = predict(regressor, newdata = training_set)),
            colour = "blue") + 
  ggtitle("Salary vs Experience (Training Set)") + 
  xlab("Years of Experience") + 
  ylab("Salary")




