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

# Load activity labels (6 observations, 2 variables)
labelNameTable <- read.table("activity_labels.txt")

# Load training data set  (7352 observations, 561 variables)
trainDataTable <- read.table("X_train.txt") 

# Load training data labels (7352 observations, 1 variables)
trainLabelTable <- read.table("y_train.txt") 

# Load subjects of training data
subjectTrainTable <- read.table("subject_train.txt")

# Load test data set (2947 observations, 561 variables)
testDataTable <- read.table("X_test.txt") 

# Load test data labels (2947 observations, 1 variable)
testLabelTable <- read.table("y_test.txt") 

# Load subjects of training data
subjectTestTable <- read.table("subject_test.txt")


## Add label and subject data to the data
# Add the train label data to the train data
trainDataTable$activityLabel <- trainLabelTable[[1]]
trainDataTable$subject <- subjectTrainTable[[1]]

# Add the test label data to the test data
testDataTable$activityLabel <- testLabelTable[[1]]
testDataTable$subject <- subjectTestTable[[1]]

## Merge train and test data (10299 observations, 562 variables)
allData <- rbind(testDataTable, trainDataTable)
str(allData,  list.len=ncol(allData))

## Change column names of the data tables with 561 feature names
colnames(allData)[1:561] <- make.names(featureNameTable[[2]], unique=TRUE)
names(allData)

 
## Select activtyLabel, mean, and standard deviation columns only
# train Data
tidyAllData <- select(allData, activityLabel, subject, grep(".*mean.*|.*std.*", colnames(allData)))

## Assign levels of the factor variable "activityLabel"
tidyAllData$activityLabel <- as.factor(tidyAllData$activityLabel)
levels(tidyAllData$activityLabel) <- as.character(labelNameTable[[2]])

## clean column names
colnames(tidyAllData) <- gsub("[.]", "", colnames(tidyAllData))
colnames(tidyAllData) <- tolower(colnames(tidyAllData))

## Save the tidy data set to "tidyAllData.txt" file
write.table(tidyAllData, "tidyAllData.txt",  row.names = FALSE)
