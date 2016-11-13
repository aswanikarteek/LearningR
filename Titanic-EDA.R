#Import Data
test = read.csv("test.csv")
train = read.csv("train.csv")

#Add a New Column called Survived
test$Survived <- "None"

#Sort columns
test <- test [,c("PassengerId", "Survived",    "Pclass"  ,    "Name"    ,    "Sex"   ,      "Age" , 
"SibSp"   ,    "Parch"     ,  "Ticket"   ,   "Fare"      ,  "Cabin"    ,   "Embarked")] 

#Now combine to a single data frame

data.combined <- rbind(train,test)
str(data.combined)
#Make the change in data types to Factor
data.combined$Survived = as.factor(data.combined$Survived)
data.combined$Pclass = as.factor(data.combined$Pclass)
data.combined$SibSp = as.factor(data.combined$SibSp)
data.combined$Parch = as.factor(data.combined$Parch)

