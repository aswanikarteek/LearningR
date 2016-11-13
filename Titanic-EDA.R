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

#Understand the dataset
table(data.combined$Pclass)
table(data.combined$Sex)
table(data.combined$Embarked)

#Load Libraries
library(ggplot2)

ggplot(train,aes(x=Pclass,fill=factor(Survived))) +
  geom_bar(width = 0.5) +
  ylab("Number of Passengers")

#Identify some anamolies - Dupes by Name
dup.names <- as.character(data.combined$Name[which(duplicated(as.character(data.combined$Name)))])
data.combined[which(data.combined$Name %in% dup.names),]

#We ascertained that this may not be dupes!!
library(stringr)

#Look at Titles in the names and see if it makes sense to create a Title column.
misses <- data.combined[which(str_detect(data.combined$Name, "Miss. ")),]
misses[1:5,]

mrses <- data.combined[which(str_detect(data.combined$Name, "Mrs. ")),]
mrses[1:5,]

extractTitle <- function(name) {
  name <- as.character(name)
  
  if (length(grep("Miss.", name)) > 0) {
    return ("Miss.")
  } else if (length(grep("Master.", name)) > 0) {
    return ("Master.")
  } else if (length(grep("Mrs.", name)) > 0) {
    return ("Mrs.")
  } else if (length(grep("Mr.", name)) > 0) {
    return ("Mr.")
  } else {
    return ("Other")
  }
}

titles <- NULL
for (i in 1:nrow(data.combined)) {
  titles <- c(titles, extractTitle(data.combined[i,"Name"]))
}
data.combined$title <- as.factor(titles)

ggplot(data.combined[1:891,], aes(x = title, fill = Survived)) +
  stat_count(width = 0.5) +
  facet_wrap(~Pclass) + 
  ggtitle("Pclass") +
  xlab("Title") +
  ylab("Total Count") +
  labs(fill = "Survived")

table(data.combined$Sex)

ggplot(data.combined[1:891,], aes(x = Sex, fill = Survived)) +
  stat_count(width = 0.5) +
  facet_wrap(~Pclass) + 
  ggtitle("Pclass") +
  xlab("Sex") +
  ylab("Total Count") +
  labs(fill = "Survived")

#So age and Sex are two important factors
summary(data.combined$Age)
summary(data.combined[1:891,"Age"])

ggplot(data.combined[1:891,], aes(x = Age, fill = Survived)) +
  facet_wrap(~Sex + Pclass) +
  geom_histogram(binwidth = 10) +
  xlab("Age") +
  ylab("Total Count")
