# Readme for "Getting and Cleaning Data" course project
## Project Description
>You should create one R script called run_analysis.R that does the following.
>
>   1. Merges the training and the test sets to create one data set.
>   2. Extracts only the measurements on the mean and standard deviation for each measurement.
>   3. Uses descriptive activity names to name the activities in the data set
>   4. Appropriately labels the data set with descriptive variable names.
>   5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and 
>      each subject.

The purpose of this project was to develop a script that would collect accelerometer data from a publically available dataset from Davide Anguita *et al* and tidy the data up. The data were modified to obtain the average values for several variables across each subject and each activity in the dataset. The final dataset can be found in "Samsung_Data_Tidy.txt". To load the tidy dataset into R, execute the following code:
```R
tidy_table <- read.table('Samsung_Data_tidy.txt', header = TRUE)
View(tidy_table)
```

*Please note that I did not modify the file paths in the UCI HAR Dataset directory that we downloaded for the assignment. When running the code, set the working directory as the directory that includes both the run_analysis.R script and the UCI HAR dataset directory and it will run properly.*

When reading the project assignment, I was confused by the open-endedness of the prompt in a few ways. I included my interpretation of the prompt and my subsequent steps in the script to address these concerns.

### Did not use certain files from the UCI HAR Dataset directory
>   1. Merges the training and the test sets to create one data set.
>   2. Extracts only the measurements on the mean and standard deviation for each measurement.

The folder that we download contains several files. Two of the directories, "train/Inertial Signals" and "test/Inertial Signals" contain bulky data in the rawest form for these acceleration measurements. Anguita's README explains that these inertial signals went through processing and "a vector of features was obtained by calculating variables from the time and frequency domain." This resulting vector (one for the training set and one for the test set) is what we use for our script. The signals data are not means or standard deviations of any measurements, so there is no need to include them in the script in the first place.

### Extracting only mean and standard deviation measurements
>   2. Extracts only the measurements on the mean and standard deviation for each measurement.

There were a couple different variables that had "mean" in the variable name from the original dataset, which you can find in "features.txt" in the original directory:
>   1 tBodyAcc-mean()-X
>
>   227 tBodyAccJerkMag-mean()
>
>   294 fBodyAcc-meanFreq()-X
>
>   558 angle(tBodyGyroJerkMean,gravityMean)
>
>   559 angle(X,gravityMean)

Going back to the information provided by Anguita in features_info.txt, we see that mean(), angle(), std(), meanFreq(), etc. are computations on the raw signal values to produce the final variables. Since we are asked to extract the mean variables, I thought to extract all variables that were computed via mean() or meanFreq(). However, I removed variables with meanFreq() from the extraction because none of those variables had an associated std() variable. The final script uses regular expressions to extract all variables containing "mean()" or "std()" in the variable name.

### Renaming the variables to fit tidy data guidelines
>   4. Appropriately labels the data set with descriptive variable names.

Tidy data as described in week 1 of this course requires variable names to be "human readable." Personally, I felt that the variable names given by Anguita *et al* were plenty descriptive and readable, but I changed the variable names to be more convetionally human readable to fit the tidy guidelines just in case. The variable name changes are described in the "Codebook.md" file.

### Calculating average values and using long format for the tidy data
>   5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and 
>      each subject.

I found two ambiguous ideas in this statement. The first piece of ambiguity refers to how to average the values in the first place. There are 30 subjects and 6 activities. Are we supposed to find the average value of each variable for each activity (creating 6 observations), then separately find the average values of each variable for each subject (creating 30 observations), then add those two sets together (to make 36 observations)? This method doesn't produce tidy data since pieces of information from the variables are reflected multiple times in separate observations, nor does this make any sense to do from a scientific standpoint for the same reason. Another method I could think of was to subset the data by activity and find the average values of all 30 subjects for each variable, making a final table of 6 observations. If the goal of the dataset is to find trends in accelerometer data for each activity (*e.g.* to make smartphones start predicting activity based off of motion) then this method could make sense too, but I feel that information is being lost within the scope of this assignment if we average data in this way. I finally decided to interpret the statement this way: "Subset the dataset first by subject, then by activity for each subject, then find the average value of each variable. Compose a tidy data set that reflects this information." You could subset first by activity and then by subject and it would produce the same data, just reformatted.

The second ambiguous idea arose from my solution to the first ambiguous idea: I now am subsetting my variables based on two observations (subject and activity), not one. What is the tidiest way to show this data? [Narrow or wide?](https://www.theanalysisfactor.com/wide-and-long-data/) I went with a narrow format with multiple observations with the same subject number but they are distinguished via the activity observation. Using a wide format would produce 198 variables instead of 66, so I think using a narrow format makes the data easier to read.
