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

The purpose of this project was to develop a script that would collect accelerometer data from a publically available dataset and tidy the data up. The data were modified to obtain the average values for several variables across each subject and each activity in the dataset.

*Please note that I did not modify the file paths in the UCI HAR Dataset directory that we downloaded for the assignment. When running the code, set the working directory as the directory that includes both the run_analysis.R script and the UCI HAR dataset directory and it will run properly.*

When reading the project assignment, I was confused by the open-endedness of the prompt in a few ways. I included my interpretation of the prompt and my subsequent steps in the script to address these concerns.

### Did not use certain files from the UCI HAR Dataset directory
>   1. Merges the training and the test sets to create one data set.
>   2. Extracts only the measurements on the mean and standard deviation for each measurement.

The folder that we download contains several files. Two of the original directories contain 

### Using long format for the tidy data
This refers specifically to bullet point 

The accelerometer data is split into multiple files, so the script first loads all the individual files and merges
the datasets. The script also creates a final tidy dataset that contains averages for values in the original dataset, subsetted for
each activity performed by each subject. The final dataset can be found in "Samsung_Data_Tidy.txt". The process is explained in more detail
in the "Codebook.md" file.
