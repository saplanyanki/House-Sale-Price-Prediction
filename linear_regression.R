library(data.table)
library(Metrics)
library(caret)
library(MASS)
library(lmtest)
library(olsrr)
library(broom)

#Highest Corellation's
# [1] OverallQual
# [2] GrLivArea
# [3] TotalBsmtSF
# [4] YearBuilt

#Linear Regression Model
model.new <- lm(SalePrice ~ OverallQual + GrLivArea + TotalBsmtSF + YearBuilt + OverallCond + LotArea + LotFrontage + CentralAirY + BedroomAbvGr + BldgTypeDuplex + FullBath, data = newdata)
summary(model.new)

#New Model Prediction
prediction.new <- model.new %>% predict(newdata.test)
summary(model.new)

#RMSE Score
RMSE = RMSE(prediction.new, newdata.test$SalePrice)

#Write the results in CSV - Do not forget to change column name to "SalePrice" manually
fwrite(test[,.(Id, prediction.new)], './project/volume/data/processed/Linear_Regression.csv')

##OLD CODE - First Attempt

#Discard Unwanted Columns 
#train.1 <- subset(train, select = -c(BldgType, Heating, CentralAir, PoolArea))
#train.1$LotFrontage[is.na(train.1$LotFrontage)] <- mean(train.1$LotFrontage, na.rm = TRUE)

#Create the Model
#model.1 <- lm(SalePrice ~ OverallQual + GrLivArea + TotalBsmtSF + YearBuilt + OverallCond + LotArea + LotFrontage, data = train.1)
#summary(model.1)

#Prediction
#prediction <- model.1 %>% predict(test)

#Plot
#plot(SalePrice , prediction, data = test)
#abline(lm(SalePrice ~ prediction, data = test))
