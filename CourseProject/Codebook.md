# Codebook for "Getting and Cleaning Data" course project

## Data
The data used in this analysis all comes from Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto, and Xavier Parra in the UCI HAR Dataset. Further documentation on this dataset can be found [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones#). The purpose of this script `run_analysis.R` was to average the values of several variables described below based on `Subject` and `Activity` of the participants in the experiment, then output these averaged values to a tidy dataset that I called `Samsung_Data_Tidy.txt`.

## Variables
Subject
  * A numeric variable indentifying which subject performed the activities

Activity
  * A variable describing the activity performed by the subject to generate acceleration data. There were six activities in the UCI HAR Dataset:
    1. LAYING
    2. SITTING
    3. STANDING
    4. WALKING
    5. WALKING_DOWNSTAIRS
    6. WALKING_UPSTAIRS

The remaining variables in this analysis are described in `features_info.txt` which is downloaded with the UCI HAR Dataset. The measured variables were renamed to be more human readable. The old variable name from the UCI HAR Dataset is listed alongside its respective variable name found in `Samsung_Data_Tidy.txt`.

|UCI HAR Dataset Name| New Variable Name|
|:---:|:---:|
tbodyacc-mean()-x |BodyAcceleration_Time_Avg_X
tbodyacc-mean()-y |BodyAcceleration_Time_Avg_Y
tbodyacc-mean()-z |BodyAcceleration_Time_Avg_Z
tbodyacc-std()-x |BodyAcceleration_Time_Std_X
tbodyacc-std()-y |BodyAcceleration_Time_Std_Y
tbodyacc-std()-z |BodyAcceleration_Time_Std_Z
tgravityacc-mean()-x |Gravity_Time_Avg_X
tgravityacc-mean()-y |Gravity_Time_Avg_Y
tgravityacc-mean()-z |Gravity_Time_Avg_Z
tgravityacc-std()-x |Gravity_Time_Std_X
tgravityacc-std()-y |Gravity_Time_Std_Y
tgravityacc-std()-z |Gravity_Time_Std_Z
tbodyaccjerk-mean()-x |BodyJerk_Time_Avg_X
tbodyaccjerk-mean()-y |BodyJerk_Time_Avg_Y
tbodyaccjerk-mean()-z |BodyJerk_Time_Avg_Z
tbodyaccjerk-std()-x |BodyJerk_Time_Std_X
tbodyaccjerk-std()-y |BodyJerk_Time_Std_Y
tbodyaccjerk-std()-z |BodyJerk_Time_Std_Z
tbodygyro-mean()-x |BodyTurn_Time_Avg_X
tbodygyro-mean()-y |BodyTurn_Time_Avg_Y
tbodygyro-mean()-z |BodyTurn_Time_Avg_Z
tbodygyro-std()-x |BodyTurn_Time_Std_X
tbodygyro-std()-y |BodyTurn_Time_Std_Y
tbodygyro-std()-z |BodyTurn_Time_Std_Z
tbodygyrojerk-mean()-x |BodyTurnJerk_Time_Avg_X
tbodygyrojerk-mean()-y |BodyTurnJerk_Time_Avg_Y
tbodygyrojerk-mean()-z |BodyTurnJerk_Time_Avg_Z
tbodygyrojerk-std()-x |BodyTurnJerk_Time_Std_X
tbodygyrojerk-std()-y |BodyTurnJerk_Time_Std_Y
tbodygyrojerk-std()-z |BodyTurnJerk_Time_Std_Z
tbodyaccmag-mean() |BodyAccelerationMagnitude_Time_Avg
tbodyaccmag-std() |BodyAccelerationMagnitude_Time_Std
tgravityaccmag-mean() |GravityMagnitude_Time_Avg
tgravityaccmag-std() |GravityMagnitude_Time_Std
tbodyaccjerkmag-mean() |BodyJerkMagnitude_Time_Avg
tbodyaccjerkmag-std() |BodyJerkMagnitude_Time_Std
tbodygyromag-mean() |BodyTurnMagnitude_Time_Avg
tbodygyromag-std() |BodyTurnMagnitude_Std
tbodygyrojerkmag-mean() |BodyTurnJerkMagnitude_Avg
tbodygyrojerkmag-std() |BodyTurnJerkMagnitude_Std
fbodyacc-mean()-x |BodyAcceleration_FFT_Avg_X
fbodyacc-mean()-y |BodyAcceleration_FFT_Avg_Y
fbodyacc-mean()-z |BodyAcceleration_FFT_Avg_Z
fbodyacc-std()-x |BodyAcceleration_FFT_Std_X
fbodyacc-std()-y |BodyAcceleration_FFT_Std_Y
fbodyacc-std()-z |BodyAcceleration_FFT_Std_Z
fbodyaccjerk-mean()-x |BodyJerk_FFT_Avg_X
fbodyaccjerk-mean()-y |BodyJerk_FFT_Avg_Y
fbodyaccjerk-mean()-z |BodyJerk_FFT_Avg_Z
fbodyaccjerk-std()-x |BodyJerk_FFT_Std_X
fbodyaccjerk-std()-y |BodyJerk_FFT_Std_Y
fbodyaccjerk-std()-z |BodyJerk_FFT_Std_Z
fbodygyro-mean()-x |BodyTurn_FFT_Avg_X
fbodygyro-mean()-y |BodyTurn_FFT_Avg_Y
fbodygyro-mean()-z |BodyTurn_FFT_Avg_Z
fbodygyro-std()-x |BodyTurn_FFT_Std_X
fbodygyro-std()-y |BodyTurn_FFT_Std_Y
fbodygyro-std()-z |BodyTurn_FFT_Std_Z
fbodyaccmag-mean() |BodyAccelerationMagnitude_FFT_Avg
fbodyaccmag-std() |BodyAccelerationMagnitude_FFT_Std
fbodybodyaccjerkmag-mean() |BodyJerkMagnitude_FFT_Avg
fbodybodyaccjerkmag-std() |BodyJerkMagnitude_FFT_Std
fbodybodygyromag-mean() |BodyTurnMagnitude_FFT_Avg
fbodybodygyromag-std() |BodyTurnMagnitude_FFT_Std
fbodybodygyrojerkmag-mean() |BodyTurnJerkMagnitude_FFT_Avg
fbodybodygyrojerkmag-std() |BodyTurnJerkMagnitude_FFT_Std
