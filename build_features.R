library(data.table)
library(Metrics)
library(caret)
library(MASS)
library(lmtest)
library(olsrr)
library(broom)

#Read in the files
train <- fread('./project/volume/data/interim/Stat_380_train2022.csv')
test <- fread('./project/volume/data/interim/Stat_380_test2022.csv')


#Check for NA values in all columns
train.super <- train
sapply(train.super, function(x) sum(is.na(x)))

#Replacing NA's with mean for LotFrontage
train.super$LotFrontage[is.na(train.super$LotFrontage)] <- mean(train.super$LotFrontage, na.rm = TRUE)

#One Hot Encoding
dummy <- dummyVars(" ~ .", data=train.super)
newdata <- data.frame(predict(dummy, newdata = train.super))

#First lets look at the corellation
cor(newdata)

#Highest Corellation's
# [1] OverallQual
# [2] GrLivArea
# [3] TotalBsmtSF
# [4] YearBuilt

#Change test data to our needs before prediction + adds columns from encoding
dummy <- dummyVars(" ~ .", data=test)
newdata.test <- data.frame(predict(dummy, newdata = test))
newdata.test$LotFrontage[is.na(newdata.test$LotFrontage)] <- mean(newdata.test$LotFrontage, na.rm = TRUE)
