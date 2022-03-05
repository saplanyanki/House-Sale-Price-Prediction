library(randomForest)
library(caret)
library(mlbench)

#This is for Random Forest Model that placed top 2 in class

#Set a new df to store data and Use that for RF
trainingset <- newdata

#We have to set response variable as integer to do RF
trainingset$SalePrice <- as.integer(trainingset$SalePrice)

#Run the Random Forest Model (Takes 20 min on my Laptop)
rf <- randomForest(SalePrice~., data=trainingset, proximity=TRUE)
print(rf)

#Save the Prediction into p1
p1 <- predict(rf, trainingset)

#Write the results in CSV - Do not forget to change column name to "SalePrice" manually
fwrite(test[,.(Id, p1)], './project/volume/data/processed/Random_Forest.csv')
