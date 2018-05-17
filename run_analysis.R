## Load packages
library(dplyr)

## load data from files
# 'features.txt': List of all features.
# 'activity_labels.txt': Links the class labels with their activity name.
# 'train/X_train.txt': Training set.
# 'train/y_train.txt': Training labels.
# 'test/X_test.txt': Test set.
# 'test/y_test.txt': Test labels.

# load features data (561 observations, 2 variables)
featureNameTable <- read.table("features.txt", stringsAsFactors = FALSE)
head(featureNameTable)
tail(featureNameTable)
nrow(featureNameTable)
str(featureNameTable)

# Load activity labels (6 observations, 2 variables)
labelNameTable <- read.table("activity_labels.txt")
head(labelNameTable)
str(labelNameTable)

# Load training data set  (7352 observations, 561 variables)
trainDataTable <- read.table("X_train.txt") 
head(trainDataTable)
str(trainDataTable)

# Load training data labels (7352 observations, 1 variables)
trainLabelTable <- read.table("y_train.txt") 
head(trainLabelTable)
str(trainLabelTable)
unique(trainLabelTable)

# Load test data set (2947 observations, 561 variables)
testDataTable <- read.table("X_test.txt") 
head(testDataTable)
tail(testDataTable)
str(testDataTable)

# Load test data labels (2947 observations, 1 variable)
testLabelTable <- read.table("y_test.txt") 
head(testLabelTable)
str(testLabelTable)
unique(testLabelTable)

## Add label data to the data
# Add the train label data to the train data
trainDataTable$activityLabel <- trainLabelTable[[1]]
str(trainDataTable,  list.len=ncol(trainDataTable))
names(trainDataTable)


# Add the test label data to the test data
testDataTable$activityLabel <- testLabelTable[[1]]
str(testDataTable,  list.len=ncol(testDataTable))
names(testDataTable)


## Merge train and test data (10299 observations, 562 variables)
allData <- rbind(testDataTable, trainDataTable)
str(allData,  list.len=ncol(allData))

## Change column names of the data tables with 561 feature names
colnames(allData)[1:561] <- make.names(featureNameTable[[2]], unique=TRUE)
names(allData)


## Select activtyLabel, mean, and standard deviation columns only
# train Data
tinyAllData <- select(allData, activityLabel, grep(".*mean.*|.*std.*", colnames(allData)))
head(tinyAllData)
names(tinyAllData)
ncol(tinyAllData)
str(tinyAllData)

## Assign levels of the factor variable "activityLabel"
tinyAllData$activityLabel <- as.factor(tinyAllData$activityLabel)
levels(tinyAllData$activityLabel) <- as.character(labelNameTable[[2]])
str(tinyAllData)
head(tinyAllData)
a$activityLabel <- factor(a$activityLabel, as.character(labelNameTable[[2]]))

## Save the tiny data set to "tinyAllData.txt" file
write.table(tinyAllData, "tinyAllData.txt")
 
