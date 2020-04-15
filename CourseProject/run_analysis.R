## Course project for week 4 of 'Getting and Cleaning Data' course on Coursera
## from github repo jmounta1/GettingAndCleaningData
## Project goal: create a tidy data set based on accelerometer data from the Samsung Galaxy S smartphone


# load packages
library(tidyverse)

# load in data - NOTE: this requires setting the working directory to include the necessary files
# if you downloaded the directory and script from jmounta1/GettingAndCleaningData/tree/master/CourseProject, set the working directory to the
  # directory that contains run_analysis.R and the UCI HAR Dataset folder
vars <- scan('UCI HAR Dataset/features.txt', what = character(), sep = '\n')
activity_labels <- read_table('UCI HAR Dataset/activity_labels.txt', col_names = F)
dataset_test <- read_table('UCI HAR Dataset/test/X_test.txt')
dataset_train <- read_table('UCI HAR Dataset/train/X_train.txt')
activities_test <- read_table('UCI HAR Dataset/test/y_test.txt')
activities_train <- read_table('UCI HAR Dataset/train/y_train.txt')
subjects_test <- read_table('UCI HAR Dataset/test/subject_test.txt')
subjects_train <- read_table('UCI HAR Dataset/train/subject_train.txt')

# tidy data, label datasets
vars <- str_extract(vars, '\\D.*')    #get rid of the numbers in front of the variable names
colnames(dataset_test) <- vars
colnames(dataset_train) <- vars
colnames(activities_test) <- 'activity'
colnames(activities_train) <- 'activity'
colnames(subjects_test) <- 'subject_number'
colnames(subjects_train) <- 'subject_number'

# append activities and subject columns to datasets
dataset_test <- cbind(subjects_test, activities_test, dataset_test)
dataset_train <- cbind(subjects_train, activities_train, dataset_train)

# merge datasets via rbind function, rename activity column from nums to char descriptions
dataset_total <- rbind(dataset_test, dataset_train)
dataset_total$activity <- as.numeric(dataset_total$activity)
index <- 1    # initialize index for counting in the for loop
for (i in dataset_total$activity) {
  dataset_total$activity[index] <- activity_labels[i,2]
  index <- index + 1
}

# subset the data table to include test/training label, activity description, mean(), and std() for each measurement using regex
colnames(dataset_total) <- tolower(colnames(dataset_total))
subset <- str_which(colnames(dataset_total), '(subject_number)|(activity)|(mean\\(\\))|std\\(\\)')
dataset_subset <- dataset_total[ ,subset]
dataset_subset$activity <- as.character(dataset_subset$activity)   #don't know why activity column was converted to list, but changed back to char

# create a new tidy dataset that takes the average of each variable per activity per subject
# do this by splitting data frame by subject, then use a for loop to further split into 
dataset_split1 <- split(dataset_subset[ ,1:ncol(dataset_subset)], dataset_subset$subject_number)   #x is a list with each element containing a matrix of values related to a single subject
dataset_split2 <- list()   #initialize list to contain all splits (by subject and further by activity)
index <- 1
for (k in dataset_split1) {    #couldn't figure out how to use apply to do this since the factor arg in split changes for each element in x
  dataset_split2[[index]] <- split(k[ ,1:ncol(k)], k[['activity']])
  index <- index + 1
}
dataset_tidy <- data.frame()    #initialize data frame to add the average values to, as well as tidy headers (human readable)
tidy_headers <- c('Subject','Activity','BodyAcceleration_Time_Avg_X','BodyAcceleration_Time_Avg_Y','BodyAcceleration_Time_Avg_Z',
                  'BodyAcceleration_Time_Std_X','BodyAcceleration_Time_Std_Y','BodyAcceleration_Time_Std_Z','Gravity_Time_Avg_X',
                  'Gravity_Time_Avg_Y','Gravity_Time_Avg_Z','Gravity_Time_Std_X','Gravity_Time_Std_Y','Gravity_Time_Std_Z','BodyJerk_Time_Avg_X',
                  'BodyJerk_Time_Avg_Y','BodyJerk_Time_Avg_Z','BodyJerk_Time_Std_X','BodyJerk_Time_Std_Y','BodyJerk_Time_Std_Z',
                  'BodyTurn_Time_Avg_X','BodyTurn_Time_Avg_Y','BodyTurn_Time_Avg_Z','BodyTurn_Time_Std_X','BodyTurn_Time_Std_Y',
                  'BodyTurn_Time_Std_Z','BodyTurnJerk_Time_Avg_X','BodyTurnJerk_Time_Avg_Y','BodyTurnJerk_Time_Avg_Z','BodyTurnJerk_Time_Std_X',
                  'BodyTurnJerk_Time_Std_Y','BodyTurnJerk_Time_Std_Z','BodyAccelerationMagnitude_Time_Avg','BodyAccelerationMagnitude_Time_Std',
                  'GravityMagnitude_Time_Avg','GravityMagnitude_Time_Std','BodyJerkMagnitude_Time_Avg','BodyJerkMagnitude_Time_Std',
                  'BodyTurnMagnitude_Time_Avg','BodyTurnMagnitude_Std','BodyTurnJerkMagnitude_Avg','BodyTurnJerkMagnitude_Std',
                  'BodyAcceleration_FFT_Avg_X','BodyAcceleration_FFT_Avg_Y','BodyAcceleration_FFT_Avg_Z','BodyAcceleration_FFT_Std_X',
                  'BodyAcceleration_FFT_Std_Y','BodyAcceleration_FFT_Std_Z','BodyJerk_FFT_Avg_X','BodyJerk_FFT_Avg_Y','BodyJerk_FFT_Avg_Z',
                  'BodyJerk_FFT_Std_X','BodyJerk_FFT_Std_Y','BodyJerk_FFT_Std_Z','BodyTurn_FFT_Avg_X','BodyTurn_FFT_Avg_Y','BodyTurn_FFT_Avg_Z',
                  'BodyTurn_FFT_Std_X','BodyTurn_FFT_Std_Y','BodyTurn_FFT_Std_Z','BodyAccelerationMagnitude_FFT_Avg',
                  'BodyAccelerationMagnitude_FFT_Std','BodyJerkMagnitude_FFT_Avg','BodyJerkMagnitude_FFT_Std','BodyTurnMagnitude_FFT_Avg',
                  'BodyTurnMagnitude_FFT_Std','BodyTurnJerkMagnitude_FFT_Avg','BodyTurnJerkMagnitude_FFT_Std')
for (l in dataset_split2) {
  for (m in l) {
    row_means <- colMeans(m[ ,3:ncol(m)])
    row_to_add <- cbind(m[1,1:2],t(row_means))
    dataset_tidy <- rbind(dataset_tidy, row_to_add)
  }
}
colnames(dataset_tidy) <- tidy_headers

# write tidy dataset to text file
write.table(dataset_tidy, file = 'Samsung_Data_Tidy.txt', row.names = FALSE)
