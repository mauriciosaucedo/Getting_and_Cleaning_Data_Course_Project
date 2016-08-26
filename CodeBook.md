#Code Book for Course Project

##Overview

###Source of the original data:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

###Full Description from the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

##Process

The script run_analysis.R performs the following process to fet the data and clean up to create a tidy data set:

Merge the

##Variables

- fileURL - contains the URL for the data source
- features - Table with the names of features that will become the variables in the data set. The source is features text file.
- data_train_set - Measurement data from trainning. Source is train/X_train.txt
- data_train_label - Label data from trainning. Soruce is train/Y_train.txt
- data_train_subject - Subject data from trainning. Source is train/subject_train.txt
- data_test_set - Measurement data from testing. Source is test/X_train.txt
- data_test_label - Label data from testing. Soruce is test/Y_train.txt
- data_test_subject - Subject data from testing. Source is test/subject_train.txt
- data_train -Combined data frame of trainning subsets described above.
- data_test - Combined data frame of testing subsets described above.
- data - Combined data frame of data_train and data_test
- mean_std_cols - Numeric vector of the variable columns that contain mean or std
- data_mean_std - Subset of data based on the mean_std_cols columns.
- activity_labels - Table with the activity labels. Source is activity_labels.txt
- updated_names - Character vector with the reading friendly names for data_mean_std data frame.
- new_data - Secondary data frame with the aggregation of the average of each variable.

##Output

###data_mean_std

data_mean_std is a 10299x81 data frame.

The first column contains subject IDs.(integers between 1 and 30)
The second column contains activity names.
The last 79 columns are measurements.

###new_data

new_data is a 180x81 data frame.

The first column contains subject IDs.
The second column contains activity names.
The last 79 columns are the averages for each of the variables.
