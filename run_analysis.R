## Loading libraries we will use 
library(plyr)
library(dplyr)

## Step 0. Downloading data and preparing dataset

## Create directory for data
if (!file.exists("data")) {
        dir.create("data")
}

## Download data archive
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
fileName <- "UCI HAR Dataset.zip"
download.file(fileUrl, destfile=fileName, method="curl")

## Save dowbload date-time
dateDownloaded <- date()
dateDownloaded

## Unzip data archive to data folder
unzip(zipfile = fileName, exdir = "./data")

## List of unzipped files
list.files("./data", recursive = TRUE)

## Read data from files
filePath <- "./data/UCI HAR Dataset"
FeaturesList <- read.table(file.path(filePath, "features.txt"), header = FALSE)
ActivityLabels <- read.table(file.path(filePath, "activity_labels.txt"), header = FALSE)
TrainingSetData <- read.table(file.path(filePath,"train", "X_train.txt"), header = FALSE, col.names=FeaturesList[ ,2])
TrainingLabelsData <- read.table(file.path(filePath,"train", "y_train.txt"), header = FALSE, col.names=c("Activity"))
TrainingSubjectsData <- read.table(file.path(filePath,"train", "subject_train.txt"), header = FALSE, col.names=c("Subject"))
TestingSetData <- read.table(file.path(filePath,"test", "X_test.txt"), header = FALSE, col.names=FeaturesList[ ,2])
TestingLabelsData <- read.table(file.path(filePath,"test", "y_test.txt"), header = FALSE, col.names=c("Activity"))
TestingSubjectsData <- read.table(file.path(filePath,"test", "subject_test.txt"), header = FALSE, col.names=c("Subject"))


## Step 1. Merges the training and the test sets to create one data set.

## Row-bind training and testing datasets
SetData <- rbind(TrainingSetData, TestingSetData)
LabelsData <- rbind(TrainingLabelsData, TestingLabelsData)
SubjectsData <- rbind(TrainingSubjectsData, TestingSubjectsData)


## Step 2. Extracts only the measurements on the mean and standard deviation for each measurement.

## Using select to subset columns with mean and std data. (using ".mean." instead of "mean" to exclude gravityMean variables('cause it's not mean of activity parameters))
MeanAndStdData <- select(SetData,  contains(".mean."), contains(".std."))

## Step 3. Uses descriptive activity names to name the activities in the data set

## Change Activity number to descriptive activity name
LabelsData$Activity <- ActivityLabels[LabelsData$Activity, 2]


## Putting all columns together
AllData <- cbind(SubjectsData, LabelsData, MeanAndStdData)

## Step 4. Appropriately labels the data set with descriptive variable names.

names(AllData) <- gsub("^t","time",names(AllData))
names(AllData) <- gsub("^f","frequency",names(AllData))
names(AllData) <- gsub("Acc","Accelerometer",names(AllData))
names(AllData) <- gsub("Gyro","Gyroscope",names(AllData))
names(AllData) <- gsub("Mag","Magnitude",names(AllData))
names(AllData) <- gsub("BodyBody","Body",names(AllData))
names(AllData) <- gsub("\\.\\.\\.",".",names(AllData))
names(AllData) <- gsub("\\.\\.","",names(AllData))

## Step 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Creating tidy dataset
TidyData <- ddply(AllData, c("Subject", "Activity"), numcolwise(mean))

## Writing Tidy dataset to file
write.table(TidyData, "tidydata.txt", row.name = FALSE)