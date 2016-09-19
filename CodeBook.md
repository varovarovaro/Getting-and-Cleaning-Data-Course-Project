


Introduction

Script 'run_analysis.R' performs following activities:

Downloads and Extracts Dataset if doesnt exist from UCL Depository 
Merges the training and the test sets to create one data set.
Appropriately labels the data set with descriptive variable names.
Extracts only the measurements on the mean and standard deviation for each measurement.
Uses descriptive activity names to name the activities in the data set
Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Data Set

The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. There ar ethree files each for test and train data

measurements from the accelerometer and gyroscope
activity label
identifies the subject who performed the activity for each window sample

Details of Work Performed:

Step 0 - Set Working Directory and Load Required Package
Packages are installed if not available
Packages set are :"dplyr","data.table","plyr","reshape2"
_____________________________________________________________

Step 1 - Download and Extract Dataset if doesnt exist from UCL Depository https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
_____________________________________________________________

Step 2 - Reading of Input Data Bases and renaming of headers with 
descriptive variable name

In final data there are 10299 rows. Each row as 561 measurements. Additionally there are two columns for 'Subject' of study and 'Activity Codes)

Step 2.1 - 
Following variables were created to read value for train data of activities:

s_train : Data Frame with 'subject_train.txt' data
x_train : Data Frame with 'X_train.txt' data
y_train : Data Frame with 'y_train.txt' data

all_train : Data frame combining all the three input datasets of train: 's_train', 'x_train', 'y_train'

Post this 's_train','x_train','y_train' were dropped (to free up  resources)

Step 2.2 - 
Following variables were created to read value for test data of activities:

s_test : Data Frame with 'subject_test.txt' data
x_test : Data Frame with 'X_test.txt' data
y_test : Data Frame with 'y_test.txt' data

all_test : Data frame combining all the three input datasets of test: 's_test', 'x_test', 'y_test'

Post this 's_test','x_test','y_test' were dropped (to free up  resources)

Step 2.3 - Create combined dataset

full_data - Data frame combining all the three variables of 'all_train' and 'all_test' datasets

Post this 'all_train', 'all_test' were dropped (to free up  resources)

____________________________________________________________
Step 3 - Renaming of columns

There are 10299 rows. Each row as 561 measurements. Additionally there are two columns for 'Subject' of study and 'Activity Codes)


features_names : Data frame with names of 561 features in it, size = 561x2, to be used for naming the columns

Columns of 'full_data' were renamed basis feature_names

_____________________________________________________________

Step 4 : Select only columns conatining mean and standard deviation

There are 10299 rows. Each row as 33 measurements each for mean and standard deviation. Additionally there are two columns for 'Subject' of study and 'Activity Codes)

merg_mean : Data frame with columns which have 'mean()' in the column names of the 'full_data' data frame

merg_std : Data frame with columns which have 'std()' in the column names of the 'full_data' data frame

selected_data : Data frame with columns for 'Subject' (i.e. person), 'Actvity_Code', 'merg_mean', 'merg_std'

Post this 'full_data','merg_mean','merg_std' were dropped (to free up  resources)

________________________________________________

Step 5 : Replace Activity Code by activity names

There are 10299 rows. Each row as 33 measurements each for mean and standard deviation. Additionally there are two columns for 'Subject' of study and 'Activity Names'). 'Activity Codes are replaces by Activity Names'

activity_names : Data frame with activity_labels in it, size=6x2

selected_data was updated with names of activities by first merging (other join by activity codes) 'selected_data' and 'activity_names'

Post that columns were rearranged in 'selected_data'


________________________________________________

Step 6 : Create a second, independent tidy data set with the 
average of each variable for each activity and each subject.

There are 30 subjects and 6 activities so there are 180 rows in dataset. There 66 entries of mean and standard deviation. So in all there are 68 columns (1 each for subect and activity + 66 for mean and standard deviation of observations). Final dataset is saved in 'tidy_data'.txt

'output_data.txt' file holds the data for each of the variables depending upon the 'activity' and the 'subject'. It has dimension of 180 x 68. Relevant Data can be searched on the basis of the first two columns of Activity and Subject.

melt_data : Single column of data with stacks of columns other than 'Activity_Name' and 'Subject' from 'selected_data' data frame

cast_data : Data frame casted from the molten data frame 'melt_data'.

Post that 'cast_data' was written to a file 
output_data.txt' in working directory

