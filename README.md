# GCData_Course_Project
Getting and Cleaning Data Course Project

Script uses plyr and dplyr libraries, so it should be installed to run script

## Step 0. Downloading data and preparing dataset

1. Create directory for data (with checking it's existence)
2. Download archive file from Web
3. Unzip all files to folder
4. Listing all files, to see file pathes and names
5. Reading data from files and defining column names (where needed):
- features.txt:  labels for Training and Testing sets columns
- activity_labels.txt: descriptive labels for activities
Training data:
- X_train.txt: Training Set
- y_train.txt: Traing Labels
- subject_train: Subjects, who performed activities
Testing data:
- X_test.txt: Test Set
- y_test.txt: Test Labels
- subject_test: Subjects, who performed activities


## Step 1. Merges the training and the test sets to create one data set.

Use row-bind for training and testing datasets to merge Set, Labels and Subjects datasets.

## Step 2. Extracts only the measurements on the mean and standard deviation for each measurement.

Using select to subset columns with mean and std data. (using ".mean." instead of "mean" to exclude gravityMean variables('cause it's not mean of activity parameters))

## Step 3. Uses descriptive activity names to name the activities in the data set

Change Activity number to descriptive activity name

## Putting all columns together
Using column binding to aggregate all 3 datasets (Set, Labels and Subjects)

## Step 4. Appropriately labels the data set with descriptive variable names

Using gsub to complete column names and remove unusefull characters

## Step 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Using ddply to calculate mean for each std and mean column, groupped by subject and activity variables

## Writing Tidy dataset to file

Writing Tidy dataset to tidydata.txt